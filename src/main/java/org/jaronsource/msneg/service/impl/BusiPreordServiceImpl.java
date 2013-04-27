package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiPreordDao;
import org.jaronsource.msneg.domain.BusiPreord;
import org.jaronsource.msneg.service.BusiPreordService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiPreordServiceImpl extends SearchFormSupportService<BusiPreord, Integer> implements BusiPreordService {

	@Autowired
	private BusiPreordDao busiPreordDao;
	
	@Override
	public IDao<BusiPreord, Integer> getDao() {
		return busiPreordDao;
	}

}