package org.jaronsource.msneg.domain;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.Column;
import javax.persistence.Transient;

import com.ccesun.framework.core.dao.support.IEntity;
import com.ccesun.framework.core.dao.support.EntityUtils;

@Entity
@Table(name="sys_dept")
public class SysDept implements IEntity<Integer> {
	
	private static final long serialVersionUID = 1835069915L;
	
	/** 主键 */
	@Id
	@GeneratedValue
	@Column(name="dept_id")
	private Integer deptId;
	
	/** 名称 */
	@Column(name="dept_name")
	private String deptName;
	
	/** 描述 */
	@Column(name="dept_remarks")
	private String deptRemarks;
	
	/** 部门类型 */
	@Column(name="dept_type_key")
	private String deptTypeKey;
	
	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}
	
	public Integer getDeptId() {
		return deptId;
	}
	
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	
	public String getDeptName() {
		return deptName;
	}
	
	public void setDeptRemarks(String deptRemarks) {
		this.deptRemarks = deptRemarks;
	}
	
	public String getDeptRemarks() {
		return deptRemarks;
	}
	
	public void setDeptTypeKey(String deptTypeKey) {
		this.deptTypeKey = deptTypeKey;
	}
	
	public String getDeptTypeKey() {
		return deptTypeKey;
	}
	
	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.deptId);
	}
}
