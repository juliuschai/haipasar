const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const ejs = require('ejs');
var session = require('express-session')
const fileUpload = require('express-fileupload');
const router_module = require('./router_module.js');
const router_api = require('./route_api.js');
const router_views = require('./router_views.js');


// ----------------------------------- [Engine]
// [ExpressJS]
const app = express()
const port = 80 // 3000

// [Express file upload]
app.use(fileUpload());

// [EJS tempalte engine]
app.use(express.static('views')) // static web router
app.engine('html', ejs.renderFile);
app.set('view engine', 'html');

// [Body Parser middleware]
app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

// [Mysql Engine]
var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit: 10,
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'dbhaipasar',
  multipleStatements: true
});

// [Express Session]
var session = require('express-session')
app.use(session({
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: true
}))


// ----------------------------------- [Main]
var myLogger = function (req, res, next) {
  if (!req.session.init) {
    let datesesi = new Date();
    req.session.init = true
    console.log('log --> ip :' + req.connection.remoteAddress.split(`:`).pop() + ' / time :' + datesesi);
  }
  next()
}
app.use(myLogger)

// ---------[static web router]
app.use(express.static('assets'))
app.use(express.static('temp/paymentproof'))
app.get('/file/:idfile', router_api.folderfilemanager)

// ---------[Rest API]
//client rest
app.post('/register', router_api.registeraccount)
app.post('/login', router_api.login)
app.get('/logout', router_api.logout)
app.post('/clientpaymentupload', router_api.clientpaymentupload)
app.get('/transactionsender', router_api.transactionsender)

app.get('/cartadd/:itemid/:qty', router_api.cartadd)
app.get('/cartdelete/:itemid', router_api.cartdelete)
app.get('/cartedtqty/:itemid/:qty', router_api.carteditqty)
app.post('/profilesave', router_api.profilesave)
//admin reset
app.post('/adminchangedataorder', router_api.adminchangedataorder)
app.get('/bannersave', router_api.bannersave)
app.get('/bannerdelete/:iddata', router_api.bannerdelete)
app.post('/filemanagersave', router_api.filemanagersave)
app.get('/filemanagerdelete/:iddata', router_api.filemanagerdelete)
app.get('/categorysave', router_api.categorysave)
app.get('/categorydelete/:iddata', router_api.categorydelete)
app.get('/productadd', router_api.productadd)
app.get('/productdelete/:iddata', router_api.productdelete)


// ---------[Views Client]
app.get('/register', (req, res) => { res.render(path.join(__dirname + '/views') + '/register.html', {}) })
app.get('/login', (req, res) => { res.render(path.join(__dirname + '/views') + '/login.html', {}) })
app.get('/', router_views.main)
app.get('/main_listproduct', router_views.main_listproduct)
app.get('/product/:iddata', router_views.productdetail)
app.get('/cart', router_views.cart)
app.get('/checktransaction', router_views.checktransaction)
app.get('/checktransaction_list', router_views.checktransaction_list)
app.get('/inputpayment', router_views.inputpayment)

app.get('/registerdriver', router_views.registerdriver)
app.get('/registermitra', router_views.registermitra)
app.get('/about', (req, res) => { router_views.renderform(req, res, 'other_about.html') })
app.get('/helpcenter', (req, res) => { router_views.renderform(req, res, 'other_helpcenter.html') })

// client dashboard
app.get('/dashboard', router_views.clientdashboard)
app.get('/dashboardorder', router_views.clientorder)
app.get('/dashboardorder_list', router_views.clientorder_list)
app.get('/dashboardorderdetail', router_views.clientorderdetail)
app.get('/dashboardprofile', router_views.clientprofile)

// admin dashboard
app.get('/admin', router_views.admin)
app.post('/adminlogin', router_api.adminlogin)
app.get('/adminlogout', (req, res) => {
  req.session.idadmin = '';
  req.session.usernameadmin = '';
  req.session.passwordadmin = '';
  res.redirect('/admin');
})
app.get('/admininformation', router_views.admininformation)
app.get('/adminorder', router_views.adminorder)
app.get('/adminorder_list', router_views.adminorder_list)
app.get('/adminorderdetail', router_views.adminorderdetail)
app.get('/adminproduct', router_views.adminproduct)
app.get('/admincategory', router_views.admincategory)
app.get('/adminbanner', router_views.adminbanner)
app.get('/adminfilesmanager', router_views.adminfilesmanager)


// ---------[Debug / testing]
app.get('/testlogin', function (req, res) { res.send(req.session) })
// ----------------------------------- [End Main]
exports.module_app = () => { return pool };

app.listen(port, () => console.log(`App listening on port ${port}!`))