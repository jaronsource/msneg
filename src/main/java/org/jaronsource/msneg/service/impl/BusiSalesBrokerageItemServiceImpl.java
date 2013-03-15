package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiSalesBrokerageItemDao;
import org.jaronsource.msneg.domain.BusiSalesBrokerageItem;
import org.jaronsource.msneg.service.BusiSalesBrokerageItemService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiSalesBrokerageItemServiceImpl extends SearchFormSupportService<BusiSalesBrokerageItem, Integer> implements BusiSalesBrokerageItemService {

	@Autowired
	private BusiSalesBrokerageItemDao busiSalesBrokerageItemDao;
	
	@Override
	public IDao<BusiSalesBrokerageItem, Integer> getDao() {
		return busiSalesBrokerageItemDao;
	}

}