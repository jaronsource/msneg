package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.jaronsource.msneg.domain.BusiOrders;
import org.jaronsource.msneg.domain.SysDept;
import org.jaronsource.msneg.domain.SysUser;
import org.jaronsource.msneg.service.BusiOrdersService;
import org.jaronsource.msneg.service.SysDeptService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.spring.RequestHistory;
import com.ccesun.framework.core.web.controller.BaseController;
import com.ccesun.framework.plugins.security.SecurityTokenHolder;
import com.ccesun.framework.util.DateUtils;

@RequestMapping("/busiOrders")
@Controller
public class BusiOrdersController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiOrdersController.class);	
	
	@Autowired
	private BusiOrdersService busiOrdersService;
	
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
		
		Page<BusiOrders> busiOrdersPage = busiOrdersService.findPage(searchForm);
		model.addAttribute("busiOrdersPage", busiOrdersPage);
		model.addAttribute("depts", depts);
		model.addAttribute("weekTime", weekTime);
		model.addAttribute("monthTime", monthTime);
		model.addAttribute("threeMonthTime", threeMonthTime);
		
		return "busiOrders/list";
	}
	
	@RequestMapping(value = "/{ordersId}/update", method = GET)
    public String update(@PathVariable("ordersId") Integer ordersId, Model model) {
        model.addAttribute("busiOrders", busiOrdersService.findByPk(ordersId));
        return "busiOrders/update";
	}	
	
	@RequestMapping(value = "/{ordersId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiOrders busiOrders, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiOrders", busiOrders);
            return "busiOrders/update";
        }

        busiOrdersService.save(busiOrders);
        return "redirect:/busiOrders/" + busiOrders.getOrdersId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		
		String ordersCode = busiOrdersService.generateOrdersCode();
		
		BusiOrders busiOrders = new BusiOrders();
        model.addAttribute("busiOrders", busiOrders);
        model.addAttribute("ordersCode", ordersCode);
        return "busiOrders/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiOrders busiOrders, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiOrders", busiOrders);
            return "busiOrders/create";
        }
        
		SysUser currentUser = (SysUser) SecurityTokenHolder.getSecurityToken().getUser();
		busiOrders.setSysDept(currentUser.getDept());
		busiOrders.setSysUser(currentUser);
		busiOrders.setCreateTime(DateUtils.currentDateTime());
		busiOrders.setOrdersStateKey("A");
		busiOrders.setBillStateKey("A");
		
        busiOrdersService.save(busiOrders);
        return "history:/busiOrders";
    }	
	
	@RequestMapping(value = "/{ordersId}/show", method = GET)
    public String show(@PathVariable("ordersId") Integer ordersId, Model model) {
        BusiOrders busiOrders = busiOrdersService.findByPk(ordersId);
		model.addAttribute("busiOrders", busiOrders);
        return "busiOrders/show";
    }
    
    @RequestMapping(value = "/{ordersId}/remove", method = GET)
    public String remove(@PathVariable("ordersId") Integer ordersId, Model model) {
        busiOrdersService.remove(ordersId);
        return "redirect:/busiOrders";
    }
    
    @RequestMapping(value = "/useOrders", method = GET)
    public String useOrders(@RequestParam("ordersId") Integer ordersId, Model model) {
    	BusiOrders busiOrders = busiOrdersService.findByPk(ordersId);
    	busiOrders.setOrdersStateKey("B");
        busiOrdersService.save(busiOrders);
        return "redirect:/busiOrders";
    }
    
    @RequestMapping(value = "/returnOrders", method = GET)
    public String returnOrders(@RequestParam("ordersId") Integer ordersId, Model model) {
    	BusiOrders busiOrders = busiOrdersService.findByPk(ordersId);
    	busiOrders.setOrdersStateKey("C");
        busiOrdersService.save(busiOrders);
        return "redirect:/busiOrders";
    }
    
}

