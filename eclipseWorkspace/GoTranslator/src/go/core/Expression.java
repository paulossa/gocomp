package go.core;

public class Expression {
	
	private Type type;
	private ValuedEntity left;
	private Expression right;
	private String op;
	
	public Expression(ValuedEntity left, Expression right, String op) {
		this.type = left.getType();
		this.left = left;
		this.right = right;
		this.op = op;
	}
	
	public Number getValue() throws Exception {
		if(right == null) {
			return (Number)left.getValue();
		}
		
		if(op == "+") 
			return 
				((Number) left.getValue()).floatValue() + 
				((Number)right.getValue()).floatValue();
		
		else if(op == "-") 
			return 
				((Number) left.getValue()).floatValue() - 
				((Number)right.getValue()).floatValue();
		
		throw new Exception("lel");
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
