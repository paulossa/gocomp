package go.core;

public abstract class ValuedEntity extends ScopedEntity{
	
	@Override
	public String toString() {
		return "ValuedEntity [type=" + type + ", value=" + value + "]";
	}
	private Type type;
	private Object value;
	
	public ValuedEntity(Type t, Object val, int scope) {
		super(scope);
		this.type = t;
		this.value = val;
	}
	
	public Type getType() {
		return type;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!super.equals(obj))
			return false;
		if (getClass() != obj.getClass())
			return false;
		ValuedEntity other = (ValuedEntity) obj;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
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
