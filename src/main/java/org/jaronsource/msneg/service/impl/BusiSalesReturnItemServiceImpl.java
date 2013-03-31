package org.jaronsource.msneg.service.impl;

import java.util.List;

import org.jaronsource.msneg.dao.BusiSalesReturnItemDao;
import org.jaronsource.msneg.domain.BusiSalesReturnItem;
import org.jaronsource.msneg.service.BusiSalesReturnItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.dao.support.QCriteria;
import com.ccesun.framework.core.dao.support.QCriteria.Op;
import com.ccesun.framework.core.service.SearchFormSupportService;

@Service
public class BusiSalesReturnItemServiceImpl extends SearchFormSupportService<BusiSalesReturnItem, Integer> implements BusiSalesReturnItemService {

	@Autowired
	private BusiSalesReturnItemDao busiSalesReturnItemDao;
	
	@Override
	public IDao<BusiSalesReturnItem, Integer> getDao() {
		return busiSalesReturnItemDao;
	}

	@Override
	public List<BusiSalesReturnItem> findBusiSalesReturnItemByReturnId(Integer returnId) {
		QCriteria criteria = new QCriteria();
		criteria.addEntry("busiSalesReturn.returnId", Op.EQ, returnId);
		
		return getDao().find(criteria);
	}

}