package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiSalesWorkingItemDao;
import org.jaronsource.msneg.domain.BusiSalesWorkingItem;
import org.jaronsource.msneg.service.BusiSalesWorkingItemService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiSalesWorkingItemServiceImpl extends SearchFormSupportService<BusiSalesWorkingItem, Integer> implements BusiSalesWorkingItemService {

	@Autowired
	private BusiSalesWorkingItemDao busiSalesWorkingItemDao;
	
	@Override
	public IDao<BusiSalesWorkingItem, Integer> getDao() {
		return busiSalesWorkingItemDao;
	}

}