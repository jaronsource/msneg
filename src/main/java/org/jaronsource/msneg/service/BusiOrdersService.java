package org.jaronsource.msneg.service;

import java.util.Map;

import org.jaronsource.msneg.domain.BusiOrders;
import com.ccesun.framework.core.service.ISearchFormSupportService;

public interface BusiOrdersService extends ISearchFormSupportService<BusiOrders, Integer> {

	String generateOrdersCode();

	Map<String, Double> statis(Integer deptId, String startTime, String endTime);

}