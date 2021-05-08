
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

S1: Imprimir{$$=$1+"\n";}
|Func{$$=$1+"\n";}
|Metodo{$$=$1+"\n";}
|LFunc{$$=$1+"\n";}
|Var{$$=$1+"\n";}
|Avar{$$=$1+"\n";}
|DecVec{$$=$1+"\n";}
|ModifVec{$$=$1+"\n";}
|Listas{$$=$1+"\n";}
|Modilist{$$=$1+"\n";}
|Addlist{$$=$1+"\n";}
|ejecuciones{$$=$1+"\n";}
;


ejecuciones : exec Identificador '(' ')' ';' {$$=$1+"$"+$2+"$"+$5;}
|  exec Identificador '(' Lista_E ')' ';' {$$=$1+"$"+$2+"$"+$4+"$"+$6;};



Var: Tipo Lista_Id Var1{$$=$1+"$"+$2+"$"+$3+"\n";};

Tipo: int{$$=$1;}
|double{$$=$1;}
|boolean{$$=$1;}
|char{$$=$1;}
|String{$$=$1;};

Lista_Id: Lista_Id ',' Identificador{$$=$1+"$"+$2+"$"+$3;}
|Identificador{$$=$1;};


Var1:'=' e ';'{$$= $2;}
|';'{};

Avar: Identificador '(' ')' ';'{}
|Identificador '=' e ';'{$$=$1+" = "+ $3+"\n"};

Func: Tipo Identificador '(' Lista_Parametro ')' '{' Sent123 {$$= $7+"\n";}
|Tipo Identificador '(' ')' '{' Sent123 {$$=$6;};

Sent123: Sent1 return e ';' '}'{$$=$1+"\n";}
|return e ';' '}'{}
| Sent1 '}'{$$=$1+"\n";}
|'}'{};

Lista_Parametro: Var2 {$$=$1+"\n";};

Var2: Var2 ',' Tipo Identificador{}
|Tipo Identificador{};



Metodo: void Identificador '(' Lista_Parametro ')' '{' Sent113 {$$=$7+"\n";}
|void main '(' ')' '{' Sent113  {$$=$6+"\n";}
|void Identificador '(' ')' '{' Sent113 {$$=$6+"\n";};

Sent113: Sent1 return ';' '}'{$$=$1+"\n";}
| return ';' '}'{}
|Sent1'}' {$$=$1+"\n";}
|'}'{};

LFunc: Identificador '(' Lista_E ')' ';' {$$=$1+"$"+$2+"$"+$3+"$"+$4+"\n";};

Lista_E: Lista_E ',' e{}
|e{};


Imprimir: print '(' e ')' ';'{$$=$3};



    
IF: if '(' e ')' '{' Sent11  {$$=$6+"\n";}
|if '(' e ')' '{' Sent11  else '{' Sent11 {$$=$6+"\n"+$9;}
|if '(' e ')' '{' Sent11  ELS{$$=$6+$7+"\n";}
|if '(' e ')' '{' Sent11  ELS else'{' Sent11 {$$=+$6+$7+$10+"\n";};

ELS: ELS else if '(' e ')' '{' Sent11  {$$=$1+"\n"+$8;}
|else if '(' e ')' '{' Sent11 {$$=$7;};

Sent11: Sent1 '}' {$$=$1;}  
|Sent1 Senten ';' '}' {$$=$1;}
|Senten';' '}'{}
|'}'{};


Senten: break {}
|return {}
|return e {}
|continue {};
  
    e: e '&&' e
       {}
    | e '||' e
        {}
    |'!' e
        {}
    | '-' e %prec UMINUS
       {}
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
         {$$ = Math.pow($1, $3);}
    | e '/' e
       {$$ = $1 / $3;}
    | e '*' e
         {$$ = $1 * $3;}
    | e '%' e
         {$$ = $1 % $3;}
    | e '+' e
       {$$ = $1 + $3;}
    | e '-' e
              {$$ = $1 - $3;}
    |CADENA
       {$$ = $1;}
    |Identificador '[' e ']' 
       {}
    |CARACTER
        {$$ = $1;}
    | ENTERO
        {$$ = Number(yytext);}
    | DECIMAL
        {$$ = Number(yytext);}
    |true
       {}
    |false
       {}
    |LFunc
        {}
    |Tipo
         {}
    |tolower '(' e ')'
         {$$ = $3.toLowerCase();}
    |toupper '(' e ')'
         {$$ = $3.toUpperCase();}
    |lenght '(' e ')'
        {  $$ = $3.lenght;}
    |truncate '(' e ')'
        {$$ = Math.trunc($3);}
    |round '(' e ')'
         {$$ = Math.round($3);}
    |typeof '(' e ')'
         {$$ =$3;}
    |tostring '(' e ')'
         {$$ =$3;}
    |tochararray '(' e ')'
         {}
    |Identificador
        {$$=$1;};
        
    Swit: switch '(' e ')' '{' Cas Def '}' {$$=$6;};


    Cas: Cas case e ':' Sent1 {$$=$5;}
    |Cas case e ':' {}
    |Cas case e ':' Sent1 break ';'{$$=$5;}
    |Cas case e ':' break ';'{}
    |case e ':' {}
    |case e ':' Sent1 {$$=$4;}
    |case e ':' break ';'{}
    |case e ':' Sent1 break ';'{$$=$4;};



   Def: default ':' Sent1 break ';'{$$= $3;}
    |default ':' break ';'{}
    |default ':' Sent1 {$$= $3;}
    |default ':' {};


    Whil: while '(' e ')' '{' Sent111{$$= $6;};

    Sent111: Sent1 Senten ';' '}'{$$= $1;}
    |Sent1 '}'{}
    |Senten ';' '}'{$$= $1;}
    |'}'{};

    Do: do '{' Sent11  while '(' e ')' ';' {};

  
    Fo: for '(' Fo1 ';' e ';'  Aum ')' '{' Sent112  {};


    Sent112: Sent1 Senten ';' '}' {}
    |Senten ';' '}'{}
    |Sent1 '}'{}
    |'}'{}
    ;

    Fo1: Tipo Identificador '=' e{}
    | Identificador '=' e{};

    Aum:AUMETO{}
    |DECREMENTO{};


     DecVec: Tipo '[' ']' Identificador '=' new Tipo '[' e ']' ';' {}  
     | Tipo '[' ']' Identificador '=' '{' Lista_E '}' ';' {};
     
    ModifVec: Identificador '[' ENTERO ']' '=' e  ';'{}   ; 
    
    Listas: list '<' Tipo '>' Identificador '=' new list  '<' Tipo '>' ';' {}  
         | list '<' Tipo '>' Identificador '=' tochararray '(' e ')' ';' {} ; 

    Modilist : Identificador '[' '[' ENTERO ']' ']' = e ';' {} ; 

    Addlist : Identificador '.' '(' e ')' ';' {} ; 

    Sent1: Sent1 IF{$$=$1+"\n"+$2;}
    |Sent1 Swit{$$=$1+$2;}
    |Sent1 Whil{$$=$1+$2;}
    |Sent1 Do{$$=$1+$2;}
    |Sent1 Var{$$=$1+$2;}
    |Sent1 Imprimir{$$=$1+$2;}
    |Sent1 LFunc{$$=$1+$2;}
    |Sent1 Avar{$$=$1+$2;}
    |Sent1 Fo{$$=$1+$2;}
    |Sent1 DecVec{$$=$1+$2;}
    |Sent1 ModifVec{$$=$1+$2;}
    |Sent1 Listas{$$=$1+$2;}
    |Sent1 Modilist{$$=$1+$2;}
    |Sent1 Addlist{$$=$1+$2;}
    |Sent1 ejecuciones {$$=$1+$2;}
    |IF{$$=$1;}
    |Swit{$$=$1;}
    |Whil{$$=$1;}
    |Do{$$=$1;}
    |LFunc{$$=$1;}
    |Imprimir{$$=$1;}
    |Var{$$=$1;}
    |Avar{$$=$1;}
    |Fo{$$ = $1;}
    |DecVec{$$ = $1;}
    |ModifVec{$$ = $1;}
    |Listas{$$ = $1;}
    |Modilist{$$ = $1;}
    |Addlist{$$ = $1;}
    |ejecuciones{$$ = $1;}
   ;

 
 