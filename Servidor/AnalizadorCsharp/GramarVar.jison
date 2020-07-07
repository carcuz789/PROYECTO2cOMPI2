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

%options case-sensitive

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



Var: Tipo Lista_Id Var1{$$="TIPO -> "+$1+" Variables -> "+ $2+" \n ";};

Tipo: int{$$=$1;}
|double{$$=$1;}
|bool{$$=$1;}
|char{$$=$1;}
|string{$$=$1;};

Lista_Id: Lista_Id ',' Identificador{$$=$1+","+$3;}
|Identificador{$$=$1;};



Var1:'=' e ';'{$$= "";}
|';'{$$=" ";};

Avar: Identificador '(' ')' ';'{$$=" ";}
|Identificador '=' e ';'{$$=" ";};

Func: Tipo Identificador '(' Lista_Parametro ')' '{' Sent123 {$$=$4;}
|Tipo Identificador '(' ')' '{' Sent123 {$$=$6;};

Sent123: Sent1111 return e ';' '}'{$$=$1;}
|return e ';' '}'{$$=" ";}
| Sent1111 '}'{$$=$1;}
|'}'{$$=" ";};

Lista_Parametro: Var2 {$$=$1;};

Var2: Var2 ',' Tipo Identificador{$$=$1+"Tipo -> "+$3+" Identificador -> "+$4+"\n";}
|Tipo Identificador{$$="Tipo -> "+$1+" Identificador -> "+$2 ;}; 

Metodo: void Identificador '(' Lista_Parametro ')' '{' Sent113 {$$=$7;}
|void main '(' ')' '{' Sent113  {$$=$6;}
|void Identificador '(' ')' '{' Sent113 {$$=$6;};

Sent113: Sent1111 return ';' '}'{$$=$1;}
| return ';' '}'{$$=" ";}
|Sent1111'}' {$$=$1;}
|'}'{$$="\n";};

LFunc: Identificador '(' Lista_E ')'{$$=" ";};
Lista_E: Lista_E ',' e{$$=" ";}
|e{$$=" ";};

Imprimir: Console '.' Write  '('  e   ')' ';' {$$="";}; 


IF: if '(' e ')' '{' Sent11  {$$=$6;}
|if '(' e ')' '{' Sent11  else '{' Sent11 {$$=$6+"\n"+$9;}//if ya estan
|if '(' e ')' '{' Sent11  ELS {$$=$6+" "+$7;}
|if '(' e ')' '{' Sent11  ELS else'{' Sent11 {$$=$6+" "+$7+" "+$10;};

ELS: ELS else if '(' e ')' '{' Sent11  {$$=$8;}
|else if '(' e ')' '{' Sent11 {$$=$7;};

Sent11: Sent1111 '}' {$$=$1;}  
|Sent1111 Senten ';' '}' {$$=$1;}
|Senten';' '}' {$$="";}
|'}'{$$="\n ";};



Senten: break {$$=" ";}
|return {$$=" ";}
|return e {$$=" ";}
|continue {$$=" ";};

e: e '&&' e
    {$$="";}
| e '||' e
     {$$="";}
|'!' e
     {$$="";}
| '-' e %prec UMINUS
  {$$="";}
| '*''-' e %prec UMINUS
    {$$="";}
| '(' e ')'
     {$$="";}
| e '==' e
    {$$="";}
| e '!=' e
    {$$="";}
| e '<=' e
    {$$="";}
| e '>=' e
    {$$="";}
| e '<' e
    {$$="";}
| e '>' e
     {$$="";}
| e '^' e
   {$$="";}
| e '/' e
     {$$="";}
| e '*' e
   {$$="";}
| e '%' e
   {$$="";}
| e '+' e
  {$$="";}
| e '-' e
  {$$="";}
|CADENA
   {$$="";}
|CADENAHTML
  {$$=$1;}
|CARACTER
 {$$="";}
| ENTERO
    {$$="";}
| DECIMAL
 {$$="";}
|true
    {$$="";}
|false
  {$$="";}
|LFunc
 {$$="";}
|Identificador
    {$$="";};

e2: e2 '&&' e2
    {$$="";}
| e2 '||' e2
     {$$="";}
|'!' e2
     {$$="";}
| '-' e2 %prec UMINUS
  {$$="";}
| '*''-' e2 %prec UMINUS
    {$$="";}
| '(' e2 ')'
     {$$="";}
| e2 '==' e2
    {$$="";}
| e2 '!=' e2
    {$$="";}
| e2 '<=' e2
    {$$="";}
| e2 '>=' e2
    {$$="";}
| e2 '<' e2
    {$$="";}
| e2 '>' e2
     {$$="";}
| e2 '^' e2
   {$$="";}
| e2 '/' e2
     {$$="";}
| e2 '*' e2
   {$$="";}
| e2 '%' e2
   {$$="";}
| e2 '+' e2
  {$$="";}
| e2 '-' e2
  {$$="";}
|CADENA
   {$$="";}
|CADENAHTML
  {$$=$1;}
|CARACTER
 {$$="";}
| ENTERO
    {$$="";}
| DECIMAL
 {$$="";}
|true
    {$$="";}
|false
  {$$="";}
|LFunc
 {$$="";}
|Identificador
    {$$="";};


e8: e8 '&&' e8
    {$$="";}
| e8 '||' e8
     {$$="";}
|'!' e8
     {$$="";}
| '-' e8 %prec UMINUS
  {$$="";}
| '*''-' e8 %prec UMINUS
    {$$="";}
| '(' e8 ')'
     {$$="";}
| e8 '==' e8
    {$$="";}
| e8 '!=' e8
    {$$="";}
| e8 '<=' e8
    {$$="";}
| e8 '>=' e8
    {$$="";}
| e8 '<' e8
    {$$="";}
| e8 '>' e8
     {$$="";}
| e8 '^' e8
   {$$="";}
| e8 '/' e8
     {$$="";}
| e8 '*' e8
   {$$="";}
| e8 '%' e8
   {$$="";}
| e8 '+' e8
  {$$="";}
| e8 '-' e8
  {$$="";}
|CADENA
   {$$="";}
|CADENAHTML
  {$$=$1;}
|CARACTER
 {$$="";}
| ENTERO
    {$$="";}
| DECIMAL
 {$$="";}
|true
    {$$="";}
|false
  {$$="";}
|LFunc
 {$$="";}
|Identificador
    {$$="";};



Swit: switch '(' e ')' '{' Cas Def '}' {$$=$6+" "+$7;};

Cas: Cas case e ':' Sent1111 {$$=$5;}
|Cas case e ':' {$$=" ";}
|Cas case e ':' Sent1111 break ';'{$$=$5;}
|Cas case e ':' break ';'{$$=" ";}
|case e ':' {$$=" ";}
|case e ':' Sent1111 {$$=$4;}
|case e ':' break ';'{$$=" ";}
|case e ':' Sent1111 break ';'{$$=$4;};


Def: default ':' Sent1111 break ';'{$$=$3;}
|default ':' break ';'{$$=" ";}
|default ':' Sent1111 {$$=$3;}
|default ':' {$$=" ";};

Whil: while '(' e ')' '{' Sent111 {$$=$6;};

Sent111: Sent1111 Senten ';' '}'{$$=$1+" "+$2;}
|Sent1111 '}'{$$=$1;}
|Senten ';' '}'{$$=$1;}
|'}'{$$=" ";};

Do: do '{' Sent11  while '(' e ')' ';'{$$=$3;};

Fo: for '(' Fo1 ';' e2 ';'  Aum ')' '{' Sent112  {$$=$10;};

Sent112: Sent1111 Senten ';' '}' {$$=$1+" "+$2;}
|Senten ';' '}'{$$=$1;}
|Sent1111 '}'{$$=$1;}
|'}'{$$="\n";}
;

Fo1: Tipo Identificador '=' e2{$$=" Tipo ->"+$1 +" Identificador -> "+$2;}
| Identificador '=' e2{$$=" ";};

Aum:AUMETO{$$=" ";}
|DECREMENTO{$$=" ";};

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

