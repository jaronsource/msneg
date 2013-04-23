package org.jaronsource.msneg.service.impl;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.jaronsource.msneg.dao.BusiCategoryDao;
import org.jaronsource.msneg.domain.BusiCategory;
import org.jaronsource.msneg.service.BusiCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.service.SearchFormSupportService;
import com.ccesun.framework.plugins.dictionary.DictionaryHelper;
import com.ccesun.framework.plugins.dictionary.domain.Dictionary;

@Service
public class BusiCategoryServiceImpl extends SearchFormSupportService<BusiCategory, Integer> implements BusiCategoryService {

	@Autowired
	private BusiCategoryDao busiCategoryDao;
	
	@Autowired
	private DictionaryHelper dictionaryHelper;
	
	@Override
	public IDao<BusiCategory, Integer> getDao() {
		return busiCategoryDao;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Map<String, List<BusiCategory>> findBusiCategoryListMap() {
		
		Map<String, Dictionary> dictionaryMap = dictionaryHelper.getDictionariesByType("item_type");
		Map<String, List<BusiCategory>> result = new TreeMap<String, List<BusiCategory>>();
		for (Iterator iterator = dictionaryMap.keySet().iterator(); iterator.hasNext();) {
			String key = (String) iterator.next();
			
			List<BusiCategory> tempCategory = findBusiCategoryByItemType(key);
			result.put(key, tempCategory);
		}
		
		return result;
	}

	private List<BusiCategory> findBusiCategoryByItemType(String key) {
		String jpql = "select o from BusiCategory o where o.itemTypeKey = ?";
		return getDao().find(jpql, key);
	}

}