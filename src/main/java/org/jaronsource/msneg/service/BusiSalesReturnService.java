package org.jaronsource.msneg.service;

import java.util.List;

import org.jaronsource.msneg.domain.BusiSalesReturn;
import org.jaronsource.msneg.domain.BusiSalesReturnItem;

import com.ccesun.framework.core.service.ISearchFormSupportService;

public interface BusiSalesReturnService extends ISearchFormSupportService<BusiSalesReturn, Integer> {

	void save(BusiSalesReturn busiSalesReturn, List<BusiSalesReturnItem> busiSalesReturnItems);

}