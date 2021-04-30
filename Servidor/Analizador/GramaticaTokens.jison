
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

S1: Imprimir{$$=$1;}
|Func{$$=$1;}
|Metodo{$$=$1;}
|LFunc{$$=$1;}
|Var{$$=$1;}
|Avar{$$=$1;}
|DecVec{$$=$1;}
|ModifVec{$$=$1;}
|Listas{$$=$1;}
|Modilist{$$=$1;}
|Addlist{$$=$1;}
|ejecuciones{$$=$1;}
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

Var1:'=' e ';'{$$=$3;}
|';'{$$=$1;};

Avar: Identificador '(' ')' ';'{}
|Identificador '=' e ';'{};

Func: Tipo Identificador '(' Lista_Parametro ')' '{' Sent123 {$$=$1+"$"+$2+"$"+$3+"$"+$4+"$"+$5+"$"+$6+"$"+$7;}
|Tipo Identificador '(' ')' '{' Sent123 {$$=$1+"$"+$2+"$"+$3+"$"+$4+"$"+$5+"$"+$6;};

Sent123: Sent1 return e ';' '}'{$$=$1+"$"+$5;}
|return e ';' '}'{$$=$4;}
| Sent1 '}'{$$=$1+"$"+$2;}
|'}'{$$=$1;};

Lista_Parametro: Var2 {$$=$1;};

Var2: Var2 ',' Tipo Identificador{$$=$1+"$"+ $2+"$"+ $3+"$"+ $4;}
|Tipo Identificador{$$=$1+"$"+ $2;};


Metodo: void Identificador '(' Lista_Parametro ')' '{' Sent113 {$$=$1+"$"+$2+"$"+$3+"$"+$4+"$"+$5+"$"+$6+"$"+$7;}
|void main '(' ')' '{' Sent113  {$$=$1+"$"+$2+"$"+$3+"$"+$4+"$"+$5+"$"+$6;}
|void Identificador '(' ')' '{' Sent113 {$$=$1+"$"+$2+"$"+$3+"$"+$4+"$"+$5+"$"+$6;};

Sent113: Sent1 return ';' '}'{$$=$1+"$"+$4;}
| return ';' '}'{$$=$3;}
|Sent1 '}' {$$=$1+"$"+$2;}
|'}'{$$=$1;};

LFunc: Identificador '(' Lista_E ')' ';'{$$=$1+"$"+$2+"$"+$3+"$"+$4;};

Lista_E: Lista_E ',' e{$$=$1+"$"+$2+"$"+$3;}
|e{$$=$1;};


Imprimir: print '(' e ')' ';'{};


    
IF: if '(' e ')' '{' Sent11  {$$=$6;}
|if '(' e ')' '{' Sent11  else '{' Sent11 {$$=$6+"$"+$9;}
|if '(' e ')' '{' Sent11  ELS{$$=$6+"$"+$7;}
|if '(' e ')' '{' Sent11  ELS else '{' Sent11 {$$=$6+"$"+$7+"$"+$10;};

ELS: ELS else if '(' e ')' '{' Sent11  {$$=$1+"$"+$8;}
|else if '(' e ')' '{' Sent11 {$$=$7;};

Sent11: Sent1 '}' {$$=$1;}  
|Sent1 Senten ';' '}' {$$=$1;}
|Senten ';' '}' {}
|'}'{};


Senten: break {}
|return {}
|return e {}
|continue {};
  
    e: e '&&' e
    {$$=$1+"$"+$2+"$"+$3;}
    | e '||' e
        {$$=$1+"$"+$2+"$"+$3;}
    |'!' e
        {$$=$1+"$"+$2;}
    | '-' e %prec UMINUS
        {$$=$1+"$"+$2;}
    | '*''-' e %prec UMINUS
        {}
    | '(' e ')'
        {}
    
    | e '==' e
        {}
    | e '!=' e
    {}
    | e '<=' e
    {}
    | e '>=' e
        {}
    | e '<' e
    {}
    | e '>' e
        {}
    | e '^' e
    {}
    | e '/' e
        {}
    | e '*' e
    {}
    | e '%' e
        {}
    | e '+' e
        {}
    | e '-' e
        {}
    |CADENA
    {}
    |Identificador '[' e ']' 
        {}
    |CARACTER
        {}
    | ENTERO
        {}
    | DECIMAL
        {}
    |true
        {}
    |false
        {}
    |LFunc
        {}
    |Tipo
        {} 
    |tolower '(' e ')'
        {}
    |toupper '(' e ')'
        {}
    |lenght '(' e ')'
        {}
    |truncate '(' e ')'
        {}
    |round '(' e ')'
        {}
    |typeof '(' e ')'
        {}
    |tostring '(' e ')'
        {}
    |tochararray '(' e ')'
        {}
    |Identificador
        {};

Swit: switch '(' e ')' '{' Cas Def '}' {$$=$6+"$"+$7;};

Cas: Cas case e ':' Sent1 {$$=$1+"$"+$5;}
|Cas case e ':' {$$=$1;}
|Cas case e ':' Sent1 break ';'{$$=$1+"$"+$5;}
|Cas case e ':' break ';'{$$=$1;}
|case e ':' {}
|case e ':' Sent1 {$$=$4;}
|case e ':' break ';'{}
|case e ':' Sent1 break ';'{$$=$4;};


Def: default ':' Sent1 break ';'{$$=$3;}
|default ':' break ';'{}
|default ':' Sent1 {$$=$3;}
|default ':' {};

Whil: while '(' e ')' '{' Sent111 {$$=$6;};

Sent111: Sent1 Senten ';' '}'{$$=$1;}
|Sent1 '}'{$$=$1;}
|Senten ';' '}'{}
|'}'{};

Do: do '{' Sent11  while '(' e ')' ';'{$$=$3;};

Fo: for '(' Fo1 ';' e ';'  Aum ')' '{' Sent112  {$$=$10;};

Sent112: Sent1 Senten ';' '}'{$$=$1;}
|Senten ';' '}'{}
|Sent1 '}'{$$=$1;}
|'}'{};

Fo1: Tipo Identificador '=' e{}
| Identificador '=' e{};

Aum:AUMETO{}
|DECREMENTO{};


        
    DecVec: Tipo '[' ']' Identificador '=' new Tipo '[' e ']' ';' {$$=$1+"$"+$4+"$"+$9;}
     | Tipo '[' ']' Identificador '=' '{' Lista_E '}' ';' {$$=$1+"$"+$4+"$"+$7;};
     
    ModifVec: Identificador '[' ENTERO ']' '=' e  ';'{$$=$1+"$"+$3+"$"+$6;} ; 
    
    Listas: list '<' Tipo '>' Identificador '=' new list  '<' Tipo '>' ';' {$$=$1+"$"+$3+"$"+$5;}
         | list '<' Tipo '>' Identificador '=' tochararray '(' e ')' ';' {$$=$1+"$"+$3+"$"+$5;};

    Modilist : Identificador '[' '[' ENTERO ']' ']' = e ';' {$$=$1+"$"+$4+"$"+$8;} ; 

    Addlist : Identificador '.' add '(' e ')' ';' {$$=$1+"$"+$3;} ; 

    Sent1: Sent1 IF{$$=$1+"$"+$2;}
    |Sent1 Swit{$$=$1+"$"+$2;}
    |Sent1 Whil{$$=$1+"$"+$2;}
    |Sent1 Do{$$=$1+"$"+$2;}
    |Sent1 Var{$$=$1+"$"+$2;}
    |Sent1 Imprimir{$$=$1+"$"+$2;}
    |Sent1 LFunc{$$=$1+"$"+$2;}
    |Sent1 Avar{$$=$1+"$"+$2;}
    |Sent1 Fo{$$=$1+"$"+$2;}
    |Sent1 DecVec{$$=$1+"$"+$2;}
    |Sent1 ModifVec{$$=$1+"$"+$2;}
    |Sent1 Listas {$$=$1+"$"+$2;}
    |Sent1 Modilist{$$=$1+"$"+$2;}
    |Sent1 ejecuciones{$$=$1+"$"+$2;}
    |Sent1 Addlist{$$=$1+"$"+$2;}
    |IF{$$=$1;}
    |Swit{$$=$1;}
    |Whil{$$=$1;}
    |Do{$$=$1;}
    |Var{$$=$1;}
    |Imprimir{$$=$1;}
    |LFunc{$$=$1;}
    |Avar{$$=$1;}
    |DecVec{$$=$1;}
    |ModifVec{$$=$1;}
    |Listas{$$=$1;}
    |Modilist{$$=$1;}
    |Addlist{$$=$1;}
    |ejecuciones{$$=$1;}
    |Fo{$$=$1;};



 
 