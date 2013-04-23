package org.jaronsource.msneg.service;

import java.util.Map;

import org.jaronsource.msneg.domain.BusiSalesMakeup;

import com.ccesun.framework.core.service.ISearchFormSupportService;

public interface BusiSalesMakeupService extends ISearchFormSupportService<BusiSalesMakeup, Integer> {

	long countBySalesId(Integer salesId);

	Map<String, Double> statis(Integer deptId, String startTime, String endTime);
}