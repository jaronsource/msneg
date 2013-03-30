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

import com.ccesun.framework.core.annotation.DocDescription;
import com.ccesun.framework.core.dao.support.EntityUtils;
import com.ccesun.framework.core.dao.support.IEntity;

@Entity
@Table(name="busi_orders")
public class BusiOrders implements IEntity<Integer> {
	
	private static final long serialVersionUID = 1208464653L;
	
	/***/
	@DocDescription("主键")
	@Id
	@GeneratedValue
	@Column(name="orders_id")
	private Integer ordersId;
	
	/***/
	@DocDescription("定金单编号")
	@Column(name="orders_code")
	private String ordersCode;
	
	/***/
	@DocDescription("客户ID")
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="client_id")
	private BusiClient busiClient;
	
	/***/
	@DocDescription("定金类型")
	@Column(name="orders_type_keys")
	private String ordersTypeKeys;
	
	/***/
	@DocDescription("备注")
	@Column(name="orders_remarks")
	private String ordersRemarks;
	
	/***/
	@DocDescription("定金用途")
	@Column(name="orders_use_key")
	private String ordersUseKey;
	
	/***/
	@DocDescription("定金返还")
	@Column(name="orders_return_key")
	private String ordersReturnKey;
	
	/***/
	@DocDescription("总金额")
	@Column(name="orders_sum")
	private Integer ordersSum;
	
	/***/
	@DocDescription("现金")
	@Column(name="orders_cash")
	private Integer ordersCash;
	
	/***/
	@DocDescription("刷卡")
	@Column(name="orders_card")
	private Integer ordersCard;
	
	/***/
	@DocDescription("其他信息部分")
	@Column(name="other_remarks")
	private String otherRemarks;
	
	@DocDescription("定金单状态")
	@Column(name="orders_state_key")
	private String ordersStateKey;
	
	@DocDescription("部门")
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="dept_id")
	private SysDept sysDept;
	
	@DocDescription("经手人")
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id")
	private SysUser sysUser;
	
	@DocDescription("创建时间")
	@Column(name="create_time")
	private String createTime;
	
	public void setOrdersId(Integer ordersId) {
		this.ordersId = ordersId;
	}
	
	public Integer getOrdersId() {
		return ordersId;
	}
	
	public String getOrdersCode() {
		return ordersCode;
	}

	public void setOrdersCode(String ordersCode) {
		this.ordersCode = ordersCode;
	}

	public void setBusiClient(BusiClient busiClient) {
		this.busiClient = busiClient;
	}
	
	public BusiClient getBusiClient() {
		return busiClient;
	}
	
	public void setOrdersTypeKeys(String ordersTypeKeys) {
		this.ordersTypeKeys = ordersTypeKeys;
	}
	
	public String getOrdersTypeKeys() {
		return ordersTypeKeys;
	}
	
	public void setOrdersRemarks(String ordersRemarks) {
		this.ordersRemarks = ordersRemarks;
	}
	
	public String getOrdersRemarks() {
		return ordersRemarks;
	}
	
	public void setOrdersUseKey(String ordersUseKey) {
		this.ordersUseKey = ordersUseKey;
	}
	
	public String getOrdersUseKey() {
		return ordersUseKey;
	}
	
	public void setOrdersReturnKey(String ordersReturnKey) {
		this.ordersReturnKey = ordersReturnKey;
	}
	
	public String getOrdersReturnKey() {
		return ordersReturnKey;
	}
	
	public void setOrdersSum(Integer ordersSum) {
		this.ordersSum = ordersSum;
	}
	
	public Integer getOrdersSum() {
		return ordersSum;
	}
	
	public void setOrdersCash(Integer ordersCash) {
		this.ordersCash = ordersCash;
	}
	
	public Integer getOrdersCash() {
		return ordersCash;
	}
	
	public void setOrdersCard(Integer ordersCard) {
		this.ordersCard = ordersCard;
	}
	
	public Integer getOrdersCard() {
		return ordersCard;
	}
	
	public void setOtherRemarks(String otherRemarks) {
		this.otherRemarks = otherRemarks;
	}
	
	public String getOtherRemarks() {
		return otherRemarks;
	}
	
	public String getOrdersStateKey() {
		return ordersStateKey;
	}

	public void setOrdersStateKey(String ordersStateKey) {
		this.ordersStateKey = ordersStateKey;
	}

	public SysDept getSysDept() {
		return sysDept;
	}

	public void setSysDept(SysDept sysDept) {
		this.sysDept = sysDept;
	}

	public SysUser getSysUser() {
		return sysUser;
	}

	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
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
		return EntityUtils.isNew(this.ordersId);
	}
}
