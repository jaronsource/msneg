package org.jaronsource.msneg.service.impl;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.jaronsource.msneg.dao.BusiClientDao;
import org.jaronsource.msneg.dao.BusiSalesClearDao;
import org.jaronsource.msneg.dao.BusiSalesDao;
import org.jaronsource.msneg.dao.BusiSalesItemDao;
import org.jaronsource.msneg.dao.BusiSalesMakeupDao;
import org.jaronsource.msneg.dao.BusiSalesReturnDao;
import org.jaronsource.msneg.domain.BusiClient;
import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.domain.BusiSalesClear;
import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.domain.BusiSalesMakeup;
import org.jaronsource.msneg.domain.BusiSalesReturn;
import org.jaronsource.msneg.domain.SysDept;
import org.jaronsource.msneg.domain.SysUser;
import org.jaronsource.msneg.service.BusiSalesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.dao.support.PageRequest;
import com.ccesun.framework.core.dao.support.QCriteria;
import com.ccesun.framework.core.dao.support.QCriteria.Op;
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

	//@Autowired
	//private BusiCategoryDao busiCategoryDao;
	
	@Autowired
	private BusiClientDao busiClientDao;
	
	@Autowired
	private BusiSalesReturnDao busiSalesReturnDao;
	
	@Autowired
	private BusiSalesClearDao busiSalesClearDao;
	
	@Autowired
	private BusiSalesMakeupDao busiSalesMakeupDao;
	
	
	@Override
	public IDao<BusiSales, Integer> getDao() {
		return busiSalesDao;
	}

	@Override
	public String generateSalesCode() {
		
		SysUser currentUser = (SysUser) SecurityTokenHolder.getSecurityToken().getUser();
		SysDept sysDept = currentUser.getDept();
		
		String deptCode = sysDept.getDeptCode();
		String currentDate = DateUtils.currentDate();
		String prefix = "B";
		
		String fullPrefix = String.format("%s%s%s", deptCode, currentDate, prefix);
		
		String jpql = "select max(o.salesCode) from BusiSales o where o.salesCode like ?";
		String tmpCode = getDao().executeQueryOne(jpql, fullPrefix + "%");
		
		String numStr = StringUtils.substringAfter(tmpCode, fullPrefix);
		
		DecimalFormat df = new DecimalFormat("000");
		String result = fullPrefix + df.format(NumberUtils.toInt(numStr) + 1);
		
		return result;
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
		busiSales.setFeePrepay(busiSales.getFeePrepayCard() + busiSales.getFeePrepayCash());
		busiSales.setSalesStateKey("A");
		busiSales.setBillStateKey("A");
		busiSales.setFinanceStateKey("A");
		
		save(busiSales);
		
		for (BusiSalesItem busiSalesItem : busiSalesItems) {
			
			//busiSalesItem.setBusiCategory(busiCategoryDao.findReferenceByPk(busiSalesItem.getBusiCategory().getCateId()));
			busiSalesItem.setBusiSales(busiSales);
			busiSalesItem.setAssignStateKey("A");
			
			busiSalesItemDao.save(busiSalesItem);
		}
		
	}

	@Override
	public List<BusiSales> findSalesBySalesCode(String term) {
		String jpql = "select o from BusiSales o inner join o.busiClient o2 where o.salesCode like ? and o.billStateKey like 'A%'";
		PageRequest pageRequest = new PageRequest(1, 20);
		return getDao().find(pageRequest, jpql, '%' + term + '%');
	}

	@Override
	public List<BusiSales> findSalesByClientCellPhone(String term) {
		String jpql = "select o from BusiSales o inner join o.busiClient o2 where o2.cellPhone like ?";
		PageRequest pageRequest = new PageRequest(1, 20);
		return getDao().find(pageRequest, jpql, '%' + term + '%');
	}

	@Override
	public Map<String, Object> statis(Integer deptId, String salesType, String startTime, String endTime) {
		
		Map<String, Object> statisMap = new HashMap<String, Object>();
		
		{
			String jpql = "select count(o) from BusiSales o where o.salesTypeKey = ? and o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Long count = getDao().executeQueryOne(jpql, salesType, startTime, endTime);
			count = count == null ? 0 : count;
			statisMap.put("count", count);
		}
		
		{
			String jpql = "select sum(o.feeSum) from BusiSales o where o.salesTypeKey = ? and o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Double zongji = getDao().executeQueryOne(jpql, salesType, startTime, endTime);
			zongji = zongji == null ? 0 : zongji;
			statisMap.put("zongji", zongji);
		}
		
		{
			String jpql = "select sum(o.feeSum) from BusiSales o where o.salesTypeKey = ? and o.salesStateKey >= ? and o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Double jiesuan = getDao().executeQueryOne(jpql, salesType, "B", startTime, endTime);
			jiesuan = jiesuan == null ? 0 : jiesuan;
			statisMap.put("jiesuan", jiesuan);
		}
		
		{
			String jpql = "select sum(o.makeupSum) from BusiSalesMakeup o where o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Double bujia = getDao().executeQueryOne(jpql, startTime, endTime);
			bujia = bujia == null ? 0 : bujia;
			statisMap.put("bujia", bujia);
		}
		
		{
			String jpql = "select sum(o.returnSum) from BusiSalesReturn o where o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Double fanxiao = getDao().executeQueryOne(jpql, startTime, endTime);
			fanxiao = fanxiao == null ? 0 : fanxiao;
			statisMap.put("fanxiao", fanxiao);
		}
		
		Double weikuan = (Double) statisMap.get("zongji") - (Double) statisMap.get("jiesuan");
		statisMap.put("weikuan", weikuan);
		
		return statisMap;
	}

	@Override
	public List<Object[]> statis02(Integer deptId, String startTime, String endTime) {
		String jpql = "select o.busiCategory, count(o) from BusiSalesItem o inner join o.busiSales o2 where o2.createTime >= ? and o2.createTime <= ?";
		if (deptId != 0)
			jpql += " and o.busiSales.sysDept.deptId = " + deptId;
		jpql += " group by o.busiCategory ";
		return getDao().executeQuery(jpql, startTime, endTime);
	}

	@Override
	@Transactional
	public void invalid(Integer id) {
		BusiSales busiSales = findByPk(id);
		busiSales.setBillStateKey("B");
		save(busiSales);
	}

	@Override
	public List<BusiSales> findSalesByClientId(Integer clientId) {
		String jpql = "select o from BusiSales o where o.busiClient.clientId = ?";
		return getDao().find(jpql, clientId);
	}

	@Override
	@Transactional
	public void changeFinanceState(int salesId, String state) {
		
		BusiSales busiSales = getDao().findByPk(salesId);
		
		if (busiSales != null) {
			busiSales.setFinanceStateKey(state);
			getDao().save(busiSales);
		}
		
		QCriteria criteria = new QCriteria();
		criteria.addEntry("busiSales.salesId", Op.EQ, salesId);
		
		List<BusiSalesReturn> busiSalesReturnList = busiSalesReturnDao.find(criteria);
		List<BusiSalesClear> busiSalesClearList = busiSalesClearDao.find(criteria);
		List<BusiSalesMakeup> busiSalesMakeupList = busiSalesMakeupDao.find(criteria);
		
		for (BusiSalesReturn busiSalesReturn : busiSalesReturnList) {
			busiSalesReturn.setFinanceStateKey("B");
			busiSalesReturnDao.save(busiSalesReturn);
		}
		
		for (BusiSalesClear busiSalesClear : busiSalesClearList) {
			busiSalesClear.setFinanceStateKey("B");
			busiSalesClearDao.save(busiSalesClear);
		}
		
		for (BusiSalesMakeup busiSalesMakeup : busiSalesMakeupList) {
			busiSalesMakeup.setFinanceStateKey("B");
			busiSalesMakeupDao.save(busiSalesMakeup);
		}
		
		
	}

	@Override
	@Transactional
	public void changeBillState(Integer salesId, String state) {
		
		BusiSales busiSales = getDao().findByPk(salesId);
		if (busiSales != null) {
			busiSales.setBillStateKey(state);
			getDao().save(busiSales);
		}
		
	}

	@Override
	public Float summary(Integer salesId) {
		Float result = 0F;
		
		/*
		{
			String jpql = "select sum(o.feePrepay) from BusiSales o where o.salesId = ?";
			Float sum = getDao().executeQueryOne(jpql, salesId);
			sum = sum == null ? 0F : sum;
			result += sum;
		}
		*/
		
		{
			String jpql = "select sum(o.feeSum) from BusiSales o where o.salesId = ?";
			Double sum = getDao().executeQueryOne(jpql, salesId);
			sum = sum == null ? 0 : sum;
			result += sum.floatValue();
		}
		
		{
			String jpql = "select sum(o.makeupSum) from BusiSalesMakeup o where o.busiSales.salesId = ?";
			Double sum = getDao().executeQueryOne(jpql, salesId);
			sum = sum == null ? 0 : sum;
			result += sum.floatValue();
		}
		
		{
			String jpql = "select sum(o.actReturnSum) from BusiSalesReturn o where o.busiSales.salesId = ?";
			Double sum = getDao().executeQueryOne(jpql, salesId);
			sum = sum == null ? 0 : sum;
			result -= sum.floatValue();
		}
		
		return result;
	}


}