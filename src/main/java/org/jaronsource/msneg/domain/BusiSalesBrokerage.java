package org.jaronsource.msneg.domain;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.Column;
import javax.persistence.Transient;
import javax.persistence.ManyToOne;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.ccesun.framework.core.dao.support.IEntity;
import com.ccesun.framework.core.dao.support.EntityUtils;

@Entity
@Table(name="busi_sales_brokerage")
public class BusiSalesBrokerage implements IEntity<Integer> {
	
	private static final long serialVersionUID = 138527502L;
	
	/** 提成单ID */
	@Id
	@GeneratedValue
	@Column(name="brok_id")
	private Integer brokId;
	
	/** 提成总额 */
	@Column(name="brok_sum")
	private Integer brokSum;
	
	/** 结算方式 */
	@Column(name="clear_method_key")
	private String clearMethodKey;
	
	/** 提成人 */
	@Column(name="brok_person_name")
	private String brokPersonName;
	
	/** 经手人 */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private SysUser sysUser;
	
	/** 创建时间 */
	@Column(name="create_time")
	private String createTime;
	
	public void setBrokId(Integer brokId) {
		this.brokId = brokId;
	}
	
	public Integer getBrokId() {
		return brokId;
	}
	
	public void setBrokSum(Integer brokSum) {
		this.brokSum = brokSum;
	}
	
	public Integer getBrokSum() {
		return brokSum;
	}
	
	public void setClearMethodKey(String clearMethodKey) {
		this.clearMethodKey = clearMethodKey;
	}
	
	public String getClearMethodKey() {
		return clearMethodKey;
	}
	
	public void setBrokPersonName(String brokPersonName) {
		this.brokPersonName = brokPersonName;
	}
	
	public String getBrokPersonName() {
		return brokPersonName;
	}
	
	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}
	
	public SysUser getSysUser() {
		return sysUser;
	}
	
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	public String getCreateTime() {
		return createTime;
	}
	
	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.brokId);
	}
}
