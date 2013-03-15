package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiClientDao;
import org.jaronsource.msneg.domain.BusiClient;
import org.jaronsource.msneg.service.BusiClientService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiClientServiceImpl extends SearchFormSupportService<BusiClient, Integer> implements BusiClientService {

	@Autowired
	private BusiClientDao busiClientDao;
	
	@Override
	public IDao<BusiClient, Integer> getDao() {
		return busiClientDao;
	}

}