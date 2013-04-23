package org.jaronsource.msneg.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.jaronsource.msneg.dao.SysFuncDao;
import org.jaronsource.msneg.dao.SysRoleDao;
import org.jaronsource.msneg.domain.SysFunc;
import org.jaronsource.msneg.domain.SysRole;
import org.jaronsource.msneg.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.service.SearchFormSupportService;

@Service
public class SysRoleServiceImpl extends SearchFormSupportService<SysRole, Integer> implements SysRoleService {

	@Autowired
	private SysRoleDao sysRoleDao;
	
	@Autowired
	private SysFuncDao sysFuncDao;
	
	@Override
	public IDao<SysRole, Integer> getDao() {
		return sysRoleDao;
	}

	@Override
	@Transactional
	public void assignFunc(Integer roleId, Integer[] funcIds) {
		
		SysRole sysRole = getDao().findReferenceByPk(roleId);
		
		List<SysFunc> functions = new ArrayList<SysFunc>();
		for(Integer funcId : funcIds) {
			SysFunc sysFunc = sysFuncDao.findReferenceByPk(funcId);
			functions.add(sysFunc);
		}
		
		sysRole.setFunctions(functions);
		
		getDao().save(sysRole);
	}

}