package go.core;

public class ExpressionReturn {
	
	private String returnRegister;
	private String operator;

	
	public ExpressionReturn(String reg, String op) {
		this.returnRegister = reg;
		this.operator = op;
	}


	public String getReturnRegister() {
		return returnRegister;
	}


	public void setReturnRegister(String returnRegister) {
		this.returnRegister = returnRegister;
	}


	public String getOperator() {
		return operator;
	}


	public void setOperator(String operator) {
		this.operator = operator;
	}
}
