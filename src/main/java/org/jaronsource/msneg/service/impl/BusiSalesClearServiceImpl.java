package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.BusiSalesClearDao;
import org.jaronsource.msneg.dao.BusiSalesDao;
import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.domain.BusiSalesClear;
import org.jaronsource.msneg.service.BusiSalesClearService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.dao.support.QCriteria;
import com.ccesun.framework.core.dao.support.QCriteria.Op;
import com.ccesun.framework.core.service.SearchFormSupportService;

@Service
public class BusiSalesClearServiceImpl extends SearchFormSupportService<BusiSalesClear, Integer> implements BusiSalesClearService {

	@Autowired
	private BusiSalesClearDao busiSalesClearDao;
	
	@Autowired
	private BusiSalesDao busiSalesDao;
	
	@Override
	public IDao<BusiSalesClear, Integer> getDao() {
		return busiSalesClearDao;
	}

	@Override
	@Transactional
	public BusiSalesClear save(BusiSalesClear target) {
		BusiSales busiSales = busiSalesDao.findReferenceByPk(target.getBusiSales().getSalesId());
		busiSales.setSalesStateKey("B");
		busiSalesDao.save(busiSales);
		
		return super.save(target);
	}

	@Override
	public long countBySalesId(Integer salesId) {
		QCriteria c = new QCriteria();
		c.addEntry("busiSales.salesId", Op.EQ, salesId);
		return count(c);
	}


}