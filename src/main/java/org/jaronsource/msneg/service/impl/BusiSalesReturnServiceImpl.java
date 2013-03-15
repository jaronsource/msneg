package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiSalesReturnDao;
import org.jaronsource.msneg.domain.BusiSalesReturn;
import org.jaronsource.msneg.service.BusiSalesReturnService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiSalesReturnServiceImpl extends SearchFormSupportService<BusiSalesReturn, Integer> implements BusiSalesReturnService {

	@Autowired
	private BusiSalesReturnDao busiSalesReturnDao;
	
	@Override
	public IDao<BusiSalesReturn, Integer> getDao() {
		return busiSalesReturnDao;
	}

}