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
@Table(name="busi_sales_return_item")
public class BusiSalesReturnItem implements IEntity<Integer> {
	
	private static final long serialVersionUID = 2062850993L;
	
	/** 返销商品ID */
	@Id
	@GeneratedValue
	@Column(name="return_item_id")
	private Integer returnItemId;
	
	/** 返销单ID */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="return_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private BusiSalesReturn busiSalesReturn;
	
	/** 商品ID */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="item_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private BusiItem busiItem;
	
	/** 返销单价 */
	@Column(name="return_price")
	private Integer returnPrice;
	
	/** 返销数量 */
	@Column(name="return_amount")
	private Integer returnAmount;
	
	/** 返销合计 */
	@Column(name="return_sum")
	private Integer returnSum;
	
	/** 返销事由 */
	@Column(name="return_reason_key")
	private String returnReasonKey;
	
	/** 备注 */
	@Column(name="return_remarks")
	private String returnRemarks;
	
	public void setReturnItemId(Integer returnItemId) {
		this.returnItemId = returnItemId;
	}
	
	public Integer getReturnItemId() {
		return returnItemId;
	}
	
	public void setBusiSalesReturn(BusiSalesReturn busiSalesReturn) {
		this.busiSalesReturn = busiSalesReturn;
	}
	
	public BusiSalesReturn getBusiSalesReturn() {
		return busiSalesReturn;
	}
	
	public void setBusiItem(BusiItem busiItem) {
		this.busiItem = busiItem;
	}
	
	public BusiItem getBusiItem() {
		return busiItem;
	}
	
	public void setReturnPrice(Integer returnPrice) {
		this.returnPrice = returnPrice;
	}
	
	public Integer getReturnPrice() {
		return returnPrice;
	}
	
	public void setReturnAmount(Integer returnAmount) {
		this.returnAmount = returnAmount;
	}
	
	public Integer getReturnAmount() {
		return returnAmount;
	}
	
	public void setReturnSum(Integer returnSum) {
		this.returnSum = returnSum;
	}
	
	public Integer getReturnSum() {
		return returnSum;
	}
	
	public void setReturnReasonKey(String returnReasonKey) {
		this.returnReasonKey = returnReasonKey;
	}
	
	public String getReturnReasonKey() {
		return returnReasonKey;
	}
	
	public void setReturnRemarks(String returnRemarks) {
		this.returnRemarks = returnRemarks;
	}
	
	public String getReturnRemarks() {
		return returnRemarks;
	}
	
	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.returnItemId);
	}
}
