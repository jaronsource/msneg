package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.SysUserRoleDao;
import org.jaronsource.msneg.domain.SysUserRole;
import org.jaronsource.msneg.service.SysUserRoleService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class SysUserRoleServiceImpl extends SearchFormSupportService<SysUserRole, Integer> implements SysUserRoleService {

	@Autowired
	private SysUserRoleDao sysUserRoleDao;
	
	@Override
	public IDao<SysUserRole, Integer> getDao() {
		return sysUserRoleDao;
	}

}