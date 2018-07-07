package go.main;

import java.io.BufferedReader;
import java.io.FileReader;

import com.ccompiler.analysis.Syntatic;

import java_cup.runtime.Symbol;

public class Main {
	private static final int MIN_INPUT_FILES = 1;

	public static void main(String[] args) {
		if (args.length < MIN_INPUT_FILES) {
			printHowTo();
		} else {
			for (String filePath : args) { startCompilationFor(filePath); }
		}
	}

	private static void startCompilationFor(String filePath) {
		try {
			System.out.println("Traduzindo  - " + filePath + " - ");
			Lexical sc = new Lexical(new BufferedReader(new FileReader(filePath)));
			Syntatic parser = new Syntatic(scanner);
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
