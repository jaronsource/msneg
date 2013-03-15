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
@Table(name="busi_sales_return")
public class BusiSalesReturn implements IEntity<Integer> {
	
	private static final long serialVersionUID = 730589170L;
	
	/** 返销单ID */
	@Id
	@GeneratedValue
	@Column(name="return_id")
	private Integer returnId;
	
	/** 销售单ID */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="sales_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private BusiSales busiSales;
	
	/** 经手人 */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private SysUser sysUser;
	
	/** 返销破损 */
	@Column(name="return_loss")
	private Integer returnLoss;
	
	/** 折扣破损 */
	@Column(name="rerate_loss")
	private Integer rerateLoss;
	
	/** 备注 */
	@Column(name="return_remarks")
	private String returnRemarks;
	
	/** 结算方式 */
	@Column(name="clear_method_key")
	private String clearMethodKey;
	
	/** 其他备注 */
	@Column(name="other_remarks")
	private String otherRemarks;
	
	public void setReturnId(Integer returnId) {
		this.returnId = returnId;
	}
	
	public Integer getReturnId() {
		return returnId;
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
	
	public void setReturnLoss(Integer returnLoss) {
		this.returnLoss = returnLoss;
	}
	
	public Integer getReturnLoss() {
		return returnLoss;
	}
	
	public void setRerateLoss(Integer rerateLoss) {
		this.rerateLoss = rerateLoss;
	}
	
	public Integer getRerateLoss() {
		return rerateLoss;
	}
	
	public void setReturnRemarks(String returnRemarks) {
		this.returnRemarks = returnRemarks;
	}
	
	public String getReturnRemarks() {
		return returnRemarks;
	}
	
	public void setClearMethodKey(String clearMethodKey) {
		this.clearMethodKey = clearMethodKey;
	}
	
	public String getClearMethodKey() {
		return clearMethodKey;
	}
	
	public void setOtherRemarks(String otherRemarks) {
		this.otherRemarks = otherRemarks;
	}
	
	public String getOtherRemarks() {
		return otherRemarks;
	}
	
	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.returnId);
	}
}
