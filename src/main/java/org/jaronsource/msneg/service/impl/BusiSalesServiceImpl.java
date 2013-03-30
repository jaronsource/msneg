package org.jaronsource.msneg.service.impl;

import java.util.List;

import org.jaronsource.msneg.dao.BusiClientDao;
import org.jaronsource.msneg.dao.BusiItemDao;
import org.jaronsource.msneg.dao.BusiSalesDao;
import org.jaronsource.msneg.dao.BusiSalesItemDao;
import org.jaronsource.msneg.domain.BusiClient;
import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.domain.SysUser;
import org.jaronsource.msneg.service.BusiSalesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.dao.support.PageRequest;
import com.ccesun.framework.core.service.SearchFormSupportService;
import com.ccesun.framework.plugins.security.SecurityTokenHolder;
import com.ccesun.framework.util.BeanUtils;
import com.ccesun.framework.util.DateUtils;

@Service
public class BusiSalesServiceImpl extends SearchFormSupportService<BusiSales, Integer> implements BusiSalesService {

	@Autowired
	private BusiSalesDao busiSalesDao;
	
	@Autowired
	private BusiSalesItemDao busiSalesItemDao;

	@Autowired
	private BusiItemDao busiItemDao;
	
	@Autowired
	private BusiClientDao busiClientDao;
	
	@Override
	public IDao<BusiSales, Integer> getDao() {
		return busiSalesDao;
	}

	@Override
	public String generateSalesCode() {
		return "12N1211B017";
	}

	@Override
	@Transactional
	public void save(BusiSales busiSales, List<BusiSalesItem> busiSalesItems) {
		
		BusiClient busiClient = busiSales.getBusiClient();
		if (!busiClient.isNew()) {
			BusiClient origBusiClient = busiClientDao.findByPk(busiClient.getClientId());
			BeanUtils.mergeProperties(origBusiClient, busiClient);
			busiSales.setBusiClient(origBusiClient);
		}
		
		SysUser currentUser = (SysUser) SecurityTokenHolder.getSecurityToken().getUser();
		busiSales.setSysDept(currentUser.getDept());
		busiSales.setSysUser(currentUser);
		busiSales.setCreateTime(DateUtils.currentDateTime());
		busiSales.setSalesStateKey("A");
		save(busiSales);
		
		for (BusiSalesItem busiSalesItem : busiSalesItems) {
			
			busiSalesItem.setBusiItem(busiItemDao.findReferenceByPk(busiSalesItem.getBusiItem().getItemId()));
			busiSalesItem.setBusiSales(busiSales);
			
			busiSalesItemDao.save(busiSalesItem);
		}
		
	}

	@Override
	public List<BusiSales> findSalesBySalesCode(String term) {
		String jpql = "select o from BusiSales o inner join o.busiClient o2 where o.salesCode like ? ";
		PageRequest pageRequest = new PageRequest(1, 20);
		return getDao().find(pageRequest, jpql, '%' + term + '%');
	}

	@Override
	public List<BusiSales> findSalesByClientCellPhone(String term) {
		String jpql = "select o from BusiSales o inner join o.busiClient o2 where o2.cellPhone like ?";
		PageRequest pageRequest = new PageRequest(1, 20);
		return getDao().find(pageRequest, jpql, '%' + term + '%');
	}


}