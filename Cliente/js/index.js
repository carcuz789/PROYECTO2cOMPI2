


var Lista_Original = new Array();
var Lista_Copia = new Array();
var Lista_Copia2 = new Array();
class General {

    constructor(id, tipo, clase, metodo, parametro, tipo1, CantidadF, CantidadM) {
        this.id = id;
        this.tipo = tipo;
        this.clase = clase;
        this.metodo = metodo;
        this.parametro = parametro;
        this.tipo1 = tipo1;
        this.CantidadF = CantidadF;
        this.CantidadM = CantidadM;
    }
}

function Conn() {

    var ini = 0;
    var texto = document.getElementById("operacion").value;
    // //  console.log(texto);

    var url = 'http://localhost:8080/Calcular/';

    $.post(url, { text: texto }, function (data, status) {
        if (status.toString() == "success") {
            var ast = data.toString();
            //   var cadena = "";
            //$("#Muestra1").html(ast);
            var arbolito = data.toString();
            console.log(data.toString());
            console.log("llega la data -----------------");
            arbol(arbolito);


        } else {
            alert("Error estado de conexion:" + status);
        }
    });


    var url4 = 'http://localhost:8080/Error/';

    $.post(url4, { text: texto }, function (data, status) {
        if (status.toString() == "success") {
            var ast = data.toString();
            document.getElementById("TablaError").innerHTML = ast;
            // $("#Muestra1").html(ast);

        } else {
            alert("Error estado de conexion:" + status);
        }
    });
    var url1 = 'http://localhost:8081/EnvioTok/';

    $.post(url1, { text: texto }, function (data1, status1) {
        if (status1.toString() == "success") {
            var ast1 = data1;
            //Lista_Original = data1;
            // // console.log("Vamoooos" + ast1[0]+" "+ast1[1]);
            var cadena = "";

            for (var i = 0; i < ast1.length; i++) {

                 Lista_Copia2.push(ast1[i].toString());
             //   console.log(ast1[i].toString())
              //  if (ast1[i].toString() !== 'import' && ast1[i].toString() !== '{' && ast1[i].toString() !== '}' /*&& ast1[i].toString() !== ';'*/ && ast1[i].toString() !== ',' && ast1[i].toString() !== 'if' && ast1[i].toString() !== 'switch' && ast1[i].toString() !== 'while' && ast1[i].toString() !== 'do' && ast1[i].toString() !== 'for' && ast1[i].toString() !== 'System' && ast1[i].toString() !== 'out' && ast1[i].toString() !== 'print' && ast1[i].toString() !== 'println'/**/ && ast1[i].toString() !== '.' && ast1[i].toString() !== '%' && ast1[i].toString() !== ':' /*&& ast1[i].toString() !== ';'*/ && ast1[i].toString() !== ',' && ast1[i].toString() !== 'break' && ast1[i].toString() !== 'default' && ast1[i].toString() !== 'case' && ast1[i].toString() !== '==' && ast1[i].toString() !== '!=' && ast1[i].toString() !== '>=' && ast1[i].toString() !== '<=' && ast1[i].toString() !== '!' && ast1[i].toString() !== '&&' /**/ && ast1[i].toString() !== '||' && ast1[i].toString() !== '>' && ast1[i].toString() !== '<' /*&& ast1[i].toString() !== ';'*/ && ast1[i].toString() !== 'true' && ast1[i].toString() !== 'false' && ast1[i].toString() !== 'continue' && ast1[i].toString() !== 'return' && ast1[i].toString() !== 'else' && ast1[i].toString() !== '+' && ast1[i].toString() !== '-' && ast1[i].toString() !== '*' && ast1[i].toString() !== '/' && ast1[i].toString() !== '^') {
               //     cadena += ast1[i] + " ";
                    //console.log(cadena);
                  

            //    }
                Lista_Original.push(ast1[i].toString());
               
                //Reportes();
            }
           
            console.log("mechito");
            console.log(Lista_Original);
            // var textotabla = "<h1>TABLA DE SIMBOLOS</h1>";
            // document.getElementById("tablatokens").innerHTML =textotabla ;



        } else {
            alert("Error estado de conexion:" + status1);
        }
    });

    var texto1 = texto;
    var url2 = 'http://localhost:8082/EnvioTokCopia/';
    var TABLASIMBOLOS2="";
   TABLASIMBOLOS2 += "<h1>TABLA DE SIMBOLOS</h1><table class=\"default\"> ";
   TABLASIMBOLOS2 += "<tr><th>Nombre </th><th>Tipo Valor</th><th>Ambito</th></tr>";
    $.post(url2, { text: texto1 }, function (data2, status2) {
        if (status2.toString() == "success") {
            var ast2 = data2;
            //      Lista_Copia = data2;
            TABLASIMBOLOS2 += data2.toString();
            TABLASIMBOLOS2 +="</table>";
            var cadena = "";

            for (var i = 0; i < ast2.length; i++) {
                //console.log(ast1[i].toString())
                if (ast2[i].toString() !== 'import' && ast2[i].toString() !== '{' && ast2[i].toString() !== '}' /*&& ast1[i].toString() !== ';'*/ && ast2[i].toString() !== ',' && ast2[i].toString() !== 'if' && ast2[i].toString() !== 'switch' && ast2[i].toString() !== 'while' && ast2[i].toString() !== 'do' && ast2[i].toString() !== 'for' && ast2[i].toString() !== 'System' && ast2[i].toString() !== 'out' && ast2[i].toString() !== 'print' && ast2[i].toString() !== 'println'/**/ && ast2[i].toString() !== '.' && ast2[i].toString() !== '%' && ast2[i].toString() !== ':' /*&& ast1[i].toString() !== ';'*/ && ast2[i].toString() !== ',' && ast2[i].toString() !== 'break' && ast2[i].toString() !== 'default' && ast2[i].toString() !== 'case' && ast2[i].toString() !== '==' && ast2[i].toString() !== '!=' && ast2[i].toString() !== '>=' && ast2[i].toString() !== '<=' && ast2[i].toString() !== '!' && ast2[i].toString() !== '&&' /**/ && ast2[i].toString() !== '||' && ast2[i].toString() !== '>' && ast2[i].toString() !== '<' /*&& ast1[i].toString() !== ';'*/ && ast2[i].toString() !== 'true' && ast2[i].toString() !== 'false' && ast2[i].toString() !== 'continue' && ast2[i].toString() !== 'return' && ast2[i].toString() !== 'else' && ast2[i].toString() !== '+' && ast2[i].toString() !== '-' && ast2[i].toString() !== '*' && ast2[i].toString() !== '/' && ast2[i].toString() !== '^') {
                    cadena += ast2[i] + " ";
                    //console.log(cadena);
                    Lista_Copia.push(ast2[i].toString());
                }


                //Reportes();
            }
                console.log("mechito2");
                console.log(ast2);
                document.getElementById("tablatokens").innerHTML = TABLASIMBOLOS2;

            cadena = "";
            Reportes();

        } else {
            alert("Error estado de conexion:" + status2);
        }
    });

}
var L_Clase = new Array();
var L_Clase1 = new Array();
var aux = new Array();
var L_Variable = new Array();
var L_Variable1 = new Array();
var L_Metodo = new Array();
var L_Metodo1 = new Array();
var tipov = "", tipov1 = "", idv = "", idv1 = "", filav, columnav;
var Para1 = 0, Para2 = 0, mo = 0, CantidadM = 0, CantidadM1 = 0;
var texto = "";
var parametro = "", parametro1 = "", tipom = "", tipom1 = "";
var Ids = "", Ids1 = "";
var NClase = "", NClase1 = "";
var NMetodo = "", NMetodo1 = "", NMetodos = "", NMetodos1 = "", Nfuncion = "", Nfuncion1 = "";
var html1 = "", html2 = "", html3 = "", contador = 0, contador1 = 0;
var TABLASIMBOLOS="";

TABLASIMBOLOS += "<br><h3>TABLA DE SIMBOLOS</h3><table class=\"default\"> ";
TABLASIMBOLOS += "<tr><th>Nombre </th><th>Tipo Valor</th><th>Ambito</th></tr>";


// format ofi .dot

console.log(TABLASIMBOLOS);
function Reportes() {


    for (let index = 0; index < Lista_Original.length; index++) {
        var actual = Lista_Original[index];
        var actual1 = Lista_Original[index + 1];
        var actual2 = Lista_Original[index + 2];
        // console.log(actual + " actual");
        // console.log(actual1 + " actual1");
        // console.log(actual2 + " actual2");
        
        if ((actual === "class") && (contador == 0)) {
            console.log('es la clase ' + actual1);
            contador++;
            NClase = actual1;
        } else if ((actual === "class") && (contador != 0)) {
            L_Clase.push(new General("", "", NClase, NMetodos, "", "", CantidadM, 0));
            NClase = actual1;
            CantidadM = 0;
            // NClase = "";
            NMetodos = "";
            NMetodo="";
        }
        if (actual == "#" && index == (Lista_Original.length - 1)) {
            L_Clase.push(new General("", "", NClase, NMetodos, "", "", CantidadM, 0));
            NClase = actual1;
            CantidadM = 0;
            // NClase = "";
            NMetodos = "";
            NMetodo="";
        }

        switch (actual) {
            case 'int':
                if (actual2 === '(') {
                    console.log('es una funcion tipo int ' + actual1 + " de la clase");
                    TABLASIMBOLOS+= "<tr> <td>"+"es una funcion tipo int"+"</td><td>"+"int"+"</td><td>"+actual1+"</td></tr>";

                    CantidadM++;
                    tipom = "int";
                    NMetodos += actual1 + " ";
                    NMetodo = actual1;
                } else {
                    console.log('es una variable tipo int ' + actual1);
                    tipov = "int";
                    TABLASIMBOLOS+= " <tr><td>"+"variable tipo int"+"</td><td>"+"int"+"</td><td>"+actual1+"</td></tr>";
                    L_Variable.push(new General(actual1, tipov, NClase, NMetodo));
                    if (Lista_Original[index + 2] != ';') {
                        for (let w = index + 2; w < Lista_Original.length; w++) {
                            if (Lista_Original[w + 1] == ';') {
                                idv = Lista_Original[w];
                                L_Variable.push(new General(idv, tipov, NClase, NMetodo));
                                w++;
                                idv = "";
                                index = w;
                                break;
                            } else {
                                idv = Lista_Original[w];
                                L_Variable.push(new General(idv, tipov, NClase, NMetodo));
                            }
                        }
                    }
                }
                break;
            case 'String':
                if (actual2 === '(') {
                    console.log('es una funcion tipo String ' + actual1);
                    TABLASIMBOLOS+= "<tr> <td>"+"es una funcion tipo String"+"</td><td>"+"String"+"</td><td>"+actual1+"</td></tr>";

                    CantidadM++;
                    tipom = "String";
                    NMetodos += actual1 + " ";
                    NMetodo = actual1;
                } else {
                    console.log('es una variable tipo String ' + actual1);
                    TABLASIMBOLOS+= "<tr> <td>"+"es una variable tipo String"+"</td><td>"+"String"+"</td><td>"+actual1+"</td></tr>";

                    tipov = "String";
                    L_Variable.push(new General(actual1, tipov, NClase, NMetodo));
                    if (Lista_Original[index + 2] != ';') {
                        for (let w = index + 2; w < Lista_Original.length; w++) {
                            if (Lista_Original[w + 1] == ';') {
                                idv = Lista_Original[w];
                                L_Variable.push(new General(idv, tipov, NClase, NMetodo));
                                w++;
                                idv = "";
                                index = w;
                                break;
                            } else {
                                idv = Lista_Original[w];
                                L_Variable.push(new General(idv, tipov, NClase, NMetodo));
                            }
                        }
                    }
                }
                break;
            case 'char':
                if (actual2 === '(') {
                    console.log('es una funcion tipo char ' + actual1);
                    TABLASIMBOLOS+= "<tr> <td>"+"es una funcion tipo char"+"</td><td>"+"char"+"</td><td>"+actual1+"</td></tr>";

                    CantidadM++;
                    tipom = "char";
                    NMetodos += actual1 + " ";
                    NMetodo = actual1;

                } else {
                    console.log('es una variable tipo char ' + actual1);
                    TABLASIMBOLOS+= "<tr> <td>"+"es una variable tipo char"+"</td><td>"+"char"+"</td><td>"+actual1+"</td></tr>";

                    tipov = "char";
                    L_Variable.push(new General(actual1, tipov, NClase, NMetodo));
                    if (Lista_Original[index + 2] != ';') {
                        for (let w = index + 2; w < Lista_Original.length; w++) {
                            if (Lista_Original[w + 1] == ';') {
                                idv = Lista_Original[w];
                                L_Variable.push(new General(idv, tipov, NClase, NMetodo));
                                w++;
                                idv = "";
                                index = w;
                                break;
                            } else {
                                idv = Lista_Original[w];
                                L_Variable.push(new General(idv, tipov, NClase, NMetodo));
                            }
                        }
                    }
                }
                break;
            case 'boolean':
                if (actual2 === '(') {
                    console.log('es una funcion tipo boolena ' + actual1);
                    TABLASIMBOLOS+= " <tr><td>"+"es una funcion tipo booleana"+"</td><td>"+"boolean"+"</td><td>"+actual1+"</td></tr>";

                    CantidadM++;
                    tipom = "boolean";
                    NMetodos += actual1 + " ";
                    NMetodo = actual1;

                } else {
                    console.log('es una variable tipo boolean ' + actual1);
                    TABLASIMBOLOS+= " <tr><td>"+"es una variable tipo booleana"+"</td><td>"+"boolean"+"</td><td>"+actual1+"</td></tr>";

                    tipov = "boolean";
                    L_Variable.push(new General(actual1, tipov, NClase, NMetodo));
                    if (Lista_Original[index + 2] != ';') {
                        for (let w = index + 2; w < Lista_Original.length; w++) {
                            if (Lista_Original[w + 1] == ';') {
                                idv = Lista_Original[w];
                                L_Variable.push(new General(idv, tipov, NClase, NMetodo));
                                w++;
                                idv = "";
                                index = w;
                                break;
                            } else {
                                idv = Lista_Original[w];
                                L_Variable.push(new General(idv, tipov, NClase, NMetodo));
                            }
                        }
                    }
                }
                break;
            case 'double':
                if (actual2 === '(') {
                    console.log('es una funcion tipo double ' + actual1);
                    TABLASIMBOLOS+= " <tr><td>"+"es una funcion tipo double"+"</td><td>"+"double"+"</td><td>"+actual1+"</td></tr>";

                    CantidadM++;
                    tipom = "double";
                    NMetodos += actual1 + " ";
                    NMetodo = actual1;

                } else {
                    console.log('es una variable tipo double ' + actual1);
                    TABLASIMBOLOS+= "<tr> <td>"+"es una variable tipo double"+"</td><td>"+"double"+"</td><td>"+actual1+"</td></tr>";

                    tipov = "double";
                    L_Variable.push(new General(actual1, tipov, NClase, NMetodo));
                    if (Lista_Original[index + 2] != ';') {
                        for (let w = index + 2; w < Lista_Original.length; w++) {
                            if (Lista_Original[w + 1] == ';') {
                                idv = Lista_Original[w];
                                L_Variable.push(new General(idv, tipov, NClase, NMetodo));
                                w++;
                                idv = "";
                                index = w;
                                break;
                            } else {
                                idv = Lista_Original[w];
                                L_Variable.push(new General(idv, tipov, NClase, NMetodo));
                            }
                        }
                    }
                }
                break;
           

            case '(':
                var idkl="";
                for (let index1 = index + 1; index1 < Lista_Original.length; index1++) {
                    var paraux = Lista_Original[index1-1];
                    var par = Lista_Original[index1];
                    var par1 = Lista_Original[index1 + 1];
                    // console.log(par+" par");
                    // console.log(par1+" par1");
                    if(idkl===""){
                        idkl = paraux;
                    }
                    
                    if (par !== ')') {
                        console.log('es parametro tipo ' + par + ' nombre ' + par1);
                       
                        parametro += par + ", ";
                        index1++;
                        index = index1;
                    } else {
                        if (parametro === "") {
                            parametro = "Sin Parametro";
                            L_Metodo.push(new General("", "", NClase, NMetodo, parametro, tipom, "", ""));
                            TABLASIMBOLOS+= "<tr> <td>"+"llamada a funcion"+"</td><td>"+idkl+"</td><td>"+parametro+"</td></tr>";

                          //  NMetodo = "";
                            parametro = "";
                            tipom = "";

                        } else {
                            L_Metodo.push(new General("", "", NClase, NMetodo, parametro, tipom, "", ""));
                            TABLASIMBOLOS+= "<tr> <td>"+"es un parametro"+"</td><td>"+par+"</td><td>"+parametro+"</td></tr>";

                          //  NMetodo = "";
                            parametro = "";
                            tipom = "";
                        }
                        break;
                    }
                }
                break;
            case 'void':
                if (actual2 === '(') {
                    console.log('es una metodo tipo void ' + actual1);
                    TABLASIMBOLOS+= "<tr> <td>"+"es un metodo tipo void"+"</td><td>"+"void"+"</td><td>"+actual1+"</td></tr>";

                    CantidadM++;
                    tipom = "void";
                    NMetodos += actual1 + " ";
                    NMetodo = actual1;
                }
                break;
            default:
                break;
        }
    }

    //-------------------------------------------------------------------------------------------------------------------------------------------------------------------
    for (let index = 0; index < Lista_Copia.length; index++) {
        var actual = Lista_Copia[index];
        var actual1 = Lista_Copia[index + 1];
        var actual2 = Lista_Copia[index + 2];
        // console.log(actual + " actual");
        // console.log(actual1 + " actual1");
        // console.log(actual2 + " actual2");
        if ((actual === "class") && (contador1 == 0)) {
            console.log('es la clase ' + actual1);
            contador1++;
            NClase1 = actual1;
        } else if ((actual === "class") && (contador1 != 0)) {
            L_Clase1.push(new General("", "", NClase1, NMetodos1, "", "", CantidadM1, 0));
            NClase1 = actual1;

            CantidadM1 = 0;
            // NClase = "";
            NMetodo1="";
            NMetodos1 = "";
        }
        if (actual == "#" && index == (Lista_Original.length - 1)) {
            L_Clase1.push(new General("", "", NClase1, NMetodos1, "", "", CantidadM1, 0));
            NClase1 = actual1;
            CantidadM1 = 0;
            // NClase = "";
            NMetodos1 = "";
            NMetodo1="";
        }

        switch (actual) {
            case 'int':
                if (actual2 === '(') {
                    console.log('es una funcion tipo int ' + actual1 + " de la clase");
                    TABLASIMBOLOS+= "<tr> <td>"+"es una funcion tipo int"+"</td><td>"+"int"+"</td><td>"+actual1+"</td></tr>";

                    tipom1 = "int";
                    CantidadM1++;
                    NMetodos1 += actual1 + " ";
                    NMetodo1 = actual1;
                } else {
                    console.log('es una variable tipo int ' + actual1);
                    TABLASIMBOLOS+= " <tr><td>"+"variable tipo int"+"</td><td>"+"int"+"</td><td>"+actual1+"</td></tr>";
                    tipov1 = "int";
                    L_Variable1.push(new General(actual1, tipov1, NClase1, NMetodo1));
                    if (Lista_Copia[index + 2] != ';') {
                        for (let w = index + 2; w < Lista_Copia.length; w++) {
                            if (Lista_Copia[w + 1] == ';') {
                                idv1 = Lista_Copia[w];
                                L_Variable1.push(new General(idv1, tipov1, NClase1, NMetodo1));
                                w++;
                                idv1 = "";
                                index = w;
                                break;
                            } else {
                                idv1 = Lista_Copia[w];
                                L_Variable1.push(new General(idv1, tipov1, NClase1, NMetodo1));
                            }
                        }
                    }
                }
                break;
            case 'String':
                if (actual2 === '(') {
                    console.log('es una funcion tipo String ' + actual1);
                    TABLASIMBOLOS+= "<tr> <td>"+"es una funcion tipo String"+"</td><td>"+"String"+"</td><td>"+actual1+"</td></tr>";

                    tipom1 = "String";
                    CantidadM1++;
                    NMetodos1 += actual1 + " ";
                    NMetodo1 = actual1;
                } else {
                    console.log('es una variable tipo String ' + actual1);
                    TABLASIMBOLOS+= "<tr> <td>"+"es una variable tipo String"+"</td><td>"+"String"+"</td><td>"+actual1+"</td></tr>";

                    tipov1 = "String";
                    L_Variable1.push(new General(actual1, tipov1, NClase1, NMetodo1));
                    if (Lista_Copia[index + 2] != ';') {
                        for (let w = index + 2; w < Lista_Copia.length; w++) {
                            if (Lista_Copia[w + 1] == ';') {
                                idv1 = Lista_Copia[w];
                                L_Variable1.push(new General(idv1, tipov1, NClase1, NMetodo1));
                                w++;
                                idv1 = "";
                                index = w;
                                break;
                            } else {
                                idv1 = Lista_Copia[w];
                                L_Variable1.push(new General(idv1, tipov1, NClase1, NMetodo1));
                            }
                        }
                    }
                }
                break;
            case 'char':
                if (actual2 === '(') {
                    console.log('es una funcion tipo char ' + actual1);
                    TABLASIMBOLOS+= "<tr> <td>"+"es una funcion tipo char"+"</td><td>"+"char"+"</td><td>"+actual1+"</td></tr>";

                    tipom1 = "char";
                    CantidadM1++;
                    NMetodos1 += actual1 + " ";
                    NMetodo1 = actual1;

                } else {
                    console.log('es una variable tipo char ' + actual1);
                    TABLASIMBOLOS+= " <tr><td>"+"es una variable tipo char"+"</td><td>"+"char"+"</td><td>"+actual1+"</td></tr>";

                    tipov1 = "char";
                    L_Variable1.push(new General(actual1, tipov1, NClase1, NMetodo1));
                    if (Lista_Copia[index + 2] != ';') {
                        for (let w = index + 2; w < Lista_Copia.length; w++) {
                            if (Lista_Copia[w + 1] == ';') {
                                idv1 = Lista_Copia[w];
                                L_Variable1.push(new General(idv1, tipov1, NClase1, NMetodo1));
                                w++;
                                idv1 = "";
                                index = w;
                                break;
                            } else {
                                idv = Lista_Copia[w];
                                L_Variable1.push(new General(idv1, tipov1, NClase1, NMetodo1));
                            }
                        }
                    }
                }
                break;
            case 'boolean':
                if (actual2 === '(') {
                    console.log('es una funcion tipo boolena ' + actual1);
                    TABLASIMBOLOS+= " <tr><td>"+"es una funcion tipo booleana"+"</td><td>"+"boolean"+"</td><td>"+actual1+"</td></tr>";

                    tipom1 = "boolean";
                    CantidadM1++;
                    NMetodos1 += actual1 + " ";
                    NMetodo1 = actual1;

                } else {
                    console.log('es una variable tipo boolean ' + actual1);
                    TABLASIMBOLOS+= "<tr> <td>"+"es una variable tipo booleana"+"</td><td>"+"boolean"+"</td><td>"+actual1+"</td></tr>";

                    tipov1 = "boolean";
                    L_Variable1.push(new General(actual1, tipov1, NClase1, NMetodo1));
                    if (Lista_Copia[index + 2] != ';') {
                        for (let w = index + 2; w < Lista_Copia.length; w++) {
                            if (Lista_Copia[w + 1] == ';') {
                                idv1 = Lista_Copia[w];
                                L_Variable1.push(new General(idv1, tipov1, NClase1, NMetodo1));
                                w++;
                                idv1 = "";
                                index = w;
                                break;
                            } else {
                                idv1 = Lista_Copia[w];
                                L_Variable1.push(new General(idv1, tipov1, NClase1, NMetodo1));
                            }
                        }
                    }
                }
                break;
            case 'double':
                if (actual2 === '(') {
                    console.log('es una funcion tipo double ' + actual1);
                    TABLASIMBOLOS+= " <tr><td>"+"es una funcion tipo double"+"</td><td>"+"double"+"</td><td>"+actual1+"</td></tr>";

                    tipom1 = "double";
                    CantidadM1++;
                    NMetodos1 += actual1 + " ";
                    NMetodo1 = actual1;

                } else {
                    console.log('es una variable tipo double ' + actual1);
                    TABLASIMBOLOS+= " <tr><td>"+"es una variable tipo double"+"</td><td>"+"double"+"</td><td>"+actual1+"</td></tr>";

                    tipov1 = "double";
                    L_Variable1.push(new General(actual1, tipov1, NClase1, NMetodo1));
                    if (Lista_Copia[index + 2] != ';') {
                        for (let w = index + 2; w < Lista_Copia.length; w++) {
                            if (Lista_Copia[w + 1] == ';') {
                                idv = Lista_Copia[w];
                                L_Variable1.push(new General(idv1, tipov1, NClase1, NMetodo1));
                                w++;
                                idv1 = "";
                                index = w;
                                break;
                            } else {
                                idv1 = Lista_Copia[w];
                                L_Variable1.push(new General(idv1, tipov1, NClase1, NMetodo1));
                            }
                        }
                    }
                }
                break;
            case '(':
                for (let index1 = index + 1; index1 < Lista_Copia.length; index1++) {

                    var par = Lista_Copia[index1];
                    var par1 = Lista_Copia[index1 + 1];
                    // console.log(par+" par");
                    // console.log(par1+" par1");


                    if (par !== ')') {

                        console.log('es parametro tipo ' + par + ' nombre ' + par1);
                        TABLASIMBOLOS+= " <tr><td>"+"es un parametro tipo"+"</td><td>"+par+"</td><td>"+par1+"</td></tr>";

                        parametro1 += par + ", ";
                        index1++;
                        index = index1;
                    } else {
                        if (parametro1 === "") {
                            parametro1 = "Sin Parametro";
                            L_Metodo1.push(new General("", "", NClase1, NMetodo1, parametro1, tipom1, "", ""));
                           // NMetodo1 = "";
                            parametro1 = "";
                            tipom1 = "";

                        } else {
                            L_Metodo1.push(new General("", "", NClase1, NMetodo1, parametro1, tipom1, "", ""));
                           // NMetodo1 = "";
                            parametro1 = "";
                            tipom1 = "";
                        }
                        break;
                    }
                }
                break;
            case 'void':
                if (actual2 === '(') {
                    console.log('es una metodo tipo void ' + actual1);
                    TABLASIMBOLOS+= "<tr> <td>"+"es un metodo tipo void"+"</td><td>"+"void"+"</td><td>"+actual1+"</td></tr>";

                    tipom1 = "void";
                    CantidadM1++;
                    NMetodos1 += actual1 + " ";
                    NMetodo1 = actual1;
                }
                break;
            default:
                break;
        }
    }
    //-------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // for (let j = 0; j < L_Metodo.length; j++) {
    //     console.log("Clase: " + L_Metodo[j].clase + " Nombre: " + L_Metodo[j].metodo + " Tipo: " + L_Metodo[j].tipo1 + " Parametro: " + L_Metodo[j].parametro);

    // }
    // for (let j = 0; j < L_Metodo1.length; j++) {
    //     console.log("Clase: " + L_Metodo1[j].clase + " Nombre: " + L_Metodo1[j].metodo + " Tipo: " + L_Metodo1[j].tipo1 + " Parametro: " + L_Metodo1[j].parametro);

    // }
    // for (let j = 0; j < L_Variable.length; j++) {
    //     console.log("Clase: " + L_Variable[j].clase + " Metodo: " + L_Variable[j].metodo + " Tipo: " + L_Variable[j].tipo + " id: " + L_Variable[j].id);

    // }
    // for (let j = 0; j < L_Variable1.length; j++) {
    //     console.log("Clase: " + L_Variable1[j].clase + " Metodo: " + L_Variable1[j].metodo + " Tipo: " + L_Variable1[j].tipo + " id: " + L_Variable1[j].id);

    // } 

    TABLASIMBOLOS+="</table>";
   // document.getElementById("tablatokens").innerHTML = TABLASIMBOLOS;

    for (let j = 0; j < L_Clase1.length; j++) {
        console.log("Clase1: " + L_Clase1[j].clase + " Metodo: " + L_Clase1[j].metodo + " Cantidad Metodos: " + L_Clase1[j].CantidadF);

    }

    html3 += "<br><h3>Reporte Variables</h3><table border=\"2px\" style=\"width:750px\;height:50px\"><tbody> ";
    html3 += "<tr style=\"width:550px;height:25px\"><td>Nombre Clase</td><td>Nombre Metodo</td><td>Tipo</td><td>Nombre Variable</td>";

    for (let i = 0; i < L_Variable.length; i++) {
        // console.log("Clase: "+L_Clase[i].clase+" Tipo: "+L_Clase[i].tipo+" Metodo: "+L_Clase[i].metodo+" Id: "+L_Clase[i].id+" Tipo1: "+L_Clase[i].tipo1+" parametro: "+L_Clase[i].parametro);
        //   console.log("Clase: " + L_Clase[i].clase + " Metodo: " + L_Clase[i].metodo + " Tipo Variable: " + L_Clase[i].tipo + " Parametro: " + L_Clase[i].parametro+" Tipo1: "+L_Clase[i].tipo1);
        for (let j = 0; j < L_Variable1.length; j++) {
            //  console.log("Clase: "+L_Clase[j].clase+" Tipo1: "+L_Clase[j].tipo+" Metodo1: "+L_Clase[j].metodo+" Id1: "+L_Clase[j].id+" Tipo11: "+L_Clase[j].tipo1);
            //  console.log(L_Clase1[j].id);
            //   console.log("Clase1: " + L_Clase1[j].clase + " Metodo: " + L_Clase1[j].metodo + " Tipo Variable: " + L_Clase1[j].tipo + " Parametro: " + L_Clase1[j].parametro+" Tipo1: "+L_Clase1[j].tipo1 );
            if ((L_Variable[i].clase == L_Variable1[j].clase) && (L_Variable[i].tipo == L_Variable1[j].tipo) && (L_Variable[i].metodo == L_Variable1[j].metodo) && (L_Variable[i].id == L_Variable1[j].id) && (L_Variable[i].tipo1 == L_Variable1[j].tipo1)) {
                // texto+="Variable correcta \n";
                texto += "Clase: " + L_Variable[i].clase + " Metodo: " + L_Variable[i].metodo + " Tipo Variable: " + L_Variable[i].tipo + " Id Variable: " + L_Variable[i].id + " \n";
                html3 += "<tr>";
                html3 += "<td>" + L_Variable[i].clase + "</td>" + "<td>" + L_Variable[i].metodo + "</td>" + "<td>" + L_Variable[i].tipo + "</td>" + "<td>" + L_Variable[i].id + "</td>";
                html3 += "</tr>";
            }
        }
    }
    html3 += "</tbody></table>";
   // document.getElementById("ReporteVariable").innerHTML = html3;
    html2 += "<br><h3>Reporte Metodos</h3><table border=\"1px\" style=\"width:750px\;height:50px\"><tbody> ";
    html2 += "<tr style=\"width:550px;height:25px\"><td>Nombre Clase</td><td>Nombre Metodo</td><td>Tipo</td><td>Parametros</td>";



    for (let i = 0; i < L_Metodo.length; i++) {
        //  console.log("Clase: " + L_Metodo[i].clase + " Metodo: " + L_Metodo[i].metodo + " Tipo: " + L_Metodo[i].tipo + " Parametro: " + L_Metodo[i].parametro + " Tipo1: " + L_Metodo[i].tipo1);
        // console.log(L_Metodo[i].metodo + " metodo");
        for (let j = 0; j < L_Metodo1.length; j++) {
            // console.log(L_Metodo1.length);
            // console.log(L_Metodo[j].metodo + " metodo1");
            //   console.log("Clase1: " + L_Metodo1[j].clase + " Metodo: " + L_Metodo1[j].metodo + " Tipo: " + L_Metodo1[j].tipo + " Parametro: " + L_Metodo1[j].parametro + " Tipo1: " + L_Metodo1[j].tipo1);

            if ((L_Metodo[i].clase == L_Metodo1[j].clase) && (L_Metodo[i].tipo1 == L_Metodo1[j].tipo1) && (L_Metodo[i].parametro == L_Metodo1[j].parametro) && (L_Metodo[i].metodo == L_Metodo1[j].metodo)) {
                // texto += "Clase: " + L_Metodo[i].clase + " Metodo: " + L_Metodo[i].metodo + " Tipo Variable: " + L_Metodo[i].tipo1 + " Parametro: " + L_Metodo[i].parametro + " \n";
                html2 += "<tr>";
                html2 += "<td>" + L_Metodo[i].clase + "</td>" + "<td>" + L_Metodo[i].metodo + "</td>" + "<td>" + L_Metodo[i].tipo1 + "</td>" + "<td>" + L_Metodo[i].parametro + "</td>";
                html2 += "</tr>";
            }

        }

    }

    html2 += "</tbody></table>";
    //document.getElementById("ReporteMetodo").innerHTML = html2;
    html1 += "<br><h3>Reporte Clase</h3>    <table border=\"1px\" style=\"width:750px\;height:50px\"><tbody> ";
    html1 += "<tr style=\"width:550px;height:25px\"><td>Nombre</td><td>Cantidad Metodos y/o funciones</td>";
    for (let i = 0; i < L_Clase.length; i++) {
        console.log("Clase22: " + L_Clase[i].clase + " Metodos: " + L_Clase[i].metodo + " CantidadM: " + L_Clase[i].CantidadM);

        for (let j = 0; j < L_Clase1.length; j++) {
            console.log("Clase11: " + L_Clase1[j].clase + " Metodos: " + L_Clase1[j].metodo + " CantidadM: " + L_Clase1[j].CantidadM);

            if ((L_Clase[i].clase == L_Clase1[j].clase) && (L_Clase[i].metodo == L_Clase1[j].metodo) && (L_Clase[i].CantidadF == L_Clase1[j].CantidadF)) {
                texto += "Clase: " + L_Clase[i].clase + " Metodos: " + L_Clase[i].metodo + " CantidadM: " + L_Clase[i].CantidadF;

                html1 += "<tr>";
                html1 += "<td>" + L_Clase[i].clase + "</td>" + "<td>" + L_Clase[i].CantidadF + "</td>";
                html1 += "</tr>";
            }

        }

    }

    html1 += "</tbody></table>";
   



}
function arbol(cadena) {
    var nuevo = document.getElementById('html');
    nuevo.innerHTML = cadena;
    var reload = document.getElementById('wenas');
    if (reload.firstElementChild === null) {
        var script = document.createElement('script');
        script.innerText = "$('#html').jstree();";
        reload.appendChild(script);
    }
}

