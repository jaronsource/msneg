package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.domain.BusiSalesClear;
import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.domain.BusiSalesMakeup;
import org.jaronsource.msneg.domain.BusiSalesReturn;
import org.jaronsource.msneg.domain.SysDept;
import org.jaronsource.msneg.service.BusiSalesClearService;
import org.jaronsource.msneg.service.BusiSalesItemService;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccesun.framework.core.dao.support.Page;
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
	private BusiSalesItemService busiSalesItemService;
	
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
	
	@RequestMapping(value="/viewBills", method = {GET, POST})
	public String viewBill(@RequestParam Integer salesId, Model model) {
		
		BusiSales busiSales = busiSalesService.findByPk(salesId);
		
		//QCriteria criteria = new QCriteria();
		//criteria.addEntry("busiSales.salesId", Op.EQ, salesId);
		
		if (StringUtils.equals(busiSales.getBillStateKey(), "D")) {
			Float salesSummary = busiSalesService.summary(salesId);
			model.addAttribute("salesSummary", salesSummary);
		}
		
		List<BusiSalesMakeup> busiSalesMakeupList = busiSalesMakeupService.findBySalesId(salesId);
		List<BusiSalesClear> busiSalesClearList = busiSalesClearService.findBySalesId(salesId);
		List<BusiSalesReturn> busiSalesReturnList = busiSalesReturnService.findBySalesId(salesId);
		
		List<BusiSalesItem> busiSalesItemList = busiSalesItemService.findSalesItemBySalesId(salesId);
		
		model.addAttribute("busiSales", busiSales);
		model.addAttribute("busiSalesMakeupList", busiSalesMakeupList);
		model.addAttribute("busiSalesClearList", busiSalesClearList);
		model.addAttribute("busiSalesReturnList", busiSalesReturnList);
		model.addAttribute("busiSalesItemList", busiSalesItemList);
		
		return "busiBills/viewBill";
	}
	
	@RequestMapping(value="/invalidBill", method = {GET, POST})
	@ResponseBody
	public void invalidBill(
			@RequestParam(value="type", required=false) String type, 
			@RequestParam(value="id", required=false) Integer id, 
			Model model) {
		
		if ("busiSales".equals(type)) {
			busiSalesService.invalid(id);
		}
		
		else if ("busiSalesClear".equals(type)) {
			busiSalesClearService.invalid(id);
		}
		
		else if ("busiSalesMakeup".equals(type)) {
			busiSalesMakeupService.invalid(id);
		}
		
		else if ("busiSalesReturn".equals(type)) {
			busiSalesReturnService.invalid(id);
		}
	}
	
	@RequestMapping(value="/changeBillState", method = {GET, POST})
	public String changeBillState(
			@RequestParam(value="salesId", required=false) Integer salesId, 
			@RequestParam(value="state", required=false) String state, 
			Model model) {
		
		busiSalesService.changeBillState(salesId, state);
		return "history:/busiBills";
	}
	
	
	
}

