const express = require('express');
const cors = require('cors');
const app = express();
const bodyParser = require('body-parser')
const port = 3000;

app.use(cors());
app.use(bodyParser.urlencoded({extended: false}));
app.use(express.static(__dirname));

app.get('/', (req, res) => {
    res.sendFile(__dirname +"/index.html")
});

app.listen(port, () => {
    console.log(`Example app listening on port ${port}!`)
});


var mysql = require('mysql');

var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "ebook",
    dateStrings: true
});

con.connect(function(err) {
    if (err) throw err;
    console.log("Connected!");
});

app.get('/book', (req, res) => {
    con.query(`SELECT b.*, CONCAT_WS(' ', a.FName, a.MName, a.LName) as Author
    FROM book b
    LEFT OUTER JOIN writtenby wb ON (wb.IDBook = b.IDBook)
    LEFT OUTER JOIN author a on (wb.IDAuthor = a.IDAuthor)`, 
    function (err, result, fields) {
        if (err) throw err;
        res.send(result)
    });
});

app.get('/publisher', (req, res) => {
    con.query(`SELECT * FROM publisher`, function (err, result, fields) {
        if (err) throw err;
        res.send(result)
    });
});

app.get('/author', (req, res) => {
    con.query(`SELECT * FROM author`, function (err, result, fields) {
        if (err) throw err;
        console.log(result);
        res.send(result)
    });
});

app.post('/add-book', function(req, res){
    const form = req.body;
    console.log(form);
    form.inputPublisher = form.inputPublisher == '' ? 'NULL' : `'${form.inputPublisher}'`;
    con.query(`INSERT INTO book (IDBook, CurrentBookPrice, NameBook, CoverImage, BookSummary, BookPrice, BNamePublisher, PublisherYear, PublisherTime) 
    VALUES 
    ('${form.bookId}', NULL, '${form.inputName}', '${form.inputCover}', '${form.inputSum}', '${form.inputPrice}', ${form.inputPublisher},
    '${form.inputDate.substring(0, 4)}', '${form.inputDate}')`, 
    function (err, result, fields) {
        if (err) throw err;
        res.redirect('back');
    });
});

app.post('/edit-book', function(req, res){

    const form = req.body;
    console.log(form);
    form.inputPublisher = form.inputPublisher == '' ? 'NULL' : `'${form.inputPublisher}'`;
    con.query(`UPDATE book 
    SET NameBook = '${form.inputName}', CoverImage = '${form.inputCover}', BookSummary = '${form.inputSum}', BookPrice =  '${form.inputPrice}', BNamePublisher  =${form.inputPublisher},
    PublisherYear ='${form.inputDate.substring(0, 4)}', PublisherTime =  '${form.inputDate}'
    WHERE IDBook = '${form.bookId}'`, function (err, result, fields) {
        if (err) throw err;
        res.redirect('back');
    });
});

app.post('/delete-book', function(req, res){

    const form = req.body;
    console.log(form);
    con.query(`DELETE FROM book WHERE IDBook = '${form.bookId2}'`, function (err, result, fields) {
        if (err) throw err;
        res.redirect('back');
    });
});

app.post('/add-author', function(req, res){
    const form = req.body;
    console.log(form);

    con.query(`INSERT INTO author (IDAuthor, Fname, Mname, Lname, AddressAuthor, EmailAuthor, PhoneAuthor)
    VALUES 
    ('${form.inputId}', '${form.inputFName}', '${form.inputMName}', '${form.inputLName}', '${form.inputAdd}', '${form.inputPhone}', '${form.inputEmail}')`, 
    function (err, result, fields) {
        if (err) throw err;
        res.redirect('back');
    });
});

app.post('/edit-author', function(req, res){

    const form = req.body;
    console.log(form);
    con.query(`UPDATE author 
    SET Fname = '${form.inputFName}', Mname = '${form.inputMName}', Lname = '${form.inputLName}', 
    AddressAuthor = '${form.inputAdd}', EmailAuthor = '${form.inputEmail}', PhoneAuthor = '${form.inputPhone}'
    WHERE IDAuthor = '${form.inputId}'`, function (err, result, fields) {
        if (err) throw err;
        res.redirect('back');
    });
});

app.post('/delete-author', function(req, res){

    const form = req.body;
    con.query(`DELETE FROM author WHERE IDAuthor = '${form.inputId2}'`, function (err, result, fields) {
        if (err) throw err;
        res.redirect('back');
    });
});


app.post('/add-publisher', function(req, res){
    const form = req.body;
    console.log(form);

    con.query(`INSERT INTO publisher (NamePublisher, AddressPublisher, PhonePublisher, EmailPublisher, BusinessCode)
    VALUES 
    ('${form.inputName}', '${form.inputAdd}', '${form.inputPhone}', '${form.inputEmail}', '${form.inputCode}')`, 
    function (err, result, fields) {
        if (err) throw err;
        res.redirect('back');
    });
});

app.post('/edit-publisher', function(req, res){

    const form = req.body;
    console.log(form);
    con.query(`UPDATE publisher
    SET AddressPublisher = '${form.inputAdd}', EmailPublisher = '${form.inputEmail}', PhonePublisher = '${form.inputPhone}', BusinessCode = '${form.inputCode}'
    WHERE NamePublisher = '${form.inputName}'`, function (err, result, fields) {
        if (err) throw err;
        res.redirect('back');
    });
});

app.post('/delete-publisher', function(req, res){

    const form = req.body;
    con.query(`DELETE FROM publisher WHERE NamePublisher = '${form.inputName2}'`, function (err, result, fields) {
        if (err) throw err;
        res.redirect('back');
    });
});