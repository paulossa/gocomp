package go.core;

import java.util.ArrayList;

public class Assignment {
	
	@Override
	public String toString() {
		return "Assignment [expList1=" + expList1 + ", expList2=" + expList2 + ", op=" + op + "]";
	}

	private ArrayList<Expression> expList1;
	private ArrayList<Expression> expList2;
	private String op;
	
	public Assignment(ArrayList<Expression> exp1, ArrayList<Expression> exp2, String op) {
		this.expList1 = exp1;
		this.expList2 = exp2;
		this.op = op;
	}

	public ArrayList<Expression> getExpList1() {
		return expList1;
	}

	public void setExpList1(ArrayList<Expression> expList1) {
		this.expList1 = expList1;
	}

	public ArrayList<Expression> getExpList2() {
		return expList2;
	}

	public void setExpList2(ArrayList<Expression> expList2) {
		this.expList2 = expList2;
	}

	public String getOp() {
		return op;
	}

	public void setOp(String op) {
		this.op = op;
	}

}
