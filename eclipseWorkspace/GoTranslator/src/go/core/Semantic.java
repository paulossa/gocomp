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
	
	
	private static final String[]
			NUMERIC_TYPES = {
					"float",
					"float32", 
					"float64",
					"int",
					"int8", 
					"int16", 
					"int32", 
					"int64",
					"uint", 
					"uint8", 
					"uint16", 
					"uint32",
					"uint64"
			};

	private static final String[]
			BASIC_TYPES = {
					"bool", 
					"byte", 
					"complex64",
					"complex128",
					"error",
					"float32", 
					"float64",
					"int",
					"int8", 
					"int16", 
					"int32", 
					"int64", 
					"rune", 
					"string",
					"uint", 
					"uint8", 
					"uint16", 
					"uint32",
					"uint64", 
					"uintptr"
			};
	
	private int sec = 0;
	public static ArrayList<String> variaveis = new ArrayList<String>();
	public static HashMap<String, Type> varTypes = new HashMap<String, Type>();
	public static HashMap<String, Object> varValues = new HashMap<String, Object>();
	public static ArrayList<String> auxIdList = new ArrayList<String>();
	public static ArrayList<Expression> auxExpList = new ArrayList<Expression>();
	
	
	private static Semantic sAnalysis;
	
	
	public static Number getValue(Object exp) throws Exception {
		if(exp instanceof Expression) {
			return ((Expression) exp).getValue();
		}
		else if(exp instanceof Literal) {
			return (Number)((Literal) exp).getValue();
		} 
		else if(exp instanceof Identifier) {
			String id = ((Identifier) exp).getName();
			return (Number)varValues.get(id);
		} 
		else return (Number)exp;

	}
	
	
	public static void assignVar(String id, Object val) {
		System.out.println("atribuiu: " + val + " a variavel: " + id);
		varValues.put(id, val);
	}
	
	
	public static ArrayList<String> readIdList(String id) throws Exception {
		if(!isVarAlreadyDeclared(id)){
			auxIdList.add(id);
			declareVar(id, new Type("id_list_process"));
		}
		return auxIdList;
	}
	
	public static ArrayList<Expression> readExpList(Expression e) throws Exception {
		auxExpList.add(e);
		return auxExpList;
	}
	
	public static void endReadExpList() throws Exception {
		if(auxExpList.size() == 0) {
			throw new Exception("Impossible to finish reading empty id list");
		}
		auxExpList.clear();
	}
	
	public static void endReadIdList() throws Exception {
		if(auxIdList.size() == 0) {
			throw new Exception("Impossible to finish reading empty id list");
		}
		auxIdList.clear();
	}
	
	public static void convertIdList(Type actualType) {
		
		for(String key: varTypes.keySet()) {
			
			if(varTypes.get(key).getTypeName().equals("id_list_process")) {
				
				boolean done = false;
				
				for(String basicType: NUMERIC_TYPES) {
					if(basicType.equals(actualType.getTypeName())) {
						done = true;
						varTypes.put(key, new Type("number"));
					}
				}
				
				if(!done) varTypes.put(key, actualType);
			}
		}
	}


	
	public static boolean isVarAlreadyDeclared(String id) throws Exception {
		if(varTypes.containsKey(id)) throw new Exception("Semantic error: var " + id + " already declared.");
		return varTypes.containsKey(id);
	}
	
	
	public static Type getVariableType(String id) {
		return varTypes.get(id);
	}
	
	
	
	public static void declareVar(Object id, Type varType) {
		if(id instanceof String) {
			System.out.println("declaring " + (String)id + " of type " + varType.getTypeName());
			variaveis.add((String)id);
			varTypes.put((String)id, varType);
		}

	}
	

	public static Expression getResultingExp(Object o, String op) throws Exception {
		if(o instanceof ValuedEntity) {
			return new Expression((ValuedEntity) o, null, op);
		}
		throw new Exception("TODO: Literals");
	}
	
	
	public static void checkVariableDeclaration(Type var, Type assigned) throws Exception {
		
		if(!var.getTypeName().equals(assigned.getTypeName())){
			throw new Exception(
				"Semantic Error: Variable of type " + 
				var.getTypeName() +  
				" can not be assigned to type " + 
				assigned.getTypeName()
			);
		}
	}
	
	public static void checkIfVariableDeclared(String id) throws Exception {
		if(!variaveis.contains(id)) {
			throw new Exception("Semantic error: Variable " + id + " not declared.");
		}
		else if(varTypes.get(id).getTypeName().equals("id_list_process")) {
			throw new Exception("Semantic error: Variable " + id + " not declared.");
		}
	}
	
	public static Expression checkExpressionTypes(Object left, Object right, String op) throws Exception {
		
		
		if(left instanceof ValuedEntity && right instanceof Expression) {
			if(!((ValuedEntity) left).getType().equals(((Expression) right).getType())) {
				throw new Exception(
					"Semantic Error: Expression of type " + 
					((ValuedEntity) left).getType() +  
					" is not compatible with type " + 
					((Expression) right).getType()
				);
			}
			return new Expression(((ValuedEntity) left), ((Expression) right),op);
		}
		
		if(left instanceof Expression && right instanceof Expression) {
			if(!((Expression) left).getType().equals(((Expression) right).getType())) {
				throw new Exception(
					"Semantic Error: Expression of type " + 
					((Expression) left).getType() +  
					" is not compatible with type " + 
					((Expression) right).getType()
				);
			}
			return new Expression(null,null,null); //x + y  -  z + w
		}
		
		if(left instanceof ValuedEntity && right instanceof ValuedEntity) {
			if(!((ValuedEntity) left).getType().equals(((ValuedEntity) right).getType())) {
				throw new Exception(
					"Semantic Error: Expression of type " + 
					((ValuedEntity) left).getType() +  
					" is not compatible with type " + 
					((ValuedEntity) right).getType()
				);
			}
			
			return new Expression(((ValuedEntity) left), new Expression(((ValuedEntity) right), null, null), op);
		}
		System.out.println("WARN: Expressão não tratada semanticamente");
		return null;
	}

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
		System.out.println("Compiled Successfully");
	}	

}