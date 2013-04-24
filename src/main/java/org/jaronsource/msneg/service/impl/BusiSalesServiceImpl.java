package org.jaronsource.msneg.service.impl;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.jaronsource.msneg.dao.BusiCategoryDao;
import org.jaronsource.msneg.dao.BusiClientDao;
import org.jaronsource.msneg.dao.BusiSalesDao;
import org.jaronsource.msneg.dao.BusiSalesItemDao;
import org.jaronsource.msneg.domain.BusiClient;
import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.domain.SysDept;
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
	private BusiCategoryDao busiCategoryDao;
	
	@Autowired
	private BusiClientDao busiClientDao;
	
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
		busiSales.setSalesStateKey("A");
		busiSales.setBillStateKey("A");
		
		save(busiSales);
		
		for (BusiSalesItem busiSalesItem : busiSalesItems) {
			
			busiSalesItem.setBusiCategory(busiCategoryDao.findReferenceByPk(busiSalesItem.getBusiCategory().getCateId()));
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

	@Override
	public Map<String, Double> statis(Integer deptId, String salesType, String startTime, String endTime) {
		
		Map<String, Double> statisMap = new HashMap<String, Double>();
		
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
		
		Double weikuan = statisMap.get("zongji") - statisMap.get("jiesuan");
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


}