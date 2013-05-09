package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.Date;
import java.util.List;

import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.domain.SysDept;
import org.jaronsource.msneg.service.BusiSalesItemService;
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
import com.ccesun.framework.util.NumberUtils;

@RequestMapping("/busiAssign")
@Controller
public class BusiAssignController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiAssignController.class);	
	
	@Autowired
	private BusiSalesService busiSalesService;

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
		
		return "busiAssign/list";
	}
	
	/**
	 * 状态由销售商品的状态决定
	 * 当所有销售商品的备货状态都改变时，才更改销售单状态
	 * @param model
	 * @return
	 */
	/*
	@Deprecated
	@RequestMapping(value = "changeState", method = {GET, POST})
	public String changeState(Model model) {

		String salesId = getHttpServletRequest().getParameter("salesId");
		String state = getHttpServletRequest().getParameter("state");
		
		BusiSales busiSales = busiSalesService.findByPk(NumberUtils.toInt(salesId));
		
		if (busiSales != null) {
			busiSales.setSalesStateKey(state);
			busiSalesService.save(busiSales);
		}
		
		return "history:/busiAssign";
	}
	*/
	
	@RequestMapping(value = "changeState", method = {GET, POST})
	public String changeState(Model model) {

		String salesItemId = getHttpServletRequest().getParameter("salesItemId");
		String state = getHttpServletRequest().getParameter("state");
		
		busiSalesItemService.changeState(NumberUtils.toInt(salesItemId), state);
		
		return "history:/busiAssign";
	}
}

