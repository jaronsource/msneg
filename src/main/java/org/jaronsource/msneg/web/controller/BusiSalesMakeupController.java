package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.jaronsource.msneg.domain.BusiSalesMakeup;
import org.jaronsource.msneg.domain.SysUser;
import org.jaronsource.msneg.service.BusiSalesMakeupService;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;
import com.ccesun.framework.plugins.dictionary.DictionaryHelper;
import com.ccesun.framework.plugins.report.JasperReportUtils;
import com.ccesun.framework.plugins.security.SecurityTokenHolder;
import com.ccesun.framework.util.DateUtils;

@RequestMapping("/busiSalesMakeup")
@Controller
public class BusiSalesMakeupController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesMakeupController.class);	
	
	@Autowired
	private BusiSalesMakeupService busiSalesMakeupService;
	
	@Autowired
	private DictionaryHelper dictionaryHelper;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiSalesMakeup> busiSalesMakeupPage = busiSalesMakeupService.findPage(searchForm);
		model.addAttribute("busiSalesMakeupPage", busiSalesMakeupPage);
		
		return "busiSalesMakeup/list";
	}
	
	@RequestMapping(value = "/{makeupId}/update", method = GET)
    public String update(@PathVariable("makeupId") Integer makeupId, Model model) {
        model.addAttribute("busiSalesMakeup", busiSalesMakeupService.findByPk(makeupId));
        return "busiSalesMakeup/update";
	}	
	
	@RequestMapping(value = "/{makeupId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiSalesMakeup busiSalesMakeup, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesMakeup", busiSalesMakeup);
            return "busiSalesMakeup/update";
        }

        busiSalesMakeupService.save(busiSalesMakeup);
        return "redirect:/busiSalesMakeup/" + busiSalesMakeup.getMakeupId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiSalesMakeup busiSalesMakeup = new BusiSalesMakeup();
        model.addAttribute("busiSalesMakeup", busiSalesMakeup);
        return "busiSalesMakeup/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSalesMakeup busiSalesMakeup, BindingResult bindingResult, Model model) {
        //if (bindingResult.hasErrors()) {
        //   model.addAttribute("busiSalesMakeup", busiSalesMakeup);
        //   return "busiSalesMakeup/create";
        //}

		SysUser currentUser = (SysUser) SecurityTokenHolder.getSecurityToken().getUser();
		busiSalesMakeup.setSysUser(currentUser);
		busiSalesMakeup.setSysDept(currentUser.getDept());
		String currentTime = DateUtils.currentDateTime();
		busiSalesMakeup.setCreateTime(currentTime);
		busiSalesMakeup.setBillStateKey("A");
		busiSalesMakeupService.save(busiSalesMakeup);
        return "redirect:/busiSalesMakeup/" + busiSalesMakeup.getMakeupId() + "/show";
    }	
	
	@RequestMapping(value = "/{makeupId}/show", method = GET)
    public String show(@PathVariable("makeupId") Integer makeupId, Model model) {
        BusiSalesMakeup busiSalesMakeup = busiSalesMakeupService.findByPk(makeupId);
		model.addAttribute("busiSalesMakeup", busiSalesMakeup);
        return "busiSalesMakeup/show";
    }
	
	@RequestMapping(value = "/{makeupId}/print", method = GET)
	@ResponseBody
    public void print(@PathVariable("makeupId") Integer makeupId, HttpServletResponse response) {
    	BusiSalesMakeup busiSalesMakeup = busiSalesMakeupService.findByPk(makeupId);
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("salesCode", busiSalesMakeup.getBusiSales().getSalesCode());
		paramMap.put("clientName", busiSalesMakeup.getBusiSales().getBusiClient().getClientName());
		paramMap.put("clientPhone", PhoneUtils.decode(busiSalesMakeup.getBusiSales().getBusiClient().getAreacode(), busiSalesMakeup.getBusiSales().getBusiClient().getPhone()));
		paramMap.put("clientCellPhone", busiSalesMakeup.getBusiSales().getBusiClient().getCellPhone());
		paramMap.put("sysUser", busiSalesMakeup.getBusiSales().getSysUser().getRealName());
		paramMap.put("clientAddress", busiSalesMakeup.getBusiSales().getBusiClient().getAddress());
		paramMap.put("salesRemarks", busiSalesMakeup.getBusiSales().getSalesRemarks());
		paramMap.put("createTime", busiSalesMakeup.getCreateTime());
		paramMap.put("servLogis", dictionaryHelper.lookupDictValue0("serv_logis", busiSalesMakeup.getBusiSales().getServLogisKey()));
		paramMap.put("servGetmethod", dictionaryHelper.lookupDictValue0("serv_getmethod", busiSalesMakeup.getBusiSales().getServGetmethodKey()));
		paramMap.put("servInstallmethod", dictionaryHelper.lookupDictValue0("serv_installmethod", busiSalesMakeup.getBusiSales().getServInstallmethodKey()));
		
		paramMap.put("createTime", busiSalesMakeup.getCreateTime());
		paramMap.put("addItem1", busiSalesMakeup.getAddItem1() == null ? "0" : busiSalesMakeup.getAddItem1().toString());
		paramMap.put("addItem2", busiSalesMakeup.getAddItem2() == null ? "0" : busiSalesMakeup.getAddItem2().toString());
		paramMap.put("addItem3", busiSalesMakeup.getAddItem3() == null ? "0" : busiSalesMakeup.getAddItem3().toString());
		paramMap.put("addItem4", busiSalesMakeup.getAddItem4() == null ? "0" : busiSalesMakeup.getAddItem4().toString());
		paramMap.put("addItem5", busiSalesMakeup.getAddItem5() == null ? "0" : busiSalesMakeup.getAddItem5().toString());
		paramMap.put("addItem6", busiSalesMakeup.getAddItem6() == null ? "0" : busiSalesMakeup.getAddItem6().toString());
		paramMap.put("minusItem1", busiSalesMakeup.getMinusItem1() == null ? "0" : busiSalesMakeup.getMinusItem1().toString());
		paramMap.put("minusItem2", busiSalesMakeup.getMinusItem2() == null ? "0" : busiSalesMakeup.getMinusItem2().toString());
		paramMap.put("minusItem3", busiSalesMakeup.getMinusItem3() == null ? "0" : busiSalesMakeup.getMinusItem3().toString());
		paramMap.put("minusItem4", busiSalesMakeup.getMinusItem4() == null ? "0" : busiSalesMakeup.getMinusItem4().toString());
		paramMap.put("minusItem5", busiSalesMakeup.getMinusItem5() == null ? "0" : busiSalesMakeup.getMinusItem5().toString());
		paramMap.put("minusItem6", busiSalesMakeup.getMinusItem6() == null ? "0" : busiSalesMakeup.getMinusItem6().toString());
		paramMap.put("makeupSum", busiSalesMakeup.getMakeupSum().toString());
		paramMap.put("clearMethod", dictionaryHelper.lookupDictValue0("clear_method", busiSalesMakeup.getClearMethodKey()));
		paramMap.put("otherRemarks", busiSalesMakeup.getOtherRemarks());

		String filePath = getRealPath("/WEB-INF/print/sales_makeup.jasper");
		
		try {
			JasperReportUtils.exportPdf(response, filePath, paramMap, Collections.EMPTY_LIST, "sales_makeup");
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    @RequestMapping(value = "/{makeupId}/remove", method = GET)
    public String remove(@PathVariable("makeupId") Integer makeupId, Model model) {
        busiSalesMakeupService.remove(makeupId);
        return "redirect:/busiSalesMakeup";
    }
}

