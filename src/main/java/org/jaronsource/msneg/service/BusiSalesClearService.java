package org.jaronsource.msneg.service;

import java.util.List;

import org.jaronsource.msneg.domain.BusiSalesClear;

import com.ccesun.framework.core.service.ISearchFormSupportService;

public interface BusiSalesClearService extends ISearchFormSupportService<BusiSalesClear, Integer> {

	long countBySalesId(Integer salesId);

	void invalid(Integer id);

	List<BusiSalesClear> findBySalesId(Integer salesId);

}