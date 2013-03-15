package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiSalesReturnItemDao;
import org.jaronsource.msneg.domain.BusiSalesReturnItem;
import org.jaronsource.msneg.service.BusiSalesReturnItemService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiSalesReturnItemServiceImpl extends SearchFormSupportService<BusiSalesReturnItem, Integer> implements BusiSalesReturnItemService {

	@Autowired
	private BusiSalesReturnItemDao busiSalesReturnItemDao;
	
	@Override
	public IDao<BusiSalesReturnItem, Integer> getDao() {
		return busiSalesReturnItemDao;
	}

}