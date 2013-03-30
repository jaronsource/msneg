package org.jaronsource.msneg.service.impl;

import java.util.List;

import org.jaronsource.msneg.dao.BusiSalesItemDao;
import org.jaronsource.msneg.dao.BusiSalesReturnDao;
import org.jaronsource.msneg.dao.BusiSalesReturnItemDao;
import org.jaronsource.msneg.domain.BusiSalesReturn;
import org.jaronsource.msneg.domain.BusiSalesReturnItem;
import org.jaronsource.msneg.domain.SysUser;
import org.jaronsource.msneg.service.BusiSalesReturnService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.dao.support.QCriteria;
import com.ccesun.framework.core.dao.support.QCriteria.Op;
import com.ccesun.framework.core.service.SearchFormSupportService;
import com.ccesun.framework.plugins.security.SecurityTokenHolder;
import com.ccesun.framework.util.DateUtils;

@Service
public class BusiSalesReturnServiceImpl extends SearchFormSupportService<BusiSalesReturn, Integer> implements BusiSalesReturnService {

	@Autowired
	private BusiSalesReturnDao busiSalesReturnDao;
	
	@Autowired
	private BusiSalesReturnItemDao busiSalesReturnItemDao;
	
	@Autowired
	private BusiSalesItemDao busiSalesItemDao;
	
	@Override
	public IDao<BusiSalesReturn, Integer> getDao() {
		return busiSalesReturnDao;
	}

	@Override
	@Transactional
	public void save(BusiSalesReturn busiSalesReturn, List<BusiSalesReturnItem> busiSalesReturnItems) {
		
		SysUser currentUser = (SysUser) SecurityTokenHolder.getSecurityToken().getUser();
		busiSalesReturn.setSysDept(currentUser.getDept());
		busiSalesReturn.setSysUser(currentUser);
		busiSalesReturn.setCreateTime(DateUtils.currentDateTime());
		save(busiSalesReturn);
		
		for (BusiSalesReturnItem busiSalesReturnItem : busiSalesReturnItems) {
			
			busiSalesReturnItem.setBusiSalesItem(
					busiSalesItemDao.findReferenceByPk(busiSalesReturnItem.getBusiSalesItem().getSalesItemId()));
			busiSalesReturnItem.setBusiSalesReturn(busiSalesReturn);
			busiSalesReturnItemDao.save(busiSalesReturnItem);
		}
		
	}
	
	@Override
	public long countBySalesId(Integer salesId) {
		QCriteria c = new QCriteria();
		c.addEntry("busiSales.salesId", Op.EQ, salesId);
		return count(c);
	}

}