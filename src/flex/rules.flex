import java_cup.runtime.*;
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

%{
    /* Para criar um novo java_cup.runtime.Symbol com informação sobre
       o token atual, mas esse tipo de token não tem valor associado.
    */
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    /* Também cria um new java_cup.runtime.Symbol Com informação
       sobre o token atual, mas esse objeto tem um valor. */
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

%%

<YYINITIAL> {

    /*KEYWORDS*/

    "break"                                                     { return symbol(sym.BREAK); }
    "default"                                                   { return symbol(sym.DEFAULT); }
    "func"                                                      { System.out.println("Found keyword: " + yytext()); return symbol(sym.FUNC); }
    "interface"                                                 { return symbol(sym.INTERFACE); }
    "select"                                                    { return symbol(sym.SELECT); }
    "case"                                                      { return symbol(sym.CASE); }
    "defer"                                                     { return symbol(sym.DEFER); }
    "go"                                                        { return symbol(sym.GO); }
    "map"                                                       { return symbol(sym.MAP); }
    "struct"                                                    { return symbol(sym.STRUCT); }
    "chan"                                                      { return symbol(sym.CHAN); }
    "else"                                                      { return symbol(sym.ELSE); }
    "goto"                                                      { return symbol(sym.GOTO); }
    "package"                                                   { return symbol(sym.PACKAGE); }
    "switch"                                                    { return symbol(sym.SWITCH); }
    "const"                                                     { return symbol(sym.CONST); }
    "fallthrough"                                               { return symbol(sym.FALLTHROUGH); }
    "if"                                                        { return symbol(sym.IF); }
    "range"                                                     { return symbol(sym.RANGE); }
    "type"                                                      { return symbol(sym.TYPE); }
    "continue"                                                  { return symbol(sym.CONTINUE); }
    "for"                                                       { return symbol(sym.FOR); }
    "import"                                                    { return symbol(sym.IMPORT); }
    "return"                                                    { return symbol(sym.RETURN); }
    "var"                                                       { return symbol(sym.VAR); }

    /*OPERATORS AND PUNCTUATION*/


    "+"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "&"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "+= "                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "&="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "&&"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "=="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "!="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "("                                                         { System.out.println("Found operator/punctuation: " + yytext()); return symbol(sym.LPAREN);}
    ")"                                                         { System.out.println("Found operator/punctuation: " + yytext()); return symbol(sym.RPAREN);}
    "-"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "|"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "-="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "|="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "||"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "<"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "<="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "["                                                         { System.out.println("Found operator/punctuation: " + yytext()); return symbol(sym.LBRACK);}
    "]"                                                         { System.out.println("Found operator/punctuation: " + yytext()); return symbol(sym.RBRACK);}
    "*"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "^"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "*="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "^="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "<-"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    ">"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ">="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "{"                                                         { System.out.println("Found operator/punctuation: " + yytext()); return symbol(sym.LBRACE);}
    "}"                                                         { System.out.println("Found operator/punctuation: " + yytext()); return symbol(sym.RBRACE);}
    "/"                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    "<<"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "/="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "<<="                                                       { System.out.println("Found operator/punctuation: " + yytext()); }
    "++"                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    "="                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ":="                                                        { System.out.println("Found operator/punctuation: " + yytext()); }
    ","                                                         { System.out.println("Found operator/punctuation: " + yytext()); }
    ";"                                                         { System.out.println("Found operator/punctuation: " + yytext()); return symbol(sym.SEMICOLON); }
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
    {comment}                                                   { System.out.println("OSHE"); }
    {letter}                                                    { System.out.println("Letter been found"); }
    "//"[^\n]*{line_terminator}?                                { System.out.println("Found inline comment:" + yytext().substring(2));}
    {decimal_literal}                                           { System.out.println("Found decimal literal:" + yytext());  return symbol(sym.INTEGER_LITERAL, new Integer(yytext())); }
    {float_literal}                                             { System.out.println("Found float literal:" + yytext());}
    {hex_literal}                                               { System.out.println("Found hex literal:" + yytext());}
    {white_space}                                               { /* Ignore */}
    {identifier}                                                { System.out.println("Found identifier: " + yytext()); return symbol(sym.IDENTIFIER, yytext()); }
    {string_literal}                                            { System.out.println("Found string literal: " + yytext()); return symbol(sym.STRING_LITERAL, yytext()); }
    {imaginary_literal}                                         { System.out.println("Found imaginary literal: " + yytext()); }
    {octal_literal}                                             { System.out.println("Found octal literal: " + yytext()); }
}

[^]|\n                             { throw new RuntimeException("Erro léxico caractere ilegal: \""+yytext()+
                                                              "\" na linha "+yyline+", coluna "+yycolumn); }
<<EOF>>                          { return symbol(sym.EOF); }
