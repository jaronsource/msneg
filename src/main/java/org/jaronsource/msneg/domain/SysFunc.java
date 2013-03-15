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

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.ccesun.framework.core.dao.support.EntityUtils;
import com.ccesun.framework.core.dao.support.IEntity;
import com.ccesun.framework.plugins.security.domain.IPermission;

@Entity
@Table(name="sys_func")
public class SysFunc implements IEntity<Integer>, IPermission {
	
	private static final long serialVersionUID = 730872035L;
	
	/** 主键 */
	@Id
	@GeneratedValue
	@Column(name="func_id")
	private Integer funcId;
	
	/** 名称 */
	@Column(name="func_name")
	private String funcName;
	
	/** 地址 */
	@Column(name="func_url")
	private String funcUrl;
	
	/** 描述 */
	@Column(name="func_remarks")
	private String funcRemarks;
	
	/** 父功能 */
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="parent_id")
	@NotFound(action=NotFoundAction.IGNORE)
	private SysFunc parent;
	
	/** 功能组 */
	@Column(name="func_groupcode")
	private String funcGroupcode;
	
	/** 序号 */
	@Column(name="func_order")
	private Integer funcOrder;
	
	public void setFuncId(Integer funcId) {
		this.funcId = funcId;
	}
	
	public Integer getFuncId() {
		return funcId;
	}
	
	public void setFuncName(String funcName) {
		this.funcName = funcName;
	}
	
	public String getFuncName() {
		return funcName;
	}
	
	public void setFuncUrl(String funcUrl) {
		this.funcUrl = funcUrl;
	}
	
	public String getFuncUrl() {
		return funcUrl;
	}
	
	public void setFuncRemarks(String funcRemarks) {
		this.funcRemarks = funcRemarks;
	}
	
	public String getFuncRemarks() {
		return funcRemarks;
	}
	
	public SysFunc getParent() {
		return parent;
	}

	public void setParent(SysFunc parent) {
		this.parent = parent;
	}

	public void setFuncGroupcode(String funcGroupcode) {
		this.funcGroupcode = funcGroupcode;
	}
	
	public String getFuncGroupcode() {
		return funcGroupcode;
	}
	
	public void setFuncOrder(Integer funcOrder) {
		this.funcOrder = funcOrder;
	}
	
	public Integer getFuncOrder() {
		return funcOrder;
	}
	
	@Override
	@Transient
	public boolean isNew() {
		return EntityUtils.isNew(this.funcId);
	}

	@Override
	public String getCode() {
		return funcId == null ? null : funcId.toString();
	}

	@Override
	public String getName() {
		return funcName;
	}

	@Override
	public String getGroupCode() {
		return funcGroupcode;
	}

	@Override
	public String getParentCode() {
		return parent == null ? null : parent.getCode();
	}

	@Override
	public String getUrl() {
		return funcUrl;
	}

	@Override
	public Integer getOrder() {
		return funcOrder;
	}

	@Override
	public Boolean getReadable() {
		return true;
	}

	@Override
	public Boolean getEditable() {
		return true;
	}
}
