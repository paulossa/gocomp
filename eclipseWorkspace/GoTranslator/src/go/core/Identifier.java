package go.core;

import java.util.ArrayList;

public class Identifier extends ValuedEntity {

	private String name;
	
	public Identifier(Type t, String name, Object val, int scope) {
		super(t, val, scope);
		this.name = name;
	}
	
	public String getName() {
		return name;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + ((name == null) ? 0 : name.hashCode());
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
		Identifier other = (Identifier) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Identifier [name=" + name + ", getType()=" + getType() + ", getScope()=" + getScope() + "]";
	}

	public void setName(String name) {
		this.name = name;
	}
		

}
