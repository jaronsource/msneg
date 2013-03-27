package org.jaronsource.msneg.service.impl;

import java.util.List;

import org.jaronsource.msneg.dao.BusiClientDao;
import org.jaronsource.msneg.domain.BusiClient;
import org.jaronsource.msneg.service.BusiClientService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.dao.support.PageRequest;

import org.springframework.stereotype.Service;

@Service
public class BusiClientServiceImpl extends SearchFormSupportService<BusiClient, Integer> implements BusiClientService {

	@Autowired
	private BusiClientDao busiClientDao;
	
	@Override
	public IDao<BusiClient, Integer> getDao() {
		return busiClientDao;
	}

	@Override
	public List<BusiClient> findClientByTerm(String term) {
		String jpql = "select o from BusiClient o where o.areacode like ? or o.phone like ? or o.cellPhone like ?";
		PageRequest pageRequest = new PageRequest(1, 20);
		return getDao().find(pageRequest, jpql, '%' + term + '%', '%' + term + '%', '%' + term + '%');
	}

}