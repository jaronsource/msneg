package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiSalesWorkingDao;
import org.jaronsource.msneg.domain.BusiSalesWorking;
import org.jaronsource.msneg.service.BusiSalesWorkingService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiSalesWorkingServiceImpl extends SearchFormSupportService<BusiSalesWorking, Integer> implements BusiSalesWorkingService {

	@Autowired
	private BusiSalesWorkingDao busiSalesWorkingDao;
	
	@Override
	public IDao<BusiSalesWorking, Integer> getDao() {
		return busiSalesWorkingDao;
	}

}