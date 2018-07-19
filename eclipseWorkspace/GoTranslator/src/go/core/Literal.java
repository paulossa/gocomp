package go.core;

public class Literal extends ValuedEntity {
	
	public Literal(Type t, Number val) {
		super(t, val);
	}
	
	public Literal(Type t, Boolean val) {
		super(t, val);
	}

}
