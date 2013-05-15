package org.jaronsource.msneg.service.impl;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.jaronsource.msneg.dao.BusiCategoryDao;
import org.jaronsource.msneg.domain.BusiCategory;
import org.jaronsource.msneg.service.BusiCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

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

	@Override
	public void changeStock(Integer cateId, Integer stock) {
		String jpql = "update BusiCategory o set o.itemStockAmount = ? where o.cateId = ?";
		getDao().execute(jpql, stock, cateId);
	}

	@Override
	public List<BusiCategory> findByItemType(String itemType) {
		String jpql = "select o from BusiCategory o where o .itemTypeKey = ?";
		return getDao().find(jpql, itemType);
	}

	@Override
	public Long findStockByCateNameAndItemName(String cateName, String itemName) {
		String jpql = "select sum(o.itemStockAmount) from BusiCategory o where cateName = ? and itemName = ?";
		Long stockCount = (Long) getDao().executeQueryOne(jpql, cateName, itemName);
		return stockCount;
	}

	@Override
	@Transactional
	public void save(BusiCategory busiCategory, String basePath, CommonsMultipartFile file) {
		
		
		try {
			String ext = file.getFileItem().getName().substring(file.getFileItem().getName().lastIndexOf("."));
			String fileName = busiCategory.getCateId() + ext;
			String destFileName = basePath + File.separator + fileName;
			File destFile = new File(destFileName);
			file.getFileItem().write(destFile);
			busiCategory.setItemSmallImage(fileName);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			save(busiCategory);
		}
	}

}