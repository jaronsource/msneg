package org.jaronsource.msneg.service.impl;

import java.util.List;

import org.jaronsource.msneg.dao.BusiItemDao;
import org.jaronsource.msneg.domain.BusiItem;
import org.jaronsource.msneg.service.BusiItemService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.dao.support.PageRequest;
import com.ccesun.framework.util.CnSpellUtils;

import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

@Service
public class BusiItemServiceImpl extends SearchFormSupportService<BusiItem, Integer> implements BusiItemService {

	@Autowired
	private BusiItemDao busiItemDao;
	
	@Override
	public IDao<BusiItem, Integer> getDao() {
		return busiItemDao;
	}

	@Override
	public List<BusiItem> findItemByTypeAndTerm(String itemType, String term) {
		
		Assert.notNull(term);
		
		String jpql = "select o from BusiItem o where o.itemTypeKey = ? and ( o.itemCode like ? or o.itemName like ? or o.itemFormat like ? )";
		String termForQuery = term.toUpperCase();
		PageRequest pageRequest = new PageRequest(1, 20);
		
		return getDao().find(pageRequest, jpql, itemType, '%' + termForQuery + '%', '%' + termForQuery + '%', '%' + termForQuery + '%');
	}

	@Override
	public BusiItem save(BusiItem target) {
		String itemCnspell = CnSpellUtils.getFirstCnSpell(target.getItemName());
		target.setItemCnspell(itemCnspell);
		return super.save(target);
	}

	@Override
	public void changeStock(Integer itemId, Integer stock) {
		String jpql = "update BusiItem o set o.itemStockAmount = ? where o.itemId = ?";
		getDao().execute(jpql, stock, itemId);
		
	}


}