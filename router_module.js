const app = require('./app.js');

exports.OpenQuery = (ssql, resolve) => {
    setTimeout(() => {
        // connect mysql to query
        let pool = app.module_app();
        pool.getConnection(function (err, connection) {
            if (err) throw err;
            connection.query(ssql, function (error, results, fields) {
                connection.release();
                if (error) throw error;
                sdatareturn = {
                    error: error,
                    dataset: results,
                    fields: fields,
                }
                resolve(sdatareturn)
            });
        });
        // ----        
    }, 100);
}

exports.Sessionaccount = (req) => {
    let sstatus = '';
    if (!req.session.email) sstatus = 'false';
    else  sstatus = 'true'
    let stemp = {
        'idaccount': req.session.idaccount,
        'status': sstatus,
        'email': req.session.email,
        'password': req.session.password
    }
    return stemp;
}

exports.ExecQuery = (ssql, resolve) => {
    setTimeout(() => {
        // connect mysql to query
        let pool = app.module_app();
        pool.getConnection(function (err, connection) {
            if (err) throw err;
            connection.query(ssql, function (err, result) {
                connection.release();
                if (err) throw err;
                sdatareturn = {
                    error: err,
                    dataset: result,
                }
                resolve(sdatareturn)
            });
        });
        // ----    
    }, 100);
}

exports.EscapeString = (unsafe)=>{
    return unsafe
         .replace(/&/g, "&amp;")
         .replace(/</g, "&lt;")
         .replace(/>/g, "&gt;")
         .replace(/"/g, "&quot;")
         .replace(/'/g, "&#039;");
}

exports.ChechMaxLimitData = (ctdata)=>{
    let ctdatatemp = 0
    if ((ctdata == 'undefined') || (ctdata == '') || (ctdata == null)) ctdatatemp = 1
    else ctdatatemp = ctdata
    return ctdatatemp
}


class cart {
    constructor(itemid, qty) {
        this.itemid = itemid
        this.qty = qty
    }
}

exports.Cartdataobject =  class cartdataobject {
    check(keyitemid) {
        var flag = true
        for (let i = 0; i < this.dataitemcart.length; i++) {
            if (this.dataitemcart[i].itemid == keyitemid) {
                flag = false
            }
        }
        return flag
    }
    add(dataitemcart,itemid, qty) {
        this.dataitemcart = dataitemcart
        if (this.check(itemid)) {
            this.dataitemcart.push(new cart(itemid, qty))
            return true
        } else return false
    }
    edit(dataitemcart,itemid, qty) {
        this.dataitemcart = dataitemcart
        if (this.check(itemid)==false) {
            for (let i = 0; i < this.dataitemcart.length; i++) {
                if (this.dataitemcart[i].itemid == itemid) {
                    this.dataitemcart[i].qty = qty
                    break
                }
            }
            return true
        } else return false
    }
    delete(dataitemcart,keyitemid) {
        this.dataitemcart = dataitemcart
        if (this.check(keyitemid)==false) {
            for (let index = 0; index < this.dataitemcart.length; index++) {
                if (this.dataitemcart[index].itemid == keyitemid) {
                    this.dataitemcart.splice(index, 1);
                }
            }
            return true
        } else return false
    }
}

exports.Macrobyname = (swords,strold,strnew) =>{
    var sRegExInput = new RegExp(strold, "g");  // using regular expresion REGEX
    let ssqldata = swords.replace(sRegExInput, `"`+strnew+`"`) 
    return ssqldata
}