package org.jaronsource.msneg.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jaronsource.msneg.dao.BusiCategoryDao;
import org.jaronsource.msneg.dao.BusiSalesDao;
import org.jaronsource.msneg.dao.BusiSalesItemDao;
import org.jaronsource.msneg.dao.BusiSalesReturnDao;
import org.jaronsource.msneg.dao.BusiSalesReturnItemDao;
import org.jaronsource.msneg.domain.BusiCategory;
import org.jaronsource.msneg.domain.BusiSales;
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
	private BusiSalesDao busiSalesDao;
	
	@Autowired
	private BusiSalesReturnItemDao busiSalesReturnItemDao;
	
	@Autowired
	private BusiSalesItemDao busiSalesItemDao;
	
	@Autowired
	private BusiCategoryDao busiCategoryDao;
	
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
		busiSalesReturn.setBillStateKey("A0");
		save(busiSalesReturn);
		
		BusiSales busiSales = busiSalesDao.findReferenceByPk(busiSalesReturn.getBusiSales().getSalesId());
		busiSales.setFinanceStateKey("A");
		busiSalesDao.save(busiSales);
		
		for (BusiSalesReturnItem busiSalesReturnItem : busiSalesReturnItems) {
			
			busiSalesReturnItem.setBusiSalesItem(
					busiSalesItemDao.findReferenceByPk(busiSalesReturnItem.getBusiSalesItem().getSalesItemId()));
			busiSalesReturnItem.setBusiSalesReturn(busiSalesReturn);
			busiSalesReturnItemDao.save(busiSalesReturnItem);
			
			// 保存库存
			BusiCategory busiCategory = new BusiCategory();
			//BusiCategory salesBusiCategory = busiSalesReturnItem.getBusiSalesItem().();
			
			busiCategory.setCateName(busiSalesReturnItem.getBusiSalesItem().getCateName());
			busiCategory.setItemStockAmount(busiSalesReturnItem.getReturnAmount());
			busiCategory.setItemTypeKey(busiSalesReturnItem.getBusiSalesItem().getItemTypeKey());
			busiCategory.setStockReasonKey("B");
			busiCategory.setItemName(busiSalesReturnItem.getBusiSalesItem().getItemName());
			busiCategory.setInputUser(busiSalesReturn.getSysUser().getUserName());
			busiCategory.setItemUnitKey(busiSalesReturnItem.getBusiSalesItem().getItemUnitKey());
			busiCategory.setCreateTime(busiSalesReturn.getCreateTime());
			
			busiCategoryDao.save(busiCategory);
		}
		
	}
	
	@Override
	public long countBySalesId(Integer salesId) {
		QCriteria c = new QCriteria();
		c.addEntry("busiSales.salesId", Op.EQ, salesId);
		return count(c);
	}

	@Override
	public Map<String, Object> statis(Integer deptId, String startTime, String endTime) {
		
		Map<String, Object> statisMap = new HashMap<String, Object>();
		
		{
			String jpql = "select count(o) from BusiSalesReturn o where o.createTime >= ? and o.createTime <= ?";
			Long count = getDao().executeQueryOne(jpql, startTime, endTime);
			count = count == null ? 0 : count;
			statisMap.put("count", count);
		}
		
		{
			String jpql = "select sum(o.returnSum) from BusiSalesReturn o where o.createTime >= ? and o.createTime <= ?";
			Double zongji = getDao().executeQueryOne(jpql, startTime, endTime);
			zongji = zongji == null ? 0 : zongji;
			statisMap.put("zongji", zongji);
		}
		
		return statisMap;
	}

	@Override
	@Transactional
	public void invalid(Integer id) {
		BusiSalesReturn busiSalesReturn = findByPk(id);
		busiSalesReturn.setBillStateKey("B");
		save(busiSalesReturn);
	}

	@Override
	public List<BusiSalesReturn> findBySalesId(Integer salesId) {
		QCriteria criteria = new QCriteria();
		criteria.addEntry("busiSales.salesId", Op.EQ, salesId);
		return getDao().find(criteria);
	}

}