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
@Table(name="busi_sales_working_item")
public class BusiSalesWorkingItem implements IEntity<Integer> {
	
	private static final long serialVersionUID = 2047949131L;
	
	/** 工时单商品ID */
	@Id
	@GeneratedValue
	@Column(name="working_item_id")
	private Integer workingItemId;
	
	/** 工时单ID */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="working_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private BusiSalesWorking busiSalesWorking;
	
	/** 商品ID */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="item_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private BusiItem busiItem;
	
	/** 回访 */
	@Column(name="return_visit_key")
	private String returnVisitKey;
	
	/** 备注 */
	@Column(name="item_remarks")
	private String itemRemarks;
	
	public void setWorkingItemId(Integer workingItemId) {
		this.workingItemId = workingItemId;
	}
	
	public Integer getWorkingItemId() {
		return workingItemId;
	}
	
	public void setBusiSalesWorking(BusiSalesWorking busiSalesWorking) {
		this.busiSalesWorking = busiSalesWorking;
	}
	
	public BusiSalesWorking getBusiSalesWorking() {
		return busiSalesWorking;
	}
	
	public void setBusiItem(BusiItem busiItem) {
		this.busiItem = busiItem;
	}
	
	public BusiItem getBusiItem() {
		return busiItem;
	}
	
	public void setReturnVisitKey(String returnVisitKey) {
		this.returnVisitKey = returnVisitKey;
	}
	
	public String getReturnVisitKey() {
		return returnVisitKey;
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
		return EntityUtils.isNew(this.workingItemId);
	}
}
