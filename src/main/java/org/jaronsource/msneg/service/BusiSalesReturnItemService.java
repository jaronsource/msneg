package org.jaronsource.msneg.service;

import java.util.List;

import org.jaronsource.msneg.domain.BusiSalesReturnItem;

import com.ccesun.framework.core.service.ISearchFormSupportService;

public interface BusiSalesReturnItemService extends ISearchFormSupportService<BusiSalesReturnItem, Integer> {

	List<BusiSalesReturnItem> findBusiSalesReturnItemByReturnId(Integer returnId);
}