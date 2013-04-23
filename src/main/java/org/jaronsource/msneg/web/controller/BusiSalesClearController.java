package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.jaronsource.msneg.domain.BusiSalesClear;
import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.domain.SysUser;
import org.jaronsource.msneg.service.BusiSalesClearService;
import org.jaronsource.msneg.service.BusiSalesItemService;
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

@RequestMapping("/busiSalesClear")
@Controller
public class BusiSalesClearController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesClearController.class);	
	
	@Autowired
	private BusiSalesClearService busiSalesClearService;

	@Autowired
	private BusiSalesItemService busiSalesItemService;
	
	@Autowired
	private DictionaryHelper dictionaryHelper;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiSalesClear> busiSalesClearPage = busiSalesClearService.findPage(searchForm);
		model.addAttribute("busiSalesClearPage", busiSalesClearPage);
		
		return "busiSalesClear/list";
	}
	
	@RequestMapping(value = "/{clearId}/update", method = GET)
    public String update(@PathVariable("clearId") Integer clearId, Model model) {
        model.addAttribute("busiSalesClear", busiSalesClearService.findByPk(clearId));
        return "busiSalesClear/update";
	}	
	
	@RequestMapping(value = "/{clearId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiSalesClear busiSalesClear, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesClear", busiSalesClear);
            return "busiSalesClear/update";
        }

        busiSalesClearService.save(busiSalesClear);
        return "redirect:/busiSalesClear/" + busiSalesClear.getClearId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiSalesClear busiSalesClear = new BusiSalesClear();
        model.addAttribute("busiSalesClear", busiSalesClear);
        return "busiSalesClear/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSalesClear busiSalesClear, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesClear", busiSalesClear);
            return "busiSalesClear/create";
        }
        
        SysUser currentUser = (SysUser) SecurityTokenHolder.getSecurityToken().getUser();
        busiSalesClear.setSysUser(currentUser);
        busiSalesClear.setBillStateKey("A");
        
        busiSalesClearService.save(busiSalesClear);
        return "redirect:/busiSalesClear/" + busiSalesClear.getClearId() + "/show";
    }	
	
	@RequestMapping(value = "/{clearId}/show", method = GET)
    public String show(@PathVariable("clearId") Integer clearId, Model model) {
		
		BusiSalesClear busiSalesClear = busiSalesClearService.findByPk(clearId);
		List<BusiSalesItem> busiSalesItemList = busiSalesItemService.findSalesItemBySalesId(busiSalesClear.getBusiSales().getSalesId());
		model.addAttribute("busiSalesClear", busiSalesClear);
		model.addAttribute("busiSalesItemList", busiSalesItemList);
		
        return "busiSalesClear/show";
    }
    
    @RequestMapping(value = "/{clearId}/remove", method = GET)
    public String remove(@PathVariable("clearId") Integer clearId, Model model) {
        busiSalesClearService.remove(clearId);
        return "redirect:/busiSalesClear";
    }
    
    @RequestMapping(value = "/{clearId}/print", method = GET)
	@ResponseBody
    public void print(@PathVariable("clearId") Integer clearId, HttpServletResponse response) {
    	BusiSalesClear busiSalesClear = busiSalesClearService.findByPk(clearId);
    	List<BusiSalesItem> busiSalesItemList = busiSalesItemService.findSalesItemBySalesId(busiSalesClear.getBusiSales().getSalesId());
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("salesCode", busiSalesClear.getBusiSales().getSalesCode());
		paramMap.put("clientName", busiSalesClear.getBusiSales().getBusiClient().getClientName());
		paramMap.put("clientPhone", PhoneUtils.decode(busiSalesClear.getBusiSales().getBusiClient().getAreacode(), busiSalesClear.getBusiSales().getBusiClient().getPhone()));
		paramMap.put("clientCellPhone", busiSalesClear.getBusiSales().getBusiClient().getCellPhone());
		paramMap.put("sysUser", busiSalesClear.getBusiSales().getSysUser().getRealName());
		paramMap.put("clientAddress", busiSalesClear.getBusiSales().getBusiClient().getAddress());
		paramMap.put("salesRemarks", busiSalesClear.getBusiSales().getSalesRemarks());
		paramMap.put("createTime", busiSalesClear.getCreateTime());
		paramMap.put("servLogis", dictionaryHelper.lookupDictValue0("serv_logis", busiSalesClear.getBusiSales().getServLogisKey()));
		paramMap.put("servGetmethod", dictionaryHelper.lookupDictValue0("serv_getmethod", busiSalesClear.getBusiSales().getServGetmethodKey()));
		paramMap.put("servInstallmethod", dictionaryHelper.lookupDictValue0("serv_installmethod", busiSalesClear.getBusiSales().getServInstallmethodKey()));
		
		
		List<Map<String, String>> entries = new ArrayList<Map<String, String>>();
		for (BusiSalesItem busiSalesItem : busiSalesItemList) {
			Map<String, String> entry = new HashMap<String, String>();
			entry.put("cateName", busiSalesItem.getBusiCategory().getCateName());
			entry.put("itemName", busiSalesItem.getItemName());
			entry.put("itemUnit", dictionaryHelper.lookupDictValue0("item_unit", busiSalesItem.getItemUnitKey()) );
			entry.put("itemAmount", busiSalesItem.getItemAmount() == null ? "0" : busiSalesItem.getItemAmount().toString());
			entry.put("itemPrice", busiSalesItem.getItemPrice() == null ? "0.00" : busiSalesItem.getItemPrice().toString());
			entry.put("itemSum", busiSalesItem.getItemSum() == null ? "0.00" : busiSalesItem.getItemSum().toString());
			entry.put("itemRemarks", busiSalesItem.getItemRemarks());
			entries.add(entry);
		}
		
		String filePath = getRealPath("/WEB-INF/print/sales_clear.jasper");
		
		try {
			JasperReportUtils.exportPdf(response, filePath, paramMap, entries, "sales_clear");
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
}

