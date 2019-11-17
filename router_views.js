const app = require('./app.js');
const router_module = require('./router_module.js');
const path = require('path');
const maxlimit = 18

exports.main = (req, res) => {
    let dataBanner = null;
    let dataCategory = null;

    const Main = async () => {
        try {
            let dataBanner_Resolve = await new Promise((resolve) => { router_module.OpenQuery(`SELECT * FROM dbtbanner where isShow=0`, resolve) })
            dataBanner = dataBanner_Resolve.dataset;

            let dataCategory_Resolve = await new Promise((resolve) => { router_module.OpenQuery(`SELECT * FROM dbmcategory where isDelete=0`, resolve) })
            dataCategory = dataCategory_Resolve.dataset;

            let sessionaccount = router_module.Sessionaccount(req);
            res.render(path.join(__dirname + '/views') + '/main.html', { sessionaccount: sessionaccount, dataBanner: dataBanner, dataCategory: dataCategory });
        } catch (error) {
            console.log(error);
        }
    }
    Main()
}

exports.main_listproduct = async (req, res) => {
    let ssearch = req.query.search
    let idtypecategory = req.query.category
    let ctdata = router_module.ChechMaxLimitData(req.query.ctdata)
    let ctdataquery = ctdata * maxlimit - maxlimit
    let ssql = ''

    console.log(ssearch);
    console.log(idtypecategory);

    if ((ssearch == 'undefined') || (ssearch == '') || (ssearch == null)) ssearch = ''
    if ((idtypecategory == '0') || (idtypecategory == 'undefined') || (idtypecategory == null)) ssql = `SELECT * FROM dbmproduct where isDelete=0 and isShow=0 and NameProduct like "%` + router_module.EscapeString(ssearch) + '%" order by ID desc limit ' + ctdataquery + ',' + maxlimit
    else ssql = `SELECT * FROM dbmproduct where isDelete=0 and isShow=0 and IDCategory="` + idtypecategory + `" and NameProduct like "%` + router_module.EscapeString(ssearch) + '%" ORDER BY `isWatch` DESC limit ' + ctdataquery + ',' + maxlimit

    try {
        let dataTrans_Resolve = await new Promise((resolve) => { router_module.OpenQuery(ssql, resolve) })
        dataTrans = dataTrans_Resolve.dataset;
        let dataTransPromo = []
        let dataTransNewsItems = []

        // Pagination
        let ssql1 = ''
        if ((ssearch == 'undefined') || (ssearch == '') || (ssearch == null)) ssearch = ''
        if ((idtypecategory == '0') || (idtypecategory == 'undefined') || (idtypecategory == null)) ssql1 = `SELECT COUNT(ID) AS ct FROM dbmproduct where isDelete=0 and isShow=0 and NameProduct like "%` + router_module.EscapeString(ssearch) + '%" order by ID DESC '
        else ssql1 = `SELECT COUNT(ID) AS ct FROM dbmproduct where isDelete=0 and isShow=0 and IDCategory="` + idtypecategory + `" and NameProduct like "%` + router_module.EscapeString(ssearch) + '%" ORDER BY `isWatch` DESC '
    
        let datactpagination = await new Promise((resolve) => { router_module.OpenQuery(ssql1, resolve) })
        let ctpagintaion = Math.ceil(datactpagination.dataset[0].ct / maxlimit)

        if (ssearch == '') {
            let dataTransPromo_Resolve = await new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM  `dbmproduct` where isDelete=0  ORDER BY `isWatch` DESC LIMIT 20', resolve) })
            dataTransPromo = dataTransPromo_Resolve.dataset;

            let dataTransNewItems_Resolve = await new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM  `dbmproduct` where isDelete=0  ORDER BY `ID`  DESC LIMIT 20', resolve) })
            dataTransNewsItems = dataTransNewItems_Resolve.dataset;
        }

        let sessionaccount = router_module.Sessionaccount(req);
        res.render(path.join(__dirname + '/views') + '/main_listproduct.html', { sessionaccount: sessionaccount, dataProduct: dataTrans, dataProductPromo: dataTransPromo, dataProductNewsItems: dataTransNewsItems, ssearch: ssearch, ctdata: ctdata, ctpagintaion: ctpagintaion });
    } catch (error) {
        console.log(error);
    }
}

exports.clientdashboard = async (req, res) => {
    let modeform = req.query.mode;
    let sessionaccount = router_module.Sessionaccount(req);
    res.render(path.join(__dirname + '/views') + '/clientdashboard.html', { sessionaccount: sessionaccount, modeform: modeform });
}

exports.productdetail = (req, res) => {
    let siddata = req.params.iddata
    let dataCategory = null
    let dataProductDetail = null
    let dsProductMore = null

    const UpdateisWatchProduct = () => {
        let ssql = `UPDATE dbmproduct SET isWatch=(isWatch+1) WHERE ID="` + siddata + `";`
        new Promise((resolve) => { router_module.ExecQuery(ssql, resolve) })
            .then((result) => {
                if (result.err) console.log('cancel update iswatch product');
            }).catch((result) => { res.send(result.error) });
    }

    const RenderViews = () => {
        UpdateisWatchProduct()
        let sessionaccount = router_module.Sessionaccount(req);
        res.render(path.join(__dirname + '/views') + '/productdetail.html', { sessionaccount: sessionaccount, data: dataProductDetail, dataProduct: dsProductMore, dataCategory: dataCategory });
    }

    const ShowCategory = () => {
        let ssql1 = `SELECT * FROM dbmcategory where isDelete=0`
        new Promise((resolve) => { router_module.OpenQuery(ssql1, resolve) })
            .then((result) => {
                dataCategory = result.dataset;
                RenderViews()
            }).catch((result) => { res.send(result.error) });
    }

    const RecomendationProduct = () => {
        new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM `dbmproduct` WHERE isDelete=0 ORDER BY `isWatch` DESC LIMIT 12', resolve) })
            .then((result) => {
                dsProductMore = result.dataset;
                ShowCategory()
            }).catch((result) => { res.send(result.error) });
    }

    new Promise((resolve) => { router_module.OpenQuery('SELECT a.*,b.namecategory FROM dbmproduct a left join dbmcategory b on a.idcategory=b.id where a.id="' + siddata + '";', resolve) })
        .then((result) => {
            dataProductDetail = result.dataset
            RecomendationProduct()
        }).catch((result) => { res.send(result.error) });
}

exports.admin = (req, res) => {
    let susername = req.session.usernameadmin;
    let spassword = req.session.passwordadmin;
    new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM dbmaccount where isAdmin=1 and Email="' + susername + '" and Password="' + spassword + '"', resolve) })
        .then((result) => {
            if (result.dataset.length > 0) {
                let modeform = req.query.mode;
                res.render(path.join(__dirname + '/views') + '/admindashboard.html', { modeform: modeform });
            } else res.render(path.join(__dirname + '/views') + '/adminlogin.html', {});
        }).catch((result) => { res.send(result.error) })
}

exports.adminproduct = (req, res) => {
    let ssearch = req.query.search
    if ((ssearch == 'undefined') || (ssearch == '') || (ssearch == null)) ssearch = ""

    let ctdata = router_module.ChechMaxLimitData(req.query.ctdata)
    let ctdataquery = ctdata * maxlimit - maxlimit
    let dataProduct = null;
    let dataCategory = null;

    const RenderViews = () => {
        res.render(path.join(__dirname + '/views') + '/admin_product.html', { dataProduct: dataProduct, dataCategory: dataCategory, ctdata: ctdata });
    }

    const ShowDataCategory = () => {
        new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM `dbmcategory` WHERE isDelete=0', resolve) })
            .then((result) => {
                dataCategory = result.dataset;
                RenderViews()
            }).catch((result) => { res.send(result.error) });
    }

    const ShowDataProduct = () => {
        new Promise((resolve) => { router_module.OpenQuery('SELECT a.*, COALESCE(b.NameCategory,"") as NameCategory FROM dbmproduct a LEFT JOIN dbmcategory b ON a.IDCategory=b.ID WHERE a.isDelete=0 and a.NameProduct like "%' + ssearch + '%" order by id desc limit ' + ctdataquery + ',' + maxlimit, resolve) })
            .then((result) => {
                dataProduct = result.dataset;
                ShowDataCategory()
            }).catch((result) => { res.send(result.error) });
    }

    ShowDataProduct()
}

exports.admininformation = (req, res) => {
    let ssql = `
    SELECT COUNT(ID) FROM dbttransdoc WHERE (status="open" OR status="processed" OR status="awaiting") AND DATE_FORMAT(TimeCreated, "%M %d %Y")=DATE_FORMAT(NOW(), "%M %d %Y") INTO @ctonproses;
    SELECT COUNT(ID) AS Transaksi FROM dbttransdoc WHERE DATE_FORMAT(TimeCreated, "%M %d %Y")=DATE_FORMAT(NOW(), "%M %d %Y") INTO @ctsummarytransaction;
    SELECT SUM(GrandTotal) AS Summary FROM dbttransdoc WHERE DATE_FORMAT(TimeCreated, "%M %d %Y")=DATE_FORMAT(NOW(), "%M %d %Y") INTO @ctsummaryamounttransaction;
    SELECT @ctonproses AS ctproses,@ctsummarytransaction AS cttransaction,@ctsummaryamounttransaction AS ctamount;
    `
    new Promise((resolve) => { router_module.OpenQuery(ssql, resolve) })
        .then((result) => {
            let dataInfo = result.dataset[3];
            res.render(path.join(__dirname + '/views') + '/admin_information.html', { dataInfo: dataInfo });
        }).catch((result) => { res.send(result.error) });
}

exports.adminbanner = (req, res) => {
    let ctdata = router_module.ChechMaxLimitData(req.query.ctdata)
    let ctdataquery = ctdata * maxlimit - maxlimit

    new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM `dbtbanner` limit ' + ctdataquery + ',' + maxlimit, resolve) })
        .then((result) => {
            let dataBanner = result.dataset;
            res.render(path.join(__dirname + '/views') + '/admin_banner.html', { dataBanner: dataBanner, ctdata: ctdata });
        }).catch((result) => { res.send(result.error) });
}

exports.adminfilesmanager = (req, res) => {
    let ctdata = router_module.ChechMaxLimitData(req.query.ctdata)
    let ctdataquery = ctdata * maxlimit - maxlimit

    new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM `dbmfilesmanager` limit ' + ctdataquery + ',' + maxlimit, resolve) })
        .then((result) => {
            let dataBanner = result.dataset;
            res.render(path.join(__dirname + '/views') + '/admin_filesmanager.html', { dataBanner: dataBanner, ctdata: ctdata });
        }).catch((result) => { res.send(result.error) });
}

exports.admincategory = (req, res) => {
    let ctdata = router_module.ChechMaxLimitData(req.query.ctdata)
    let ctdataquery = ctdata * maxlimit - maxlimit

    new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM `dbmcategory` where isDelete=0 limit ' + ctdataquery + ',' + maxlimit, resolve) })
        .then((result) => {
            let dataCategory = result.dataset;
            res.render(path.join(__dirname + '/views') + '/admin_category.html', { dataCategory: dataCategory, ctdata: ctdata });
        }).catch((result) => { res.send(result.error) });
}

exports.adminorder = (req, res) => {
    res.render(path.join(__dirname + '/views') + '/admin_order.html', {});
}

exports.adminorder_list = (req, res) => {
    let sdate = req.query.tanggal
    let sinvoice = req.query.invoice
    let sstatuspayment = req.query.statuspayment
    let sstatustrans = req.query.statustrans
    let isalldate = req.query.isalldate

    let ctdata = router_module.ChechMaxLimitData(req.query.ctdata)
    let ctdataquery = ctdata * maxlimit - maxlimit

    let ssqlwhere = `WHERE a.DocNumber LIKE '%` + sinvoice + `%'`
    if (isalldate == 'false') ssqlwhere = ssqlwhere + ` AND DATE(a.TimeCreated)="` + sdate + `" `
    if (sstatustrans != 'all') ssqlwhere = ssqlwhere + ` AND a.Status="` + sstatustrans + `"`
    if (sstatuspayment != 'all') ssqlwhere = ssqlwhere + ` AND a.StatusPayment="` + sstatuspayment + `"`

    let ssql = `SELECT a.ID,a.Status,a.DocNumber,CONCAT(UCASE(LEFT(a.Status, 1)),LCASE(SUBSTRING(a.Status, 2))) as Status1,a.StatusPayment, DATE_FORMAT(a.TimeCreated,"%d %b %Y %H:%i") as TimeCreated1,a.ShippingPhone,a.GrandTotal FROM dbttransdoc a ${ssqlwhere} order by a.TimeCreated Desc `//limit ` + ctdataquery + ',' + maxlimit
    new Promise((resolve) => { router_module.OpenQuery(ssql, resolve) })
        .then((result) => {
            let dataTrans = result.dataset;
            res.render(path.join(__dirname + '/views') + '/admin_order_list.html', { dataProduct: dataTrans, ctdata: ctdata });
        }).catch((result) => { res.send(result.error) });
}

exports.adminorderdetail = (req, res) => {
    let sdocnumber = req.query.docnumber;
    let dataOrderItem = []
    let dataDocument = []
    let dataHistory = []

    const RenderViews = () => {
        let sessionaccount = router_module.Sessionaccount(req);
        res.render(path.join(__dirname + '/views') + '/admin_orderdetail.html', { sessionaccount: sessionaccount, dataOrderItem: dataOrderItem, dataDocument: dataDocument, dataHistory: dataHistory });
    }
    const GetDataHistory = () => {
        let ssql1 = `SELECT *, DATE_FORMAT(TimeCreated,"%d %b %Y %H:%i") as TimeCreated1 FROM dbttranshistory WHERE DocNumber="` + sdocnumber + `"`
        new Promise((resolve) => { router_module.OpenQuery(ssql1, resolve) })
            .then((result) => {
                dataHistory = result.dataset;
                RenderViews()
            }).catch((result) => { res.send(result.error) });
    }
    const GetDataDocument = () => {
        let ssql1 = `SELECT a.*,CONCAT(UCASE(LEFT(a.Status, 1)),LCASE(SUBSTRING(a.Status, 2))) as Status1, DATE_FORMAT(a.TimeCreated,"%d %b %Y %H:%i") as TimeCreated1 FROM dbttransdoc a WHERE a.DocNumber="` + sdocnumber + `"`
        new Promise((resolve) => { router_module.OpenQuery(ssql1, resolve) })
            .then((result) => {
                dataDocument = result.dataset;
                GetDataHistory()
            }).catch((result) => { res.send(result.error) });
    }
    const GetDataOrderItem = () => {
        let ssql = `SELECT a.ID,b.SKU, b.NameProduct,b.Unit,a.Qty,a.Price,(a.Price*a.Qty) as Total,b.ImageUrl  
        FROM dbttransdetail a LEFT JOIN dbmproduct b ON a.IDProduct=b.ID WHERE Docnumber="`+ sdocnumber + '"'
        new Promise((resolve) => { router_module.OpenQuery(ssql, resolve) })
            .then((result) => {
                dataOrderItem = result.dataset;
                GetDataDocument()
            }).catch((result) => { res.send(result.error) });
    }
    const CheckLoginAdmin = () => {
        let susername = req.session.usernameadmin;
        let spassword = req.session.passwordadmin;
        new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM dbmaccount where isAdmin=1 and Email="' + susername + '" and Password="' + spassword + '"', resolve) })
            .then((result) => {
                if (result.dataset.length > 0) {
                    GetDataOrderItem()
                } else res.render(path.join(__dirname + '/views') + '/adminlogin.html', {});
            }).catch((result) => { res.send(result.error) })
    }
    CheckLoginAdmin()
}

exports.cart = (req, res) => {
    let idaccount = req.session.idaccount;
    let sdatashipping = null
    let resultitemcart = null
    let totalcart = null
    let dataCategory = null

    const RenderViews = () => {
        let sessionaccount = router_module.Sessionaccount(req);
        res.render(path.join(__dirname + '/views') + '/cart.html', { sessionaccount: sessionaccount, data: resultitemcart, datashipping: sdatashipping, dataCategory: dataCategory, total: totalcart });
    }

    const ShowCategory = () => {
        let ssql1 = `SELECT * FROM dbmcategory where isDelete=0`
        new Promise((resolve) => { router_module.OpenQuery(ssql1, resolve) })
            .then((result) => {
                dataCategory = result.dataset;
                RenderViews()
            }).catch((result) => { res.send(result.error) });
    }

    const ShowItemCart = () => {
        let itemcart = []
        if (req.session.itemcart != undefined) itemcart = req.session.itemcart
        if (itemcart.length != 0) {
            let ssqldata = '';
            for (let i = 0; i < itemcart.length; i++) ssqldata = ssqldata + `\n ("` + itemcart[i].itemid + `","` + itemcart[i].qty + `"),`
            ssqldata = ssqldata.replace(/.$/, ";") // replace last character
            let ssql = `DROP TEMPORARY TABLE IF EXISTS dbtcart_tmp;
                    CREATE TEMPORARY TABLE dbtcart_tmp (
                    IDProduct BIGINT(20) DEFAULT NULL,
                    NameProduct VARCHAR(100) DEFAULT NULL,
                    Qty INT(11) DEFAULT NULL,
                    Price DECIMAL(10,0) DEFAULT NULL
                    );
                    INSERT INTO dbtcart_tmp (IDProduct,Qty) VALUES `+ ssqldata + `
                    UPDATE dbtcart_tmp a LEFT JOIN dbmproduct b ON a.IDProduct=b.ID SET a.NameProduct=b.NameProduct, a.Price=b.Price;
                    SELECT a.IDProduct, a.NameProduct,a.Qty,b.Unit,a.Price,(a.Price*a.Qty) Total,b.ImageUrl FROM dbtcart_tmp a LEFT JOIN dbmproduct b ON a.IDProduct=b.ID;
                    SELECT SUM(a.Price*a.Qty) AS GrandTotal FROM dbtcart_tmp a LEFT JOIN dbmproduct b ON a.IDProduct=b.ID `
            new Promise((resolve) => { router_module.OpenQuery(ssql, resolve) })
                .then((result) => {
                    resultitemcart = result.dataset[4];
                    totalcart = result.dataset[5][0].GrandTotal;
                    ShowCategory()
                }).catch((result) => { res.send(result.error) });
        } else {
            resultitemcart = []
            ShowCategory()
        }
    }

    const CheckAccount = () => {
        new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM dbmaccount where id="' + idaccount + '";', resolve) })
            .then((result) => {
                if (result.dataset.length > 0) {
                    sdatashipping = {
                        namaPenerima: result.dataset[0].DisplayName,
                        email: result.dataset[0].Email,
                        noTelp: result.dataset[0].Phone,
                        alamat: result.dataset[0].Address,
                        kota: result.dataset[0].City,
                        kodepos: result.dataset[0].CodePos
                    }
                    ShowItemCart()
                }
                else {
                    sdatashipping = {
                        namaPenerima: '',
                        noTelp: '',
                        alamat: '',
                        kota: '',
                        kodepos: ''
                    }
                    ShowItemCart()
                }
            }).catch((result) => { res.send(result.error) });
    }

    CheckAccount()
}

exports.checktransaction = (req, res) => {
    let sessionaccount = router_module.Sessionaccount(req);
    res.render(path.join(__dirname + '/views') + '/checktransaction.html', { sessionaccount: sessionaccount });
}

exports.inputpayment = (req, res) => {
    let sdocnumber = req.query.invoice
    let sessionaccount = router_module.Sessionaccount(req);

    new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM dbttransdoc where DocNumber="' + sdocnumber + '";', resolve) })
        .then((result) => {
            if (result.dataset.length > 0) {
                res.render(path.join(__dirname + '/views') + '/inputpayment.html', { sessionaccount: sessionaccount, datashipping: result.dataset, sdocnumber: sdocnumber });
            } else {
                res.render(path.join(__dirname + '/views') + '/inputpayment.html', { sessionaccount: sessionaccount, datashipping: [], sdocnumber: sdocnumber });
            }
        }).catch((result) => { res.send(result.error) });
}

exports.checktransaction_list = (req, res) => {
    let sdocnumber = req.query.search
    let dataHistory = []
    let dataTransDetail = []
    let dataDocument = []
    let totalTrans = 0
    let sessionaccount = router_module.Sessionaccount(req);

    const RenderViews = () => {
        res.render(path.join(__dirname + '/views') + '/checktransaction_list.html', { sessionaccount: sessionaccount, dataDocument: dataDocument, dataHistory: dataHistory, dataTransDetail: dataTransDetail, total: totalTrans });
    }

    const GetDataHistory = () => {
        let ssql1 = `SELECT *, DATE_FORMAT(TimeCreated,"%d %b %Y %H:%i") as TimeCreated1 FROM dbttranshistory WHERE DocNumber="` + sdocnumber + `"`
        new Promise((resolve) => { router_module.OpenQuery(ssql1, resolve) })
            .then((result) => {
                dataHistory = result.dataset;
                RenderViews()
            }).catch((result) => { res.send(result.error) });
    }

    const GetDataTransDetail = () => {
        let ssql1 = ` SELECT a.IDProduct, b.NameProduct,a.Qty,b.Unit,a.Price,(a.Price*a.Qty) Total,b.ImageUrl FROM dbttransdetail a LEFT JOIN dbmproduct b ON a.IDProduct=b.ID where DocNumber="` + sdocnumber + `" ;
                      SELECT SUM(Total) AS GrandTotal FROM dbttransdetail where DocNumber="`+ sdocnumber + `" ;`

        new Promise((resolve) => { router_module.OpenQuery(ssql1, resolve) })
            .then((result) => {
                if (result.dataset[0].length == 0) totalTrans = '0'
                else {
                    dataTransDetail = result.dataset[0];
                    totalTrans = result.dataset[1][0].GrandTotal;
                }
                GetDataHistory()
            }).catch((result) => { res.send(result.error) });
    }

    const GetDataTransHeader = () => {
        let ssql1 = `SELECT *, DATE_FORMAT(TimeCreated,"%d %b %Y %H:%i") as TimeCreated1 FROM dbttransdoc WHERE DocNumber="` + sdocnumber + `"`
        new Promise((resolve) => { router_module.OpenQuery(ssql1, resolve) })
            .then((result) => {
                if (result.dataset.length == 0) dataDocument = []
                else dataDocument = result.dataset;
                GetDataTransDetail()
            }).catch((result) => { res.send(result.error) });
    }

    GetDataTransHeader()
}

exports.clientorder = (req, res) => {
    let idaccount = req.session.idaccount;

    const BrowseData = () => {
        res.render(path.join(__dirname + '/views') + '/client_order.html', {});
    }

    const CheckAccount = () => {
        new Promise((resolve) => { router_module.OpenQuery('SELECT ID FROM dbmaccount where id="' + idaccount + '";', resolve) })
            .then((result) => {
                if (result.dataset.length > 0) BrowseData()
                else res.send('relogin')
            }).catch((result) => { res.send(result.error) });
    }
    CheckAccount()
}

exports.clientorder_list = (req, res) => {
    let sdate = req.query.tanggal
    let sinvoice = req.query.invoice
    let sstatuspayment = req.query.statuspayment
    let sstatustrans = req.query.statustrans
    let isalldate = req.query.isalldate

    let ctdata = router_module.ChechMaxLimitData(req.query.ctdata)
    let ctdataquery = ctdata * maxlimit - maxlimit

    let ssqlwhere = `WHERE a.DocNumber LIKE "%` + sinvoice + `%" AND a.IDAccount="` + req.session.idaccount + `" `
    if (isalldate == 'false') ssqlwhere = ssqlwhere + ` AND DATE(a.TimeCreated)="` + sdate + `" `
    if (sstatustrans != 'all') ssqlwhere = ssqlwhere + ` AND a.Status="` + sstatustrans + `"`
    if (sstatuspayment != 'all') ssqlwhere = ssqlwhere + ` AND a.StatusPayment="` + sstatuspayment + `"`

    let ssql = `SELECT a.ID,a.DocNumber,a.Status,CONCAT(UCASE(LEFT(a.Status, 1)),LCASE(SUBSTRING(a.Status, 2))) as Status1,a.StatusPayment, DATE_FORMAT(a.TimeCreated,"%d %b %Y %H:%i") as TimeCreated1,a.ShippingPhone,a.GrandTotal FROM dbttransdoc a ${ssqlwhere} order by a.TimeCreated Desc `//limit ` + ctdataquery + ',' + maxlimit
    new Promise((resolve) => { router_module.OpenQuery(ssql, resolve) })
        .then((result) => {
            let dataTrans = result.dataset;
            res.render(path.join(__dirname + '/views') + '/client_order_list.html', { dataProduct: dataTrans, ctdata: ctdata });
        }).catch((result) => { res.send(result.error) });
}

exports.clientorderdetail = (req, res) => {
    let sdocnumber = req.query.docnumber;
    let dataOrderItem = []
    let dataDocument = []
    let dataHistory = []

    const RenderViews = () => {
        let sessionaccount = router_module.Sessionaccount(req);
        res.render(path.join(__dirname + '/views') + '/client_orderdetail.html', { sessionaccount: sessionaccount, dataOrderItem: dataOrderItem, dataDocument: dataDocument, dataHistory: dataHistory });
    }
    const GetDataHistory = () => {
        let ssql1 = `SELECT *, DATE_FORMAT(TimeCreated,"%d %b %Y %H:%i") as TimeCreated1 FROM dbttranshistory WHERE DocNumber="` + sdocnumber + `"`
        new Promise((resolve) => { router_module.OpenQuery(ssql1, resolve) })
            .then((result) => {
                dataHistory = result.dataset;
                RenderViews()
            }).catch((result) => { res.send(result.error) });
    }
    const GetDataDocument = () => {
        let ssql1 = `SELECT a.*,CONCAT(UCASE(LEFT(a.Status, 1)),LCASE(SUBSTRING(a.Status, 2))) as Status1, DATE_FORMAT(a.TimeCreated,"%d %b %Y %H:%i") as TimeCreated1 FROM dbttransdoc a WHERE a.DocNumber="` + sdocnumber + `"`
        new Promise((resolve) => { router_module.OpenQuery(ssql1, resolve) })
            .then((result) => {
                dataDocument = result.dataset;
                GetDataHistory()
            }).catch((result) => { res.send(result.error) });
    }
    const GetDataOrderItem = () => {
        let ssql = `SELECT a.ID,b.SKU, b.NameProduct,b.Unit,a.Qty,a.Price,(a.Price*a.Qty) as Total,b.ImageUrl  
        FROM dbttransdetail a LEFT JOIN dbmproduct b ON a.IDProduct=b.ID WHERE Docnumber="`+ sdocnumber + '"'
        new Promise((resolve) => { router_module.OpenQuery(ssql, resolve) })
            .then((result) => {
                dataOrderItem = result.dataset;
                GetDataDocument()
            }).catch((result) => { res.send(result.error) });
    }
    GetDataOrderItem()
}

exports.clientprofile = (req, res) => {
    let idaccount = req.session.idaccount;
    new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM dbmaccount where id="' + idaccount + '";', resolve) })
        .then((result) => {
            if (result.dataset.length > 0) {
                let dataAccount = result.dataset;
                res.render(path.join(__dirname + '/views') + '/client_profile.html', { dataAccount: dataAccount, ctdata: '' });
            } else res.send('relogin')
        }).catch((result) => { res.send(result.error) });
}

exports.registerdriver = (req, res) => {
    let sessionaccount = router_module.Sessionaccount(req);
    res.render(path.join(__dirname + '/views') + '/register_driver.html', { sessionaccount: sessionaccount, csnumber: "082264576766" });
}

exports.registermitra = (req, res) => {
    let sessionaccount = router_module.Sessionaccount(req);
    res.render(path.join(__dirname + '/views') + '/register_mitra.html', { sessionaccount: sessionaccount, csnumber: "082264576766" });
}

exports.renderform = (req, res, templateform) => {
    let sessionaccount = router_module.Sessionaccount(req);
    res.render(path.join(__dirname + '/views') + '/' + templateform, { sessionaccount: sessionaccount })
}