package go.core;

public class Literal extends ValuedEntity {
	
	public Literal(Type t, Number val, int scope) {
		super(t, val, scope);
	}
	
	public Literal(Type t, String val, int scope) {
		super(t, val, scope);
	}
	
	public Literal(Type t, Boolean val, int scope) {
		super(t, val, scope);
	}

}
