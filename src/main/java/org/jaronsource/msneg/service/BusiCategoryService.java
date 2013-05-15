package org.jaronsource.msneg.service;

import java.util.List;
import java.util.Map;

import org.jaronsource.msneg.domain.BusiCategory;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.ccesun.framework.core.service.ISearchFormSupportService;

public interface BusiCategoryService extends ISearchFormSupportService<BusiCategory, Integer> {

	Map<String, List<BusiCategory>> findBusiCategoryListMap();

	void changeStock(Integer itemId, Integer stock);

	List<BusiCategory> findByItemType(String itemType);

	Long findStockByCateNameAndItemName(String cateName, String itemName);

	void save(BusiCategory busiCategory, String basePath, CommonsMultipartFile file);

}