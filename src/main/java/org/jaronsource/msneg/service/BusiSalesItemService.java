package org.jaronsource.msneg.service;

import java.util.List;

import org.jaronsource.msneg.domain.BusiSalesItem;
import com.ccesun.framework.core.service.ISearchFormSupportService;

public interface BusiSalesItemService extends ISearchFormSupportService<BusiSalesItem, Integer> {

	List<BusiSalesItem> findSalesItemBySalesId(Integer salesId);

	void changeState(Integer salesItemId, String state, String assignNum);

}