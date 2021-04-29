
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

S1: Imprimir{$$=$1;}
|Func{$$=$1;}
|Metodo{$$=$1;}
|Var{$$=$1;}
|Avar{$$=$1;}
|ejecuciones{$$=$1;}
;


ejecuciones : exec Identificador '(' ')' ';' {$$=$1+"$"+$2+"$"+$5;}
|  exec Identificador '(' Lista_E ')' ';' {$$=$1+"$"+$2+"$"+$4+"$"+$6;};



Var: Tipo Lista_Id Var1{$$=$1+"$"+$2+"$"+$3;}{$$ = " <td>"+"DECLARACION VARIABLE"+"</td><td>"+$1+"</td><td>"+$2+"</td>";};

Tipo: int{$$=$1;}
|double{$$=$1;}
|boolean{$$=$1;}
|char{$$=$1;}
|String{$$=$1;};

Lista_Id: Lista_Id ',' Identificador{}
|Identificador{};

Var1:'=' e ';'{}
|';'{};

Avar: Identificador '(' ')' ';'{$$ = " <td>"+"LLAMADA METODO"+"</td><td>"+"metodo"+"</td><td>"+$1+"</td>";}
|Identificador '=' e ';'{$$ = " <td>"+"ASIGNACION VARIABLE"+"</td><td>"+"ASIGNACION"+"</td><td>"+$1+"</td>";};

Func: Tipo Identificador '(' Lista_Parametro ')' '{' Sent123 {}
|Tipo Identificador '(' ')' '{' Sent123 {};

Sent123: Sent1 return e ';' '}'{}
|return e ';' '}'{}
| Sent1 '}'{}
|'}'{};

Lista_Parametro: Var2 {};

Var2: Var2 ',' Tipo Identificador {}
|Tipo Identificador {};


Metodo: void Identificador '(' Lista_Parametro ')' '{' Sent113 {}
|void main '(' ')' '{' Sent113  {}
|void Identificador '(' ')' '{' Sent113 {};

Sent113: Sent1 return ';' '}' {}
| return ';' '}'{}
|Sent1 '}'{}
|'}'{};

LFunc: Identificador '(' Lista_E ')' ';'{};

Lista_E: Lista_E ',' e {}
|e{};


Imprimir: print '(' e ')' ';'{};


    
IF: if '(' e ')' '{' Sent11  {}
|if '(' e ')' '{' Sent11  else '{' Sent11 {}
|if '(' e ')' '{' Sent11  ELS {}
|if '(' e ')' '{' Sent11  ELS else '{' Sent11 {};

ELS: ELS else if '(' e ')' '{' Sent11  {}
|else if '(' e ')' '{' Sent11 {};

Sent11: Sent1 '}' {} 
|Sent1 Senten ';' '}' {}
|Senten ';' '}' {}
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

Swit: switch '(' e ')' '{' Cas Def '}' {};

Cas: Cas case e ':' Sent1 {}
|Cas case e ':' {}
|Cas case e ':' Sent1 break ';'{}
|Cas case e ':' break ';'{}
|case e ':' {}
|case e ':' Sent1 {}
|case e ':' break ';'{}
|case e ':' Sent1 break ';'{};


Def: default ':' Sent1 break ';'{}
|default ':' break ';'{}
|default ':' Sent1 {}
|default ':' {};

Whil: while '(' e ')' '{' Sent111 {};

Sent111: Sent1 Senten ';' '}'{}
|Sent1 '}'{}
|Senten ';' '}'{}
|'}'{};

Do: do '{' Sent11  while '(' e ')' ';'{};

Fo: for '(' Fo1 ';' e ';'  Aum ')' '{' Sent112  {};

Sent112: Sent1 Senten ';' '}'{}
|Senten ';' '}'{}
|Sent1 '}'{}
|'}'{};

Fo1: Tipo Identificador '=' e{}
| Identificador '=' e{};

Aum:AUMETO{}
|DECREMENTO{};


        
    DecVec: Tipo '[' ']' Identificador '=' new Tipo '[' e ']' ';' {}
     | Tipo '[' ']' Identificador '=' '{' Lista_E '}' ';' {};
     
    ModifVec: Identificador '[' ENTERO ']' '=' e  ';'{} ; 
    
    Listas: list '<' Tipo '>' Identificador '=' new list  '<' Tipo '>' ';' {}
         | list '<' Tipo '>' Identificador '=' tochararray '(' e ')' ';' {};

    Modilist : Identificador '[' '[' ENTERO ']' ']' = e ';' {} ; 

    Addlist : Identificador '.' add '(' e ')' ';' {} ; 

    Sent1: Sent1 IF{}
    |Sent1 Swit{}
    |Sent1 Whil{}
    |Sent1 Do{}
    |Sent1 Var{$$=$1+"$"+$2;}
    |Sent1 Imprimir{}
    |Sent1 LFunc{$$=$1+"$"+$2;}
    |Sent1 Avar{$$=$1+"$"+$2;}
    |Sent1 Fo{}
    |Sent1 DecVec{$$=$1;}
    |Sent1 ModifVec{}
    |Sent1 Listas {$$=$1;}
    |Sent1 Modilist{}
    |Sent1 ejecuciones{$$=$1;}
    |Sent1 Addlist{$$=$1;}
    |IF{}
    |Swit{}
    |Whil{}
    |Do{}
    |Var{$$=$1;}
    |Imprimir{$$=$1;}
    |LFunc{$$=$1;}
    |Avar{$$=$1;}
    |DecVec{$$=$1;}
    |ModifVec{}
    |Listas{$$=$1;}
    |Modilist{}
    |Addlist{$$=$1;}
    |ejecuciones{$$=$1;}
    |Fo{};



 
 