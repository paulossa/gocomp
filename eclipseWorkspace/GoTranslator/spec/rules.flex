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
	"int"														{ System.out.println("found int"); return symbol(sym.INT);                                         	}
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
    "if"                                                        { return symbol(sym.IF);                                            }
    "range"                                                     { return symbol(sym.RANGE);                                         }
    "type"                                                      { return symbol(sym.TYPE);                                          }
    "continue"                                                  { return symbol(sym.CONTINUE);                                      }
    "for"                                                       { return symbol(sym.FOR);                                           }
    "import"                                                    { return symbol(sym.IMPORT);                                        }
    "return"                                                    { return symbol(sym.RETURN);                                        }
    "var"                                                       { System.out.println(yytext()); return symbol(sym.VAR);                                           }

    /*OPERATORS AND PUNCTUATION*/


    "+"                                                         { System.out.println(yytext()); return symbol(sym.PLUS);       }
    "&"                                                         { System.out.println(yytext()); return symbol(sym.AND);        }
    "+= "                                                       { System.out.println(yytext()); return symbol(sym.PLUSEQ);     }
    "&="                                                        { System.out.println(yytext()); return symbol(sym.ANDEQ);     }
    "&&"                                                        { System.out.println(yytext()); return symbol(sym.ANDAND);      }
    "=="                                                        { System.out.println(yytext()); return symbol(sym.EQEQ);       }
    "!="                                                        { System.out.println(yytext()); return symbol(sym.NOTEQ);      }
    "("                                                         { System.out.println(yytext()); return symbol(sym.LPAREN);     }
    ")"                                                         { System.out.println(yytext()); return symbol(sym.RPAREN);     }
    "-"                                                         { System.out.println(yytext()); return symbol(sym.MINUS);      }
    "|"                                                         { System.out.println(yytext()); return symbol(sym.PIPE);       }
    "-="                                                        { System.out.println(yytext()); return symbol(sym.MINUSEQ);    }
    "|="                                                        { System.out.println(yytext()); return symbol(sym.PIPEEQ);     }
    "||"                                                        { System.out.println(yytext()); return symbol(sym.PIPEPIPE);   }
    "<"                                                         { System.out.println(yytext()); return symbol(sym.LT);         }
    "<="                                                        { System.out.println(yytext()); return symbol(sym.LTEQ);       }
    "["                                                         { System.out.println(yytext()); return symbol(sym.LBRACK);     }
    "]"                                                         { System.out.println(yytext()); return symbol(sym.RBRACK);     }
    "*"                                                         { System.out.println(yytext()); return symbol(sym.MULT);       }
    "^"                                                         { System.out.println(yytext()); return symbol(sym.CIRCU);      }
    "*="                                                        { System.out.println(yytext()); return symbol(sym.MULTEQ);     }
    "^="                                                        { System.out.println(yytext()); return symbol(sym.CIRCUEQ);    }
    "<-"                                                        { System.out.println(yytext()); return symbol(sym.ARRLEFT);    }
    ">"                                                         { System.out.println(yytext()); return symbol(sym.GT);         }
    ">="                                                        { System.out.println(yytext()); return symbol(sym.GTEQ);       }
    "{"                                                         { System.out.println(yytext()); return symbol(sym.LBRACE);     }
    "}"                                                         { System.out.println(yytext()); return symbol(sym.RBRACE);     }
    "/"                                                         { System.out.println(yytext()); return symbol(sym.DIV);        }
    "<<"                                                        { System.out.println(yytext()); return symbol(sym.LSHIFT);     }
    "/="                                                        { System.out.println(yytext()); return symbol(sym.DIVEQ);      }
    "<<="                                                       { System.out.println(yytext()); return symbol(sym.LSHIFTEQ);   }
    "++"                                                        { System.out.println(yytext()); return symbol(sym.PLUSPLUS);   }
    "="                                                         { System.out.println(yytext()); return symbol(sym.EQ);         }
    ":="                                                        { System.out.println(yytext()); return symbol(sym.DIVEQ);      }
    ","                                                         { System.out.println(yytext()); return symbol(sym.COMMA);   }
    ";"                                                         { System.out.println(yytext()); return symbol(sym.SEMICOLON);  }
    "%"                                                         { System.out.println(yytext()); return symbol(sym.MOD);        }
    ">>"                                                        { System.out.println(yytext()); return symbol(sym.RSHIFT);     }
    "%="                                                        { System.out.println(yytext()); return symbol(sym.MODEQ);      }
    ">>="                                                       { System.out.println(yytext()); return symbol(sym.RSHIFTEQ);   }
    "--"                                                        { System.out.println(yytext()); return symbol(sym.MINUSMINUS); }
    "!"                                                         { System.out.println(yytext()); return symbol(sym.NOT);        }
    "..."                                                       { System.out.println(yytext()); return symbol(sym.ELLIPSIS);   }
    "."                                                         { System.out.println(yytext()); return symbol(sym.DOT);        }
    ":"                                                         { System.out.println(yytext()); return symbol(sym.COLON);      }
    "&^ "                                                       { System.out.println(yytext()); return symbol(sym.ANDNOT);     }
    "&^="                                                       { System.out.println(yytext()); return symbol(sym.ANDNOTEQ);   }

    /*TOKENS*/

    "/*"[^*/]*"*/"{line_terminator}?                            { System.out.println("Found traditional comment: " + yytext()); yyline++; yybegin(0);}
    {comment}                                                   { /* ignore */ }
    "//"[^\n]*{line_terminator}?                                { /* ignore */ }
    {decimal_literal}                                           { System.out.println("decimal: " + yytext());  return symbol(sym.INTEGER_LITERAL, new Integer(yytext())); }
    {float_literal}                                             { System.out.println("float literal:" + yytext()); return symbol(sym.FLOATING_POINT_LITERAL, new Float(yytext())); }
    {hex_literal}                                               { System.out.println("hex literal:" + yytext()); return symbol(sym.HEX_LITERAL, yytext());}
    {white_space}                                               { /* Ignore */}
    {identifier}		                                        { System.out.println("found id: " + yytext()); return symbol(sym.IDENTIFIER, yytext()); }
    {identifier}"."{identifier}									{ System.out.println("found qualified id: " + yytext()); return symbol(sym.QUALIFIED_IDENTIFIER, yytext()); }
    {string_literal}                                            { System.out.println("string: " + yytext()); return symbol(sym.STRING_LITERAL, yytext()); }
    {imaginary_literal}                                         { System.out.println("Imaginary: " + yytext()); return symbol(sym.IMAGINARY_LITERAL, yytext()); }
    {octal_literal}                                             { System.out.println("octal: " + yytext()); return symbol(sym.OCTAL_LITERAL, yytext()); }
}

[^]|\n                             { throw new RuntimeException("Erro léxico caractere ilegal:" + yytext() +
                                                              " na linha " + yyline + ", " + " coluna " + yycolumn); }
<<EOF>>                          { return symbol(sym.EOF); }
