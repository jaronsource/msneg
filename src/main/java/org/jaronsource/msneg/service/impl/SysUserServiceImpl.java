package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.SysUserDao;
import org.jaronsource.msneg.domain.SysUser;
import org.jaronsource.msneg.service.SysUserService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class SysUserServiceImpl extends SearchFormSupportService<SysUser, Integer> implements SysUserService {

	@Autowired
	private SysUserDao sysUserDao;
	
	@Override
	public IDao<SysUser, Integer> getDao() {
		return sysUserDao;
	}

}