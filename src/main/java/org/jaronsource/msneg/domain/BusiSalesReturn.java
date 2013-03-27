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

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.ccesun.framework.core.dao.support.EntityUtils;
import com.ccesun.framework.core.dao.support.IEntity;

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
	
	/** 应返金额 */
	@Column(name="return_sum")
	private Integer returnSum;
	
	/** 返销破损 */
	@Column(name="return_loss")
	private Integer returnLoss;
	
	/** 折扣破损 */
	@Column(name="rerate_loss")
	private Integer rerateLoss;
	
	/** 实返金额 */
	@Column(name="act_return_sum")
	private Integer actReturnSum;
	
	/** 备注 */
	@Column(name="return_remarks")
	private String returnRemarks;
	
	/** 结算方式 */
	@Column(name="clear_method_key")
	private String clearMethodKey;
	
	/** 其他备注 */
	@Column(name="other_remarks")
	private String otherRemarks;
	
	/** 部门 */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="dept_id")
	private SysDept sysDept;
	
	/** 创建日期 */
	@Column(name="create_time")
	private String createTime;
	
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
	
	public Integer getReturnSum() {
		return returnSum;
	}

	public void setReturnSum(Integer returnSum) {
		this.returnSum = returnSum;
	}

	public Integer getActReturnSum() {
		return actReturnSum;
	}

	public void setActReturnSum(Integer actReturnSum) {
		this.actReturnSum = actReturnSum;
	}

	public SysDept getSysDept() {
		return sysDept;
	}

	public void setSysDept(SysDept sysDept) {
		this.sysDept = sysDept;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.returnId);
	}
}
