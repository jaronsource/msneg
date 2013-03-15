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
@Table(name="busi_stock")
public class BusiStock implements IEntity<Integer> {
	
	private static final long serialVersionUID = 964893587L;
	
	/** 库存ID */
	@Id
	@GeneratedValue
	@Column(name="stock_id")
	private Integer stockId;
	
	/** 商品ID */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="item_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private BusiItem busiItem;
	
	/** 库存数量 */
	@Column(name="stock_amount")
	private Integer stockAmount;
	
	public void setStockId(Integer stockId) {
		this.stockId = stockId;
	}
	
	public Integer getStockId() {
		return stockId;
	}
	
	public void setBusiItem(BusiItem busiItem) {
		this.busiItem = busiItem;
	}
	
	public BusiItem getBusiItem() {
		return busiItem;
	}
	
	public void setStockAmount(Integer stockAmount) {
		this.stockAmount = stockAmount;
	}
	
	public Integer getStockAmount() {
		return stockAmount;
	}
	
	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.stockId);
	}
}
