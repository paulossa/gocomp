package go.core;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.Stack;
import java.util.HashMap;

//import go.symbol.core.Case;
//import go.symbol.core.Default;
//import go.symbol.core.Expression;
//import go.symbol.core.Function;
//import go.symbol.core.Identifier;
//import go.symbol.core.Operation;
//import go.symbol.core.Program;
//import go.symbol.core.Register;
//import go.symbol.core.ScopedEntity;
//import go.symbol.core.Switch;
//import go.symbol.core.SwitchCase;
//import go.symbol.core.Type;
//import go.symbol.core.Variable;
//import go.symbol.util.SemanticException;

public class Semantic {

	public static Syntactic parser;
	
	public int lastListSize = 0;

//	private static final Type[] 
//			BASIC_TYPES = new Type[] { 
//					new Type("int"), 
//					new Type("float"), 
//					new Type("double"),
//					new Type("long"), 
//					new Type("char"), 
//					new Type("void"), 
//					new Type("string"), 
//					new Type("bool") 
//				};
	
	private int sec = 0;
	public static ArrayList<String> variaveis = new ArrayList<String>();
	public static ArrayList<String> valores = new ArrayList<String>();
	private static Semantic sAnalysis;

	private static HashMap<String, Integer> ids = new HashMap<String, Integer>(); 

	public static Semantic getInstance() {
		if (sAnalysis == null)
			sAnalysis = new Semantic();
		return sAnalysis;
	}
	
	private Semantic() {
//		scopeStack = new Stack<ScopedEntity>();
//		cProgram = new Program();
	}

	public void hw() {
		System.out.println("hworld! -----------------------------------");
	}
	
	public void addId(String id) {
		System.out.println("AddId");
		if (!ids.containsKey(id)) {
			ids.put(id, getSeqNb());
		}
	}

	private Integer getSeqNb() {
		return ++sec;
	}
	
	public void addExp(Object e) {
		System.out.println(e);
	}
	
	public void finishList(String id) {
		System.out.println("call b");
		addId(id);
		lastListSize++;
//		System.out.println("Args size = " + lastListSize);
//		System.out.println(ids);
//		lastListSize = 0;	
	}
	
	public void addToList(String id) {
		System.out.println("call a");
		addId(id);
		lastListSize++;
	}
	
	

}
