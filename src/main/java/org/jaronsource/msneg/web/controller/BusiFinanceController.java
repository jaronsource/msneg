package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.math.NumberUtils;
import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.domain.SysDept;
import org.jaronsource.msneg.service.BusiSalesService;
import org.jaronsource.msneg.service.SysDeptService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.spring.RequestHistory;
import com.ccesun.framework.core.web.controller.BaseController;
import com.ccesun.framework.util.DateUtils;
import com.ccesun.framework.util.StringUtils;

@RequestMapping("/busiFinance")
@Controller
public class BusiFinanceController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiFinanceController.class);	
	
	@Autowired
	private BusiSalesService busiSalesService;
	
	//@Autowired
	//private BusiSalesReturnService busiSalesReturnService;
	
	//@Autowired
	//private BusiSalesClearService busiSalesClearService;
	
	//@Autowired
	//private BusiSalesMakeupService busiSalesMakeupService;
	
	@Autowired
	private SysDeptService sysDeptService;
	
	@RequestMapping(method = {GET, POST})
	@RequestHistory
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		List<SysDept> depts = sysDeptService.findSalesByType("A", "S");
		Date now = new Date();
		String weekTime = DateUtils.format(DateUtils.addDays(now, 7), DateUtils.PATTERN_DATETIME);
		String monthTime = DateUtils.format(DateUtils.addDays(now, 30), DateUtils.PATTERN_DATETIME);
		String threeMonthTime = DateUtils.format(DateUtils.addDays(now, 90), DateUtils.PATTERN_DATETIME);
		
		//searchForm.addFormEntry("billStateKey_lk", "A%");
		
		Page<BusiSales> busiSalesPage = busiSalesService.findPage(searchForm);
		model.addAttribute("busiSalesPage", busiSalesPage);
		
		model.addAttribute("depts", depts);
		model.addAttribute("weekTime", weekTime);
		model.addAttribute("monthTime", monthTime);
		model.addAttribute("threeMonthTime", threeMonthTime);
		
		return "busiFinance/list";
	}
	
	@RequestMapping(value = "changeState", method = {GET, POST})
	public String changeState(Model model) {

		String salesId = getHttpServletRequest().getParameter("salesId");
		//String state = getHttpServletRequest().getParameter("state");
		
		BusiSales busiSales = busiSalesService.findByPk(NumberUtils.toInt(salesId));
        if (busiSales == null) {
        	model.addAttribute("errorMsg", getMessage("busiSales.errMsg.notFound"));
        	return "error";
        }
        
        if (StringUtils.equals(busiSales.getBillStateKey(), "B")) {
        	model.addAttribute("errorMsg", getMessage("busiSales.errMsg.invalid"));
        	return "error";
        }
        
        if (StringUtils.equals(busiSales.getBillStateKey(), "C")) {
        	model.addAttribute("errorMsg", getMessage("busiSales.errMsg.close"));
        	return "error";
        }
		//BusiSales busiSales = busiSalesService.findByPk(NumberUtils.toInt(salesId));
		
		//if (busiSales != null) {
			//busiSales.setSalesStateKey(state);
			//busiSales.setFinanceStateKey("B");
			busiSalesService.changeFinanceState(NumberUtils.toInt(salesId), "B");
			 
		//}
		
		return "history:/busiFinance";
	}
	
}

