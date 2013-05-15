package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.jaronsource.msneg.domain.BusiOrders;
import org.jaronsource.msneg.domain.SysDept;
import org.jaronsource.msneg.domain.SysUser;
import org.jaronsource.msneg.service.BusiOrdersService;
import org.jaronsource.msneg.service.SysDeptService;
import org.jaronsource.msneg.utils.PhoneUtils;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.spring.RequestHistory;
import com.ccesun.framework.core.web.controller.BaseController;
import com.ccesun.framework.plugins.dictionary.DictionaryHelper;
import com.ccesun.framework.plugins.report.JasperReportUtils;
import com.ccesun.framework.plugins.security.SecurityTokenHolder;
import com.ccesun.framework.util.DateUtils;
import com.ccesun.framework.util.StringUtils;

@RequestMapping("/busiOrders")
@Controller
public class BusiOrdersController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiOrdersController.class);	
	
	@Autowired
	private BusiOrdersService busiOrdersService;
	
	@Autowired
	private DictionaryHelper dictionaryHelper;
	
	@Autowired
	private SysDeptService sysDeptService;
	
	@RequestMapping(method = {GET, POST})
	@RequestHistory
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		SysUser sysUser = (SysUser) SecurityTokenHolder.getSecurityToken().getUser();
		SysDept sysDept = sysUser.getDept();
		
		List<SysDept> depts = null;
		if (StringUtils.equals(sysDept.getDeptTypeKey(), "A")) {
			depts = new ArrayList<SysDept>();
			depts.add(sysDept);
			searchForm.addFormEntry("sysDept.deptId_eq_int", sysDept.getDeptId().toString());
		} else {
			depts = sysDeptService.findSalesByType("A", "S");
		}
		
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
		busiOrders.setBillStateKey("A0");
		
        busiOrdersService.save(busiOrders);
        return "redirect:/busiOrders/" + busiOrders.getOrdersId() + "/show";
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
    public String useOrders(@RequestParam("ordersId") Integer ordersId, @RequestParam("salesCode") String salesCode, Model model) {
    	BusiOrders busiOrders = busiOrdersService.findByPk(ordersId);
    	busiOrders.setOrdersStateKey("B");
    	busiOrders.setForSalesCode(salesCode);
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
    
    @RequestMapping(value = "/{ordersId}/print", method = GET)
	@ResponseBody
    public void print(@PathVariable("ordersId") Integer ordersId, HttpServletResponse response) {
		
		SysUser sysUser = (SysUser) SecurityTokenHolder.getSecurityToken().getUser();
		SysDept sysDept = sysUser.getDept();
		
		BusiOrders busiOrders = busiOrdersService.findByPk(ordersId);
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("deptLogo", getRealPath("/WEB-INF/print/" + sysDept.getDeptLogo()));
		paramMap.put("ordersCode", busiOrders.getOrdersCode());
		paramMap.put("clientName", busiOrders.getBusiClient().getClientName());
		paramMap.put("clientPhone", PhoneUtils.decode(busiOrders.getBusiClient().getAreacode(), busiOrders.getBusiClient().getPhone()));
		paramMap.put("clientCellPhone", busiOrders.getBusiClient().getCellPhone());
		paramMap.put("sysUser", busiOrders.getHandleUser());
		paramMap.put("clientAddress", busiOrders.getBusiClient().getAddress());
		paramMap.put("ordersType", dictionaryHelper.lookupDictValue0("orders_type", busiOrders.getOrdersTypeKeys()));
		paramMap.put("ordersRemarks", busiOrders.getOrdersRemarks());
		paramMap.put("ordersUse", dictionaryHelper.lookupDictValue0("orders_use", busiOrders.getOrdersUseKey()));
		paramMap.put("ordersReturn", dictionaryHelper.lookupDictValue0("orders_return", busiOrders.getOrdersReturnKey()));
		paramMap.put("ordersSum", busiOrders.getOrdersSum() == null ? "0.00" : busiOrders.getOrdersSum().toString());
		paramMap.put("ordersCash", busiOrders.getOrdersCash() == null ? "0.00" : busiOrders.getOrdersCash().toString());
		paramMap.put("ordersCard", busiOrders.getOrdersCard() == null ? "0.00" : busiOrders.getOrdersCard().toString());
		paramMap.put("otherRemarks", busiOrders.getOtherRemarks());
		paramMap.put("createTime", busiOrders.getCreateTime().substring(0, 8));
		
		paramMap.put("deptAddress", sysDept.getDeptAddress());
		paramMap.put("deptPhone", sysDept.getDeptPhone());
		paramMap.put("deptFax", sysDept.getDeptFax());
		paramMap.put("deptServicePhone", sysDept.getDeptServicePhone());
		
		String filePath = getRealPath("/WEB-INF/print/orders.jasper");
		
		List<Map<String, String>> entries = new ArrayList<Map<String, String>>();
		
		try {
			JasperReportUtils.exportPdf(response, filePath, paramMap, entries, "orders");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
    }
}

