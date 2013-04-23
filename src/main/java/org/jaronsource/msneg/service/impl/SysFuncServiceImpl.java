package org.jaronsource.msneg.service.impl;

import org.jaronsource.msneg.dao.SysFuncDao;
import org.jaronsource.msneg.domain.SysFunc;
import org.jaronsource.msneg.service.SysFuncService;
import com.ccesun.framework.core.service.SearchFormSupportService;
import org.springframework.beans.factory.annotation.Autowired;
import com.ccesun.framework.core.dao.support.IDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SysFuncServiceImpl extends SearchFormSupportService<SysFunc, Integer> implements SysFuncService {

	@Autowired
	private SysFuncDao sysFuncDao;
	
	@Override
	public IDao<SysFunc, Integer> getDao() {
		return sysFuncDao;
	}

	@Override
	@Transactional
	public SysFunc save(SysFunc target) {
		if (target.getParent() != null && (target.getParent().getFuncId() == null || target.getParent().getFuncId() == 0 ))
			target.setParent(null);
		return super.save(target);
	}
	
	

}