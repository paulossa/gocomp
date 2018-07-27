package go.core;

public class Register {
	
	private static int nextAvailableRegister = -1;
	private static int label = 100;
	
	public static String getLabel() {
		label += 8;
		return label + ": ";
	}
	
	public static String peekNextLabel() {
		return "" +  (label + 8);
	}
	
	public static int curLabel() {
		return label;
	}
	
	public static String getNewRegister() {
		return "R" + ++nextAvailableRegister;
	
	}
	
	public static void finishUseReg() {
		//nextAvailableRegister = -1;
	}

}
