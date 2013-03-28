package org.jaronsource.msneg.service;

import java.util.List;

import org.jaronsource.msneg.domain.SysDept;
import com.ccesun.framework.core.service.ISearchFormSupportService;

public interface SysDeptService extends ISearchFormSupportService<SysDept, Integer> {

	List<SysDept> findSalesByType(String deptType);

}