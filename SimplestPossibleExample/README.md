A small JFlex+Cup example

It comes from a short article series in the Linux Gazette by Richard
A. Sevenich and Christopher Lopes, titled "Compiler Construction
Tools". The article series starts at
Small changes and updates to newest JFlex+Cup versions by Gerwin Klein





Files:

cup/Main.java       demo of a main program
cup/lcalc.flex      the lexer spec
cup/output.good     how the output should look like for the test
cup/ycalc.cup       the parser spec
cup/test.txt        sample input for testing


> To Compile
		~> Added JFLEX to PATH optional 
		jflex lcalc.flex 										(Generates Lexer.java )                                                
		java -cp <path_to_cup.jar>;. java_cup.Main < ycalc.cup 	(Receives the language grammar specs )
		javac -cp <path_to_cup.jar>;. Main.java 				(Compiles Main class to would be equivalent to a compiler/interpreter )

> To run: 
		java -cp <path_to_cup.jar>;. Main test.txt              (runs test.txt and outputs result)