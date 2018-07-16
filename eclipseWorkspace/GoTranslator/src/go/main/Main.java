package go.main;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

import java_cup.runtime.Symbol;
import go.core.*;

public class Main {
	private static final int MIN_INPUT_FILES = 1;

	public static void main(String[] args) {
		for (int i = 2; i <= 2; i++) 
			startCompilationFor("test/input" + i + ".go");
	}

	private static void startCompilationFor(String filePath) {
		try {
			System.out.println("Traduzindo  - " + filePath + " - ");
			Lexical sc = new Lexical(new BufferedReader(new FileReader(filePath)));
			Syntactic parser = new Syntactic(sc);
			Symbol s = parser.parse();
			
		} catch (Exception e) {
			System.err.println("Failed to compile \"" + filePath + "\":");
			System.err.println(e.getMessage());
		}
	}

	private static void printHowTo() {
		System.out
		.println("Modo de uso: java -jar <compiler>.jar source [source2 source3...]");
	}
}
