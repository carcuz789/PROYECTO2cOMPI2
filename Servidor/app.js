"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Lista_Original;
var Lista_comparar;
var express = require("express");
var cors = require("cors");
var bodyParser = require("body-parser");
var gramatica = require("./AnalizadorCsharp/GramaticaCsh");
var gramaticatrauc = require("./AnalizadorCsharp/GramaticaCshTrad");
var Errores_1 = require("./CshAST/Errores");
var TOKENS = require("./CshAST/TOKENS");
var app = express();
app.use(bodyParser.json());
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.post('/Calcular/', function (req, res) {
    var entrada = req.body.text;
    var resultado = parser(entrada);
   

    var err = Errores_1.Errores.geterror();
    console.log(err);
    
    //document.getElementById("tabla").innerHTML = err;
    res.send(resultado.toString());
    Errores_1.Errores.clear();
});
app.post('/Calcular2/', function (req, res) {
    var entrada = req.body.text;
    
    var resultado = traducir(entrada);

    
    //document.getElementById("tabla").innerHTML = err;
    res.send(resultado.toString());
    
});
app.post('/Error/', function (req, res) {
    var entrada = req.body.text;
    var resultado = parser(entrada);


    var err = Errores_1.Errores.geterror();
    //console.log(err);
    
    //document.getElementById("tabla").innerHTML = err;
    res.send(err);
    Errores_1.Errores.clear();
});
/*---------------------------------------------------------------*/
var server = app.listen(8080, function () {
    console.log('Servidor escuchando en puerto 8080...');

});
/*---------------------------------------------------------------*/

var app1 = express();
app1.use(bodyParser.json());
app1.use(cors());
app1.use(bodyParser.urlencoded({ extended: true }));
app1.post('/EnvioTok/', function (req, res1) {
    var entrada1 = req.body.text;
    var resultado1 = parser1(entrada1);

    res1.send(resultado1);
    while (resultado1.length > 0) {
        resultado1.pop();
    }
});
/*---------------------------------------------------------------*/
var server = app1.listen(8081, function () {
    //console.log('Servidor escuchando en puerto 8081...');

});



var app2 = express();
app2.use(bodyParser.json());
app2.use(cors());
app2.use(bodyParser.urlencoded({ extended: true }));
app2.post('/EnvioTokCopia/', function (req, res2) {
    var entrada2 = req.body.text;
    var resultado2 = parser2(entrada2);
  
     
    res2.send(resultado2);
    while (resultado2.length > 0) {
        resultado2.pop();
    }
});
/*---------------------------------------------------------------*/
var server = app2.listen(8082, function () {
   // console.log('Servidor escuchando en puerto 8082...');

});


function parser(texto) {
    try {

        return gramatica.parse(texto);
    }
    catch (e) {
        return "Error en compilacion de Entrada1: " + e.toString();
        // return texto+"Error1";
    }
}

function traducir(texto) {
    try {

        return gramaticatrauc.parse(texto);
    }
    catch (e) {
        return "Error en compilacion de Entrada1: " + e.toString();
        // return texto+"Error1";
    }
}



