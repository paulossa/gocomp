package go.core;

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

%class Lexical
%public
%standalone
%cup
%unicode
%line
%column

letters = [a-zA-Z_]
digits =  [a-zA-Z_0-9]
identifier = {letters}{digits}*
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

    public static String curLine;

    private Symbol symbol(int type) {
        curLine = "line: " + yyline;
        return new Symbol(type, yyline, yycolumn);
    }

    /* Também cria um new java_cup.runtime.Symbol Com informação
       sobre o token atual, mas esse objeto tem um valor. */
    private Symbol symbol(int type, Object value) {
        curLine = "line: " + yyline;
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

%%

<YYINITIAL> {

	/* TYPES */
    
    /*KEYWORDS*/

    "break"                                                     { return symbol(sym.BREAK);                                         }
    "default"                                                   { return symbol(sym.DEFAULT);                                       }
    "func"                                                      { return symbol(sym.FUNC);       									}
    "interface"                                                 { return symbol(sym.INTERFACE);                                     }
    "select"                                                    { return symbol(sym.SELECT);                                        }
    "case"                                                      { return symbol(sym.CASE);                                          }
    "defer"                                                     { return symbol(sym.DEFER);                                         }
    "go"                                                        { return symbol(sym.GO);                                            }
    "map"                                                       { return symbol(sym.MAP);                                           }
    "struct"                                                    { return symbol(sym.STRUCT);                                        }
    "chan"                                                      { return symbol(sym.CHAN);                                          }
    "else"                                                      { return symbol(sym.ELSE);                                          }
    "goto"                                                      { return symbol(sym.GOTO);                                          }
    "package"                                                   { return symbol(sym.PACKAGE);    									}
    "switch"                                                    { return symbol(sym.SWITCH);                                        }
    "const"                                                     { return symbol(sym.CONST);                                         }
    "fallthrough"                                               { return symbol(sym.FALLTHROUGH);                                   }
    "if"                                                        { return symbol(sym.IF);                                            }
    "range"                                                     { return symbol(sym.RANGE);                                         }
    "type"                                                      { return symbol(sym.TYPE);                                          }
    "continue"                                                  { return symbol(sym.CONTINUE);                                      }
    "for"                                                       { return symbol(sym.FOR);                                           }
    "import"                                                    { return symbol(sym.IMPORT);                                        }
    "return"                                                    { return symbol(sym.RETURN);                                        }
    "var"                                                       {  return symbol(sym.VAR);                                           }

    /*OPERATORS AND PUNCTUATION*/


    "+"                                                         { return symbol(sym.PLUS, yytext());      }
    "&"                                                         { return symbol(sym.AND, yytext());      }
    "+= "                                                       { return symbol(sym.PLUSEQ, yytext());      }
    "&="                                                        { return symbol(sym.ANDEQ, yytext());      }
    "&&"                                                        { return symbol(sym.ANDAND, yytext());      }
    "=="                                                        { return symbol(sym.EQEQ, yytext());      }
    "!="                                                        { return symbol(sym.NOTEQ, yytext());      }
    "("                                                         { return symbol(sym.LPAREN, yytext());      }
    ")"                                                         { return symbol(sym.RPAREN, yytext());      }
    "-"                                                         { return symbol(sym.MINUS, yytext());      }
    "|"                                                         { return symbol(sym.PIPE, yytext());      }
    "-="                                                        { return symbol(sym.MINUSEQ, yytext());      }
    "|="                                                        { return symbol(sym.PIPEEQ, yytext());      }
    "||"                                                        { return symbol(sym.PIPEPIPE, yytext());      }
    "<"                                                         { return symbol(sym.LT, yytext());      }
    "<="                                                        { return symbol(sym.LTEQ, yytext());      }
    "["                                                         { return symbol(sym.LBRACK, yytext());      }
    "]"                                                         { return symbol(sym.RBRACK, yytext());      }
    "*"                                                         { return symbol(sym.MULT, yytext());      }
    "^"                                                         { return symbol(sym.CIRCU, yytext());      }
    "*="                                                        { return symbol(sym.MULTEQ, yytext());      }
    "^="                                                        { return symbol(sym.CIRCUEQ, yytext());      }
    "<-"                                                        { return symbol(sym.ARRLEFT, yytext());      }
    ">"                                                         { return symbol(sym.GT, yytext());      }
    ">="                                                        { return symbol(sym.GTEQ, yytext());      }
    "{"                                                         { return symbol(sym.LBRACE, yytext());      }
    "}"                                                         { return symbol(sym.RBRACE, yytext());      }
    "/"                                                         { return symbol(sym.DIV, yytext());      }
    "<<"                                                        { return symbol(sym.LSHIFT, yytext());      }
    "/="                                                        { return symbol(sym.DIVEQ, yytext());      }
    "<<="                                                       { return symbol(sym.LSHIFTEQ, yytext());      }
    "++"                                                        { return symbol(sym.PLUSPLUS, yytext());      }
    "="                                                         { return symbol(sym.EQ, yytext());      }
    ":="                                                        { return symbol(sym.COLONEQ, yytext());      }
    ","                                                         { return symbol(sym.COMMA, yytext());      }
    ";"                                                         { return symbol(sym.SEMICOLON, yytext());      }
    "%"                                                         { return symbol(sym.MOD, yytext());      }
    ">>"                                                        { return symbol(sym.RSHIFT, yytext());      }
    "%="                                                        { return symbol(sym.MODEQ, yytext());      }
    ">>="                                                       { return symbol(sym.RSHIFTEQ, yytext());      }
    "--"                                                        { return symbol(sym.MINUSMINUS, yytext());      }
    "!"                                                         { return symbol(sym.NOT, yytext());      }
    "..."                                                       { return symbol(sym.ELLIPSIS, yytext());      }
    "."                                                         { return symbol(sym.DOT, yytext());      }
    ":"                                                         { return symbol(sym.COLON, yytext());      }
    "&^ "                                                       { return symbol(sym.ANDNOT, yytext());      }
    "&^="                                                       { return symbol(sym.ANDNOTEQ, yytext());      }

    /*TOKENS*/

    "/*"[^*/]*"*/"{line_terminator}?                            { /* ignore */ }
    {comment}                                                   { /* ignore */ }
    "//"[^\n]*{line_terminator}?                                { /* ignore */ }
    {decimal_literal}                                           { return symbol(sym.INTEGER_LITERAL, new Integer(yytext())); }
    {float_literal}                                             { return symbol(sym.FLOATING_POINT_LITERAL, new Float(yytext())); }
    {hex_literal}                                               { return symbol(sym.HEX_LITERAL, yytext());}
    {white_space}                                               { /* Ignore */} 
    {identifier}		                                        { return symbol(sym.IDENTIFIER, yytext()); }
    {identifier}"."{identifier}									{ return symbol(sym.QUALIFIED_IDENTIFIER, yytext()); }
    {string_literal}                                            { return symbol(sym.STRING_LITERAL, yytext()); }
    {imaginary_literal}                                         { return symbol(sym.IMAGINARY_LITERAL, yytext()); }
    {octal_literal}                                             { return symbol(sym.OCTAL_LITERAL, yytext()); }
}

[^]|\n                             { throw new RuntimeException("Erro léxico caractere ilegal:" + yytext() +
                                                              " na linha " + yyline + ", " + " coluna " + yycolumn); }
<<EOF>>                          { return symbol(sym.EOF); }
