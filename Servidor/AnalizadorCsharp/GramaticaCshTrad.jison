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
[\']([^\'\n]|(\\|\'))*[\']            return 'CADENAHTML';
[A-Za-z|"_"]+[A-Za-z|0-9|"_"]*  return 'Identificador';
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

S10: S10 Sent1{$$=$1+" "+$2;}
|Sent1 {$$=$1;}
|S10 Sent2{$$=$1+" "+$2;}
|Sent2 {$$=$1;}
|error {}
;

SIm: Imp{$$=$1;};
Scl: S1{$$=$1;};


S1: class Identificador '{'  Sent12 {$$=$1+" "+ $2+" "+ $4 ;};



Sent12: Sent2 '}'{$$=$1;}
|'}'{};



Var: Tipo Lista_Id Var1{$$=$1+" "+ $2+" "+ $3;};

Tipo: int{$$="var";}
|double{$$="var";}
|bool{$$="var";}
|char{$$="var";}
|string{$$="var";};

Lista_Id: Lista_Id ',' Identificador{$$=$1+" "+ $2+" "+ $3;}
|Identificador{$$=$1;};

COMEENT:COMMULT {$$="\'\'\' \n"+$1+" \n \'\'\'";}
|COMSIMP {$$="#"+$1;};

Var1:'=' e ';'{$$= "= "+$2;}
|';'{$$=" ";};

Avar: Identificador '(' ')' ';'{$$="def "+ $2+" "+ $3;}
|Identificador '=' e ';'{$$=$1+" ="+ $3;};

Func: Tipo Identificador '(' Lista_Parametro ')' '{' Sent123 {$$=$1+" "+ $2+" "+ $3+" "+ $4 +" "+$5+" "+ $7;}
|Tipo Identificador '(' ')' '{' Sent123 {$$=$1+" "+ $2+" "+ $3+" "+ $4 +" "+ $6;};

Sent123: Sent1111 return e ';' '}'{$$=$1+" return"+$3;}
|return e ';' '}'{$$=$1+" "+$2;}
| Sent1111 '}'{$$=$1;}
|'}'{$$="\n";};

Lista_Parametro: Var2 {$$=$1;};

Var2: Var2 ',' Tipo Identificador{$$=$1+" "+ $2+" "+ $3+" "+ $4;}
|Tipo Identificador{$$=$1+" "+ $2;};

Metodo: void Identificador '(' Lista_Parametro ')' '{' Sent113 {$$="def "+$2+"("+$4+"): \n"+$7;}
|void main '(' ')' '{' Sent113  {$$="def"+$2+" "+" ( ) :\n"+$6+" \n if name = \"main \" :main() \n";}
|void Identificador '(' ')' '{' Sent113 {$$="def "+$2+" ( ) : \n"+$6;};

Sent113: Sent1111 return ';' '}'{$$=$1+" "+$2;}
| return ';' '}'{$$=$1;}
|Sent1111'}' {$$=$1;}
|'}'{$$="\n";};

LFunc: Identificador '(' Lista_E ')'{$$=$1+" "+ $3;};
Lista_E: Lista_E ',' e{$$=$1+"  "+ $3;}
|e{$$=$1;};

Imprimir: Console '.' Write  '('  e   ')' ';' {$$="print("+$5+") \n";}; 


IF: if '(' e ')' '{' Sent11  {$$="if  "+$3+" : \n"+$6;}
|if '(' e ')' '{' Sent11  else '{' Sent11 {$$="if "+$3+": \n"+$6+"\n"+"else : \n"+$9;}//if ya estan
|if '(' e ')' '{' Sent11  ELS {$$="if "+$3+": \n"+$6+"\n"+$7+"\n";}
|if '(' e ')' '{' Sent11  ELS else'{' Sent11 {$$="if "+$3+": \n"+$6+"\n"+$7+"\n"+$8+": \n"+$10;};

ELS: ELS else if '(' e ')' '{' Sent11  {$$=$1+" "+" elif  "+$5+" : \n"+$8;}
|else if '(' e ')' '{' Sent11 {$$=" elif  "+$4+" : \n"+$7;};

Sent11: Sent1111 '}' {$$=$1;}  
|Sent1111 Senten ';' '}' {$$=$1+" "+$2;}
|Senten';' '}' {$$=$1;}
|'}'{$$="\n ";};



Senten: break {$$=$1;}
|return {$$=$1;}
|return e {$$=$1+$2;}
|continue {$$=$1;};

e: e '&&' e
    {$$=$1+" "+" and "+" "+$3;}
| e '||' e
     {$$=$1+" "+" or "+" "+$3;}
|'!' e
     {$$=$1+" "+" not "+" "+$3;}
| '-' e %prec UMINUS
     {$$=$1+" "+$2+" "+$3;}
| '*''-' e %prec UMINUS
    {$$=$1+" "+$2+" "+$3;}
| '(' e ')'
     {$$=$1+" "+$2+" "+$3;}
| e '==' e
    {$$=$1+" "+$2+" "+$3;}
| e '!=' e
     {$$=$1+" "+$2+" "+$3;}
| e '<=' e
    {$$=$1+" "+$2+" "+$3;}
| e '>=' e
     {$$=$1+" "+$2+" "+$3;}
| e '<' e
     {$$=$1+" "+$2+" "+$3;}
| e '>' e
     {$$=$1+" "+$2+" "+$3;}
| e '^' e
    {$$=$1+" "+$2+" "+$3;}
| e '/' e
     {$$=$1+" "+$2+" "+$3;}
| e '*' e
    {$$=$1+" "+$2+" "+$3;}
| e '%' e
   {$$=$1+" "+$2+" "+$3;}
| e '+' e
  {$$=$1+" "+$2+" "+$3;}
| e '-' e
  {$$=$1+" "+$2+" "+$3;}
|CADENA
    {$$=$1;}
|CADENAHTML
  {$$=$1;}
|CARACTER
   {$$=$1;}
| ENTERO
    {$$=$1;}
| DECIMAL
  {$$=$1;}
|true
    {$$=$1;}
|false
    {$$=$1;}
|LFunc
   {$$=$1;}
|Identificador
    {$$=$1;};



e2: e2 '&&' e2
    {$$=$1+" "+" and "+" "+$3;}
| e2 '||' e2
     {$$=$1+" "+" or "+" "+$3;}
|'!' e2
     {$$=$1+" "+" not "+" "+$3;}
| '-' e2 %prec UMINUS
     {$$=$3;}
| '*''-' e2 %prec UMINUS
    {$$=$3;}
| '(' e2 ')'
     {$$=$3;}
| e2 '==' e2
   {$$=$3;}
| e2 '!=' e2
     {$$=$3;}
| e2 '<=' e2
    {$$=$3;}
| e2 '>=' e2
   {$$=$3;}
| e2 '<' e2
     {$$=$3;}
| e2 '>' e2
   {$$=$3;}
| e2 '^' e2
   {$$=$3;}
| e2 '/' e2
    {$$=$3;}
| e2 '*' e2
   {$$=$3;}
| e2 '%' e2
  {$$=$3;}
| e2 '+' e2
{$$=$3;}
| e2 '-' e2
 {$$=$3;}
|CADENA
    {$$=$1;}
|CADENAHTML
  {$$=$1;}
|CARACTER
   {$$=$1;}
| ENTERO
    {$$=$1;}
| DECIMAL
  {$$=$1;}
|true
    {$$=$1;}
|false
    {$$=$1;}
|LFunc
   {$$=$1;}
|Identificador
    {$$=$1;};    


e8: e8 '&&' e8
    {$$=$1+" "+" and "+" "+$3;}
| e8 '||' e8
     {$$=$1+" "+" or "+" "+$3;}
|'!' e8
     {$$=$1+" "+" not "+" "+$3;}
| '-' e8 %prec UMINUS
     {$$=$1+" "+$2+" "+$3;}
| '*''-' e8 %prec UMINUS
    {$$=$1+" "+$2+" "+$3;}
| '(' e8 ')'
     {$$=$1+" "+$2+" "+$3;}
| e8 '==' e8
    {$$=$1+" "+$2+" "+$3;}
| e8 '!=' e8
     {$$=$1+" "+$2+" "+$3;}
| e8 '<=' e8
    {$$=$1+" "+$2+" "+$3;}
| e8 '>=' e8
     {$$=$1+" "+$2+" "+$3;}
| e8 '<' e8
     {$$=$1+" "+$2+" "+$3;}
| e8 '>' e8
     {$$=$1+" "+$2+" "+$3;}
| e8 '^' e8
    {$$=$1+" "+$2+" "+$3;}
| e8 '/' e8
     {$$=$1+" "+$2+" "+$3;}
| e8 '*' e8
    {$$=$1+" "+$2+" "+$3;}
| e8 '%' e8
   {$$=$1+" "+$2+" "+$3;}
| e8 '+' e8
  {$$=$1+" "+","+" "+$3;}
| e8 '-' e8
  {$$=$1+" "+$2+" "+$3;}
|CADENA
    {$$=$1;}
|CADENAHTML
  {$$=$1;}
|CARACTER
   {$$=$1;}
| ENTERO
    {$$=$1;}
| DECIMAL
  {$$=$1;}
|true
    {$$=$1;}
|false
    {$$=$1;}
|LFunc
   {$$=$1;}
|Identificador
    {$$=$1;};



Swit: switch '(' e ')' '{' Cas Def '}' {$$="def switch  ("+$3+") : \n"+"switcher{"+$6+$7+"}";};

Cas: Cas case e ':' Sent1111 {$$=$3+" :"+$5;}
|Cas case e ':' {$$=$3+" :";}
|Cas case e ':' Sent1111 break ';'{$$=$3+" :"+$5+",\n";}
|Cas case e ':' break ';'{$$=$3+" :"+",\n";}
|case e ':' {$$=$2+" : \n";}
|case e ':' Sent1111 {$$=$2+" : \n"+$4;}
|case e ':' break ';'{$$=$2+" :  , \n";}
|case e ':' Sent1111 break ';'{$$=$2+" : "+$4+",";};


Def: default ':' Sent1111 break ';'{$$=$1+" :"+ $3+" ,";}
|default ':' break ';'{$$=$1+": , ";}
|default ':' Sent1111 {$$=$1+" : "+ $3;}
|default ':' {$$=$1+":";};

Whil: while '(' e ')' '{' Sent111 {$$=$1+" "+$3+":\n"+$6;};

Sent111: Sent1111 Senten ';' '}'{$$=$1+" "+$2;}
|Sent1111 '}'{$$=$1;}
|Senten ';' '}'{$$=$1;}
|'}'{};

Do: do '{' Sent11  while '(' e ')' ';'{$$="while True : \n"+$3+"if("+$6+"):/n break";};

Fo: for '(' Fo1 ';' e2 ';'  Aum ')' '{' Sent112  {$$=$1+" "+$3+","+$5+"): \n"+$10;};

Sent112: Sent1111 Senten ';' '}' {$$=$1+" "+$2;}
|Senten ';' '}'{$$=$1;}
|Sent1111 '}'{$$=$1;}
|'}'{$$="\n";}
;

Fo1: Tipo Identificador '=' e2{$$= $2+" in a range("+$4;}
| Identificador '=' e2{$$= $1+"in a range("+$3;};

Aum:AUMETO{$$=$1;}
|DECREMENTO{$$=$1;};

Sent1: IF{$$=$1;}
|Swit{$$=$1;}
|Whil{$$=$1;}
|Do{$$=$1;}
|LFunc{$$=$1;}
|Fo{$$=$1;}

;

Sent2: Imprimir{$$=$1;}
|Func{$$=$1;}
|Metodo{$$=$1;}
|Var{$$=$1;}
|Avar{$$=$1;}


;
Sent1111: IF{$$=$1;}
|Swit{$$=$1;}
|Whil{$$=$1;}
|Do{$$=$1;}
|LFunc{$$=$1;}
|Fo{$$=$1;}
|Var{$$=$1;}
|Avar{$$=$1;}
|Imprimir{$$=$1;}
|Sent1111 IF{$$=$1+" "+$2;}
|Sent1111 Swit{$$=$1+" "+$2;}
|Sent1111 Whil{$$=$1+" "+$2;}
|Sent1111 Do{$$=$1+" "+$2;}
|Sent1111 LFunc{$$=$1+" "+$2;}
|Sent1111 Fo{$$=$1+" "+$2;}
|Sent1111 Imprimir{$$=$1+" "+$2;}
|Sent1111 Avar{$$=$1+" "+$2;}
|Sent1111 Var{$$=$1+" "+$2;}

;

Sent2222: Imprimir{$$=$1;}
|Func{$$=$1;}
|Metodo{$$=$1;}
|Var{$$=$1;}
|Avar{$$=$1;}
|Sent2222 Imprimir{$$=$1+" "+$2;}
|Sent2222 Func{$$=$1+" "+$2;}
|Sent2222 Metodo{$$=$1+" "+$2;}
|Sent2222 Var{$$=$1+" "+$2;}
|Sent2222 Avar{$$=$1+" "+$2;}

;

