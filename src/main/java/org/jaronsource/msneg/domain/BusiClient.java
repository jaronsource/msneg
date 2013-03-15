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
@Table(name="busi_client")
public class BusiClient implements IEntity<Integer> {
	
	private static final long serialVersionUID = 1389384263L;
	
	/** 客户ID */
	@Id
	@GeneratedValue
	@Column(name="client_id")
	private Integer clientId;
	
	/** 客户姓名 */
	@Column(name="client_name")
	private String clientName;
	
	/** 电话 */
	@Column(name="phone")
	private String phone;
	
	/** 手机 */
	@Column(name="cell_phone")
	private String cellPhone;
	
	/** 地址 */
	@Column(name="address")
	private String address;
	
	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}
	
	public Integer getClientId() {
		return clientId;
	}
	
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	
	public String getClientName() {
		return clientName;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}
	
	public String getCellPhone() {
		return cellPhone;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getAddress() {
		return address;
	}
	
	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.clientId);
	}
}
