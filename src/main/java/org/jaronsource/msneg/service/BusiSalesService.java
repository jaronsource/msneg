package org.jaronsource.msneg.service;

import java.util.List;
import java.util.Map;

import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.domain.BusiSalesItem;

import com.ccesun.framework.core.service.ISearchFormSupportService;

public interface BusiSalesService extends ISearchFormSupportService<BusiSales, Integer> {

	String generateSalesCode();

	List<BusiSales> findSalesBySalesCode(String term);

	List<BusiSales> findSalesByClientCellPhone(String term);
	
	void save(BusiSales busiSales, List<BusiSalesItem> busiSalesItems);

	Map<String, Object> statis(Integer deptId, String salesType, String startTime, String endTime);

	List<Object[]> statis02(Integer deptId, String startTime, String endTime);

	void invalid(Integer id);



}