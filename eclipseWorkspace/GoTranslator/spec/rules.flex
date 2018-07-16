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

	/* TYPES */
	"rune"														{ return symbol(sym.RUNE);                                         	}
	"byte"														{ return symbol(sym.BYTE);                                         	}
	"short"														{ return symbol(sym.SHORT);                                         	}
	"long"														{ return symbol(sym.LONG);                                         	}
	"char"														{ return symbol(sym.CHAR);                                         	}
	"complex64"													{ return symbol(sym.COMPLEX64);                                         	}
	"complex128"												{ return symbol(sym.COMPLEX128);                                         	}
	"bool"														{ return symbol(sym.BOOL);                                         	}
	"int"														{  return symbol(sym.INT);                                         	}
	"int8"														{ return symbol(sym.INT8);                                        	}
	"int16"														{ return symbol(sym.INT16);                                       	}
	"int32"														{ return symbol(sym.INT32);                                       	}
	"int64"														{ return symbol(sym.INT64);                                       	}
	"uint"														{ return symbol(sym.UINT);                                        	}
	"uintptr"													{ return symbol(sym.UINTPTR);                                       }
	"uint8"														{ return symbol(sym.UINT8);                                        	}
	"uint16"													{ return symbol(sym.UINT16);                                        }
	"uint32"													{ return symbol(sym.UINT32);                                        }
	"uint64"													{ return symbol(sym.UINT64);                                        }
	"float32"													{ return symbol(sym.FLOAT32);                                       }
	"float64"													{ return symbol(sym.FLOAT64);                                       }


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
    "if"                                                        { System.out.println(yytext()); return symbol(sym.IF);                                            }
    "range"                                                     { return symbol(sym.RANGE);                                         }
    "type"                                                      { System.out.println(yytext()); return symbol(sym.TYPE);                                          }
    "continue"                                                  { return symbol(sym.CONTINUE);                                      }
    "for"                                                       { return symbol(sym.FOR);                                           }
    "import"                                                    { return symbol(sym.IMPORT);                                        }
    "return"                                                    { return symbol(sym.RETURN);                                        }
    "var"                                                       { return symbol(sym.VAR);                                           }

    /*OPERATORS AND PUNCTUATION*/


    "+"                                                         { return symbol(sym.PLUS);       }
    "&"                                                         { return symbol(sym.AND);        }
    "+= "                                                       { return symbol(sym.PLUSEQ);     }
    "&="                                                        { return symbol(sym.ANDEQ);     }
    "&&"                                                        { return symbol(sym.ANDAND);      }
    "=="                                                        { return symbol(sym.EQEQ);       }
    "!="                                                        { return symbol(sym.NOTEQ);      }
    "("                                                         { return symbol(sym.LPAREN);     }
    ")"                                                         { return symbol(sym.RPAREN);     }
    "-"                                                         { return symbol(sym.MINUS);      }
    "|"                                                         { return symbol(sym.PIPE);       }
    "-="                                                        { return symbol(sym.MINUSEQ);    }
    "|="                                                        { return symbol(sym.PIPEEQ);     }
    "||"                                                        { return symbol(sym.PIPEPIPE);   }
    "<"                                                         { return symbol(sym.LT);         }
    "<="                                                        { return symbol(sym.LTEQ);       }
    "["                                                         { return symbol(sym.LBRACK);     }
    "]"                                                         { return symbol(sym.RBRACK);     }
    "*"                                                         { return symbol(sym.MULT);       }
    "^"                                                         { return symbol(sym.CIRCU);      }
    "*="                                                        { return symbol(sym.MULTEQ);     }
    "^="                                                        { return symbol(sym.CIRCUEQ);    }
    "<-"                                                        { return symbol(sym.ARRLEFT);    }
    ">"                                                         { return symbol(sym.GT);         }
    ">="                                                        { return symbol(sym.GTEQ);       }
    "{"                                                         { return symbol(sym.LBRACE);     }
    "}"                                                         { return symbol(sym.RBRACE);     }
    "/"                                                         { return symbol(sym.DIV);        }
    "<<"                                                        { return symbol(sym.LSHIFT);     }
    "/="                                                        { return symbol(sym.DIVEQ);      }
    "<<="                                                       { return symbol(sym.LSHIFTEQ);   }
    "++"                                                        { return symbol(sym.PLUSPLUS);   }
    "="                                                         { return symbol(sym.EQ);         }
    ":="                                                        { return symbol(sym.DIVEQ);      }
    ","                                                         { return symbol(sym.COMMA);   }
    ";"                                                         { return symbol(sym.SEMICOLON);  }
    "%"                                                         { return symbol(sym.MOD);        }
    ">>"                                                        { return symbol(sym.RSHIFT);     }
    "%="                                                        { return symbol(sym.MODEQ);      }
    ">>="                                                       { return symbol(sym.RSHIFTEQ);   }
    "--"                                                        { return symbol(sym.MINUSMINUS); }
    "!"                                                         { return symbol(sym.NOT);        }
    "..."                                                       { return symbol(sym.ELLIPSIS);   }
    "."                                                         { return symbol(sym.DOT);        }
    ":"                                                         { return symbol(sym.COLON);      }
    "&^ "                                                       { return symbol(sym.ANDNOT);     }
    "&^="                                                       { return symbol(sym.ANDNOTEQ);   }

    /*TOKENS*/

    "/*"[^*/]*"*/"{line_terminator}?                            {  yyline++; yybegin(0);}
    {comment}                                                   { /* ignore */ }
    "//"[^\n]*{line_terminator}?                                { /* ignore */ }
    {decimal_literal}                                           { return symbol(sym.INTEGER_LITERAL, new Integer(yytext())); }
    {float_literal}                                             { return symbol(sym.FLOATING_POINT_LITERAL, new Float(yytext())); }
    {hex_literal}                                               { return symbol(sym.HEX_LITERAL, yytext());}
    {white_space}                                               { /* Ignore */}
    {identifier}		                                        {  return symbol(sym.IDENTIFIER, yytext()); }
    {identifier}"."{identifier}									{ return symbol(sym.QUALIFIED_IDENTIFIER, yytext()); }
    {string_literal}                                            { return symbol(sym.STRING_LITERAL, yytext()); }
    {imaginary_literal}                                         { return symbol(sym.IMAGINARY_LITERAL, yytext()); }
    {octal_literal}                                             { return symbol(sym.OCTAL_LITERAL, yytext()); }
}

[^]|\n                             { throw new RuntimeException("Erro léxico caractere ilegal:" + yytext() +
                                                              " na linha " + yyline + ", " + " coluna " + yycolumn); }
<<EOF>>                          { return symbol(sym.EOF); }
