package org.jaronsource.msneg.service;

import java.util.List;

import org.jaronsource.msneg.domain.BusiItem;
import com.ccesun.framework.core.service.ISearchFormSupportService;

public interface BusiItemService extends ISearchFormSupportService<BusiItem, Integer> {

	void changeStock(Integer itemId, Integer stock);

	List<BusiItem> findItemByCateIdAndTerm(Integer cateId, String term);

}