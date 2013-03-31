package org.jaronsource.msneg.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.jaronsource.msneg.dao.BusiOrdersDao;
import org.jaronsource.msneg.domain.BusiOrders;
import org.jaronsource.msneg.service.BusiOrdersService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class BusiOrdersServiceImpl extends SearchFormSupportService<BusiOrders, Integer> implements BusiOrdersService {

	@Autowired
	private BusiOrdersDao busiOrdersDao;
	
	@Override
	public IDao<BusiOrders, Integer> getDao() {
		return busiOrdersDao;
	}

	@Override
	public String generateOrdersCode() {
		return "12N1211B017";
	}

	@Override
	public Map<String, Long> statis(Integer deptId, String startTime, String endTime) {
		
		Map<String, Long> statisMap = new HashMap<String, Long>();
		
		{
			String jpql = "select sum(o.ordersSum) from BusiOrders o where o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Long zongji = getDao().executeQueryOne(jpql, startTime, endTime);
			zongji = zongji == null ? 0 : zongji;
			statisMap.put("zongji", zongji);
		}
		
		{
			String jpql = "select sum(o.ordersSum) from BusiOrders o where o.ordersStateKey = ? and o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Long yishiyong = getDao().executeQueryOne(jpql, "A", startTime, endTime);
			yishiyong = yishiyong == null ? 0 : yishiyong;
			statisMap.put("yishiyong", yishiyong);
		}
		
		{
			String jpql = "select sum(o.ordersSum) from BusiOrders o where o.ordersStateKey = ? and o.createTime >= ? and o.createTime <= ?";
			if (deptId != 0)
				jpql += " and o.sysDept.deptId = " + deptId;
			Long yitui = getDao().executeQueryOne(jpql, "B", startTime, endTime);
			yitui = yitui == null ? 0 : yitui;
			statisMap.put("yitui", yitui);
		}
		
		return statisMap;
	}

}