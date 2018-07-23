package go.core;

public class Expression extends ScopedEntity {
	
	private Type type;
	private ValuedEntity left;
	private Expression right;
	private String op;
	
	private int count = 0;
	
	public Expression(ValuedEntity left, Expression right, String op, int scope) {
		super(scope);
		this.type = left.getType();
		this.left = left;
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
				
				Semantic.finalCode.add("MUL " + reg + ", " +  thisVal + ", " + nextVal + "\n");
				
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
				
				
				Semantic.finalCode.add("DIV " + reg + ", " +  thisVal + ", " + nextVal + "\n");
				
			}
			
			if(right != null) {
				right.fixTree1();
			}
			
		}
	}
	
	public String getCode() {
		

		fixTree1();
		fixTree2();
		String ans = getCodeAux();
		return ans;
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

			String ans = instrucao + reg + ", " + aux + ", " + next + "\n";

			Semantic.finalCode.add(ans);

			
			if(count-- > 0) 
				return reg;
			
			else 
				return ans;
			
		}
		return "FAIL";
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
