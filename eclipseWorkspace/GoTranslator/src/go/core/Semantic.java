package go.core;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.Queue;
import java.util.LinkedList;
import java.util.HashMap;


public class Semantic {
	
	private static int GLOBAL_SCOPE = 1;
	public static int currentScope = 1;

	public static Syntactic parser;
	public static Lexical lex;
	
	public static Queue<String> finalCode = new LinkedList<String>(); 
	
	public static String getCode() {
		String ans = "100: " + "LD SP, 4000\n";
		
		while(!finalCode.isEmpty()) {
			ans += finalCode.remove();
		}
		
		return ans + Register.getLabel() + "halt\n";
	}
	
	
	
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
					"function",
					"bool", 
					"byte", 
					"complex64",
					"complex128",
					"float",
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
	public static ArrayList<Identifier> variaveis = new ArrayList<Identifier>();
	
	public static HashMap<String, String> idToRegister = new HashMap<String, String> ();
	
	private static Semantic sAnalysis;
	
	
	public static void reorderLabels() { 

		ArrayList l = new ArrayList(Semantic.getInstance().finalCode);
		int startLabel = 108;
		
		for(int i = 0 ; i < l.size() ; i++) {
			
			l.set(i, startLabel + ((String) l.get(i)).substring(3));
			startLabel += 8;
		}
		
		finalCode = new LinkedList<>(l);
		
	}
	
	
	public static void checkIfTypeExists(Type t) throws Exception {
		boolean found = false;
		for(String type: BASIC_TYPES) {
			if(t.getTypeName().equals(type)) {
				found = true;
			}
		}
		if(!found) throw new Exception(lex.curLine + " Semantic error: Type " + t.getTypeName() + " not declared");
	}
	
	
	public static String checkAssignment(Object expList1, Object expList2, Object op) throws Exception {
		
		int lastLabel = 0;
		int size1 = ((ArrayList<Expression>) expList1).size();
		int size2 = ((ArrayList<Expression>) expList2).size();
		
		if(size1 != size2) {
			throw new Exception("Identifier list and expression list have different sizes");
		}
	
		
		for(int i = size1 - 1 ; i >= 0 ; i--) {
			Expression exp1 = ((ArrayList<Expression>) expList1).get(i);
			Expression exp2 = ((ArrayList<Expression>) expList2).get(i);
			
			if(!exp1.getType().equals(exp2.getType())) {
				throw new Exception("Expected " + exp1.getType() + " but got " + exp2.getType() + " at position " + (i - size1 + 1) + " of assignment list");
			}
			
			if(!(exp1.getLeft() instanceof Identifier) || exp1.isDeep()) {
				throw new Exception("Expected identifier at position " + (i - size1 + 1) + " of left side of assignment.");
			}
			
			if(!(exp2.getLeft() instanceof ValuedEntity)) {
				throw new Exception("Expected identifier or literal at position " + (i - size1 + 1) + " of right side of assignment.");
			}
			
			Identifier id = (Identifier) exp1.getLeft();
			
			//ignora
			if(!exp2.getType().getTypeName().equals("string")) {
			
				int beginReg = Register.curLabel() + 8;
				
				if(op.equals("=")) {
					ExpressionReturn er = exp2.getCode();
					Semantic.finalCode.add(Register.getLabel() + "ST " + id.getName() + ", " + er.getReturnRegister() + "\n");
				}
				else if(op.equals("*=")) {
					ExpressionReturn er = exp2.getCode();
					String reg = Register.getNewRegister();
					Semantic.finalCode.add(Register.getLabel() + "LD " + reg + ", " + id.getName() + "\n");
					Semantic.finalCode.add(Register.getLabel() + "MULT "  + reg + ", " + reg + ", " + er.getReturnRegister() + "\n");
					Semantic.finalCode.add(Register.getLabel() + "ST " + id.getName() + ", " + reg + "\n");
					Register.finishUseReg();
				}
				
				else if(op.equals("-=")) {
					ExpressionReturn er = exp2.getCode();
					String reg = Register.getNewRegister();
					Semantic.finalCode.add(Register.getLabel() + "LD " + reg + ", " + id.getName() + "\n");
					Semantic.finalCode.add(Register.getLabel() + "SUB " + reg + ", " + reg + ", " + er.getReturnRegister() + "\n");
					Semantic.finalCode.add(Register.getLabel() + "ST " + id.getName() + ", " + reg + "\n");
					Register.finishUseReg();
				}
				
				else if(op.equals("/=")) {
					ExpressionReturn er = exp2.getCode();
					String reg = Register.getNewRegister();
					Semantic.finalCode.add(Register.getLabel() + "LD " + reg + ", " + id.getName() + "\n");
					Semantic.finalCode.add(Register.getLabel() + "DIV "  + reg + ", " + reg + ", " + er.getReturnRegister() + "\n");
					Semantic.finalCode.add(Register.getLabel() + "ST " + id.getName() + ", " + reg + "\n");
					Register.finishUseReg();
				}
				
				else if(op.equals("+=")) {
					ExpressionReturn er = exp2.getCode();
					String reg = Register.getNewRegister();
					Semantic.finalCode.add(Register.getLabel() + "LD " + reg + ", " + id.getName() + "\n");
					Semantic.finalCode.add(Register.getLabel() + "ADD "  + reg + ", " + reg + ", " + er.getReturnRegister() + "\n");
					Semantic.finalCode.add(Register.getLabel() + "ST " + id.getName() + ", " + reg + "\n");
					Register.finishUseReg();
				}
				
				return ""+beginReg;
				
			}
		}
		
		return null;
		
	}
	
	
	public static void checkTypeExpressionList(Type t, ArrayList<Expression> ar) throws Exception {
		
		for(int i = 0 ; i < ar.size(); i++) {
			Expression exp = ar.get(i);
			if(!exp.getType().equals(t)) {
				throw new Exception(lex.curLine + " Semantic error: Expected type " + t + " but got " + exp.getType() + " at position " + i + " of expression list");
			}
		}
	}
	
	
	public static void isVarAlreadyDeclared(Identifier id) throws Exception {
		
		for(Identifier i: variaveis) {
			if(i.getName().equals(id.getName()) && (i.getScope() == currentScope || i.getScope() == GLOBAL_SCOPE)) {
				throw new Exception(lex.curLine + " Semantic error: var " + id + " already declared.");
			}
		}

	}
	
	
	public static Identifier getIdByName(String id) throws Exception {
		for(Identifier i: variaveis) {
			if(i.getName().equals(id) && (i.getScope() <= currentScope || i.getScope() == GLOBAL_SCOPE)) {
				return i;
			}
		}
		
		throw new Exception(lex.curLine + " Semantic error: Variable " + id + " not declared in current or global scope.");
	}
	
	
	public static void declareExpIdList(ArrayList<Expression> v, ArrayList<Identifier> o) throws Exception {

		if(o.size() != v.size())
		{
			throw new Exception(lex.curLine + " Semantic error: Identifier list and expression list have different sizes.");
		}

		int listSize = v.size();

		for(int i = 0; i < listSize ; i++){
			Expression e = v.get(i);	
			Identifier id = o.get(i);		
			id.setType(e.getType());
			
			isVarAlreadyDeclared(id);

			declareVar(id, e.getType());
			
			String expReg = e.getCode().getReturnRegister();
			
			idToRegister.put(id.getName(), expReg);
			
			finalCode.add(Register.getLabel() + "ST " + id.getName() + ", " + expReg + "\n");
			Register.finishUseReg();
		}
		
	}
	
	
	public static void declareIdList(Type t, ArrayList<Identifier> ar) throws Exception {
		for(int i = 0 ; i < ar.size() ; i++) {
			Identifier id = ar.get(i);
			id.setType(t);
			isVarAlreadyDeclared(id);

			declareVar(id, t);
			
			String reg = Register.getLabel();
			
			idToRegister.put(id.getName(), reg);
			
			if(id.getType().getTypeName().equals("int"))
				finalCode.add(reg + "ST " + id.getName() + ", #0\n");
			
			else if(id.getType().getTypeName().equals("float"))
				finalCode.add(reg + "ST " + id.getName() + ", #0.0\n");
			
			else if(id.getType().getTypeName().equals("string"))
				finalCode.add(reg + "ST " + id.getName() + ", \"\"\n");
			
			else if(id.getType().getTypeName().equals("bool"))
				finalCode.add(reg + "ST " + id.getName() + ", #0\n");
			
			
			Register.finishUseReg();
		}
	}
	
	
	public static void declareVar(Identifier id, Type varType) {
//			System.out.println("declaring " + id + " of type " + varType.getTypeName());
		id.setType(varType);
		variaveis.add(id);
	}
	

	public static Expression getResultingExp(Object o, String op) throws Exception {

		if(o instanceof Expression) {
			
			if(op != null && (op.equals("<-") || op.equals("*") || op.equals("&") || op.equals("<-") ) ) {
				return null;
			}
			
			if(op != null && op.equals("!")) {
				if (  ((Expression) o).getType().getTypeName().equals("bool")) {
					System.out.println(o);
					int val = (int) ((Expression) o).getLeft().getValue();
					((Expression) o).getLeft().setValue((val == 1)? 0 : 1);
				}
				
				else throw new Exception(lex.curLine + " Semantic error: Invalid expression.");

			}
			
			
			
			else if(op != null && op.equals("-")) {
				if (  ((Expression) o).getType().getTypeName().equals("int")) {
					((Expression) o).getLeft().setValue((int)((Expression) o).getLeft().getValue() * -1);
				}
				
				else if (  ((Expression) o).getType().getTypeName().equals("float")) {
					((Expression) o).getLeft().setValue((float)((Expression) o).getLeft().getValue() * -1);
				}
				
				else throw new Exception(lex.curLine + " Semantic error: Invalid expression.");

			}
			
			else if (op != null && op.equals("+")) {
				if (  !((Expression) o).getType().getTypeName().equals("int") &&   !((Expression) o).getType().getTypeName().equals("float") ) {
					throw new Exception(lex.curLine + " Semantic error: Invalid expression.");
				}
			}
			
			else if (op != null && op.equals("^")) {
				if (  !((Expression) o).getType().getTypeName().equals("int")  ) {
					throw new Exception(lex.curLine + " Semantic error: Invalid expression.");
				} else ((Expression) o).getLeft().setValue( ( (int)((Expression) o).getLeft().getValue() + 1 ) * -1 );
			}
			
			return (Expression)o;
		}
		
		if(o instanceof ValuedEntity) {
			
			return new Expression((ValuedEntity) o, null, op, currentScope);
		}
		
		
		return null;
	}
	
	
	public static void checkVariableDeclaration(Type var, Type assigned) throws Exception {
		
		if(!var.getTypeName().equals(assigned.getTypeName())){
			throw new Exception(
				lex.curLine + " Semantic Error: Variable of type " + 
				var.getTypeName() +  
				" can not be assigned to type " + 
				assigned.getTypeName()
			);
		}
	}
	
	public static Expression checkExpressionTypes(Object left, Object right, String op) throws Exception {
		
//		System.out.println(left);
//		System.out.println(right);
		
		if(left instanceof ValuedEntity && right instanceof Expression) {
			if(!((ValuedEntity) left).getType().equals(((Expression) right).getType())) {
				throw new Exception(
					lex.curLine + " Semantic Error: Expression of type " + 
					((ValuedEntity) left).getType() +  
					" is not compatible with type " + 
					((Expression) right).getType()
				);
			}
			return new Expression(((ValuedEntity) left), ((Expression) right), op, currentScope);
		}
		
		if(left instanceof Expression && right instanceof Expression) {
			if(!((Expression) left).getType().equals(((Expression) right).getType())) {
				throw new Exception(
					lex.curLine + " Semantic Error: Expression of type " + 
					((Expression) left).getType() +  
					" is not compatible with type " + 
					((Expression) right).getType()
				);
			}
			((Expression) left).setRight((Expression) right); //x + y  -  z + w
			((Expression) left).setOp(op); //x + y  -  z + w
			//System.out.println("result = " + left);
			return (Expression)left;
		}
		
		if(left instanceof ValuedEntity && right instanceof ValuedEntity) {
			if(!((ValuedEntity) left).getType().equals(((ValuedEntity) right).getType())) {
				throw new Exception(
					lex.curLine + " Semantic Error: Expression of type " + 
					((ValuedEntity) left).getType() +  
					" is not compatible with type " + 
					((ValuedEntity) right).getType()
				);
			}
			
			return new Expression(((ValuedEntity) left), new Expression(((ValuedEntity) right), null, null, currentScope), op, currentScope);
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
		String[] predef = {"len", "append", "cap", "close", "complex","copy", "delete", "imag", "make", "new", "panic", "print", "println", "real", "recover"};
		
		for(String s: predef) {
			Identifier id = new Identifier(new Type("function"), s, null, GLOBAL_SCOPE);
			variaveis.add(id);
		}
//		scopeStack = new Stack<ScopedEntity>();
//		cProgram = new Program();
	}

	public void hw() {
		System.out.println("Compiled Successfully");
	}	

}