package go.core;

public class Type {
	
	@Override
	public String toString() {
		return "Type [typeName=" + typeName + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((typeName == null) ? 0 : typeName.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Type other = (Type) obj;
		if (typeName == null) {
			if (other.typeName != null)
				return false;
		} else if (!typeName.equals(other.typeName))
			return false;
		return true;
	}

	private String typeName;
	
	public Type(String ttype) {
		this.typeName = ttype;
	}
	
	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String ttype) {
		this.typeName = ttype;
	}
}
