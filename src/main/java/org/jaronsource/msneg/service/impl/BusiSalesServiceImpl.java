package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiSalesDao;
import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.service.BusiSalesService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiSalesServiceImpl extends SearchFormSupportService<BusiSales, Integer> implements BusiSalesService {

	@Autowired
	private BusiSalesDao busiSalesDao;
	
	@Override
	public IDao<BusiSales, Integer> getDao() {
		return busiSalesDao;
	}

}