package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.Date;
import java.util.List;

import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.domain.BusiSalesClear;
import org.jaronsource.msneg.domain.BusiSalesMakeup;
import org.jaronsource.msneg.domain.BusiSalesReturn;
import org.jaronsource.msneg.domain.SysDept;
import org.jaronsource.msneg.service.BusiSalesClearService;
import org.jaronsource.msneg.service.BusiSalesMakeupService;
import org.jaronsource.msneg.service.BusiSalesReturnService;
import org.jaronsource.msneg.service.BusiSalesService;
import org.jaronsource.msneg.service.SysDeptService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.QCriteria;
import com.ccesun.framework.core.dao.support.QCriteria.Op;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.spring.RequestHistory;
import com.ccesun.framework.core.web.controller.BaseController;
import com.ccesun.framework.util.DateUtils;

@RequestMapping("/busiBills")
@Controller
public class BusiBillsController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiBillsController.class);	
	
	@Autowired
	private BusiSalesService busiSalesService;
	
	@Autowired
	private BusiSalesMakeupService busiSalesMakeupService;
	
	@Autowired
	private BusiSalesReturnService busiSalesReturnService;
	
	@Autowired
	private BusiSalesClearService busiSalesClearService;
	
	@Autowired
	private SysDeptService sysDeptService;
	
	@RequestMapping(method = {GET, POST})
	@RequestHistory
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		List<SysDept> depts = sysDeptService.findSalesByType("A");
		Date now = new Date();
		String weekTime = DateUtils.format(DateUtils.addDays(now, 7), DateUtils.PATTERN_DATETIME);
		String monthTime = DateUtils.format(DateUtils.addDays(now, 30), DateUtils.PATTERN_DATETIME);
		String threeMonthTime = DateUtils.format(DateUtils.addDays(now, 90), DateUtils.PATTERN_DATETIME);
		
		Page<BusiSales> busiSalesPage = busiSalesService.findPage(searchForm);
		model.addAttribute("busiSalesPage", busiSalesPage);
		
		model.addAttribute("depts", depts);
		model.addAttribute("weekTime", weekTime);
		model.addAttribute("monthTime", monthTime);
		model.addAttribute("threeMonthTime", threeMonthTime);
		
		return "busiBills/list";
	}
	
	@RequestMapping(method = {GET, POST})
	public String viewBill(@RequestParam Integer salesId, Model model) {
		
		BusiSales busiSales = busiSalesService.findByPk(salesId);
		
		QCriteria criteria = new QCriteria();
		criteria.addEntry("salesId", Op.EQ, salesId);
		
		List<BusiSalesMakeup> busiSalesMakeupList = busiSalesMakeupService.find(criteria);
		List<BusiSalesClear> busiSalesClearList = busiSalesClearService.find(criteria);
		List<BusiSalesReturn> busiSalesReturnList = busiSalesReturnService.find(criteria);
		
		model.addAttribute("busiSales", busiSales);
		model.addAttribute("busiSalesMakeupList", busiSalesMakeupList);
		model.addAttribute("busiSalesClearList", busiSalesClearList);
		model.addAttribute("busiSalesReturnList", busiSalesReturnList);
		
		return "busiBills/viewBill";
	}
	
}

