package org.jaronsource.msneg.service.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jaronsource.msneg.dao.SysDeptDao;
import org.jaronsource.msneg.domain.SysDept;
import org.jaronsource.msneg.service.SysDeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ccesun.framework.core.dao.support.IDao;
import com.ccesun.framework.core.service.SearchFormSupportService;

@Service
public class SysDeptServiceImpl extends SearchFormSupportService<SysDept, Integer> implements SysDeptService {

	@Autowired
	private SysDeptDao sysDeptDao;
	
	@Override
	public IDao<SysDept, Integer> getDao() {
		return sysDeptDao;
	}

	@Override
	public List<SysDept> findSalesByType(String... deptType) {

		String jpql = "select o from SysDept o where o.deptTypeKey in :deptTypeKey";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deptTypeKey", Arrays.asList(deptType));
		return getDao().find(jpql, params);
	}

}