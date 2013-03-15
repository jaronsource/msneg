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
@Table(name="busi_sales_working")
public class BusiSalesWorking implements IEntity<Integer> {
	
	private static final long serialVersionUID = 1009255989L;
	
	/** 工时单ID */
	@Id
	@GeneratedValue
	@Column(name="working_id")
	private Integer workingId;
	
	/** 其他项目名称 */
	@Column(name="other_item_name")
	private String otherItemName;
	
	/** 其他项目单价 */
	@Column(name="other_item_price")
	private Integer otherItemPrice;
	
	/** 其他项目数量 */
	@Column(name="other_item_amount")
	private Integer otherItemAmount;
	
	/** 其他项目合计 */
	@Column(name="other_item_sum")
	private Integer otherItemSum;
	
	/** 项目备注 */
	@Column(name="other_item_remarks")
	private String otherItemRemarks;
	
	/** 工时总额 */
	@Column(name="fee_sum")
	private Integer feeSum;
	
	/** 结算形式 */
	@Column(name="clear_method_key")
	private String clearMethodKey;
	
	/** 安装部门 */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="install_dept_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private SysDept sysDept;
	
	/**  */
	@Column(name="other_remarks")
	private String otherRemarks;
	
	/** 创建时间 */
	@Column(name="create_time")
	private String createTime;
	
	/** 经手人 */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private SysUser sysUser;
	
	public void setWorkingId(Integer workingId) {
		this.workingId = workingId;
	}
	
	public Integer getWorkingId() {
		return workingId;
	}
	
	public void setOtherItemName(String otherItemName) {
		this.otherItemName = otherItemName;
	}
	
	public String getOtherItemName() {
		return otherItemName;
	}
	
	public void setOtherItemPrice(Integer otherItemPrice) {
		this.otherItemPrice = otherItemPrice;
	}
	
	public Integer getOtherItemPrice() {
		return otherItemPrice;
	}
	
	public void setOtherItemAmount(Integer otherItemAmount) {
		this.otherItemAmount = otherItemAmount;
	}
	
	public Integer getOtherItemAmount() {
		return otherItemAmount;
	}
	
	public void setOtherItemSum(Integer otherItemSum) {
		this.otherItemSum = otherItemSum;
	}
	
	public Integer getOtherItemSum() {
		return otherItemSum;
	}
	
	public void setOtherItemRemarks(String otherItemRemarks) {
		this.otherItemRemarks = otherItemRemarks;
	}
	
	public String getOtherItemRemarks() {
		return otherItemRemarks;
	}
	
	public void setFeeSum(Integer feeSum) {
		this.feeSum = feeSum;
	}
	
	public Integer getFeeSum() {
		return feeSum;
	}
	
	public void setClearMethodKey(String clearMethodKey) {
		this.clearMethodKey = clearMethodKey;
	}
	
	public String getClearMethodKey() {
		return clearMethodKey;
	}
	
	public void setSysDept(SysDept sysDept) {
		this.sysDept = sysDept;
	}
	
	public SysDept getSysDept() {
		return sysDept;
	}
	
	public void setOtherRemarks(String otherRemarks) {
		this.otherRemarks = otherRemarks;
	}
	
	public String getOtherRemarks() {
		return otherRemarks;
	}
	
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	public String getCreateTime() {
		return createTime;
	}
	
	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}
	
	public SysUser getSysUser() {
		return sysUser;
	}
	
	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.workingId);
	}
}
