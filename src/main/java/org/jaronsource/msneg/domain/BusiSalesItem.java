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
@Table(name="busi_sales_item")
public class BusiSalesItem implements IEntity<Integer> {
	
	private static final long serialVersionUID = 101368166L;
	
	/** 销售商品ID */
	@Id
	@GeneratedValue
	@Column(name="sales_item_id")
	private Integer salesItemId;
	
	/** 销售单ID */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="sales_id")
	private BusiSales busiSales;
	
	/** 商品ID */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="item_id")
	private BusiItem busiItem;
	
	/** 商品数量 */
	@Column(name="item_amount")
	private Integer itemAmount;
	
	/** 合计 */
	@Column(name="item_sum")
	private Integer itemSum;
	
	/** 信息备注 */
	@Column(name="item_remarks")
	private String itemRemarks;
	
	public BusiSalesItem() {}
	
	public BusiSalesItem(Integer salesItemId) {
		super();
		this.salesItemId = salesItemId;
	}

	public void setSalesItemId(Integer salesItemId) {
		this.salesItemId = salesItemId;
	}
	
	public Integer getSalesItemId() {
		return salesItemId;
	}
	
	public void setBusiSales(BusiSales busiSales) {
		this.busiSales = busiSales;
	}
	
	public BusiSales getBusiSales() {
		return busiSales;
	}
	
	public void setBusiItem(BusiItem busiItem) {
		this.busiItem = busiItem;
	}
	
	public BusiItem getBusiItem() {
		return busiItem;
	}
	
	public Integer getItemAmount() {
		return itemAmount;
	}

	public void setItemAmount(Integer itemAmount) {
		this.itemAmount = itemAmount;
	}

	public void setItemSum(Integer itemSum) {
		this.itemSum = itemSum;
	}
	
	public Integer getItemSum() {
		return itemSum;
	}
	
	public void setItemRemarks(String itemRemarks) {
		this.itemRemarks = itemRemarks;
	}
	
	public String getItemRemarks() {
		return itemRemarks;
	}
	
	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.salesItemId);
	}
}
