package org.jaronsource.msneg.service.impl;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.jaronsource.msneg.dao.BusiClientDao;
import org.jaronsource.msneg.dao.BusiOrdersDao;
import org.jaronsource.msneg.domain.BusiClient;
import org.jaronsource.msneg.domain.BusiOrders;
import org.jaronsource.msneg.domain.SysDept;
import org.jaronsource.msneg.domain.SysUser;
import org.jaronsource.msneg.service.BusiOrdersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.service.SearchFormSupportService;
import com.ccesun.framework.plugins.security.SecurityTokenHolder;
import com.ccesun.framework.util.BeanUtils;
import com.ccesun.framework.util.DateUtils;

@Service
public class BusiOrdersServiceImpl extends SearchFormSupportService<BusiOrders, Integer> implements BusiOrdersService {

	@Autowired
	private BusiClientDao busiClientDao;
	
	@Autowired
	private BusiOrdersDao busiOrdersDao;
	
	@Override
	public IDao<BusiOrders, Integer> getDao() {
		return busiOrdersDao;
	}

	@Override
	public String generateOrdersCode() {
		SysUser currentUser = (SysUser) SecurityTokenHolder.getSecurityToken().getUser();
		SysDept sysDept = currentUser.getDept();
		
		String deptCode = sysDept.getDeptCode();
		String currentDate = DateUtils.currentDate();
		String prefix = "O";
		
		String fullPrefix = String.format("%s%s%s", deptCode, currentDate, prefix);
		
		String jpql = "select max(o.ordersCode) from BusiOrders o where o.ordersCode like ?";
		String tmpCode = getDao().executeQueryOne(jpql, fullPrefix + "%");
		
		String numStr = StringUtils.substringAfter(tmpCode, fullPrefix);
		
		DecimalFormat df = new DecimalFormat("000");
		String result = fullPrefix + df.format(NumberUtils.toInt(numStr) + 1);
		
		return result;
	}

	@Override
	public Map<String, Object> statis(Integer deptId, String startTime, String endTime) {
		
		Map<String, Object> statisMap = new HashMap<String, Object>();
		
		{
			String jpql = "select count(o) from BusiOrders o where o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Long count = getDao().executeQueryOne(jpql, startTime, endTime);
			count = count == null ? 0 : count;
			statisMap.put("count", count);
		}
		
		{
			String jpql = "select sum(o.ordersSum) from BusiOrders o where o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Double zongji = getDao().executeQueryOne(jpql, startTime, endTime);
			zongji = zongji == null ? 0 : zongji;
			statisMap.put("zongji", zongji);
		}
		
		{
			String jpql = "select sum(o.ordersSum) from BusiOrders o where o.ordersStateKey = ? and o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Double yishiyong = getDao().executeQueryOne(jpql, "A", startTime, endTime);
			yishiyong = yishiyong == null ? 0 : yishiyong;
			statisMap.put("yishiyong", yishiyong);
		}
		
		{
			String jpql = "select sum(o.ordersSum) from BusiOrders o where o.ordersStateKey = ? and o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Double yitui = getDao().executeQueryOne(jpql, "B", startTime, endTime);
			yitui = yitui == null ? 0 : yitui;
			statisMap.put("yitui", yitui);
		}
		
		return statisMap;
	}

	@Override
	@Transactional
	public BusiOrders save(BusiOrders busiOrders) {

		BusiClient busiClient = busiOrders.getBusiClient();
		if (!busiClient.isNew()) {
			BusiClient origBusiClient = busiClientDao.findByPk(busiClient.getClientId());
			BeanUtils.mergeProperties(origBusiClient, busiClient);
			busiOrders.setBusiClient(origBusiClient);
		}
		
		return super.save(busiOrders);
	}
	
	

}