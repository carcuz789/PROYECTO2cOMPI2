
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

S1: Imprimir{$$ = "<ul><li>Imprimir<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Func{$$ = "<ul><li>Declaracion Funcion<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Metodo{$$ = "<ul><li>Declaracion Metodo<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Var{$$ = "<ul><li>Declaracion Variable<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Avar{$$ = "<ul><li>Asignacion Variable<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|ejecuciones {$$ = "<ul><li>Funcion exec <ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
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

Sent123: Sent1 return e ';' '}'{$$=$1+"<ul><li>Return<ul><li>"+$2+$3+"</li></ul></li></ul>";}
|return e ';' '}'{$$="<ul><li>Return<ul><li>"+$1+$2+"</li></ul></li></ul>";}
| Sent1 '}'{$$=$1;}
|'}'{};

Lista_Parametro: Var2 {$$=$1;};

Var2: Var2 ',' Tipo Identificador{$$=$1+"$"+ $2+"$"+ $3+"$"+ $4;}
|Tipo Identificador{$$=$1+"$"+ $2;};



Metodo: void Identificador '(' Lista_Parametro ')' '{' Sent113 {$$="<ul><li>Identificador Metodo "+$2+"<ul><li>Parametros Metodo <ul><li>"+$4+"</li></ul></li></ul><ul><li>Cuerpo metodo "+$7+"</li></ul></li></ul>";}
|void main '(' ')' '{' Sent113  {$$="<ul><li>Main "+$2+"<ul><li>Cuerpo Main "+$6+"</li></ul></li></ul>";}
|void Identificador '(' ')' '{' Sent113 {$$="<ul><li>Identificador Metodo "+$2+"<ul><li>Cuerpo Metodo "+$6+"</li></ul></li></ul>";};

Sent113: Sent1 return ';' '}'{$$=$1+"<ul><li>Return"+$2+"</li></ul>";}
| return ';' '}'{$$="<ul><li>Return<ul><li> "+$1+"</li></ul></li></ul>";}
|Sent1'}' {$$=$1;}
|'}'{};

LFunc: Identificador '(' Lista_E ')' ';' {$$=$1+"$"+$2+"$"+$3+"$"+$4;};

Lista_E: Lista_E ',' e{$$=$1+"$"+$2+"$"+$3;}
|e{$$=$1;};


Imprimir: print '(' e ')' ';'{$$="<ul><li>Tipo Imprimir "+$1+"</li></ul>"+"<ul><li>Sentencia a Imprimir"+$3+"</li></ul>";};



    
IF: if '(' e ')' '{' Sent11  {$$="<ul><li>Condicion If"+$3+"</li></ul><ul><li>Cuerpo If"+$6+"</li></ul>";}
|if '(' e ')' '{' Sent11  else '{' Sent11 {$$="<ul><li>Condicion If"+$3+"</li></ul><ul><li>Cuerpo If"+$6+"</li></ul><ul><li>Cuerpo else"+$9+"</li></ul>";}
|if '(' e ')' '{' Sent11  ELS{$$="<ul><li>Condicion If"+$3+"</li></ul><ul><li>Cuerpo If"+$6+"</li></ul>"+$7;}
|if '(' e ')' '{' Sent11  ELS else'{' Sent11 {$$="<ul><li>Condicion If"+$3+"</li></ul><ul><li>Cuerpo If"+$6+"</li></ul>"+$7+"</li></ul><ul><li>Cuerpo else"+$10+"</li></ul>";};

ELS: ELS else if '(' e ')' '{' Sent11  {$$=$1+"<ul><li>Declaracion Else If<ul><li>Condicion Else If"+$5+"</li></ul><ul><li>Cuerpo Else If"+$8+"</li></ul></li></ul>";}
|else if '(' e ')' '{' Sent11 {$$="<ul><li>Declaracion Else If<ul><li>Condicion Else If"+$4+"</li></ul><ul><li>Cuerpo Else If"+$7+"</li></ul></li></ul>";};

Sent11: Sent1 '}' {$$=$1;}  
|Sent1 Senten ';' '}' {$$=$1+"<ul><li>Sentencia<ul><li> "+$2+"</li></ul></li></ul>";}
|Senten';' '}' {$$="<ul><li>Sentencia<ul><li> "+$1+"</li></ul></li></ul>";}
|'}'{};


Senten: break {}
|return {}
|return e {}
|continue {};
  
    e: e '&&' e
        {$$ = "<ul><li>And"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    | e '||' e
        {$$ = "<ul><li>Or"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    |'!' e
        {$$ = "<ul><li>Not<ul><li>"+$1+$2+"</li></ul></li></ul>";}
    | '-' e %prec UMINUS
        {$$ = "<ul><li>Valor Negativo<ul><li>"+$1+$2+"</li></ul></li></ul>";}
    | '*''-' e %prec UMINUS
        {$$ = "<ul><li>Menos Unitario<ul><li>"+$1+$2+$3+"</li></ul></li></ul>";}
    | '(' e ')'
        {$$ = "<ul><li>Parentesis<ul><li> "+$2+"</li></ul></li></ul>";}
    | e '==' e
        {$$ = "<ul><li>Igual Igual"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    | e '!=' e
        {$$ = "<ul><li>Distinto"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    | e '<=' e
        {$$ = "<ul><li>Menor Igual"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    | e '>=' e
        {$$ = "<ul><li>Mayor Igual"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    | e '<' e
        {$$ = "<ul><li>Menor"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    | e '>' e
        {$$ = "<ul><li>Mayor"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    | e '^' e
        {$$ = "<ul><li>Potencia"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    | e '/' e
        {$$ = "<ul><li>Division"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    | e '*' e
        {$$ = "<ul><li>Multiplicacion"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    | e '%' e
        {$$ = "<ul><li>Modulo"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    | e '+' e
        {$$ = "<ul><li>Suma"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    | e '-' e
        {$$ = "<ul><li>Resta"+$1+"<ul><li> "+$2+" "+$3+"</li></ul></li></ul></li></ul>";}
    |CADENA
        {$$ = "<ul><li>Cadena<ul><li>"+$1+"</li></ul></li></ul>";}
    |Identificador '[' e ']' 
       {$$ = "<ul><li> arreglo <ul><li>"+$1+""+$3+"</li></ul></li></ul>";}
    |CARACTER
        {$$ = "<ul><li>Caracter<ul><li>"+$1+"</li></ul></li></ul>";}
    | ENTERO
        {$$ = "<ul><li>Entero<ul><li>"+$1+"</li></ul></li></ul>";}
    | DECIMAL
        {$$ = "<ul><li>Decimal<ul><li>"+$1+"</li></ul></li></ul>";}
    |true
        {$$ = "<ul><li>True<ul><li>"+$1+"</li></ul></li></ul>";}
    |false
        {$$ = "<ul><li>False<ul><li>"+$1+"</li></ul></li></ul>";}
    |LFunc
        {$$ = "<ul><li>Llamada Funcion<ul><li>"+$1+"</li></ul></li></ul>";}
    |Tipo
         {$$ = "<ul><li>tipo<ul><li>"+$1+"</li></ul></li></ul>";}
    |tolower '(' e ')'
         {$$ = "<ul><li>Llamada tolower<ul><li>"+$1+"</li></ul></li></ul>";}
    |toupper '(' e ')'
         {$$ = "<ul><li>Llamada toupper<ul><li>"+$1+"</li></ul></li></ul>";}
    |lenght '(' e ')'
        {$$ = "<ul><li>Llamada lenght<ul><li>"+$1+"</li></ul></li></ul>";}
    |truncate '(' e ')'
        {$$ = "<ul><li>Llamada truncate<ul><li>"+$1+"</li></ul></li></ul>";}
    |round '(' e ')'
         {$$ = "<ul><li>Llamada round<ul><li>"+$1+"</li></ul></li></ul>";}
    |typeof '(' e ')'
         {$$ = "<ul><li>Llamada typeof<ul><li>"+$1+"</li></ul></li></ul>";}
    |tostring '(' e ')'
         {$$ = "<ul><li>Llamada to string<ul><li>"+$1+"</li></ul></li></ul>";}
    |tochararray '(' e ')'
         {$$ = "<ul><li>Llamada To charArray<ul><li>"+$1+"</li></ul></li></ul>";}
    |Identificador
        {$$ = "<ul><li>Identificador<ul><li>"+$1+"</li></ul></li></ul>";};
        
    Swit: switch '(' e ')' '{' Cas Def '}' {$$="<ul><li>Condicion Switch "+$3+"</li></ul><ul><li>Cuerpo Switch "+$6+$7+"</li></ul>";};


    Cas: Cas case e ':' Sent1 {$$=$1+"<ul><li>Condicion Case "+$3+"</li></ul><ul><li>Cuerpo Case "+$5+"</li></ul>";}
    |Cas case e ':' {$$=$1+"<ul><li>Condicion Case "+$3+"</li></ul>";}
    |Cas case e ':' Sent1 break ';'{$$=$1+"<ul><li>Condicion Case "+$3+"</li></ul><ul><li>Cuerpo Case "+$5+"</li></ul><ul><li>Break "+$6+"</li></ul>";}
    |Cas case e ':' break ';'{$$=$1+"<ul><li>Condicion Case "+$3+"</li></ul><ul><li>Break "+$5+"</li></ul>";}
    |case e ':' {$$="<ul><li>Condicion Case "+$2+"</li></ul>";}
    |case e ':' Sent1 {$$="<ul><li>Condicion Case "+$2+"</li></ul><ul><li>Cuerpo Case "+$4+"</li></ul>";}
    |case e ':' break ';'{$$=$1+"<ul><li>Condicion Case "+$2+"</li></ul><ul><li>Break "+$4+"</li></ul>";}
    |case e ':' Sent1 break ';'{$$="<ul><li>Condicion Case "+$2+"</li></ul><ul><li>Cuerpo Case "+$4+"</li></ul><ul><li>Break "+$5+"</li></ul>";};



   Def: default ':' Sent1 break ';'{$$=$1+" "+ $3+" "+ $4;}
    |default ':' break ';'{$$=$1+" "+ $3;}
    |default ':' Sent1 {$$=$1+" "+ $3;}
    |default ':' {$$=$1;};


    Whil: while '(' e ')' '{' Sent111 {$$="<ul><li>Condicion While "+$3+"</li></ul><ul><li>Cuerpo While "+$6+"</li></ul>"};

    Sent111: Sent1 Senten ';' '}'{$$=$1+"<ul><li>Sentencia<ul><li> "+$2+"</li></ul></li></ul>";}
    |Sent1 '}'{$$=$1}
    |Senten ';' '}'{$$="<ul><li>Sentencia<ul><li> "+$1+"</li></ul></li></ul>";}
    |'}'{};

    Do: do '{' Sent11  while '(' e ')' ';'{$$="<ul><li>Cuerpo Do "+ $3+" </li></ul><ul><li>"+ $4+"<ul><li>Condicion do while" + $6+"</li></ul></li></ul>";};

  
    Fo: for '(' Fo1 ';' e ';'  Aum ')' '{' Sent112  {$$= "<ul><li>Asignacion "+ $3+"<ul><li>Condicion "+$5+"<ul><li>Aumento o Decremento "+$7+"</li></ul></li></ul></li></ul>"+"<ul><li>Cuerpo For"+$10+"</li></ul>";};


    Sent112: Sent1 Senten ';' '}' {$$=$1+"<ul><li>Sentencia<ul><li> "+$2+"</li></ul></li></ul>";}
    |Senten ';' '}'{$$="<ul><li>Sentencia<ul><li> "+$1+"</li></ul></li></ul>";}
    |Sent1 '}'{$$=$1;}
    |'}'{}
    ;

    Fo1: Tipo Identificador '=' e{$$=$1+" "+ $2+" "+$4;}
    | Identificador '=' e{$$=$1+" "+ $3;};

    Aum:AUMETO{$$="<ul><li>Aumento "+$1+"</li></ul>";}
    |DECREMENTO{$$="<ul><li>Decremento "+$1+"</li></ul>";};


        
    DecVec: Tipo '[' ']' Identificador '=' new Tipo '[' e ']' ';' {$$=$1+"$"+$4+"$"+$9;}
     | Tipo '[' ']' Identificador '=' '{' Lista_E '}' ';' {$$=$1+"$"+$4+"$"+$7;};
     
    ModifVec: Identificador '[' ENTERO ']' '=' e  ';'{$$=$1+"$"+$3+"$"+$6;} ; 
    
    Listas: list '<' Tipo '>' Identificador '=' new list  '<' Tipo '>' ';' {$$=$1+"$"+$3+"$"+$5;}
         | list '<' Tipo '>' Identificador '=' tochararray '(' e ')' ';' {$$=$1+"$"+$3+"$"+$5;};

    Modilist : Identificador '[' '[' ENTERO ']' ']' = e ';' {$$=$1+"$"+$4+"$"+$8;} ; 

    Addlist : Identificador '.' '(' e ')' ';' {$$=$1+"$"+$3;} ; 


    Sent1: Sent1 IF{$$="<ul><li>"+$1+"<ul><li>Declaracion If<ul><li>"+$2+"</li></ul></li></ul></li></ul>";}
    |Sent1 Swit{$$="<ul><li>"+$1+"<ul><li>Declaracion Switch<ul><li>"+$2+"</li></ul></li></ul></li></ul>";}
    |Sent1 Whil{$$="<ul><li>"+$1+"<ul><li>Declaracion While<ul><li>"+$2+"</li></ul></li></ul></li></ul>";}
    |Sent1 Do{$$="<ul><li>"+$1+"<ul><li>Declaracion Do<ul><li>"+$2+"</li></ul></li></ul></li></ul>";}
    |Sent1 Var{$$="<ul><li>"+$1+"<ul><li>Declaracion Variable<ul><li>"+$2+"</li></ul></li></ul></li></ul>";}
    |Sent1 Imprimir{$$="<ul><li>"+$1+"<ul><li>Imprimir<ul><li>"+$2+"</li></ul></li></ul></li></ul>";}
    |Sent1 LFunc{$$="<ul><li>"+$1+"<ul><li>Asignacion Funcion <ul><li>"+$2+"</li></ul></li></ul></li></ul>";}
    |Sent1 Avar{$$="<ul><li>"+$1+"<ul><li>Asignacion Variable<ul><li>"+$2+"</li></ul></li></ul></li></ul>";}
    |Sent1 Fo{$$="<ul><li>"+$1+"<ul><li>Declaracion For<ul><li>"+$2+"</li></ul></li></ul></li></ul>";}
    |Sent1 Addlist{$$ = "<ul><li>Modificar Lista<ul><li>"+$1+"</li></ul></li></ul>";}
    |IF{$$="<ul><li>Declaracion If <ul><li>"+$1+"</li></ul></li></ul>";}
    |Swit{$$="<ul><li>Declaracion Switch<ul><li>"+$1+"</li></ul></li></ul>";}
    |Whil{$$="<ul><li>Declaracion While<ul><li>"+$1+"</li></ul></li></ul>";}
    |Do{$$="<ul><li>Declaracion Do<ul><li>"+$1+"</li></ul></li></ul>";}
    |Var{$$="<ul><li>Declaracion Variable<ul><li>"+$1+"</li></ul></li></ul>";}
    |Imprimir{$$="<ul><li>Imprimir<ul><li>"+$1+"</li></ul></li></ul>";}
    |LFunc{$$="<ul><li>Asignacion Funcion<ul><li>"+$1+"</li></ul></li></ul>";}
    |Avar{$$="<ul><li>Asignacion Variable<ul><li>"+$1+"</li></ul></li></ul>";}
    |Fo{$$ = "<ul><li>Declaracion For<ul><li>"+$1+"</li></ul></li></ul>";}
    |DecVec{$$ = "<ul><li>Declaracion Vector<ul><li>"+$1+"</li></ul></li></ul>";}
    |ModifVec{$$ = "<ul><li>Modificacion Vector<ul><li>"+$1+"</li></ul></li></ul>";}
    |Listas{$$ = "<ul><li>Declaracion Lista<ul><li>"+$1+"</li></ul></li></ul>";}
    |Modilist{$$ = "<ul><li>Modificar Lista<ul><li>"+$1+"</li></ul></li></ul>";}
    |Addlist{$$ = "<ul><li>Agregar a lista <ul><li>"+$1+"</li></ul></li></ul>";}
    |ejecuciones{$$ = "<ul><li>Exec<ul><li>"+$1+"</li></ul></li></ul>";};

 
 