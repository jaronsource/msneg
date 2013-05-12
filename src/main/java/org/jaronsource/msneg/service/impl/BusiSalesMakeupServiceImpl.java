package org.jaronsource.msneg.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jaronsource.msneg.dao.BusiSalesDao;
import org.jaronsource.msneg.dao.BusiSalesMakeupDao;
import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.domain.BusiSalesMakeup;
import org.jaronsource.msneg.service.BusiSalesMakeupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.dao.support.QCriteria;
import com.ccesun.framework.core.dao.support.QCriteria.Op;
import com.ccesun.framework.core.service.SearchFormSupportService;

@Service
public class BusiSalesMakeupServiceImpl extends SearchFormSupportService<BusiSalesMakeup, Integer> implements BusiSalesMakeupService {

	@Autowired
	private BusiSalesMakeupDao busiSalesMakeupDao;
	
	@Autowired
	private BusiSalesDao busiSalesDao;
	
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

	@Override
	public Map<String, Object> statis(Integer deptId, String startTime, String endTime) {
		
		Map<String, Object> statisMap = new HashMap<String, Object>();
		
		{
			String jpql = "select count(o) from BusiSalesMakeup o where o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Long count = getDao().executeQueryOne(jpql, startTime, endTime);
			count = count == null ? 0 : count;
			statisMap.put("count", count);
		}
		
		{
			String jpql = "select sum(o.makeupSum) from BusiSalesMakeup o where o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Double zongji = getDao().executeQueryOne(jpql, startTime, endTime);
			zongji = zongji == null ? 0 : zongji;
			statisMap.put("zongji", zongji);
		}
		
		{
			String jpql = "select sum(o.addItem1 + o.addItem2 + o.addItem3 + o.addItem4 + o.addItem5 + o.addItem6 ) from BusiSalesMakeup o where o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Double zengjia = getDao().executeQueryOne(jpql, startTime, endTime);
			zengjia = zengjia == null ? 0 : zengjia;
			statisMap.put("zengjia", zengjia);
		}
		
		{
			String jpql = "select sum(o.minusItem1 + o.minusItem2 + o.minusItem3 + o.minusItem4 + o.minusItem5 + o.minusItem6 ) from BusiSalesMakeup o where o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Double jiashao = getDao().executeQueryOne(jpql, startTime, endTime);
			jiashao = jiashao == null ? 0 : jiashao;
			statisMap.put("jiashao", jiashao);
		}
		
		return statisMap;
	}

	@Override
	@Transactional
	public void invalid(Integer id) {
		BusiSalesMakeup busiSalesMakeup = findByPk(id);
		busiSalesMakeup.setBillStateKey("B");
		save(busiSalesMakeup);
	}

	@Override
	@Transactional
	public BusiSalesMakeup save(BusiSalesMakeup target) {
		BusiSales busiSales = busiSalesDao.findReferenceByPk(target.getBusiSales().getSalesId());
		busiSales.setFinanceStateKey("A");
		busiSalesDao.save(busiSales);
		return super.save(target);
	}

	@Override
	public List<BusiSalesMakeup> findBySalesId(Integer salesId) {
		QCriteria criteria = new QCriteria();
		criteria.addEntry("busiSales.salesId", Op.EQ, salesId);
		return getDao().find(criteria);
	}
	
	
}