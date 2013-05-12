package org.jaronsource.msneg.service;

import java.util.List;
import java.util.Map;

import org.jaronsource.msneg.domain.BusiSalesMakeup;

import com.ccesun.framework.core.service.ISearchFormSupportService;

public interface BusiSalesMakeupService extends ISearchFormSupportService<BusiSalesMakeup, Integer> {

	long countBySalesId(Integer salesId);

	Map<String, Object> statis(Integer deptId, String startTime, String endTime);

	void invalid(Integer id);

	List<BusiSalesMakeup> findBySalesId(Integer salesId);
}