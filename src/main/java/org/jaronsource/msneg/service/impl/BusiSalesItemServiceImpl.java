package org.jaronsource.msneg.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.jaronsource.msneg.dao.BusiSalesDao;
import org.jaronsource.msneg.dao.BusiSalesItemDao;
import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.service.BusiSalesItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.dao.support.PageRequest;
import com.ccesun.framework.core.service.SearchFormSupportService;

@Service
public class BusiSalesItemServiceImpl extends SearchFormSupportService<BusiSalesItem, Integer> implements BusiSalesItemService {

	@Autowired
	private BusiSalesItemDao busiSalesItemDao;
	
	@Autowired
	private BusiSalesDao busiSalesDao;
	
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

	@Override
	@Transactional
	public void changeState(Integer salesItemId, String state) {
		
		BusiSalesItem busiSalesItem = busiSalesItemDao.findByPk(salesItemId);
		busiSalesItem.setAssignStateKey(state);
		getDao().save(busiSalesItem);
		
		Integer salesId = busiSalesItem.getBusiSales().getSalesId();
		String jpql = "select min(o.assignStateKey) from BusiSalesItem o where o.busiSales.salesId = ?";
		String assignStateKey = getDao().executeQueryOne(jpql, salesId);
		
		BusiSales busiSales = busiSalesDao.findByPk(salesId);
		if (busiSales != null) {
			if (StringUtils.equals(busiSales.getSalesStateKey(), assignStateKey)) 
				busiSales.setSalesStateKey(assignStateKey);
			
		}
		
	}

}