package com.eazytec.core.pojo;

import java.io.Serializable;

/**
 * 
 * @author Frin
 * @description
 */
public abstract class BaseBean implements Serializable {

	private long primaryKey;

	public BaseBean() {
		super();
	}

	public long getPrimaryKey() {
		return primaryKey;
	}

	public void setPrimaryKey(long id) {
		this.primaryKey = id;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (primaryKey ^ (primaryKey >>> 32));
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
		BaseBean other = (BaseBean) obj;
		if (primaryKey != other.primaryKey)
			return false;
		return true;
	}

}
