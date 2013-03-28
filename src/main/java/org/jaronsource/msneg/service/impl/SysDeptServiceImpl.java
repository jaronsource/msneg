package org.jaronsource.msneg.service.impl;

import java.util.List;

import org.jaronsource.msneg.dao.SysDeptDao;
import org.jaronsource.msneg.domain.SysDept;
import org.jaronsource.msneg.service.SysDeptService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;

@Service
public class SysDeptServiceImpl extends SearchFormSupportService<SysDept, Integer> implements SysDeptService {

	@Autowired
	private SysDeptDao sysDeptDao;
	
	@Override
	public IDao<SysDept, Integer> getDao() {
		return sysDeptDao;
	}

	@Override
	public List<SysDept> findSalesByType(String deptType) {

		String jpql = "select o from SysDept o where o.deptType = ?";
		return getDao().find(jpql, deptType);
	}

}