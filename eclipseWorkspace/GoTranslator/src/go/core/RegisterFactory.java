package go.core;

import java.util.LinkedList;

public class RegisterFactory {

	public static LinkedList<String> createdRegisters = new LinkedList<String>();
	public static Integer id = 0;
	
	public static String newRegister() {
		String register = "R" + id++;
		createdRegisters.add(register);
		return register;
	}
	
	
}
