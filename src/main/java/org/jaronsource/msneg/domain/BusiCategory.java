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
	
	/** 库存 **/
	@Column(name="item_stock_amount")
	private Integer itemStockAmount;
	
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

	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.cateId);
	}
}
