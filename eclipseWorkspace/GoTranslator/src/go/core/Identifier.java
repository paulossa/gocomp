package go.core;

import java.util.ArrayList;

public class Identifier extends ValuedEntity {

	private String name;
	
	public Identifier(Type t, String name, Number val) {
		super(t, val);
		this.name = name;
	}
	
	public String getName() {
		return name;
	}

	@Override
	public String toString() {
		return "Identifier [name=" + name + "]";
	}

	public void setName(String name) {
		this.name = name;
	}
		

}
