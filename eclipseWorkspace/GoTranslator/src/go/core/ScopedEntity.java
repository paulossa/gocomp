package go.core;

public class ScopedEntity {
	private int scope;
	
	public int getScope() {
		return scope;
	}

	public void setScope(int scope) {
		this.scope = scope;
	}

	public ScopedEntity(int sscope) {
		this.scope = sscope;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + scope;
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
		ScopedEntity other = (ScopedEntity) obj;
		if (scope != other.scope)
			return false;
		return true;
	}
	
}
