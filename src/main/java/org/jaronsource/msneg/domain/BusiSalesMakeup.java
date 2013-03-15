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
@Table(name="busi_sales_makeup")
public class BusiSalesMakeup implements IEntity<Integer> {
	
	private static final long serialVersionUID = 491694362L;
	
	/** 补价单ID */
	@Id
	@GeneratedValue
	@Column(name="makeup_id")
	private Integer makeupId;
	
	/** 补价总额 */
	@Column(name="makeup_sum")
	private Integer makeupSum;
	
	/** 经手人 */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private SysUser sysUser;
	
	/** 新增临时性损耗费用 */
	@Column(name="add_item1")
	private Integer addItem1;
	
	/** 增值服务取费 */
	@Column(name="add_item2")
	private Integer addItem2;
	
	/** 上衣托管安装（含多施工费用） */
	@Column(name="add_item3")
	private Integer addItem3;
	
	/** 变更议价补价 */
	@Column(name="add_item4")
	private Integer addItem4;
	
	/** 新增运输及商品管理费用 */
	@Column(name="add_item5")
	private Integer addItem5;
	
	/** 其他商议费用 */
	@Column(name="add_item6")
	private Integer addItem6;
	
	/** 递减临时性损耗费用 */
	@Column(name="minus_item1")
	private Integer minusItem1;
	
	/** 补退议价差额 */
	@Column(name="minus_item2")
	private Integer minusItem2;
	
	/** 递减托管安装（含少施工费用） */
	@Column(name="minus_item3")
	private Integer minusItem3;
	
	/** 遇零取整差价 */
	@Column(name="minus_item4")
	private Integer minusItem4;
	
	/** 商品瑕疵/破损议价差额 */
	@Column(name="minus_item5")
	private Integer minusItem5;
	
	/**  其他商议费用 */
	@Column(name="minus_item6")
	private Integer minusItem6;
	
	/** 补价信息备注 */
	@Column(name="makeup_remarks")
	private String makeupRemarks;
	
	/** 其他备注 */
	@Column(name="other_remarks")
	private String otherRemarks;
	
	/** 创建时间 */
	@Column(name="create_time")
	private String createTime;
	
	public void setMakeupId(Integer makeupId) {
		this.makeupId = makeupId;
	}
	
	public Integer getMakeupId() {
		return makeupId;
	}
	
	public void setMakeupSum(Integer makeupSum) {
		this.makeupSum = makeupSum;
	}
	
	public Integer getMakeupSum() {
		return makeupSum;
	}
	
	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}
	
	public SysUser getSysUser() {
		return sysUser;
	}
	
	public void setAddItem1(Integer addItem1) {
		this.addItem1 = addItem1;
	}
	
	public Integer getAddItem1() {
		return addItem1;
	}
	
	public void setAddItem2(Integer addItem2) {
		this.addItem2 = addItem2;
	}
	
	public Integer getAddItem2() {
		return addItem2;
	}
	
	public void setAddItem3(Integer addItem3) {
		this.addItem3 = addItem3;
	}
	
	public Integer getAddItem3() {
		return addItem3;
	}
	
	public void setAddItem4(Integer addItem4) {
		this.addItem4 = addItem4;
	}
	
	public Integer getAddItem4() {
		return addItem4;
	}
	
	public void setAddItem5(Integer addItem5) {
		this.addItem5 = addItem5;
	}
	
	public Integer getAddItem5() {
		return addItem5;
	}
	
	public void setAddItem6(Integer addItem6) {
		this.addItem6 = addItem6;
	}
	
	public Integer getAddItem6() {
		return addItem6;
	}
	
	public void setMinusItem1(Integer minusItem1) {
		this.minusItem1 = minusItem1;
	}
	
	public Integer getMinusItem1() {
		return minusItem1;
	}
	
	public void setMinusItem2(Integer minusItem2) {
		this.minusItem2 = minusItem2;
	}
	
	public Integer getMinusItem2() {
		return minusItem2;
	}
	
	public void setMinusItem3(Integer minusItem3) {
		this.minusItem3 = minusItem3;
	}
	
	public Integer getMinusItem3() {
		return minusItem3;
	}
	
	public void setMinusItem4(Integer minusItem4) {
		this.minusItem4 = minusItem4;
	}
	
	public Integer getMinusItem4() {
		return minusItem4;
	}
	
	public void setMinusItem5(Integer minusItem5) {
		this.minusItem5 = minusItem5;
	}
	
	public Integer getMinusItem5() {
		return minusItem5;
	}
	
	public void setMinusItem6(Integer minusItem6) {
		this.minusItem6 = minusItem6;
	}
	
	public Integer getMinusItem6() {
		return minusItem6;
	}
	
	public void setMakeupRemarks(String makeupRemarks) {
		this.makeupRemarks = makeupRemarks;
	}
	
	public String getMakeupRemarks() {
		return makeupRemarks;
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
	
	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.makeupId);
	}
}
