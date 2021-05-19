import * as express from 'express';
const app = express();

var mysql      = require('mysql');
const connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'me',
  password : 'secret',
  database : 'my_db'
});

connection.connect();

connection.query('SELECT 1 + 1 AS solution', function (error:any, results:any, fields:any) {
  if (error) throw error;
  else{
    app.post('/item', function(req, res) {
        var data = req.body.data;
        res.send('Add ' + data);
        console.log('Add ' + data);
     });
  }
  console.log('The solution is: ', results[0].solution);
});

connection.end();
/*
//Create
//Ejemplo: POST http://localhost:8080/item
app.post('/item', function(req, res) {
    var data = req.body.data;
    res.send('Add ' + data);
    console.log('Add ' + data);
 });
//GetAll
//Ejemplo: GET http://localhost:8080/item
app.get('/item', function(req, res, next) {
    if(req.query.filter) {
     next();
     return;
    }
    res.send('Get all');
    console.log('Get all');
  });*/

export { app as gamerouter };