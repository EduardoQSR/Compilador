package codigo;
import static codigo.Tokens.*;
%%
%class Lexer
%type Tokens
L=[a-zA-Z_]+
Punto = "."
D = [0-9]+
//D = [0-9]+("\\."[0-9]+)?
//D = [0-9]+ Punto? [0-9]+
espacio=[ ,\t,\r]+
%{
    public String lexeme;
%}
%%

/* Espacios en blanco */
{espacio} {/*Ignore*/}

/* Comentarios */
( "//"(.)* ) {/*Ignore*/}

/* Salto de linea */
( "\n" ) {return Linea;}

/* Comillas */
( "\"" ) {lexeme=yytext(); return Comillas;}

/* Tipos de datos */
( ent | caracter | largo | fdec | dec )
{
    lexeme=yytext(); return T_dato;
}

/* Tipo de dato String */
( String )
{
    lexeme=yytext(); return Cadena;}

"\"" [^*] ~"\"" | "\"" + "\'" //expresion regular para definir mensajes
{
    {lexeme=yytext(); return Mensaje;}
}

/* Palabra reservada Yes */
( yes ) {lexeme=yytext(); return Yes;}

/* Palabra reservada Escribe */
( "escribe" ) {lexeme=yytext(); return Escribe;}

/* Palabra reservada Otro_caso */
( otro_caso ) {lexeme=yytext(); return Otro_caso;}

/* Palabra reservada Haz */
( haz ) {lexeme=yytext(); return Haz;}

/* Palabra reservada Durante */
( durante ) {lexeme=yytext(); return Durante;}

/* Palabra reservada Bucle */
( bucle ) {lexeme=yytext(); return Bucle;}

/* Operador Igual */
( "=" ) {lexeme=yytext(); return Igual;}

/* Operador Suma */
( "+" ) {lexeme=yytext(); return Suma;}

/* Operador Resta */
( "-" ) {lexeme=yytext(); return Resta;}

/* Operador Multiplicacion */
( "*" ) {lexeme=yytext(); return Multiplicacion;}

/* Operador Division */
( "/" ) {lexeme=yytext(); return Division;}

/* Operador Coma */
( "coma" ) {lexeme=yytext(); return Coma;}

/* Operadores logicos */
( "&&" | "||" | "!" | "&" | "|" ) {lexeme=yytext(); return Op_logico;}

/*Operadores Relacionales */
( ">" | "<" | "==" | "!=" | ">=" | "<=" | "<<" | ">>" ) {lexeme = yytext(); return Op_relacional;}

/* Operadores Atribucion */
( "+=" | "-="  | "*=" | "/=" | "%=" ) {lexeme = yytext(); return Op_atribucion;}

/* Operadores Incremento y decremento */
( "++" | "--" ) {lexeme = yytext(); return Op_incremento;}

/*Operadores Booleanos*/
(true | false)      {lexeme = yytext(); return Op_booleano;}

/* Parentesis de apertura */
( "(" ) {lexeme=yytext(); return Parentesis_a;}

/* Parentesis de cierre */
( ")" ) {lexeme=yytext(); return Parentesis_c;}

/* Llave de apertura */
( "{" ) {lexeme=yytext(); return Llave_a;}

/* Llave de cierre */
( "}" ) {lexeme=yytext(); return Llave_c;}

/* Corchete de apertura */
( "[" ) {lexeme = yytext(); return Corchete_a;}

/* Corchete de cierre */
( "]" ) {lexeme = yytext(); return Corchete_c;}

/* Marcador de inicio de algoritmo */
( "ejecutar" ) {lexeme=yytext(); return Ejecutar;}

/* Punto y coma */
( ";" ) {lexeme=yytext(); return P_coma;}

/* Identificador */
{L}({L}|{D})* {lexeme=yytext(); return Identificador;}

/* Numero */
//("(-"{D}+")")|{D}+ 
(\\+|\\-)?{D}+\\.?{D}+
{lexeme=yytext(); return Numero;}

/* Error de analisis */
 . {return ERROR;}
