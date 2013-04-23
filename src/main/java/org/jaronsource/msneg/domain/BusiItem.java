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
@Table(name="busi_item")
public class BusiItem implements IEntity<Integer> {
	
	private static final long serialVersionUID = 712913827L;
	
	/** 商品ID */
	@Id
	@GeneratedValue
	@Column(name="item_id")
	private Integer itemId;
	
	/** 名称 */
	@Column(name="item_name")
	private String itemName;
	
	/** 单位 */
	@Column(name="item_unit_key")
	private String itemUnitKey;
	
	/** 单价 */
	@Column(name="item_price")
	private Integer itemPrice;
	
	/** 助记符 */
	@Column(name="item_cnspell")
	private String itemCnspell;
	
	/** 库存数量 */
	@Column(name="item_stock_amount")
	private Integer itemStockAmount;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="cate_id")
	private BusiCategory busiCategory;
	
	public BusiItem() {}
	
	public BusiItem(Integer itemId) {
		this.itemId = itemId;
	}
	
	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}
	
	public Integer getItemId() {
		return itemId;
	}
	
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	
	public String getItemName() {
		return itemName;
	}
	
	public String getItemUnitKey() {
		return itemUnitKey;
	}

	public void setItemUnitKey(String itemUnitKey) {
		this.itemUnitKey = itemUnitKey;
	}

	public void setItemPrice(Integer itemPrice) {
		this.itemPrice = itemPrice;
	}
	
	public Integer getItemPrice() {
		return itemPrice;
	}
	
	public void setItemCnspell(String itemCnspell) {
		this.itemCnspell = itemCnspell;
	}
	
	public String getItemCnspell() {
		return itemCnspell;
	}
	
	public Integer getItemStockAmount() {
		return itemStockAmount;
	}

	public void setItemStockAmount(Integer itemStockAmount) {
		this.itemStockAmount = itemStockAmount;
	}
	
	public BusiCategory getBusiCategory() {
		return busiCategory;
	}

	public void setBusiCategory(BusiCategory busiCategory) {
		this.busiCategory = busiCategory;
	}

	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.itemId);
	}
}
