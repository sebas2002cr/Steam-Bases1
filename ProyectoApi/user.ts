/*'use strict'

const express = require('express')
const bodyParser = require('body-parser')

const app = express()
const port = process.env.PORT || 5000

app.use(bodyParser.urlencoded({extended:false}))
app.use(bodyParser.json())

app.get('/api/datos',(req,res) => {
    res.send({massage : `Hola ${req.params.name}!`})
})

app.listen(port,() => {
    console.log(`API REST corriendo en http:localhost:${port}`)
    
})/*