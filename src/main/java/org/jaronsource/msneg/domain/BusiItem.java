package org.jaronsource.msneg.domain;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.Column;
import javax.persistence.Transient;

import com.ccesun.framework.core.dao.support.IEntity;
import com.ccesun.framework.core.dao.support.EntityUtils;

@Entity
@Table(name="busi_item")
public class BusiItem implements IEntity<Integer> {
	
	private static final long serialVersionUID = 712913827L;
	
	/** 商品ID */
	@Id
	@GeneratedValue
	@Column(name="item_id")
	private Integer itemId;
	
	/** 货号 */
	@Column(name="item_code")
	private String itemCode;
	
	/** 名称 */
	@Column(name="item_name")
	private String itemName;
	
	/** 型号 */
	@Column(name="item_format")
	private String itemFormat;
	
	/** 单位 */
	@Column(name="item_unit")
	private String itemUnit;
	
	/** 单价 */
	@Column(name="item_price")
	private Integer itemPrice;
	
	/** 助记符 */
	@Column(name="item_cnspell")
	private String itemCnspell;
	
	/** 类别 */
	@Column(name="item_type_key")
	private String itemTypeKey;
	
	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}
	
	public Integer getItemId() {
		return itemId;
	}
	
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	
	public String getItemCode() {
		return itemCode;
	}
	
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	
	public String getItemName() {
		return itemName;
	}
	
	public void setItemFormat(String itemFormat) {
		this.itemFormat = itemFormat;
	}
	
	public String getItemFormat() {
		return itemFormat;
	}
	
	public void setItemUnit(String itemUnit) {
		this.itemUnit = itemUnit;
	}
	
	public String getItemUnit() {
		return itemUnit;
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
	
	public void setItemTypeKey(String itemTypeKey) {
		this.itemTypeKey = itemTypeKey;
	}
	
	public String getItemTypeKey() {
		return itemTypeKey;
	}
	
	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.itemId);
	}
}
