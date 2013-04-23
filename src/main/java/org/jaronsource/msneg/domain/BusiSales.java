package org.jaronsource.msneg.domain;

import javax.persistence.CascadeType;
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
@Table(name="busi_sales")
public class BusiSales implements IEntity<Integer> {
	
	private static final long serialVersionUID = 1701372650L;
	
	/** 销售单ID */
	@Id
	@GeneratedValue
	@Column(name="sales_id")
	private Integer salesId;
	
	/** 编码 */
	@Column(name="sales_code")
	private String salesCode;
	
	/** 销售部门 */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="dept_id")
	private SysDept sysDept;
	
	/** 经手人 */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id")
	private SysUser sysUser;
	
	/** 创建时间 */
	@Column(name="create_time")
	private String createTime;
	
	/** 备注 */
	@Column(name="sales_remarks")
	private String salesRemarks;
	
	/** 销售单类型 */
	@Column(name="sales_type_key")
	private String salesTypeKey;
	
	/** 客户 */
	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.PERSIST)
	@JoinColumn(name="client_id")
	private BusiClient busiClient;
	
	/** 状态 */
	@Column(name="sales_state_key")
	private String salesStateKey;
	
	/** 物流信息 */
	@Column(name="serv_logis_key")
	private String servLogisKey;
	
	/** 取货方式 */
	@Column(name="serv_getmethod_key")
	private String servGetmethodKey;
	
	/** 安装方式 */
	@Column(name="serv_installmethod_key")
	private String servInstallmethodKey;
	
	/** 总金额 */
	@Column(name="fee_sum")
	private Float feeSum;
	
	/** 预付金额 */
	@Column(name="fee_prepay")
	private Float feePrepay;
	
	/** 预付金现金 */
	@Column(name="fee_prepay_cash")
	private Float feePrepayCash;
	
	/** 预付金刷卡 */
	@Column(name="fee_prepay_card")
	private Float feePrepayCard;
	
	/** 剩余尾款 */
	@Column(name="fee_remain")
	private Float feeRemain;
	
	/** 其他备注 */
	@Column(name="other_remarks")
	private String otherRemarks;
	
	/** 合同条款 */
	@Column(name="sales_contract")
	private String salesContract;
	
	/** 单据状态 */
	@Column(name="bill_state_key")
	private String billStateKey;
	
	public void setSalesId(Integer salesId) {
		this.salesId = salesId;
	}
	
	public Integer getSalesId() {
		return salesId;
	}
	
	public void setSalesCode(String salesCode) {
		this.salesCode = salesCode;
	}
	
	public String getSalesCode() {
		return salesCode;
	}
	
	public void setSysDept(SysDept sysDept) {
		this.sysDept = sysDept;
	}
	
	public SysDept getSysDept() {
		return sysDept;
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
	
	public void setSalesRemarks(String salesRemarks) {
		this.salesRemarks = salesRemarks;
	}
	
	public String getSalesRemarks() {
		return salesRemarks;
	}
	
	public void setSalesTypeKey(String salesTypeKey) {
		this.salesTypeKey = salesTypeKey;
	}
	
	public String getSalesTypeKey() {
		return salesTypeKey;
	}
	
	public void setBusiClient(BusiClient busiClient) {
		this.busiClient = busiClient;
	}
	
	public BusiClient getBusiClient() {
		return busiClient;
	}
	
	public void setSalesStateKey(String salesStateKey) {
		this.salesStateKey = salesStateKey;
	}
	
	public String getSalesStateKey() {
		return salesStateKey;
	}
	
	public void setServLogisKey(String servLogisKey) {
		this.servLogisKey = servLogisKey;
	}
	
	public String getServLogisKey() {
		return servLogisKey;
	}
	
	public void setServGetmethodKey(String servGetmethodKey) {
		this.servGetmethodKey = servGetmethodKey;
	}
	
	public String getServGetmethodKey() {
		return servGetmethodKey;
	}
	
	public void setServInstallmethodKey(String servInstallmethodKey) {
		this.servInstallmethodKey = servInstallmethodKey;
	}
	
	public String getServInstallmethodKey() {
		return servInstallmethodKey;
	}
	
	public void setOtherRemarks(String otherRemarks) {
		this.otherRemarks = otherRemarks;
	}
	
	public String getOtherRemarks() {
		return otherRemarks;
	}
	
	public void setSalesContract(String salesContract) {
		this.salesContract = salesContract;
	}
	
	public String getSalesContract() {
		return salesContract;
	}
	
	public Float getFeeSum() {
		return feeSum;
	}

	public void setFeeSum(Float feeSum) {
		this.feeSum = feeSum;
	}

	public Float getFeePrepay() {
		return feePrepay;
	}

	public void setFeePrepay(Float feePrepay) {
		this.feePrepay = feePrepay;
	}

	public Float getFeePrepayCash() {
		return feePrepayCash;
	}

	public void setFeePrepayCash(Float feePrepayCash) {
		this.feePrepayCash = feePrepayCash;
	}

	public Float getFeePrepayCard() {
		return feePrepayCard;
	}

	public void setFeePrepayCard(Float feePrepayCard) {
		this.feePrepayCard = feePrepayCard;
	}

	public Float getFeeRemain() {
		return feeRemain;
	}

	public void setFeeRemain(Float feeRemain) {
		this.feeRemain = feeRemain;
	}

	public String getBillStateKey() {
		return billStateKey;
	}

	public void setBillStateKey(String billStateKey) {
		this.billStateKey = billStateKey;
	}

	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.salesId);
	}
}
