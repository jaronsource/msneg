package org.jaronsource.msneg.domain;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.Column;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.ccesun.framework.core.dao.support.IEntity;
import com.ccesun.framework.core.dao.support.EntityUtils;

@Entity
@Table(name="sys_dept")
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
public class SysDept implements IEntity<Integer> {
	
	private static final long serialVersionUID = 1835069915L;
	
	/** 主键 */
	@Id
	@GeneratedValue
	@Column(name="dept_id")
	private Integer deptId;
	
	/** 编码 */
	@Column(name="dept_code")
	private String deptCode;
	
	/** 名称 */
	@Column(name="dept_name")
	private String deptName;
	
	/** 地址 */
	@Column(name="dept_address")
	private String deptAddress;
	
	/** 电话 */
	@Column(name="dept_phone")
	private String deptPhone;
	
	/** 售后服务电话 */
	@Column(name="dept_service_phone")
	private String deptServicePhone;
	
	/** E-mail */
	@Column(name="dept_email")
	private String deptEmail;
	
	/** 传真 */
	@Column(name="dept_fax")
	private String deptFax;
	
	/** 描述 */
	@Column(name="dept_remarks")
	private String deptRemarks;
	
	/** 部门LOGO */
	@Column(name="dept_logo")
	private String deptLogo;
	
	/** 部门类型 */
	@Column(name="dept_type_key")
	private String deptTypeKey;
	
	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}
	
	public Integer getDeptId() {
		return deptId;
	}
	
	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
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
	
	public String getDeptAddress() {
		return deptAddress;
	}

	public void setDeptAddress(String deptAddress) {
		this.deptAddress = deptAddress;
	}

	public String getDeptPhone() {
		return deptPhone;
	}

	public void setDeptPhone(String deptPhone) {
		this.deptPhone = deptPhone;
	}

	public String getDeptServicePhone() {
		return deptServicePhone;
	}

	public void setDeptServicePhone(String deptServicePhone) {
		this.deptServicePhone = deptServicePhone;
	}

	public String getDeptEmail() {
		return deptEmail;
	}

	public void setDeptEmail(String deptEmail) {
		this.deptEmail = deptEmail;
	}

	public String getDeptFax() {
		return deptFax;
	}

	public void setDeptFax(String deptFax) {
		this.deptFax = deptFax;
	}

	public String getDeptLogo() {
		return deptLogo;
	}

	public void setDeptLogo(String deptLogo) {
		this.deptLogo = deptLogo;
	}

	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.deptId);
	}
}
