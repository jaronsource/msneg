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
@Table(name="busi_sales_clear")
public class BusiSalesClear implements IEntity<Integer> {
	
	private static final long serialVersionUID = 226230940L;
	
	/** 结算单ID */
	@Id
	@GeneratedValue
	@Column(name="clear_id")
	private Integer clearId;
	
	/** 结算金额 */
	@Column(name="fee_clear")
	private Integer feeClear;
	
	/** 结算金额现金 */
	@Column(name="fee_clear_cash")
	private Integer feeClearCash;
	
	/** 结算金额刷卡 */
	@Column(name="fee_clear_card")
	private Integer feeClearCard;
	
	/** 剩余尾款 */
	@Column(name="fee_remain")
	private Integer feeRemain;
	
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
	
	/** 创建时间 */
	@Column(name="create_time")
	private String createTime;
	
	public void setClearId(Integer clearId) {
		this.clearId = clearId;
	}
	
	public Integer getClearId() {
		return clearId;
	}
	
	public void setFeeClear(Integer feeClear) {
		this.feeClear = feeClear;
	}
	
	public Integer getFeeClear() {
		return feeClear;
	}
	
	public void setFeeClearCash(Integer feeClearCash) {
		this.feeClearCash = feeClearCash;
	}
	
	public Integer getFeeClearCash() {
		return feeClearCash;
	}
	
	public void setFeeClearCard(Integer feeClearCard) {
		this.feeClearCard = feeClearCard;
	}
	
	public Integer getFeeClearCard() {
		return feeClearCard;
	}
	
	public void setFeeRemain(Integer feeRemain) {
		this.feeRemain = feeRemain;
	}
	
	public Integer getFeeRemain() {
		return feeRemain;
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
