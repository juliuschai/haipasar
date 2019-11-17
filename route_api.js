const app = require('./app.js');
const router_module = require('./router_module.js');
const path = require('path');
const fs = require('fs');
const Jimp = require('jimp');

//======================================================== function Global 

const SaveSession = (req, sidaccount, semail, spassword) => {
    req.session.idaccount = sidaccount;
    req.session.email = semail;
    req.session.password = spassword;
    console.log('login session : ' + req.session.email);
}

//======================================================== 

exports.logout = (req, res) => {
    req.session.idaccount = null;
    req.session.email = null;
    req.session.password = null;
    res.send('true');
}

exports.login = (req, res) => {
    let email = router_module.EscapeString(req.body.email);
    let password = router_module.EscapeString(req.body.password);

    const CheckEmailandPassword = () => {
        new Promise((resolve) => { router_module.OpenQuery('SELECT ID FROM dbmaccount where email="' + email + '" and password="' + password + '";', resolve) })
            .then((result) => {
                if (result.dataset.length > 0) {
                    SaveSession(req, result.dataset[0].ID, email, password)
                    res.send('true')
                } else res.send("password not valid")
            }).catch((result) => { res.send(result.error) });
    }

    const CheckEmail = () => {
        new Promise((resolve) => { router_module.OpenQuery('SELECT ID FROM dbmaccount where email="' + email + '";', resolve) })
            .then((resultCheckEmail) => {
                if (resultCheckEmail.dataset.length > 0) CheckEmailandPassword()
                else res.send("email not rigistered")
            }).catch((result) => { res.send(result.error) });
    }

    CheckEmail()
}

exports.registeraccount = (req, res) => {
    let displayname = router_module.EscapeString(req.body.displayname);
    let email = router_module.EscapeString(req.body.email);
    let password = router_module.EscapeString(req.body.password);

    const SaveRegisterAccount = () => {
        new Promise((resolve) => { router_module.OpenQuery("INSERT INTO dbmaccount (displayname,email,password) VALUES ('" + displayname + "','" + email + "','" + password + "'); \n SELECT (LAST_INSERT_ID()) AS idaccount;", resolve) })
            .then((result) => {
                if (result.dataset.length > 0) {
                    console.log('Register : ' + email)
                    SaveSession(req, result.dataset[1][0].idaccount, email, password)
                    res.send('true')
                } else res.send("Failed to register")
            }).catch((result) => { res.send(result.error) });
    }

    new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM dbmaccount where email="' + email + '";', resolve) })
        .then((result) => {
            if (result.dataset.length > 0) res.send("email already exist ")
            else SaveRegisterAccount()
        }).catch((result) => { res.send(result.error) });
}

exports.adminlogin = (req, res) => {
    let susername = router_module.EscapeString(req.body.username);
    let spassword = router_module.EscapeString(req.body.password);

    new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM dbmaccount where Email="' + susername + '" and Password="' + spassword + '"', resolve) })
        .then((result) => {
            if (result.dataset.length > 0) {
                req.session.idadmin = result.dataset[0].ID;
                req.session.usernameadmin = susername;
                req.session.passwordadmin = spassword;
                res.send('true');
            } else {
                req.session.usernameadmin = '';
                req.session.passwordadmin = '';
                res.send('Can\'t Login');
            }
        }).catch((result) => { res.send(result.error) })
}

exports.productadd = (req, res) => {
    let mode = router_module.EscapeString(req.query.mode)
    let iddata = router_module.EscapeString(req.query.iddata)
    let sku = router_module.EscapeString(req.query.sku)
    let nameproduct = router_module.EscapeString(req.query.nameproduct)
    let category = router_module.EscapeString(req.query.category)
    let urlimage = router_module.EscapeString(req.query.urlimage)
    let unit = router_module.EscapeString(req.query.unit)
    let price = router_module.EscapeString(req.query.price)
    let stock = router_module.EscapeString(req.query.stock)
    let description = router_module.EscapeString(req.query.description)
    let isShowQty = router_module.EscapeString(req.query.isShowQty)
    let isShow = router_module.EscapeString(req.query.isShow)

    let idcategory = null;

    const SaveData = () => {
        let ssqlSave = '';
        if (mode == 'edit') ssqlSave = "UPDATE dbmproduct SET SKU='" + sku + "', nameproduct='" + nameproduct + "', imageurl='" + urlimage + "', unit='" + unit + "', price='" + price + "', stock='" + stock + "', description='" + description + "', idcategory='" + idcategory + "', isShowStock='" + isShowQty + "', isShow='" + isShow + "' where ID='" + iddata + "'";
        else if (mode == 'add') ssqlSave = "INSERT INTO dbmproduct (SKU,nameproduct,imageurl,unit,price,stock,description,idcategory,isShowStock,isShow) VALUES ('" + sku + "','" + nameproduct + "','" + urlimage + "','" + unit + "','" + price + "','" + stock + "','" + description + "','" + idcategory + "','" + isShowQty + "','" + isShow + "')";
        new Promise((resolve) => { router_module.ExecQuery(ssqlSave, resolve) })
            .then((result) => {
                if (result.err) res.send("false")
                else res.send('true')
            }).catch((result) => { res.send(result.error) });
    }

    const CheckCateogry = () => {
        new Promise((resolve) => { router_module.OpenQuery('SELECT ID FROM dbmcategory WHERE NameCategory="' + category + '";', resolve) })
            .then((result) => {
                if (result.dataset.length > 0) {
                    idcategory = result.dataset[0].ID
                    SaveData()
                } else res.send("tipe category tidak valid")
            }).catch((result) => { res.send(result.error) });
    }

    let ssql = '';
    if (mode == 'add') ssql = 'SELECT * FROM dbmproduct where isDelete=0 and nameproduct="' + nameproduct + '";'
    else ssql = 'SELECT * FROM dbmproduct where isDelete=0 and ID="' + iddata + '";'
    new Promise((resolve) => { router_module.OpenQuery(ssql, resolve) })
        .then((result) => {
            if (mode == 'add') {
                if (result.dataset.length > 0) res.send("product name already exist ")
                else CheckCateogry();
            } else if (mode == 'edit') {
                if (result.dataset.length = 0) res.send("data product not found ")
                else CheckCateogry()
            }
        })
        .catch((result) => {
            res.send(result.error)
        });
}

exports.productdelete = (req, res) => {
    let iddata = router_module.EscapeString(req.params.iddata)
    new Promise((resolve) => { router_module.ExecQuery("UPDATE `dbmproduct` SET IsDelete=1 WHERE ID='" + iddata + "';", resolve) })
        .then((result) => {
            if (result.err) res.send("false")
            else res.send('true')
        }).catch((result) => { res.send(result.error) });
}

exports.cartadd = (req, res) => {
    let idproduct = router_module.EscapeString(req.params.itemid)
    let qty = router_module.EscapeString(req.params.qty)

    const AddToCart = () => {
        let itemcart = []
        if (req.session.itemcart != undefined) itemcart = req.session.itemcart
        let podcart = new router_module.Cartdataobject
        let flag = podcart.add(itemcart, idproduct, qty)
        if (flag == false) podcart.edit(itemcart, idproduct, qty)
        req.session.itemcart = itemcart

        res.send('true')
    }

    const CheckProductAvailable = () => {
        new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM dbmproduct where id="' + idproduct + '";', resolve) })
            .then((result) => {
                if (result.dataset.length > 0) AddToCart()
                else res.send("product tidak di temukan ")
            }).catch((result) => { res.send(result.error) });
    }
    CheckProductAvailable()
}

exports.carteditqty = (req, res) => {
    let itemid = router_module.EscapeString(req.params.itemid)
    let qty = router_module.EscapeString(req.params.qty)

    const UpdateProduct = () => {
        let itemcart = []
        if (req.session.itemcart != undefined) itemcart = req.session.itemcart
        var podcart = new router_module.Cartdataobject
        podcart.edit(itemcart, itemid, qty)

        res.send('true')
    }
    UpdateProduct()
}

exports.cartdelete = (req, res) => {
    let itemid = router_module.EscapeString(req.params.itemid)

    let itemcart = []
    if (req.session.itemcart != undefined) itemcart = req.session.itemcart
    var podcart = new router_module.Cartdataobject
    podcart.delete(itemcart, req.params.itemid) + ' delete item :' + itemid
    req.session.itemcart = itemcart

    res.send('true')
}

exports.adminchangedataorder = (req, res) => {
    let transid = router_module.EscapeString(req.body.transid)
    let docnumber = router_module.EscapeString(req.body.docnumber)
    let statuspayment = router_module.EscapeString(req.body.statuspayment)
    let statustrans = router_module.EscapeString(req.body.statustrans)
    let dataDocument = []

    const UpdateHistory = () => {
        let ssql = ''
        let memoStatusTrans = ''
        let memoStatusPayment = ''
        let flag = false

        if (dataDocument.StatusPayment != statuspayment) {
            //notyet,waiting,success,reject
            switch (statuspayment) {
                case 'notyet':
                    memoStatusPayment = "Belum melakukan pembayaran";
                    break;
                case 'waiting':
                    memoStatusPayment = "Pembayaran sedang diproses";
                    break;
                case 'success':
                    memoStatusPayment = "Pembarayan telah dikonfirmasi";
                    break;
                case 'reject':
                    memoStatusPayment = "Pembarayan ditolak";
                    break;
                default:
                    memoStatusPayment = "-";
            }
            ssql = `INSERT INTO dbttranshistory (TransID,DocNumber,Status,Notes,TimeCreated) values ("` + dataDocument.ID + `","` + dataDocument.DocNumber + `","new","` + memoStatusPayment + `",now());`
            flag = true
        }
        if (dataDocument.Status != statustrans) {
            // open,processed,awaiting,complete,canceled
            switch (statustrans) {
                case 'open':
                    memoStatusTrans = "Transaksi diperbarui";
                    break;
                case 'processed':
                    memoStatusTrans = "Transaksi diproses";
                    break;
                case 'awaiting':
                    memoStatusTrans = "Transaksi sedang diproses";
                    break;
                case 'complete':
                    memoStatusTrans = "Transaksi berhasil";
                    break;
                case 'canceled':
                    memoStatusTrans = "Transaksi dibatalkan";
                    break;
                default:
                    memoStatusTrans = "-";
            }
            ssql = ssql + `\n INSERT INTO dbttranshistory (TransID,DocNumber,Status,Notes,TimeCreated) values ("` + dataDocument.ID + `","` + dataDocument.DocNumber + `","new","` + memoStatusTrans + `",now());`
            flag = true
        }
        if (flag) {
            new Promise((resolve) => { router_module.ExecQuery(ssql, resolve) })
                .then((result) => {
                    if (result.err) res.send("Gagal menyimpan")
                    else res.send('true')
                }).catch((result) => { res.send(result.error) });
        } else {
            res.send('true')
        }
    }

    const UpdateData = () => {
        let ssql = 'UPDATE `dbttransdoc` SET `Status`="' + statustrans + '", `StatusPayment`="' + statuspayment + '" WHERE `ID`="' + transid + '"'
        new Promise((resolve) => { router_module.ExecQuery(ssql, resolve) })
            .then((result) => {
                if (result.err) res.send("Gagal menyimpan")
                else UpdateHistory()
            }).catch((result) => { res.send(result.error) });
    }
    const CheckData = () => {
        new Promise((resolve) => { router_module.OpenQuery('SELECT ID,DocNumber,Status,StatusPayment FROM dbttransdoc where Docnumber="' + docnumber + '";', resolve) })
            .then((result) => {
                if (result.dataset.length > 0) {
                    dataDocument = result.dataset[0]
                    UpdateData()
                } else res.send("Data invalid")
            }).catch((result) => { res.send(result.error) });
    }
    CheckData()
}

exports.profilesave = (req, res) => {
    let idaccount = req.session.idaccount
    let displayname = router_module.EscapeString(req.body.displayname)
    let telp = router_module.EscapeString(req.body.telp)
    let city = router_module.EscapeString(req.body.city)
    let address = router_module.EscapeString(req.body.address)
    let codepos = router_module.EscapeString(req.body.codepos)

    const UpdateData = () => {
        let ssql = 'UPDATE dbmaccount SET DisplayName="' + displayname + '", Phone="' + telp + '", Address="' + address + '", City="' + city + '", CodePos="' + codepos +
            '" where ID="' + idaccount + '";';

        let pool = app.module_app();
        pool.getConnection(function (err, connection) {
            if (err) throw err;
            connection.query(ssql, function (err, result) {
                connection.release();
                if (err) {
                    console.log(err)
                    res.send('false')
                } else res.send('true')
            });
        });
    }

    new Promise((resolve) => { router_module.OpenQuery('SELECT ID FROM dbmaccount where id="' + idaccount + '";', resolve) })
        .then((result) => {
            if (result.dataset.length > 0) UpdateData()
            else res.send("/relogin")
        }).catch((result) => { res.send(result.error) });
}

exports.transactionsender = (req, res) => {
    let idaccount = req.session.idaccount
    let namereceipt = router_module.EscapeString(req.query.namereceipt)
    let emailreceipt = router_module.EscapeString(req.query.emailreceipt)
    let numberreceipt = router_module.EscapeString(req.query.numberreceipt)
    let city = router_module.EscapeString(req.query.city)
    let address = router_module.EscapeString(req.query.address)
    let codePos = router_module.EscapeString(req.query.codePos)
    let notes = router_module.EscapeString(req.query.notes)

    if ((idaccount == 'undefined') || (idaccount == '') || (idaccount == null)) idaccount = 0

    const SaveTransaction = () => {
        let itemcart = []
        if (req.session.itemcart != undefined) itemcart = req.session.itemcart
        let ssqldata = '';
        for (let i = 0; i < itemcart.length; i++) ssqldata = ssqldata + `\n (@TransID,@DocNumber,"` + itemcart[i].itemid + `","` + itemcart[i].qty + `","0"),`
        ssqldata = ssqldata.replace(/.$/, ";") // replace last character

        let ssqlInsertTransaction = `INSERT INTO dbttransdoc (IDAccount,TimeCreated,TimeUpdated,STATUS,ShippingRecipient,ShippingEmail,ShippingPhone,ShippingAddress,ShippingCity,ShippingCodePos,PaymentProof,ShippingPaymentPerson,ShippingPaymentNumber,ShippingPaymentBank,StatusPayment,Notes)`
            + `SELECT "` + idaccount + `",NOW(),NOW(),"open","` + namereceipt + `","` + emailreceipt + `","` + numberreceipt + `","` + address + `","` + city + `","` + codePos + `","","","","","notyet","` + notes + `";` + // data account
            `SELECT LAST_INSERT_ID() INTO @TransID;
        SET @DocNumber=(SELECT  CONCAT(DATE_FORMAT(NOW(),"%d%m%y"),@TransID));
        UPDATE dbttransdoc SET DocNumber=@DocNumber WHERE ID=@TransID;
        INSERT INTO dbttransdetail (TransID, DocNumber,IDProduct,Qty,Price) VALUES `+ ssqldata + `
        UPDATE dbttransdetail a LEFT JOIN dbmproduct b ON a.IDProduct=b.ID SET a.Price=b.Price, a.Total=(b.Price*a.QTy) WHERE TransID=@TransID ;
        UPDATE dbttransdoc SET GrandTotal=(SELECT COALESCE(SUM(Price*Qty),0) FROM dbttransdetail WHERE DocNumber=@DocNumber) WHERE DocNumber=@DocNumber;
        INSERT INTO dbttranshistory (TransID,DocNumber,Status,Notes,TimeCreated) values (@TransID,@DocNumber,"new","Transaksi dibuat",now());
        SELECT DocNumber,DATE_FORMAT(TimeCreated,"%d %b %Y") as Tanggal  FROM dbttransdoc where ID=@TransID;
        `

        new Promise((resolve) => { router_module.OpenQuery(ssqlInsertTransaction, resolve) })
            .then((result) => {
                if (result.dataset[8].length > 0) {
                    console.log('customer order')
                    req.session.itemcart = []
                    res.json({ status: true, invoice: result.dataset[8][0].DocNumber, tanggal: result.dataset[8][0].Tanggal })
                } else res.json({ status: false, message: 'Gagal melakukan pemesanan' })
            }).catch((result) => { res.send(result.error) });
    }

    const CheckifCartNull = () => {
        let itemcart = []
        if (req.session.itemcart != undefined) itemcart = req.session.itemcart
        if (itemcart.length != 0) SaveTransaction()
        else res.json({ status: false, message: 'Tidak bisa melanjutkan karena pemesanan daftar barang kosong' })
    }

    const CheckData = () => {
        if ((namereceipt == '') || (numberreceipt == '') ||
            (address == '') || (city == '') || (codePos == '')) {
            res.json({ status: false, message: 'Mohon lengkapi data pengiriman' })
        } else CheckifCartNull()
    }
    CheckData()
}

exports.filemanagersave = (req, res) => {
    let datafile = req.files.datafile
    let namefile = router_module.EscapeString(req.body.namefile)

    let namefiledata = null
    let iddata = null
    let spath = ''

    const ConvertThumbnail = () => {
        Jimp.read(uploadPath)
            .then(lenna => {
                return lenna
                    .quality(60) // set JPEG quality
                    .write(__dirname + '/temp/filesmanager/tmp_' + spath); // save
            })
            .catch(err => {
                console.error(err);
            });
    }

    const UpdateData = () => {
        let ssql = `Update dbmfilesmanager set NameFile="` + namefile + `", Path="` + spath + `"  where ID="` + iddata + `"`
        new Promise((resolve) => { router_module.ExecQuery(ssql, resolve) })
            .then((result) => {
                if (result.err) res.send("false")
                else res.send('true')
            }).catch((result) => { res.send(result.error) });
    }

    function SaveFile() {
        spath = namefiledata + datafile.name
        uploadPath = __dirname + '/temp/filesmanager/' + spath;
        datafile.mv(uploadPath, function (err) {
            if (err) res.send('Gagal mengupload file')
            else{
                ConvertThumbnail()
                UpdateData()
            } 
        });
    }
    function SaveData() {
        // let ssql = `INSERT INTO dbmfilesmanager (NameFile,Path,TimeCreated) values ("`+namefile+`","`+spathFile+`",now());`
        let ssql = ` INSERT INTO dbmfilesmanager (TimeCreated)VALUES(NOW());
                    SELECT CONCAT(DATE_FORMAT(NOW(),'%y%m%d'),LAST_INSERT_ID(),"-`+ namefile + `") AS namedata, LAST_INSERT_ID() as IDData;`
        new Promise((resolve) => { router_module.OpenQuery(ssql, resolve) })
            .then((result) => {
                if (result.dataset.length > 0) {
                    namefiledata = result.dataset[1][0].namedata
                    iddata = result.dataset[1][0].IDData
                    SaveFile()
                } else res.send('false');
            }).catch((result) => { res.send(result.error) })


    }
    if (Object.keys(req.files).length == 0) res.send('No files were uploaded.')
    else SaveData()
}

exports.filemanagerdelete = (req, res) => {
    let iddata = router_module.EscapeString(req.params.iddata)
    let pathData = ''

    const DeleteFile = () => {
        fileData = __dirname + '/temp/filesmanager/' + pathData;
        fs.unlink(fileData, function (err) {
            if (err) throw err;
            res.send('true')
        });
    }

    const DeleteData = () => {
        new Promise((resolve) => { router_module.ExecQuery("Delete from `dbmfilesmanager` WHERE ID='" + iddata + "';", resolve) })
            .then((result) => {
                if (result.err) res.send("false")
                else DeleteFile()
            }).catch((result) => { res.send(result.error) });
    }

    const ChooseData = () => {
        let ssql = `SELECT * FROM dbmfilesmanager where ID="` + iddata + `"`
        new Promise((resolve) => { router_module.OpenQuery(ssql, resolve) })
            .then((result) => {
                if (result.dataset.length > 0) {
                    pathData = result.dataset[0].Path
                    DeleteData()
                } else res.send('false');
            }).catch((result) => { res.send(result.error) })
    }
    ChooseData()
}

exports.clientpaymentupload = (req, res) => {
    let proof = req.files.proof
    let docnumber = router_module.EscapeString(req.body.docnumber)
    let bank = router_module.EscapeString(req.body.bank)
    let namebank = router_module.EscapeString(req.body.namebank)
    let numberbank = router_module.EscapeString(req.body.numberbank)
    let amount = router_module.EscapeString(req.body.amount)

    const ConvertThumbnail = () => {
        Jimp.read(uploadPath)
            .then(lenna => {
                return lenna
                    .quality(60) // set JPEG quality
                    .write( __dirname + '/temp/paymentproof/tmp_' + proof.name); // save
            })
            .catch(err => {
                console.error(err);
            });
    }

    function SaveFile() {
        if (Object.keys(req.files).length == 0) res.send('No files were uploaded.')
        else {
            uploadPath = __dirname + '/temp/paymentproof/' + proof.name;
            proof.mv(uploadPath, function (err) {
                if (err) res.send('Gagal mengupload file')
                else{
                    ConvertThumbnail()
                    SaveDataPayment(proof.name)
                } 
            });
        }
    }

    function SaveDataPayment(spathFile) {
        let ssql = `UPDATE dbttransdoc SET StatusPayment="waiting", PaymentProof='` + spathFile + `',ShippingPaymentPerson='` + namebank + `',ShippingPaymentNumber='` + numberbank + `',
                    ShippingPaymentBank='` + bank + `',ShippingAmount='` + amount + `' WHERE DocNumber='` + docnumber + `';
                    INSERT INTO dbttranshistory (TransID,DocNumber,Status,Notes,TimeCreated) values (0,"`+ docnumber + `","new","Upload pembayaran",now());`
        new Promise((resolve) => { router_module.ExecQuery(ssql, resolve) })
            .then((result) => {
                if (result.err) res.send("false")
                else res.send('true')
            }).catch((result) => { res.send(result.error) });
    }

    // Main
    new Promise((resolve) => { router_module.OpenQuery('SELECT * FROM dbttransdoc where DocNumber="' + docnumber + '";', resolve) })
        .then((result) => {
            if (result.dataset.length > 0) SaveFile()
            else res.send("Pembayaran invalid, Data invoice tidak di temukan !")
        }).catch((result) => { res.send(result.error) });
}

exports.bannersave = (req, res) => {
    let mode = req.query.mode
    let iddata = router_module.EscapeString(req.query.iddata)

    let judul = router_module.EscapeString(req.query.judul)
    let content = router_module.EscapeString(req.query.content)
    let urlimage = router_module.EscapeString(req.query.urlimage)
    let isshow = router_module.EscapeString(req.query.isshow)

    function SaveData() {
        let ssqlSave = '';
        if (mode == 'edit') ssqlSave = "UPDATE dbtbanner SET Caption='" + judul + "', Content='" + content + "', ImageUrl='" + urlimage + "', isShow='" + isshow + "' where ID='" + iddata + "'";
        else if (mode == 'add') ssqlSave = "INSERT INTO dbtbanner (Caption,Content,ImageUrl,isShow) VALUES ('" + judul + "','" + content + "','" + urlimage + "','" + isshow + "')";
        new Promise((resolve) => { router_module.ExecQuery(ssqlSave, resolve) })
            .then((result) => {
                if (result.err) res.send("false")
                else res.send('true')
            }).catch((result) => { res.send(result.error) });
    }

    if (mode == 'add') SaveData()
    else {
        let ssql = '';
        ssql = 'SELECT * FROM dbtbanner where ID="' + iddata + '";'
        new Promise((resolve) => { router_module.OpenQuery(ssql, resolve) })
            .then((result) => {
                if (result.dataset.length = 0) res.send("Data banner tidak ditemukan")
                else SaveData()
            })
            .catch((result) => {
                res.send(result.error)
            });
    }
}

exports.bannerdelete = (req, res) => {
    let iddata = router_module.EscapeString(req.params.iddata);
    new Promise((resolve) => { router_module.ExecQuery("Delete from `dbtbanner` WHERE ID='" + iddata + "';", resolve) })
        .then((result) => {
            if (result.err) res.send("false")
            else res.send('true')
        }).catch((result) => { res.send(result.error) });
}

exports.categorysave = (req, res) => {
    let mode = req.query.mode;
    let iddata = router_module.EscapeString(req.query.iddata);
    let nameCategory = router_module.EscapeString(req.query.namecategory);
    let urlimage = router_module.EscapeString(req.query.urlimage);

    function SaveData() {
        let ssqlSave = '';
        if (mode == 'edit') ssqlSave = "UPDATE dbmcategory SET NameCategory='" + nameCategory + "', ImageUrl='" + urlimage + "' where ID='" + iddata + "'";
        else if (mode == 'add') ssqlSave = "INSERT INTO dbmcategory (NameCategory, ImageUrl) VALUES ('" + nameCategory + "', '" + urlimage + "')";
        new Promise((resolve) => { router_module.ExecQuery(ssqlSave, resolve) })
            .then((result) => {
                if (result.err) res.send("false")
                else res.send('true')
            }).catch((result) => { res.send(result.error) });
    }

    if (mode == 'add') SaveData()
    else {
        let ssql = '';
        ssql = 'SELECT * FROM dbmcategory where ID="' + iddata + '";'
        new Promise((resolve) => { router_module.OpenQuery(ssql, resolve) })
            .then((result) => {
                if (result.dataset.length = 0) res.send("Data kategori tidak ditemukan")
                else SaveData()
            })
            .catch((result) => {
                res.send(result.error)
            });
    }
}

exports.categorydelete = (req, res) => {
    let iddata = router_module.EscapeString(req.params.iddata);

    // new Promise((resolve) => { router_module.ExecQuery("Delete from `dbmcategory` WHERE ID='" + iddata + "';", resolve) })
    new Promise((resolve) => { router_module.ExecQuery("Update `dbmcategory` Set isDelete=1 WHERE ID='" + iddata + "';", resolve) })
        .then((result) => {
            if (result.err) res.send("false")
            else res.send('true')
        }).catch((result) => { res.send(result.error) });
}

exports.folderfilemanager = (req, res) => {
    let idfile = req.params.idfile
    let spath = path.join(__dirname + '/temp/filesmanager') + '/' + idfile
    fs.access(spath, fs.F_OK, (err) => {
        if (err) {
            console.error(err)
            res.send('Data not found')
            return
        }
        res.sendfile(spath)
    })
}