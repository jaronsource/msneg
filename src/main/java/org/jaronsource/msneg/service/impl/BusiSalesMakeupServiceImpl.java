package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiSalesMakeupDao;
import org.jaronsource.msneg.domain.BusiSalesMakeup;
import org.jaronsource.msneg.service.BusiSalesMakeupService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.dao.support.QCriteria;
import com.ccesun.framework.core.dao.support.QCriteria.Op;

import org.springframework.stereotype.Service;

@Service
public class BusiSalesMakeupServiceImpl extends SearchFormSupportService<BusiSalesMakeup, Integer> implements BusiSalesMakeupService {

	@Autowired
	private BusiSalesMakeupDao busiSalesMakeupDao;
	
	@Override
	public IDao<BusiSalesMakeup, Integer> getDao() {
		return busiSalesMakeupDao;
	}

	@Override
	public long countBySalesId(Integer salesId) {
		QCriteria c = new QCriteria();
		c.addEntry("busiSales.salesId", Op.EQ, salesId);
		return count(c);
	}
}