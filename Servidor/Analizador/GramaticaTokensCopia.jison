
/*------------------------------------------------IMPORTS----------------------------------------------*/
%{
    // let CPrimitivo=require('../JavaAST/Expresiones/Primitivo');
    // let CAritmetica=require('../JavaAST/Expresiones/Aritmetica');

    // let guardar=require('../JavaAST/datos');
    let Prueba=require('../JavaAST/Mostrar');
    let Lista = require('../Listas/GenerarObjeto');
    var Tokens = new Array();
    var ini=0;
    var Cuerpo="",cadena1="",probe="";

    // let CErrores=require('../JavaAST/Errores');
    // let CNodoError=require('../JavaAST/NodoError');
    // let Tokens = require('..');
    function Borrar(){
       return "Hola";
    }
%}



/*------------------------------------------------LEXICO------------------------------------------------*/
%lex
%options case-insensitive
%%
\s+                                 // se ignoran espacios en blanco
"//".*                              // comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] // comentario multiple líneas
"*"                   return '*';
"/"                   return '/';
"-"                   return '-';
"+"                   return '+';
"^"                   return '^';
"("                   return '(';
")"                   return ')';
"exec"                return 'exec';

"{"                    return '{';
"}"                    return '}';
"import"                    return 'import';
";"                    return ';';
"int"                    return 'int';
"double"                    return 'double';
"boolean"                    return 'boolean';
"char"                    return 'char';
"String"                    return 'String';
","                    return ',';
"add"                  return 'add';
"list"                 return 'list';
"toLower"              return 'tolower';
"toUpper"              return 'toupper';
"lenght"               return 'lenght';
"truncate"             return 'truncate';
"round"                return 'round';
"typeof"               return 'typeof';
"toString"             return 'tostring';
"toCharArray"          return 'tochararray';
"new"                  return 'new';
"void"                    return 'void';
"main"                    return 'main';

"."                    return '.';

"print"                    return 'print';
"println"                    return 'println';
"%"                    return '%';
":"                    return ':';
"break"                    return 'break';
"default"                    return 'default';
"case"                    return 'case';
"while"                    return 'while';
"do"                    return 'do';
"=="                    return '==';
"!="                    return '!=';
">="                    return '>=';
"<="                    return '<=';
"&&"                    return '&&';
"||"                    return '||';
"!"                    return '!';
">"                    return '>';
"<"                    return '<';
"="                    return '=';
"true"                 return 'true';
"false"                 return 'false';
"for"                    return 'for';
"continue"                    return 'continue';
"return"                    return 'return';
"switch"                    return 'switch';
"if"                    return 'if';
"else"                    return 'else';
[\n]                      return 'SALTO';
[0-9]+("."[0-9]+)  return 'DECIMAL';
[0-9]+             return 'ENTERO';
[A-Za-z|"_"]+[A-Za-z|0-9|"_"]*"+""+"     return 'AUMETO';
[A-Za-z|"_"]+[A-Za-z|0-9|"_"]*"-""-"     return 'DECREMENTO';
[0-9]+."+""+"       return 'EAUMENTO';
[0-9]+("."[0-9]+)."+""+"  return 'DAUMENTO';
[0-9]+."-""-"       return 'EDECREMENTO';
[0-9]+("."[0-9]+)."-""-"  return 'DDECREMENTO';

[\']([^])[\'] return 'CARACTER';
\"[^\"]*\"				{ yytext = yytext.substr(1,yyleng-2); return 'CADENA'; }
[A-Za-z|"_"][A-Za-z|0-9|"_"]*  return 'Identificador';
.           CErrores.Errores.add(new CNodoError.NodoError("Lexico","No se esperaba el caracter: "+yytext,yylineno))
<<EOF>>               return 'EOF';


/lex

/* operator associations and precedence */
%left '&&' '||' '==' '<=' '>=' '<' '>' '!='
%right '!'
%left '^'
%left '*' '/' '%'
%left '+' '-'
// %left '++' '--'


%left UMINUS
%start S0

%% /* language grammar */
S0: S10 EOF
{    
    //$$=new Prueba.most($1); return $$.mostr();
    // $$=Tokens.push("");
    // return
 //   Tokens.push($1);
   
    
    cadena1 = $1;  
    //console.log(cadena1);
    Cuerpo = cadena1.split('$');
   
    for(i=0; i<Cuerpo.length; i++){
        Tokens.push(Cuerpo[i]);
        
    }
    Tokens.push("#");
    cadena1="";
    Cuerpo="";
    // console.log(Tokens+" El antes");
    $$=new Lista.Toks(Tokens); return $$.Tokes(); 
    // console.log(Tokens.length+" El tamanio");
   
    
};

S10:S10 Scl {$$=$1+"$"+$2;}
|Scl{$$=$1;}
;




Scl:S1{$$=$1;};

S1: Imprimir{$$ = "<tr> <td>"+"llamada a metodo tipo imprimir"+"</td><td>"+"print"+"</td><td>"+$1+"</td></tr>";}
|Func{$$ = "<tr> <td>"+"declaracion funcion"+"</td><td>"+"funcion"+"</td><td>"+$1+"</td></tr>";}
|Metodo{$$ = $1;}
|LFunc{$$ = "<tr> <td>"+"llamada funcion"+"</td><td>"+"funcion"+"</td><td>"+$1+"</td></tr>";}
|Var{$$ = "<tr> <td>"+"Declaracion de variable"+"</td><td>"+"variable"+"</td><td>"+$1+"</td></tr>";}
|Avar{$$ = "<tr> <td>"+"Asignacion de variable"+"</td><td>"+"variable"+"</td><td>"+$1+"</td></tr>";}
|DecVec{$$ = "<tr> <td>"+"Declaracion de vector"+"</td><td>"+"vector"+"</td><td>"+$1+"</td></tr>";}
|ModifVec{$$ = "<tr> <td>"+"Modificacion de vector"+"</td><td>"+"vector"+"</td><td>"+$1+"</td></tr>";}
|Listas{$$ = "<tr> <td>"+"Declaracion de lista"+"</td><td>"+"lista"+"</td><td>"+$1+"</td></tr>";}
|Modilist{$$ = "<tr> <td>"+"Modificacion de lista"+"</td><td>"+"lista"+"</td><td>"+$1+"</td></tr>";}
|Addlist{$$ = "<tr> <td>"+"Agregar a lista"+"</td><td>"+"lista"+"</td><td>"+$1+"</td></tr>";}
|ejecuciones{$$ = "<tr> <td>"+"llamada ejecucion"+"</td><td>"+"exec"+"</td><td>"+$1+"</td></tr>";}
;


ejecuciones : exec Identificador '(' ')' ';' {$$=$1+"$"+$2+"$"+$5;}
|  exec Identificador '(' Lista_E ')' ';' {$$=$1+"$"+$2+"$"+$4+"$"+$6;};



Var: Tipo Lista_Id Var1{$$=$1+"$"+$2+"$"+$3;};

Tipo: int{$$=$1;}
|double{$$=$1;}
|boolean{$$=$1;}
|char{$$=$1;}
|String{$$=$1;};

Lista_Id: Lista_Id ',' Identificador{$$=$1+"$"+$2+"$"+$3;}
|Identificador{$$=$1;};


Var1:'=' e ';'{$$= $2;}
|';'{};

Avar: Identificador '(' ')' ';'{$$=$1+" "+ $2+" "+ $3;}
|Identificador '=' e ';'{$$=$1+" "+ $3};

Func: Tipo Identificador '(' Lista_Parametro ')' '{' Sent123 {$$=$1+" "+ $2+" "+ $3+" "+ $4 +" "+$5+" "+ $7;}
|Tipo Identificador '(' ')' '{' Sent123 {$$=$1+" "+ $2+" "+ $3+" "+ $4 +" "+ $6;};

Sent123: Sent1 return e ';' '}'{$$=$1;}
|return e ';' '}'{}
| Sent1 '}'{$$=$1;}
|'}'{};

Lista_Parametro: Var2 {$$=$1;};

Var2: Var2 ',' Tipo Identificador{$$=$1+"$"+ $2+"$"+ $3+"$"+ $4;}
|Tipo Identificador{$$=$1+"$"+ $2;};



Metodo: void Identificador '(' Lista_Parametro ')' '{' Sent113 {$$="<tr> <td>"+"identificacion de de metodo void"+"</td><td>"+"metodo"+"</td><td>"+$2+"</td></tr>"+$7;}
|void main '(' ')' '{' Sent113  {$$="<tr> <td>"+"declaracion de metodo void"+"</td><td>"+"metodo"+"</td><td>"+$2+"</td></tr>"+$6;}
|void Identificador '(' ')' '{' Sent113 {$$="<tr> <td>"+"declaracion de metodo void"+"</td><td>"+"metodo"+"</td><td>"+$2+"</td></tr>"+$6;};

Sent113: Sent1 return ';' '}'{$$=$1;}
| return ';' '}'{}
|Sent1'}' {$$=$1;}
|'}'{};

LFunc: Identificador '(' Lista_E ')' ';' {$$=$1+"$"+$2+"$"+$3+"$"+$4;};

Lista_E: Lista_E ',' e{$$=$1+"$"+","+"$"+$3;}
|e{$$=$1;};


Imprimir: print '(' e ')' ';'{$$=$1+" "+$3;};



    
IF: if '(' e ')' '{' Sent11  {$$=$6;}
|if '(' e ')' '{' Sent11  else '{' Sent11 {$$=$6+$9;}
|if '(' e ')' '{' Sent11  ELS{$$=$6+$7;}
|if '(' e ')' '{' Sent11  ELS else'{' Sent11 {$$=$6+$7+$10;};

ELS: ELS else if '(' e ')' '{' Sent11  {$$=$1+$8;}
|else if '(' e ')' '{' Sent11 {$$=$7;};

Sent11: Sent1 '}' {$$=$1;}  
|Sent1 Senten ';' '}' {$$=$1+"Sentencia - "+$2+"";}
|Senten';' '}' {$$="Sentencia - "+$1+"";}
|'}'{};


Senten: break {}
|return {}
|return e {}
|continue {};
  
    e: e '&&' e
        {$$ = "And "+$1+" "+$2+" "+$3+"";}
    | e '||' e
        {$$ = "Or "+$1+" "+$2+" "+$3+"";}
    |'!' e
        {$$ = "Not "+$1+$2+"";}
    | '-' e %prec UMINUS
        {$$ = "Valor Negativo "+$1+$2+"";}
    | '*''-' e %prec UMINUS
        {$$ = "Menos Unitario "+$1+$2+$3+"";}
    | '(' e ')'
        {$$ = "Parentesis "+$2+"";}
    | e '==' e
        {$$ = "Igual Igual "+$1+" "+$2+" "+$3+"";}
    | e '!=' e
        {$$ = "Distinto " +$1+" "+$2+" "+$3+"";}
    | e '<=' e
        {$$ = "Menor Igual "+$1+" "+$2+" "+$3+"";}
    | e '>=' e
        {$$ = "Mayor Igual "+$1+" "+$2+" "+$3+"";}
    | e '<' e
        {$$ = "Menor "+$1+" "+$2+" "+$3+"";}
    | e '>' e
        {$$ = "Mayor "+$1+" "+$2+" "+$3+"";}
    | e '^' e
        {$$ = "Potencia "+$1+" "+$2+" "+$3+"";}
    | e '/' e
        {$$ = "Division "+$1+" "+$2+" "+$3+"";}
    | e '*' e
        {$$ = "Multiplicacion "+$1+" "+$2+" "+$3+"";}
    | e '%' e
        {$$ = "Modulo "+$1+" "+$2+" "+$3+"";}
    | e '+' e
        {$$ = "Suma "+$1+" "+$2+" "+$3+"";}
    | e '-' e
        {$$ = "Resta "+$1+" "+$2+" "+$3+"";}
    |CADENA
        {$$ = "Cadena "+$1+"";}
    |Identificador '[' e ']' 
       {$$ = " arreglo "+$1+""+$3+"";}
    |CARACTER
        {$$ = "Caracter "+$1+"";}
    | ENTERO
        {$$ = "Entero "+$1+"";}
    | DECIMAL
        {$$ = "Decimal "+$1+"";}
    |true
        {$$ = "True "+$1+"";}
    |false
        {$$ = "False "+$1+"";}
    |LFunc
        {$$ = "Llamada Funcion "+$1+"";}
    |Tipo
         {$$ = "tipo "+$1+"";}
    |tolower '(' e ')'
         {$$ = "Llamada tolower "+$1+"";}
    |toupper '(' e ')'
         {$$ = "Llamada toupper "+$1+"";}
    |lenght '(' e ')'
        {$$ = "Llamada lenght "+$1+"";}
    |truncate '(' e ')'
        {$$ = "Llamada truncate "+$1+"";}
    |round '(' e ')'
         {$$ = "Llamada round "+$1+"";}
    |typeof '(' e ')'
         {$$ = "Llamada typeof "+$1+"";}
    |tostring '(' e ')'
         {$$ = "Llamada to string "+$1+"";}
    |tochararray '(' e ')'
         {$$ = "Llamada To charArray "+$1+"";}
    |Identificador
        {$$ = "Identificador -"+$1+"";};
        
  	  Swit: switch '(' e ')' '{' Cas Def '}' {$$="Condicion Switch "+$3+"Cuerpo Switch "+$6+$7+"";};


    Cas: Cas case e ':' Sent1 {$$=$1+$5+"";}
    |Cas case e ':' {$$=$1;}
    |Cas case e ':' Sent1 break ';'{$$=$1+$5;}
    |Cas case e ':' break ';'{$$=$1;}
    |case e ':' {}
    |case e ':' Sent1 {$$=$4+"";}
    |case e ':' break ';'{}
    |case e ':' Sent1 break ';'{$$=$4;};



   Def: default ':' Sent1 break ';'{$$=$3;}
    |default ':' break ';'{}
    |default ':' Sent1 {$$=$3;}
    |default ':' {};


    Whil: while '(' e ')' '{' Sent111 {$$=$6;};

    Sent111: Sent1 Senten ';' '}'{$$=$1+" "+$2+"";}
    |Sent1 '}'{$$=$1;}
    |Senten ';' '}'{$$="Sentencia "+$1+"";}
    |'}'{};

    Do: do '{' Sent11  while '(' e ')' ';'{$$=$3;};

  
    Fo: for '(' Fo1 ';' e ';'  Aum ')' '{' Sent112  {$$= $3+$10;};


    Sent112: Sent1 Senten ';' '}' {$$=$1+" "+$2+"";}
    |Senten ';' '}'{}
    |Sent1 '}'{$$=$1;}
    |'}'{}
    ;

    Fo1: Tipo Identificador '=' e{$$=$1+" "+ $2+" "+$4;}
    | Identificador '=' e{$$=$1+" "+ $3;};

    Aum:AUMETO{$$="Aumento "+$1+"";}
    |DECREMENTO{$$="Decremento "+$1+"";};


        
    DecVec: Tipo '[' ']' Identificador '=' new Tipo '[' e ']' ';' {$$=$1+"$"+$4+"$"+$9;}
     | Tipo '[' ']' Identificador '=' '{' Lista_E '}' ';' {$$=$1+"$"+$4+"$"+$7;};
     
    ModifVec: Identificador '[' ENTERO ']' '=' e  ';'{$$=$1+"$"+$3+"$"+$6;} ; 
    
    Listas: list '<' Tipo '>' Identificador '=' new list  '<' Tipo '>' ';' {$$=$1+"$"+$3+"$"+$5;}
         | list '<' Tipo '>' Identificador '=' tochararray '(' e ')' ';' {$$=$1+"$"+$3+"$"+$5;};

    Modilist : Identificador '[' '[' ENTERO ']' ']' = e ';' {$$=$1+"$"+$4+"$"+$8;} ; 

    Addlist : Identificador '.' '(' e ')' ';' {$$=$1+"$"+$4;} ; 


    Sent1: Sent1 IF{$$=""+$1+""+$2+"";}
    |Sent1 Swit{$$=""+$1+""+$2+"";}
    |Sent1 Whil{$$=""+$1+""+$2+"";}
    |Sent1 Do{$$=""+$1+""+$2+"";}
    |Sent1 Var{$$=""+$1+""+"<tr> <td>"+"Declaracion variable"+"</td><td>"+"variable"+"</td><td>"+$2+"</td></tr>";}
    |Sent1 Imprimir{$$=""+$1+"<tr> <td>"+"llamada a metodo tipo imprimir"+"</td><td>"+"print"+"</td><td>"+$2+"</td></tr>";}
    |Sent1 LFunc{$$=""+$1+" "+"<tr> <td>"+"llamada a funcion"+"</td><td>"+"funcion"+"</td><td>"+$2+"</td></tr>";}
    |Sent1 Avar{$$=""+$1+""+"<tr> <td>"+"Asignacion de variable"+"</td><td>"+"variable"+"</td><td>"+$2+"</td></tr>";}
    |Sent1 Fo{$$=""+$1+""+$2+"";}
    |Sent1 DecVec{$$ = $1+ "<tr> <td>"+"Declaracion de vector"+"</td><td>"+"vector"+"</td><td>"+$2+"</td></tr>";}
    |Sent1 ModifVec{$$ = $1+ "<tr> <td>"+"Modificacion de vector"+"</td><td>"+"vector"+"</td><td>"+$2+"</td></tr>";}
    |Sent1 Listas{$$ = $1+ "<tr> <td>"+"Declaracion de lista"+"</td><td>"+"lista"+"</td><td>"+$2+"</td></tr>";}
    |Sent1 Modilist{$$ = $1+ "<tr> <td>"+"Modificacion de lista"+"</td><td>"+"lista"+"</td><td>"+$2+"</td></tr>";}
    |Sent1 Addlist{$$ = $1+ "<tr> <td>"+"Agregar a lista"+"</td><td>"+"lista"+"</td><td>"+$2+"</td></tr>";}
    |Sent1 ejecuciones{$$ = "<tr> <td>"+"llamada ejecucion"+"</td><td>"+"exec"+"</td><td>"+$2+"</td></tr>";}
    |IF{$$=" "+$1+"";}
    |Swit{$$=""+$1+"";}
    |Whil{$$=""+$1+"";}
    |Do{$$=+$1+"";}
    |LFunc{$$ =  "<tr> <td>"+"llamada de funcion"+"</td><td>"+"funcion"+"</td><td>"+$1+"</td></tr>";}
    |Imprimir{$$ = "<tr> <td>"+"llamada a metodo tipo imprimir"+"</td><td>"+"print"+"</td><td>"+$1+"</td></tr>";}
    |Var{$$ = "<tr> <td>"+"Declaracion de variable"+"</td><td>"+"variable"+"</td><td>"+$1+"</td></tr>";}
    |Avar{$$ = "<tr> <td>"+"Asignacion de variable"+"</td><td>"+"variable"+"</td><td>"+$1+"</td></tr>";}
    |Fo{$$ = $1;}
    |DecVec{$$ = "<tr> <td>"+"Declaracion de vector"+"</td><td>"+"vector"+"</td><td>"+$1+"</td></tr>";}
    |ModifVec{$$ = "<tr> <td>"+"Modificacion de vector"+"</td><td>"+"vector"+"</td><td>"+$1+"</td></tr>";}
    |Listas{$$ = "<tr> <td>"+"Declaracion de lista"+"</td><td>"+"lista"+"</td><td>"+$1+"</td></tr>";}
    |Modilist{$$ = "<tr> <td>"+"Modificacion de lista"+"</td><td>"+"lista"+"</td><td>"+$1+"</td></tr>";}
    |Addlist{$$ = "<tr> <td>"+"Agregar a lista"+"</td><td>"+"lista"+"</td><td>"+$1+"</td></tr>";}
    |ejecuciones{$$ = "<tr> <td>"+"llamada ejecucion"+"</td><td>"+"exec"+"</td><td>"+$1+"</td></tr>";}
;

 
 