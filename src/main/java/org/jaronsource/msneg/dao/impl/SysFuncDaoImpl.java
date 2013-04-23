package org.jaronsource.msneg.dao.impl;

import java.util.ArrayList;
import java.util.Collection;

import org.apache.commons.lang.math.NumberUtils;
import org.jaronsource.msneg.dao.SysFuncDao;
import org.jaronsource.msneg.domain.SysFunc;
import org.springframework.stereotype.Repository;

import com.ccesun.framework.core.dao.support.GenericDao;
import com.ccesun.framework.core.dao.support.QCriteria;
import com.ccesun.framework.core.dao.support.QCriteria.Op;
import com.ccesun.framework.plugins.security.dao.IPermissionDao;
import com.ccesun.framework.plugins.security.domain.IPermission;
import com.ccesun.framework.util.StringUtils;

@Repository
public class SysFuncDaoImpl extends GenericDao<SysFunc, Integer> implements SysFuncDao, IPermissionDao {

	@Override
	public IPermission findPermissionByCode(String code) {
		
		return findByPk(NumberUtils.toInt(code));
	}

	@Override
	public Collection<IPermission> findPermissionsByGroupCodeAndParentCode(
			String groupCode, String parentCode) {
		
		QCriteria criteria = new QCriteria();
				
		if (!StringUtils.isBlank(groupCode)) {
			criteria.addEntry("funcGroupcode", Op.EQ, groupCode);
		}
		
		if (!StringUtils.isBlank(parentCode)) {
			criteria.addEntry("parent.code", Op.EQ, parentCode);
		}
		
		return new ArrayList<IPermission>(find(criteria));
	}

}