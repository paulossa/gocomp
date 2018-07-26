package go.core;

public class Expression extends ScopedEntity {
	
	private Type type;
	private ValuedEntity left;
	private Expression right;
	private String op;
	private boolean hasRelational = false;
	private String relOp = null;
	private Expression lexp;
	
	private int count = 0;
	
	public Expression(ValuedEntity left, String op, int scope) {
		super(scope);
		this.type = left.getType();
		this.left = left;
		
		this.op = op;
	}
	
	public Expression(ValuedEntity left, Expression right, String op, int scope) {
		super(scope);
		this.type = left.getType();
		this.left = left;
		this.right = right;
		this.op = op;
	}
	public Expression(ValuedEntity l, ValuedEntity r, String op, int scope) {
		super(scope);
		this.type = l.getType();
		this.left = l; 
		this.op = op;
	}
	
	public Expression(Expression left, Expression right, String op, int scope) {
		super(scope);
		this.type = left.getType();
		this.lexp = left;
		this.right = right;
		this.op = op;
	}

	private void fixTree2() {
		if(right != null) {
//			System.out.println(right);
			
			if(op.equals("*")) {

				String reg =  Register.getNewRegister();
				String thisVal = "";
				String nextVal = "";
				
				if(left instanceof Literal) {
					thisVal += "#" + left.getValue();
				}
				
				if(left instanceof Identifier) {
					thisVal += ((Identifier)left).getName();
				}
				
				if(right.left instanceof Literal) {
					nextVal += "#" + right.left.getValue();
				}
				
				if(right.left instanceof Identifier) {
					nextVal +=  ((Identifier)right.left).getName();
				}
				
				
				left = new Identifier(left.getType(), reg, reg ,0);
				op = right.getOp();
				right = right.getRight();
				
				Semantic.finalCode.add(Register.getLabel() + "MUL " + reg + ", " +  thisVal + ", " + nextVal + "\n");
				
			}
			
			if(right != null) {
				right.fixTree2();
			}
			
		}
	}
	
	private void fixTree1() {
		if(right != null) {
			
			if(op.equals("/")) {
				
				String reg =  Register.getNewRegister();
				String thisVal = "";
				String nextVal = "";
				
				if(left instanceof Literal) {
					thisVal += "#" + left.getValue();
				}
				
				if(left instanceof Identifier) {
					thisVal += ((Identifier)left).getName();
				}
				
				if(right.left instanceof Literal) {
					nextVal += "#" + right.left.getValue();
				}
				
				if(right.left instanceof Identifier) {
					nextVal +=  ((Identifier)right.left).getName();
				}
				
				
				left = new Identifier(left.getType(), reg, reg ,0);
				op = right.getOp();
				right = right.getRight();
				
				
				Semantic.finalCode.add(Register.getLabel() + "DIV " + reg + ", " +  thisVal + ", " + nextVal + "\n");
				
			}
			
			if(right != null) {
				right.fixTree1();
			}
			
		}
	}
	
	public ExpressionReturn getCode() throws Exception {
		
		this.hasRelational = false;
		this.relOp = null;
		
		String returnReg = "";
		
		if(type.getTypeName().equals("string")) {
			String ans = "";
			if(left instanceof Identifier) {
				ans += ((Identifier) left).getName();
			}
			
			if(left instanceof Literal) {
				ans += ((Literal) left).getValue();
			}
			
			return new ExpressionReturn(ans, null);
		}
		
		String result = checkRelationalOp(this, this);
		
		if(result != null) {
			returnReg += result;
			return new ExpressionReturn(returnReg, this.relOp);
		}

		
		if(!hasRelational) {
			fixTree1();
			fixTree2();
			String ans = getCodeAux();
			returnReg += ans;			
		}
		
		return new ExpressionReturn(returnReg, null);

	}
	
	private String checkRelationalOp(Expression e, Expression initial) throws Exception {

		if(e.op != null && (e.op.equals("==") || e.op.equals(">=") || e.op.equals(">") || e.op.equals("<") || e.op.equals("<=") || e.op.equals("!="))) {
			
			String registerRight = e.getRight().getCodeAux();
			
			e.setRight(null);
			
			this.relOp = e.op;
			
			String registerLeft = initial.getCodeAux();
			
			String newReg = Register.getNewRegister();
			
			Semantic.finalCode.add(Register.getLabel() + "SUB " + newReg + ", " + registerLeft + ", " + registerRight + "\n");
			
			hasRelational = true;	
			return newReg;
		}
		
		else if(e.getRight() != null)
			return checkRelationalOp(e.getRight(), initial);
		
		else return null;
	
	}
	
	private String getCodeAux() {
		if(right == null) {
			
			if(left instanceof Identifier) {
				Identifier i = (Identifier) left;
				return i.getName();
			}
			
			else if(left instanceof Literal) {
				Literal i = (Literal) left;
				return "#" + i.getValue();
			}
			
		}
		
		else {
			
			boolean done = false;
			
			String aux = "";
			
			if(left instanceof Identifier) {
				Identifier i = (Identifier) left;
				aux += i.getName();
			}
			
			else if(left instanceof Literal) {
				Literal i = (Literal) left;
				aux += "#" + i.getValue();
			}
			
			count += 1;

			String reg = Register.getNewRegister();
			String next = right.getCodeAux();
			
			String instrucao = "";
			
			if(op.equals("+")) {
				instrucao = "ADD ";
			}
			else if(op.equals("-")) {
				instrucao = "SUB ";
			}
			
			else if(op.equals("/")) {
				instrucao = "DIV ";
			}
			
			else if(op.equals("*")) {
				instrucao = "MUL ";
			}
			
			else if(op.equals("||")) {
				instrucao = "OR ";
			}
			
			else if(op.equals("&&")) {
				instrucao = "AND ";
			}
			
			else if(op.equals("!")) {
				instrucao = "MUL ";
			}
			
//			else if (op.equals("==")) {
//				done = true;
//				Semantic.finalCode.add(Register.getLabel() + "LD " + reg + ", " + aux + "\n");
//				Semantic.finalCode.add(Register.getLabel() + "SUB " + reg + ", " + reg + ", " + next + "\n");
//				return reg;
////				System.out.println();
////				System.out.println();
//			}
			
			String ans = Register.getLabel() + instrucao + reg + ", " + aux + ", " + next + "\n";

			Semantic.finalCode.add(ans);

			
			if(count-- > 0) 
				return reg;
			
			else 
				return ans;
			
		}
		return "FAIL";
	}
	public String repr() { 
		if (left instanceof Identifier) 
			return ((Identifier) left).getName();
		else if (left instanceof ValuedEntity)
			return "#" + left.getValue();
		return left.toString();
//		if (left != null && (int) left.getValue() != 0)
//			return "#" + left.getValue();
//		else {
//			return lexp.getCodeAux();
//		}
	}
	
	//Returns true if expression is deep. i.e.: Two or more expressions nested.
	public boolean isDeep() {
		return right != null;
	}

	public ValuedEntity getLeft() {
		return left;
	}

	public void setLeft(ValuedEntity left) {
		this.left = left;
	}

	public Expression getRight() {
		return right;
	}

	@Override
	public String toString() {
		return "Expression [type=" + type + ", left=" + left + ", right=" + right + ", op=" + op + "]";
	}

	public void setRight(Expression right) {
		this.right = right;
	}

	public String getOp() {
		return op;
	}

	public void setOp(String op) {
		this.op = op;
	}

	public Type getType() {
		return this.type;
	}

	public void setType(Type ttype) {
		this.type = ttype;
	}
}
