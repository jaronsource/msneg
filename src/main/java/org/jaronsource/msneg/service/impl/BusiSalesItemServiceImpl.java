package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiSalesItemDao;
import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.service.BusiSalesItemService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiSalesItemServiceImpl extends SearchFormSupportService<BusiSalesItem, Integer> implements BusiSalesItemService {

	@Autowired
	private BusiSalesItemDao busiSalesItemDao;
	
	@Override
	public IDao<BusiSalesItem, Integer> getDao() {
		return busiSalesItemDao;
	}

}