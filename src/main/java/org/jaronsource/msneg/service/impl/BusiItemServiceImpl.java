package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiItemDao;
import org.jaronsource.msneg.domain.BusiItem;
import org.jaronsource.msneg.service.BusiItemService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiItemServiceImpl extends SearchFormSupportService<BusiItem, Integer> implements BusiItemService {

	@Autowired
	private BusiItemDao busiItemDao;
	
	@Override
	public IDao<BusiItem, Integer> getDao() {
		return busiItemDao;
	}

}