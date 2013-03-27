package org.jaronsource.msneg.service.impl;

import java.util.List;

import org.jaronsource.msneg.dao.BusiSalesItemDao;
import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.service.BusiSalesItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.dao.support.PageRequest;
import com.ccesun.framework.core.service.SearchFormSupportService;

@Service
public class BusiSalesItemServiceImpl extends SearchFormSupportService<BusiSalesItem, Integer> implements BusiSalesItemService {

	@Autowired
	private BusiSalesItemDao busiSalesItemDao;
	
	@Override
	public IDao<BusiSalesItem, Integer> getDao() {
		return busiSalesItemDao;
	}

	@Override
	public List<BusiSalesItem> findSalesItemBySalesId(Integer salesId) {
		String jpql = "select o from BusiSalesItem o inner join fetch o.busiSales o2 where o2.salesId = ?";
		
		PageRequest pageRequest = new PageRequest(1, 20);
		return getDao().find(pageRequest, jpql, salesId);
	}

}