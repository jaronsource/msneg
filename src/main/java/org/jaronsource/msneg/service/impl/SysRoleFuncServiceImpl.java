package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.SysRoleFuncDao;
import org.jaronsource.msneg.domain.SysRoleFunc;
import org.jaronsource.msneg.service.SysRoleFuncService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class SysRoleFuncServiceImpl extends SearchFormSupportService<SysRoleFunc, Integer> implements SysRoleFuncService {

	@Autowired
	private SysRoleFuncDao sysRoleFuncDao;
	
	@Override
	public IDao<SysRoleFunc, Integer> getDao() {
		return sysRoleFuncDao;
	}

}