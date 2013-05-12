package org.jaronsource.msneg.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.ccesun.framework.core.annotation.DocDescription;
import com.ccesun.framework.core.dao.support.EntityUtils;
import com.ccesun.framework.core.dao.support.IEntity;

@Entity
@Table(name="busi_preord")
public class BusiPreord implements IEntity<Integer> {
	
	private static final long serialVersionUID = 1229185252L;
	
	/***/
	@DocDescription("")
	@Id
	@GeneratedValue
	@Column(name="preord_id")
	private Integer preordId;
	
	/***/
	@DocDescription("报备人姓名")
	@Column(name="preord_person")
	private String preordPerson;
	
	/***/
	@DocDescription("报备人电话")
	@Column(name="preord_person_phone")
	private String preordPersonPhone;
	
	/***/
	@Column(name="preord_person_company")
	private String preordPersonCompay;
	
	/***/
	@DocDescription("客户姓名")
	@Column(name="client_name")
	private String clientName;
	
	/***/
	@DocDescription("客户电话")
	@Column(name="client_cellphone")
	private String clientCellphone;
	
	/***/
	@DocDescription("客户地址")
	@Column(name="client_address")
	private String clientAddress;
	
	/***/
	@DocDescription("备注")
	@Column(name="remarks")
	private String remarks;
	
	/***/
	@DocDescription("创建时间")
	@Column(name="create_time")
	private String createTime;
	
	/***/
	@DocDescription("状态")
	@Column(name="preord_state_key")
	private String preordStateKey;
	
	@Column(name="input_user")
	private String inputUser;
	
	@Column(name="check_user")
	private String checkUser;
	
	public void setPreordId(Integer preordId) {
		this.preordId = preordId;
	}
	
	public Integer getPreordId() {
		return preordId;
	}
	
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	
	public String getClientName() {
		return clientName;
	}
	
	public String getClientCellphone() {
		return clientCellphone;
	}

	public void setClientCellphone(String clientCellphone) {
		this.clientCellphone = clientCellphone;
	}

	public void setPreordPerson(String preordPerson) {
		this.preordPerson = preordPerson;
	}
	
	public String getPreordPerson() {
		return preordPerson;
	}
	
	public void setPreordPersonPhone(String preordPersonPhone) {
		this.preordPersonPhone = preordPersonPhone;
	}
	
	public String getPreordPersonPhone() {
		return preordPersonPhone;
	}
	
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String getRemarks() {
		return remarks;
	}
	
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	public String getCreateTime() {
		return createTime;
	}
	
	public void setPreordStateKey(String preordStateKey) {
		this.preordStateKey = preordStateKey;
	}
	
	public String getPreordStateKey() {
		return preordStateKey;
	}
	
	public String getClientAddress() {
		return clientAddress;
	}

	public void setClientAddress(String clientAddress) {
		this.clientAddress = clientAddress;
	}

	public String getPreordPersonCompay() {
		return preordPersonCompay;
	}

	public void setPreordPersonCompay(String preordPersonCompay) {
		this.preordPersonCompay = preordPersonCompay;
	}

	public String getInputUser() {
		return inputUser;
	}

	public void setInputUser(String inputUser) {
		this.inputUser = inputUser;
	}

	public String getCheckUser() {
		return checkUser;
	}

	public void setCheckUser(String checkUser) {
		this.checkUser = checkUser;
	}

	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.preordId);
	}
}
