package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.SysDictDao;
import org.jaronsource.msneg.domain.SysDict;
import org.jaronsource.msneg.service.SysDictService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class SysDictServiceImpl extends SearchFormSupportService<SysDict, Integer> implements SysDictService {

	@Autowired
	private SysDictDao sysDictDao;
	
	@Override
	public IDao<SysDict, Integer> getDao() {
		return sysDictDao;
	}

}