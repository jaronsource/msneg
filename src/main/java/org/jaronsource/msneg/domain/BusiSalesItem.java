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
	
	/** 商品数量 */
	@Column(name="item_amount")
	private Integer itemAmount;
	
	/** 合计 */
	@Column(name="item_sum")
	private Float itemSum;
	
	/** 信息备注 */
	@Column(name="item_remarks")
	private String itemRemarks;
	
	/** 名称 */
	@Column(name="item_name")
	private String itemName;
	
	/** 单位 */
	@Column(name="item_unit_key")
	private String itemUnitKey;
	
	/** 单价 */
	@Column(name="item_price")
	private Float itemPrice;
	
	/** 备货状态 */
	@Column(name="assign_state_key")
	private String assignStateKey;
	
	//@ManyToOne(fetch=FetchType.LAZY)
	//@JoinColumn(name="cate_id")
	//private BusiCategory busiCategory;
	
	@Column(name="item_type_key")
	private String itemTypeKey;
	
	@Column(name="cate_name")
	private String cateName;
	
	/**
	 * 到货批次号
	 */
	@Column(name="assign_num")
	private String assignNum;
	
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
	
	public Integer getItemAmount() {
		return itemAmount;
	}

	public void setItemAmount(Integer itemAmount) {
		this.itemAmount = itemAmount;
	}

	public Float getItemSum() {
		return itemSum;
	}

	public void setItemSum(Float itemSum) {
		this.itemSum = itemSum;
	}

	public void setItemRemarks(String itemRemarks) {
		this.itemRemarks = itemRemarks;
	}
	
	public String getItemRemarks() {
		return itemRemarks;
	}
	
	public String getItemUnitKey() {
		return itemUnitKey;
	}

	public void setItemUnitKey(String itemUnitKey) {
		this.itemUnitKey = itemUnitKey;
	}

	public Float getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(Float itemPrice) {
		this.itemPrice = itemPrice;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	
	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public String getAssignStateKey() {
		return assignStateKey;
	}

	public void setAssignStateKey(String assignStateKey) {
		this.assignStateKey = assignStateKey;
	}

	public String getAssignNum() {
		return assignNum;
	}

	public void setAssignNum(String assignNum) {
		this.assignNum = assignNum;
	}

	public String getItemTypeKey() {
		return itemTypeKey;
	}

	public void setItemTypeKey(String itemTypeKey) {
		this.itemTypeKey = itemTypeKey;
	}

	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.salesItemId);
	}
}
