package org.jaronsource.msneg.service;

import java.util.List;
import java.util.Map;

import org.jaronsource.msneg.domain.BusiSalesReturn;
import org.jaronsource.msneg.domain.BusiSalesReturnItem;

import com.ccesun.framework.core.service.ISearchFormSupportService;

public interface BusiSalesReturnService extends ISearchFormSupportService<BusiSalesReturn, Integer> {

	void save(BusiSalesReturn busiSalesReturn, List<BusiSalesReturnItem> busiSalesReturnItems);
	
	long countBySalesId(Integer salesId);

	Map<String, Long> statis(Integer deptId, String startTime, String endTime);

}