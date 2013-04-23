package org.jaronsource.msneg.domain;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.ccesun.framework.core.dao.support.EntityUtils;
import com.ccesun.framework.core.dao.support.IEntity;

@Entity
@Table(name="sys_role")
public class SysRole implements IEntity<Integer> {
	
	private static final long serialVersionUID = 1222691226L;
	
	/** 主键 */
	@Id
	@GeneratedValue
	@Column(name="role_id")
	private Integer roleId;
	
	/** 角色名 */
	@Column(name="role_name")
	private String roleName;
	
	/** 描述 */
	@Column(name="role_remarks")
	private String roleRemarks;
	
	@ManyToMany(cascade = CascadeType.PERSIST)
	@JoinTable(name = "sys_rolefunc",
	    joinColumns = @JoinColumn(name = "role_id"),
	    inverseJoinColumns =  @JoinColumn(name = "func_id"))
	private List<SysFunc> functions;
	
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	
	public Integer getRoleId() {
		return roleId;
	}
	
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	
	public String getRoleName() {
		return roleName;
	}
	
	public void setRoleRemarks(String roleRemarks) {
		this.roleRemarks = roleRemarks;
	}
	
	public String getRoleRemarks() {
		return roleRemarks;
	}
	
	public List<SysFunc> getFunctions() {
		return functions;
	}

	public void setFunctions(List<SysFunc> functions) {
		this.functions = functions;
	}

	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.roleId);
	}
}
