package go.core;

public class Register {
	
	private static int nextAvailableRegister = 0;
	private static int label = 100;
	
	public static String getLabel() {
		label += 8;
		return label + ": ";
	}
	
	public static String getNewRegister() {
		nextAvailableRegister += 1;
		return "R" + nextAvailableRegister;
	
	}

}
