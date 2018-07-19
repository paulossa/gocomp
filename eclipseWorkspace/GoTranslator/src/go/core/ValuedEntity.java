package go.core;

public abstract class ValuedEntity {
	
	@Override
	public String toString() {
		return "ValuedEntity [type=" + type + ", value=" + value + "]";
	}
	private Type type;
	private Object value;
	
	public ValuedEntity(Type t, Object val) {
		this.type = t;
		this.value = val;
	}
	
	public Type getType() {
		return type;
	}
	public void setType(Type type) {
		this.type = type;
	}
	public Object getValue() {
		return value;
	}
	public void setValue(Object value) {
		this.value = value;
	}

}
