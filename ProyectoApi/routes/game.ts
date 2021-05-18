import * as express from 'express';
const app = express();
/*
app.post("/saludarTo", (req, res,next) => {
    res.json({ message: saludos[Math.trunc(Math.random()*saludos.length)]+ " "+req.body.quien});
});

app.post("/saludarTo", (req, res,next) => {
    res.json({id : req.body.id});
});*/
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
  });
  
export { app as gamerouter };