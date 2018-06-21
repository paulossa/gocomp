package flex;
import java_cup.runtime.*;
import cup.sym;
/*

    OBSERVAÇÕES:

    Especificação do GO: https://golang.org/ref/spec#unicode_letter
    Exemplo para a linguagem JAVA: https://github.com/moy/JFlex/blob/master/jflex/examples/java/java.flex
    Documentação JFLEX: http://jflex.de/manual.html#ExampleLexRules
    Tutorialzinho legal: https://www.skenz.it/compilers/classroom/practice1_6.pdf
    Projeto de uma galera das antigas com JFLEX/Cup para C: https://github.com/brunomb/CCompiler

    Caracter "_" é considerado uma letra em GO.
    a-f dá matche em todos os caracteres de a até f
    [xX] dá matche em x ou X
    [^] dá matche em TODOS os caracteres
    [.] dá matche em todos os caracteres menos fim de linhas UNICODE

    Unicode letters = [:letter:]
    Unidode digits = [:digit:]

*/

%%

%class Lexer
%standalone
%cup
%cupdebug
%debug

%unicode

%line
%column

identifier =  [:jletter:] [:jletterdigit:]*
line_terminator = \r|\n|\r\n|\u000A
white_space = {line_terminator} | [ \t\f]
comment = ("/*"[^*]"*/") | ("//"[^*]new_line)
letter = [:letter:] | _
decimal_digit = [0-9]
octal_digit   = [0-7]
hex_digit     = [0-9a-fA-F]
decimal_literal = [1-9]{decimal_digit}*
octal_literal = 0{octal_digit}*
hex_literal = 0[xX]{hex_digit}*
decimals = {decimal_digit}{decimal_digit}*
exponent = [eE][+-]?{decimals}
float_literal = ({decimals}"."{decimals}?{exponent}?) | ({decimals}{exponent}) | ("."{decimals}{exponent}?)
string_literal = "`"([^\\\`]|\\.)*"`" | \"([^\\\"]|\\.)*\"
imaginary_literal = ({float_literal}|{decimal_literal})i

%%

<YYINITIAL> {

    /*KEYWORDS*/

    "break"                                                     { System.out.println("Found keyword: " + yytext()); }
    "default"                                                   { System.out.println("Found keyword: " + yytext()); }
    "func"                                                      { System.out.println("Found keyword: " + yytext()); }
    "interface"                                                 { System.out.println("Found keyword: " + yytext()); }
    "select"                                                    { System.out.println("Found keyword: " + yytext()); }
    "case"                                                      { System.out.println("Found keyword: " + yytext()); }
    "defer"                                                     { System.out.println("Found keyword: " + yytext()); }
    "go"                                                        { System.out.println("Found keyword: " + yytext()); }
    "map"                                                       { System.out.println("Found keyword: " + yytext()); }
    "struct"                                                    { System.out.println("Found keyword: " + yytext()); }
    "chan"                                                      { System.out.println("Found keyword: " + yytext()); }
    "else"                                                      { System.out.println("Found keyword: " + yytext()); }
    "goto"                                                      { System.out.println("Found keyword: " + yytext()); }
    "package"                                                   { System.out.println("Found keyword: " + yytext()); }
    "switch"                                                    { System.out.println("Found keyword: " + yytext()); }
    "const"                                                     { System.out.println("Found keyword: " + yytext()); }
    "fallthrough"                                               { System.out.println("Found keyword: " + yytext()); }
    "if"                                                        { System.out.println("Found keyword: " + yytext()); }
    "range"                                                     { System.out.println("Found keyword: " + yytext()); }
    "type"                                                      { System.out.println("Found keyword: " + yytext()); }
    "continue"                                                  { System.out.println("Found keyword: " + yytext()); }
    "for"                                                       { System.out.println("Found keyword: " + yytext()); }
    "import"                                                    { System.out.println("Found keyword: " + yytext()); }
    "return"                                                    { System.out.println("Found keyword: " + yytext()); }
    "var"                                                       { System.out.println("Found keyword: " + yytext()); }
    
    /*OPERATORS AND PUNCTUATION*/


    "+"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "&"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "+= "                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "&="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "&&"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "=="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "!="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "("                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ")"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "-"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "|"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "-="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "|="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "||"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "<"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "<="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "["                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "]"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "*"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "^"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "*="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "^="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "<-"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    ">"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ">="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "{"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "}"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "/"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "<<"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "/="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "<<="                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "++"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "="                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ":="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    ","                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ";"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "%"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ">>"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "%="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    ">>="                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "--"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "!"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "..."                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "."                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ":"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "&^ "                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "&^="                                                       { System.out.println("Found operator/punctuation: " + yytext()); }

    /*TOKENS*/

    "/*"[^*/]*"*/"{line_terminator}?                            { System.out.println("Found traditional comment: " + yytext()); yyline++; yybegin(0);}
    "//"[^\n]*{line_terminator}?                                { System.out.println("Found inline comment:" + yytext().substring(2));}
    {decimal_literal}                                           { System.out.println("Found decimal literal:" + yytext());}
    {float_literal}                                             { System.out.println("Found float literal:" + yytext());}
    {hex_literal}                                               { System.out.println("Found hex literal:" + yytext());}
    {white_space}                                               { /* Ignore */}
    {identifier}                                                { System.out.println("Found identifier: " + yytext()); }
    {string_literal}                                            { System.out.println("Found string literal: " + yytext()); }
    {imaginary_literal}                                         { System.out.println("Found imaginary literal: " + yytext()); }
    {octal_literal}                                             { System.out.println("Found octal literal: " + yytext()); }
}
