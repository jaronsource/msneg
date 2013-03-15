package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiStockDao;
import org.jaronsource.msneg.domain.BusiStock;
import org.jaronsource.msneg.service.BusiStockService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiStockServiceImpl extends SearchFormSupportService<BusiStock, Integer> implements BusiStockService {

	@Autowired
	private BusiStockDao busiStockDao;
	
	@Override
	public IDao<BusiStock, Integer> getDao() {
		return busiStockDao;
	}

}