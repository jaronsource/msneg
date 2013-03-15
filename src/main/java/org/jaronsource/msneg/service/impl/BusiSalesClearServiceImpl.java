package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiSalesClearDao;
import org.jaronsource.msneg.domain.BusiSalesClear;
import org.jaronsource.msneg.service.BusiSalesClearService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiSalesClearServiceImpl extends SearchFormSupportService<BusiSalesClear, Integer> implements BusiSalesClearService {

	@Autowired
	private BusiSalesClearDao busiSalesClearDao;
	
	@Override
	public IDao<BusiSalesClear, Integer> getDao() {
		return busiSalesClearDao;
	}

}