package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiSalesBrokerageDao;
import org.jaronsource.msneg.domain.BusiSalesBrokerage;
import org.jaronsource.msneg.service.BusiSalesBrokerageService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiSalesBrokerageServiceImpl extends SearchFormSupportService<BusiSalesBrokerage, Integer> implements BusiSalesBrokerageService {

	@Autowired
	private BusiSalesBrokerageDao busiSalesBrokerageDao;
	
	@Override
	public IDao<BusiSalesBrokerage, Integer> getDao() {
		return busiSalesBrokerageDao;
	}

}