


var Lista_Original = new Array();
var Lista_Copia = new Array();
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
           

            var arbolito = data.toString();
        
            arbol(arbolito);//hace el arbol de derivaciones 


        } else {
            alert("Error estado de conexion:" + status);
        }
    });

    var url = 'http://localhost:8080/Calcular2/';

    $.post(url, { text: texto }, function (data, status) {
        if (status.toString() == "success") {
            var ast = data.toString();
           //HTMLIN

           document.getElementById("Prueba").value = ast;           
          


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
                //console.log(ast1[i].toString())
                if (ast1[i].toString() !== 'import' && ast1[i].toString() !== '{' && ast1[i].toString() !== '}' /*&& ast1[i].toString() !== ';'*/ && ast1[i].toString() !== ',' && ast1[i].toString() !== 'if' && ast1[i].toString() !== 'switch' && ast1[i].toString() !== 'while' && ast1[i].toString() !== 'do' && ast1[i].toString() !== 'for' && ast1[i].toString() !== 'System' && ast1[i].toString() !== 'out' && ast1[i].toString() !== 'print' && ast1[i].toString() !== 'println'/**/ && ast1[i].toString() !== '.' && ast1[i].toString() !== '%' && ast1[i].toString() !== ':' /*&& ast1[i].toString() !== ';'*/ && ast1[i].toString() !== ',' && ast1[i].toString() !== 'break' && ast1[i].toString() !== 'default' && ast1[i].toString() !== 'case' && ast1[i].toString() !== '==' && ast1[i].toString() !== '!=' && ast1[i].toString() !== '>=' && ast1[i].toString() !== '<=' && ast1[i].toString() !== '!' && ast1[i].toString() !== '&&' /**/ && ast1[i].toString() !== '||' && ast1[i].toString() !== '>' && ast1[i].toString() !== '<' /*&& ast1[i].toString() !== ';'*/ && ast1[i].toString() !== 'true' && ast1[i].toString() !== 'false' && ast1[i].toString() !== 'continue' && ast1[i].toString() !== 'return' && ast1[i].toString() !== 'else' && ast1[i].toString() !== '+' && ast1[i].toString() !== '-' && ast1[i].toString() !== '*' && ast1[i].toString() !== '/' && ast1[i].toString() !== '^') {
                    cadena += ast1[i] + " ";
                    console.log(cadena);
                    Lista_Original.push(ast1[i].toString());

                }

                // console.log(Lista_Original);
                //Reportes();
            }





        } else {
            alert("Error estado de conexion:" + status1);
        }
    });

   

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

