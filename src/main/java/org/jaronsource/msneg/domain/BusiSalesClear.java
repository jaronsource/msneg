package org.jaronsource.msneg.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.ccesun.framework.core.dao.support.EntityUtils;
import com.ccesun.framework.core.dao.support.IEntity;

@Entity
@Table(name="busi_sales_clear")
public class BusiSalesClear implements IEntity<Integer> {
	
	private static final long serialVersionUID = 226230940L;
	
	/** 结算单ID */
	@Id
	@GeneratedValue
	@Column(name="clear_id")
	private Integer clearId;
	
	/** 销售单ID */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="sales_id")
	private BusiSales busiSales;
	
	/** 经手人 */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id")
	private SysUser sysUser;
	
	/** 创建时间 */
	@Column(name="create_time")
	private String createTime;
	
	public void setClearId(Integer clearId) {
		this.clearId = clearId;
	}
	
	public Integer getClearId() {
		return clearId;
	}
	
	public void setBusiSales(BusiSales busiSales) {
		this.busiSales = busiSales;
	}
	
	public BusiSales getBusiSales() {
		return busiSales;
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
		return EntityUtils.isNew(this.clearId);
	}
}
