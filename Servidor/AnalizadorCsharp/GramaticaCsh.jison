
/*------------------------------------------------IMPORTS----------------------------------------------*/
%{
    

    let Prueba=require('../CshAST/Mostrar');
    let Tok = require("../Token");
    var Tokens = new Array();
    let CErrores=require('../CshAST/Errores');
    let CNodoError=require('../CshAST/NodoError');
    
%}



/*------------------------------------------------LEXICO------------------------------------------------*/
%lex

%%
\s+                                 // alv los espacios en blanco
"//".*                              // comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] // comentario multiple líneas
"-"                   return '-';
"+"                   return '+';
"^"                   return '^';
"("                   return '(';
")"                   return ')';
"*"                   return '*';
"/"                   return '/';
"int"                    return 'int';
"double"                    return 'double';
"bool"                    return 'bool';
"char"                    return 'char';
"string"                    return 'string';
","                    return ',';
"class"               return 'class';
"{"                    return '{';
"}"                    return '}';

";"                    return ';';
"void"                    return 'void';
"main"                    return 'main';
"Console"                    return 'Console';
"."                    return '.';
"Write"                    return 'Write';
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
"if"                    return 'if';
"else"                    return 'else';
[\n]                      return 'SALTO';
"true"                 return 'true';
"false"                 return 'false';
"for"                    return 'for';
"continue"                    return 'continue';
"return"                    return 'return';
"switch"                    return 'switch';
[0-9]+."+""+"       return 'EAUMENTO';
[0-9]+("."[0-9]+)."+""+"  return 'DAUMENTO';
[0-9]+."-""-"       return 'EDECREMENTO';
[0-9]+("."[0-9]+)."-""-"  return 'DDECREMENTO';
[0-9]+("."[0-9]+)  return 'DECIMAL';
[0-9]+             return 'ENTERO';
[A-Za-z|"_"]+[A-Za-z|0-9|"_"]*"+""+"     return 'AUMETO';
[A-Za-z|"_"]+[A-Za-z|0-9|"_"]*"-""-"     return 'DECREMENTO';
[\']([^])[\'] return 'CARACTER';
[\"]([^\"\n]|(\\|\"))*[\"]             return 'CADENA';
[\']([^\'\n]|(\\|\'))*[\']             return 'CADENAHTML';
[A-Za-z|"_"]+[A-Za-z|0-9|"_"]*  return 'Identificador';
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
{    $$=new Prueba.most($1); return $$.mostr();
    
};

S10:S10 Sent1{$$=$1+" "+$2;}
|Sent1 {$$=$1;}
|S10 Sent2{$$=$1+" "+$2;}
|Sent2 {$$=$1;}
|error {CErrores.Errores.add(new CNodoError.NodoError("Sintactico","No se esperaba el token: "+yytext,yylineno));}
;

SIm: Imp{$$="<ul><li>Import<ul><li>"+$1+"</li></ul></li></ul>";};
Scl: S1{$$="<ul><li>Clase<ul><li>"+$1+"</li></ul>";};


S1: class Identificador '{'  Sent12 {$$=$1+" "+ $2+" "+ $4 ;};



Sent12: Sent2 '}'{$$=$1+" "+$2;}
|'}'{$$="";};



Var: Tipo Lista_Id Var1{$$=$1+" "+ $2+" "+ $3;};

Tipo: int{$$=$1;}
|double{$$=$1;}
|bool{$$=$1;}
|char{$$=$1;}
|string{$$=$1;};

Lista_Id: Lista_Id ',' Identificador{$$=$1+" "+ $2+" "+ $3;}
|Identificador{$$=$1;};

Var1:'=' e ';'{$$= $2;}
|';'{};

Avar: Identificador '(' ')' ';'{$$=$1+" "+ $2+" "+ $3;}
|Identificador '=' e ';'{$$=$1+" "+ $3};

Func: Tipo Identificador '(' Lista_Parametro ')' '{' Sent123 {$$=$1+" "+ $2+" "+ $3+" "+ $4 +" "+$5+" "+ $7;}
|Tipo Identificador '(' ')' '{' Sent123 {$$=$1+" "+ $2+" "+ $3+" "+ $4 +" "+ $6;};

Sent123: Sent1111 return e ';' '}'{$$=$1+"<ul><li>Return<ul><li>"+$2+$3+"</li></ul></li></ul>";}
|return e ';' '}'{$$="<ul><li>Return<ul><li>"+$1+$2+"</li></ul></li></ul>";}
| Sent1111 '}'{$$=$1;}

|'}'{};

Lista_Parametro: Var2 {$$=$1;};

Var2: Var2 ',' Tipo Identificador{$$=$1+" "+ $2+" "+ $3+" "+ $4;}
|Tipo Identificador{$$=$1+" "+ $2;};

Metodo: void Identificador '(' Lista_Parametro ')' '{' Sent113 {$$="<ul><li>Identificador Metodo "+$2+"<ul><li>Parametros Metodo <ul><li>"+$4+"</li></ul></li></ul><ul><li>Cuerpo metodo "+$7+"</li></ul></li></ul>";}
|void main '(' ')' '{' Sent113  {$$="<ul><li>Main "+$2+"<ul><li>Cuerpo Main "+$6+"</li></ul></li></ul>";}
|void Identificador '(' ')' '{' Sent113 {$$="<ul><li>Identificador Metodo "+$2+"<ul><li>Cuerpo Metodo "+$6+"</li></ul></li></ul>";};

Sent113: Sent1111 return ';' '}'{$$=$1+"<ul><li>Return"+$2+"</li></ul>";}
| return ';' '}'{$$="<ul><li>Return<ul><li> "+$1+"</li></ul></li></ul>";}
|Sent1111'}' {$$=$1;}
|'}'{};

LFunc: Identificador '(' Lista_E ')'{$$=$1+" "+ $3;};
Lista_E: Lista_E ',' e{$$=$1+"  "+ $3;}
|e{$$=$1;};

Imprimir: Console '.' Write  '(' e ')' ';' {$$="<ul><li>Tipo Imprimir "+$5+"</li></ul>"+"<ul><li>Sentencia a Imprimir"+$5+"</li></ul>";};


IF: if '(' e ')' '{' Sent11  {$$="<ul><li>Condicion If"+$3+"</li></ul><ul><li>Cuerpo If"+$6+"</li></ul>";}
|if '(' e ')' '{' Sent11  else '{' Sent11 {$$="<ul><li>Condicion If"+$3+"</li></ul><ul><li>Cuerpo If"+$6+"</li></ul><ul><li>Cuerpo else"+$9+"</li></ul>";}
|if '(' e ')' '{' Sent11  ELS{$$="<ul><li>Condicion If"+$3+"</li></ul><ul><li>Cuerpo If"+$6+"</li></ul>"+$7;}
|if '(' e ')' '{' Sent11  ELS else'{' Sent11 {$$="<ul><li>Condicion If"+$3+"</li></ul><ul><li>Cuerpo If"+$6+"</li></ul>"+$7+"</li></ul><ul><li>Cuerpo else"+$10+"</li></ul>";};

ELS: ELS else if '(' e ')' '{' Sent11  {$$=$1+"<ul><li>Declaracion Else If<ul><li>Condicion Else If"+$5+"</li></ul><ul><li>Cuerpo Else If"+$8+"</li></ul></li></ul>";}
|else if '(' e ')' '{' Sent11 {$$="<ul><li>Declaracion Else If<ul><li>Condicion Else If"+$4+"</li></ul><ul><li>Cuerpo Else If"+$7+"</li></ul></li></ul>";};

Sent11: Sent1111 '}' {$$=$1;}  
 
|Sent1111 Senten ';' '}' {$$=$1+"<ul><li>Sentencia<ul><li> "+$2+"</li></ul></li></ul>";}

|Senten';' '}' {$$="<ul><li>Sentencia<ul><li> "+$1+"</li></ul></li></ul>";}
|'}'{};



Senten: break {$$=$1;}
|return {$$=$1;}
|return e {$$=$1+$2;}
|continue {$$=$1;};

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
|CADENAHTML
    {$$ = "<ul><li>Cadenahtml<ul><li>"+$1+"</li></ul></li></ul>";}
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
|Identificador
    {$$ = "<ul><li>Identificador<ul><li>"+$1+"</li></ul></li></ul>";};

Swit: switch '(' e ')' '{' Cas Def '}' {$$="<ul><li>Condicion Switch "+$3+"</li></ul><ul><li>Cuerpo Switch "+$6+$7+"</li></ul>";};

Cas: Cas case e ':' Sent1111 {$$=$1+"<ul><li>Condicion Case "+$3+"</li></ul><ul><li>Cuerpo Case "+$5+"</li></ul>";}
|Cas case e ':' {$$=$1+"<ul><li>Condicion Case "+$3+"</li></ul>";}
|Cas case e ':' Sent1111 break ';'{$$=$1+"<ul><li>Condicion Case "+$3+"</li></ul><ul><li>Cuerpo Case "+$5+"</li></ul><ul><li>Break "+$6+"</li></ul>";}
|Cas case e ':' break ';'{$$=$1+"<ul><li>Condicion Case "+$3+"</li></ul><ul><li>Break "+$5+"</li></ul>";}
|case e ':' {$$="<ul><li>Condicion Case "+$2+"</li></ul>";}
|case e ':' Sent1111 {$$="<ul><li>Condicion Case "+$2+"</li></ul><ul><li>Cuerpo Case "+$4+"</li></ul>";}
|case e ':' break ';'{$$=$1+"<ul><li>Condicion Case "+$2+"</li></ul><ul><li>Break "+$4+"</li></ul>";}
|case e ':' Sent1111 break ';'{$$="<ul><li>Condicion Case "+$2+"</li></ul><ul><li>Cuerpo Case "+$4+"</li></ul><ul><li>Break "+$5+"</li></ul>";};

Def: default ':' Sent1111 break ';'{$$=$1+" "+ $3+" "+ $4;}
|default ':' break ';'{$$=$1+" "+ $3;}
|default ':' Sent1111 {$$=$1+" "+ $3;}
|default ':' {$$=$1;};

Whil: while '(' e ')' '{' Sent111 {$$="<ul><li>Condicion While "+$3+"</li></ul><ul><li>Cuerpo While "+$6+"</li></ul>";};

Sent111: Sent1111 Senten ';' '}'{$$=$1+"<ul><li>Sentencia<ul><li> "+$2+"</li></ul></li></ul>";}
|Sent1111 '}'{$$=$1}
|Senten ';' '}'{$$="<ul><li>Sentencia<ul><li> "+$1+"</li></ul></li></ul>";}
|'}'{};

Do: do '{' Sent11  while '(' e ')' ';'{$$="<ul><li>Cuerpo Do "+ $3+" </li></ul><ul><li>"+ $4+"<ul><li>Condicion do while" + $6+"</li></ul></li></ul>";};

Fo: for '(' Fo1 ';' e ';'  Aum ')' '{' Sent112  {$$= "<ul><li>Asignacion "+ $3+"<ul><li>Condicion "+$5+"<ul><li>Aumento o Decremento "+$7+"</li></ul></li></ul></li></ul>"+"<ul><li>Cuerpo For"+$10+"</li></ul>";};

Sent112: Sent1111 Senten ';' '}' {$$=$1+"<ul><li>Sentencia<ul><li> "+$2+"</li></ul></li></ul>";}
|Senten ';' '}'{$$="<ul><li>Sentencia<ul><li> "+$1+"</li></ul></li></ul>";}
|Sent1111 '}'{$$=$1;}
|'}'{}
;

Fo1: Tipo Identificador '=' e{$$=$1+" "+ $2+" "+$4;}
| Identificador '=' e{$$=$1+" "+ $3;};

Aum:AUMETO{$$="<ul><li>Aumento "+$1+"</li></ul>";}
|DECREMENTO{$$="<ul><li>Decremento "+$1+"</li></ul>";};

Sent1: IF{$$="<ul><li>Declaracion If <ul><li>"+$1+"</li></ul></li></ul>";}
|Swit{$$="<ul><li>Declaracion Switch<ul><li>"+$1+"</li></ul></li></ul>";}
|Whil{$$="<ul><li>Declaracion While<ul><li>"+$1+"</li></ul></li></ul>";}
|Do{$$="<ul><li>Declaracion Do<ul><li>"+$1+"</li></ul></li></ul>";}
|LFunc{$$="<ul><li>Asignacion Funcion<ul><li>"+$1+"</li></ul></li></ul>";}
|Fo{$$ = "<ul><li>Declaracion For<ul><li>"+$1+"</li></ul></li></ul>";}

;

Sent2: Imprimir{$$ = "<ul><li>Imprimir<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Func{$$ = "<ul><li>Declaracion Funcion<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Metodo{$$ = "<ul><li>Declaracion Metodo<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Var{$$ = "<ul><li>Declaracion Variable<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Avar{$$ = "<ul><li>Asignacion Variable<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}

;

Sent1111: IF{$$="<ul><li>Declaracion If <ul><li>"+$1+"</li></ul></li></ul>";}
|Swit{$$="<ul><li>Declaracion Switch<ul><li>"+$1+"</li></ul></li></ul>";}
|Whil{$$="<ul><li>Declaracion While<ul><li>"+$1+"</li></ul></li></ul>";}
|Do{$$="<ul><li>Declaracion Do<ul><li>"+$1+"</li></ul></li></ul>";}
|LFunc{$$="<ul><li>Asignacion Funcion<ul><li>"+$1+"</li></ul></li></ul>";}
|Fo{$$ = "<ul><li>Declaracion For<ul><li>"+$1+"</li></ul></li></ul>";}
|Sent1111 IF{$$=$1+"<ul><li>Declaracion If <ul><li>"+$2+"</li></ul></li></ul>";}
|Sent1111 Swit{$$=$1+"<ul><li>Declaracion Switch<ul><li>"+$2+"</li></ul></li></ul>";}
|Sent1111 Whil{$$=$1+"<ul><li>Declaracion While<ul><li>"+$2+"</li></ul></li></ul>";}
|Sent1111 Do{$$=$1+"<ul><li>Declaracion Do<ul><li>"+$2+"</li></ul></li></ul>";}
|Sent1111 LFunc{$$=$1+"<ul><li>Asignacion Funcion<ul><li>"+$2+"</li></ul></li></ul>";}
| Sent1111 Fo{$$ = $1+"<ul><li>Declaracion For<ul><li>"+$2+"</li></ul></li></ul>";}
|Sent1111 Imprimir{$$ = $1+"<ul><li>Imprimir<ul><li>"+$2+"</li></ul></li></ul></li></ul>";}
|Sent1111 Avar{$$ =$1+ "<ul><li>Asignacion Variable<ul><li>"+$2+"</li></ul></li></ul></li></ul>";}
|Sent1111 Var{$$ = $1+"<ul><li>Declaracion Variable<ul><li>"+$2+"</li></ul></li></ul></li></ul>";}
| Imprimir{$$ = "<ul><li>Imprimir<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Avar{$$ = "<ul><li>Asignacion Variable<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Var{$$ = "<ul><li>Declaracion Variable<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
;

Sent2222: Imprimir{$$ = "<ul><li>Imprimir<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Func{$$ = "<ul><li>Declaracion Funcion<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Metodo{$$ = "<ul><li>Declaracion Metodo<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Var{$$ = "<ul><li>Declaracion Variable<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Avar{$$ = "<ul><li>Asignacion Variable<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
| Sent22 Imprimir{$$ =$1+ "<ul><li>Imprimir<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Sent2222 Func{$$ = $1+"<ul><li>Declaracion Funcion<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Sent2222 Metodo{$$ = $1+"<ul><li>Declaracion Metodo<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Sent2222 Var{$$ =$1+ "<ul><li>Declaracion Variable<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}
|Sent2222 Avar{$$ =$1+ "<ul><li>Asignacion Variable<ul><li>"+$1+"</li></ul></li></ul></li></ul>";}

;


