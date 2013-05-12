package org.jaronsource.msneg.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.ccesun.framework.core.dao.support.EntityUtils;
import com.ccesun.framework.core.dao.support.IEntity;

@Entity
@Table(name="busi_category")
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
public class BusiCategory implements IEntity<Integer> {
	
	private static final long serialVersionUID = 1701372650L;
	
	/** 系列ID */
	@Id
	@GeneratedValue
	@Column(name="cate_id")
	private Integer cateId;
	
	/** 类型 */
	@Column(name="item_type_key")
	private String itemTypeKey;
	
	/** 系列名称 */
	@Column(name="cate_name")
	private String cateName;
	
	/** 商品名称 */
	@Column(name="item_name")
	private String itemName;
	
	/** 批次 */
	@Column(name="assign_num")
	private String assignNum;
	
	/**
	 * 单位
	 */
	@Column(name="item_unit_key")
	private String itemUnitKey;
	
	/** 入库原因 */
	@Column(name="stock_reason_key")
	private String stockReasonKey;
	
	/** 所在库号 */
	@Column(name="ku_num")
	private String kuNum;
	
	@Column(name="input_user")
	private String inputUser;
	
	@Column(name="item_remarks")
	private String itemRemarks;
	
	@Column(name="remarks")
	private String remarks;
	
	/** 库存 **/
	@Column(name="item_stock_amount")
	private Integer itemStockAmount;
	
	@Column(name="item_image")
	private String itemImage;
	
	@Column(name="item_small_image")
	private String itemSmallImage;
	
	@Column(name="create_time")
	private String createTime;
	
	//private String change
	
	public BusiCategory() {
	}
	
	public BusiCategory(int cateId) {
		this.cateId = cateId;
	}

	public Integer getCateId() {
		return cateId;
	}

	public void setCateId(Integer cateId) {
		this.cateId = cateId;
	}

	public String getItemTypeKey() {
		return itemTypeKey;
	}

	public void setItemTypeKey(String itemTypeKey) {
		this.itemTypeKey = itemTypeKey;
	}

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public Integer getItemStockAmount() {
		return itemStockAmount;
	}

	public void setItemStockAmount(Integer itemStockAmount) {
		this.itemStockAmount = itemStockAmount;
	}
	
	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getAssignNum() {
		return assignNum;
	}

	public void setAssignNum(String assignNum) {
		this.assignNum = assignNum;
	}

	public String getItemUnitKey() {
		return itemUnitKey;
	}

	public void setItemUnitKey(String itemUnitKey) {
		this.itemUnitKey = itemUnitKey;
	}

	public String getStockReasonKey() {
		return stockReasonKey;
	}

	public void setStockReasonKey(String stockReasonKey) {
		this.stockReasonKey = stockReasonKey;
	}

	public String getKuNum() {
		return kuNum;
	}

	public void setKuNum(String kuNum) {
		this.kuNum = kuNum;
	}

	public String getInputUser() {
		return inputUser;
	}

	public void setInputUser(String inputUser) {
		this.inputUser = inputUser;
	}

	public String getItemRemarks() {
		return itemRemarks;
	}

	public void setItemRemarks(String itemRemarks) {
		this.itemRemarks = itemRemarks;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String getItemImage() {
		return itemImage;
	}

	public void setItemImage(String itemImage) {
		this.itemImage = itemImage;
	}

	public String getItemSmallImage() {
		return itemSmallImage;
	}

	public void setItemSmallImage(String itemSmallImage) {
		this.itemSmallImage = itemSmallImage;
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
		return EntityUtils.isNew(this.cateId);
	}
}
