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
@Table(name="busi_sales_brokerage_item")
public class BusiSalesBrokerageItem implements IEntity<Integer> {
	
	private static final long serialVersionUID = 1018285781L;
	
	/** 提成商品ID */
	@Id
	@GeneratedValue
	@Column(name="brok_item_id")
	private Integer brokItemId;
	
	/** 提成单ID */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="brok_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private BusiSalesBrokerage busiSalesBrokerage;
	
	/** 商品ID */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="item_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private BusiItem busiItem;
	
	/** 返销 */
	@Column(name="brok_return")
	private Integer brokReturn;
	
	/** 安装 */
	@Column(name="brok_install")
	private Integer brokInstall;
	
	/** 辅差 */
	@Column(name="brok_makeup")
	private Integer brokMakeup;
	
	/** 比率 */
	@Column(name="brok_ratio")
	private Integer brokRatio;
	
	/** 净价 */
	@Column(name="brok_mere_price")
	private Integer brokMerePrice;
	
	/** 净量 */
	@Column(name="brok_mere_amount")
	private Integer brokMereAmount;
	
	/** 提成合计 */
	@Column(name="brok_sum")
	private Integer brokSum;
	
	public void setBrokItemId(Integer brokItemId) {
		this.brokItemId = brokItemId;
	}
	
	public Integer getBrokItemId() {
		return brokItemId;
	}
	
	public void setBusiSalesBrokerage(BusiSalesBrokerage busiSalesBrokerage) {
		this.busiSalesBrokerage = busiSalesBrokerage;
	}
	
	public BusiSalesBrokerage getBusiSalesBrokerage() {
		return busiSalesBrokerage;
	}
	
	public void setBusiItem(BusiItem busiItem) {
		this.busiItem = busiItem;
	}
	
	public BusiItem getBusiItem() {
		return busiItem;
	}
	
	public void setBrokReturn(Integer brokReturn) {
		this.brokReturn = brokReturn;
	}
	
	public Integer getBrokReturn() {
		return brokReturn;
	}
	
	public void setBrokInstall(Integer brokInstall) {
		this.brokInstall = brokInstall;
	}
	
	public Integer getBrokInstall() {
		return brokInstall;
	}
	
	public void setBrokMakeup(Integer brokMakeup) {
		this.brokMakeup = brokMakeup;
	}
	
	public Integer getBrokMakeup() {
		return brokMakeup;
	}
	
	public void setBrokRatio(Integer brokRatio) {
		this.brokRatio = brokRatio;
	}
	
	public Integer getBrokRatio() {
		return brokRatio;
	}
	
	public void setBrokMerePrice(Integer brokMerePrice) {
		this.brokMerePrice = brokMerePrice;
	}
	
	public Integer getBrokMerePrice() {
		return brokMerePrice;
	}
	
	public void setBrokMereAmount(Integer brokMereAmount) {
		this.brokMereAmount = brokMereAmount;
	}
	
	public Integer getBrokMereAmount() {
		return brokMereAmount;
	}
	
	public void setBrokSum(Integer brokSum) {
		this.brokSum = brokSum;
	}
	
	public Integer getBrokSum() {
		return brokSum;
	}
	
	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.brokItemId);
	}
}
