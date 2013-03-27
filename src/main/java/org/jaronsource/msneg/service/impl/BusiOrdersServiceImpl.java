package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiOrdersDao;
import org.jaronsource.msneg.domain.BusiOrders;
import org.jaronsource.msneg.service.BusiOrdersService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiOrdersServiceImpl extends SearchFormSupportService<BusiOrders, Integer> implements BusiOrdersService {

	@Autowired
	private BusiOrdersDao busiOrdersDao;
	
	@Override
	public IDao<BusiOrders, Integer> getDao() {
		return busiOrdersDao;
	}

}