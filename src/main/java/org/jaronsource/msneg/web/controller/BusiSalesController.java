package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.jaronsource.msneg.domain.BusiCategory;
import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.domain.SysDept;
import org.jaronsource.msneg.domain.SysUser;
import org.jaronsource.msneg.service.BusiCategoryService;
import org.jaronsource.msneg.service.BusiSalesItemService;
import org.jaronsource.msneg.service.BusiSalesService;
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
import com.ccesun.framework.core.web.controller.BaseController;
import com.ccesun.framework.plugins.dictionary.DictionaryHelper;
import com.ccesun.framework.plugins.report.JasperReportUtils;
import com.ccesun.framework.plugins.security.SecurityTokenHolder;
import com.ccesun.framework.util.NumberUtils;
import com.ccesun.framework.util.StringUtils;

@RequestMapping("/busiSales")
@Controller
public class BusiSalesController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesController.class);	
	
	@Autowired
	private BusiSalesService busiSalesService;
	
	@Autowired
	private BusiCategoryService busiCategoryService;
	
	@Autowired
	private BusiSalesItemService busiSalesItemService;
	
	@Autowired
	private DictionaryHelper dictionaryHelper;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiSales> busiSalesPage = busiSalesService.findPage(searchForm);
		model.addAttribute("busiSalesPage", busiSalesPage);
		
		return "busiSales/list";
	}
	
	@RequestMapping(value = "/{salesId}/update", method = GET)
    public String update(@PathVariable("salesId") Integer salesId, Model model) {
        model.addAttribute("busiSales", busiSalesService.findByPk(salesId));
        return "busiSales/update";
	}	
	
	@RequestMapping(value = "/{salesId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiSales busiSales, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSales", busiSales);
            return "busiSales/update";
        }

        busiSalesService.save(busiSales);
        return "redirect:/busiSales/" + busiSales.getSalesId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		
		BusiSales busiSales = new BusiSales();
		BusiSalesForm form = new BusiSalesForm();
		form.setBusiSales(busiSales);
		
		//List<BusiCategory> busiCategories = busiCategoryService.findAll();
		
		Map<String, List<BusiCategory>> busiCategoryListMap = busiCategoryService.findBusiCategoryListMap();
		
		String salesCode = busiSalesService.generateSalesCode();
		
        model.addAttribute("form", form);
        model.addAttribute("busiCategoryListMap", busiCategoryListMap);
        getHttpSession().setAttribute("salesCode", salesCode);
        
        return "busiSales/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSalesForm busiSalesForm, BindingResult bindingResult, Model model) {
        //if (bindingResult.hasErrors()) {
        //    model.addAttribute("busiSales", busiSales);
        //    return "busiSales/create";
        //}
        
		HttpServletRequest requst = getHttpServletRequest();
		String[] cateNames = requst.getParameterValues("cateName");
		String[] itemTypes = requst.getParameterValues("itemType");
		String[] itemNames = requst.getParameterValues("itemName");
		String[] itemAmounts = requst.getParameterValues("itemAmount");
		String[] itemSums = requst.getParameterValues("itemSum");
		String[] itemRemarks = requst.getParameterValues("itemRemarks");
		String[] itemUnits = requst.getParameterValues("itemUnit");
		String[] itemPrices = requst.getParameterValues("itemPrice");
		
		List<BusiSalesItem> busiSalesItems = new ArrayList<BusiSalesItem>();
		for (int i = 0; i < cateNames.length; i++) {
			if (StringUtils.isNotBlank(itemNames[i])) {
				BusiSalesItem busiSalesItem = new BusiSalesItem();
				busiSalesItem.setItemAmount(NumberUtils.toInt(itemAmounts[i]));
				busiSalesItem.setItemTypeKey(itemTypes[i]);
				busiSalesItem.setItemName(itemNames[i]);
				busiSalesItem.setItemRemarks(itemRemarks[i]);
				busiSalesItem.setItemSum(NumberUtils.toFloat(itemSums[i]));
				busiSalesItem.setItemUnitKey(itemUnits[i]);
				busiSalesItem.setItemPrice(NumberUtils.toFloat(itemPrices[i]));
				//busiSalesItem.setBusiCategory(new BusiCategory(NumberUtils.toInt(cateIds[i])));
				busiSalesItem.setCateName(cateNames[i]);
				busiSalesItems.add(busiSalesItem);
			}
		}
		
		busiSalesService.save(busiSalesForm.getBusiSales(), busiSalesItems);
		
        return "redirect:/busiSales/" + busiSalesForm.getBusiSales().getSalesId() + "/show";
    }	
	
	@RequestMapping(value = "/{salesId}/show", method = GET)
    public String show(@PathVariable("salesId") Integer salesId, Model model) {
		BusiSales busiSales = busiSalesService.findByPk(salesId);
		List<BusiSalesItem> busiSalesItemList = busiSalesItemService.findSalesItemBySalesId(salesId);
		model.addAttribute("busiSales", busiSales);
		model.addAttribute("busiSalesItemList", busiSalesItemList);
		
        return "busiSales/show";
    }
	
	@RequestMapping(value = "/{salesId}/print", method = GET)
	@ResponseBody
    public void print(@PathVariable("salesId") Integer salesId, HttpServletResponse response) {
		
		SysUser sysUser = (SysUser) SecurityTokenHolder.getSecurityToken().getUser();
		SysDept sysDept = sysUser.getDept();
		
		BusiSales busiSales = busiSalesService.findByPk(salesId);
		List<BusiSalesItem> busiSalesItemList = busiSalesItemService.findSalesItemBySalesId(salesId);
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("deptLogo", getRealPath("/WEB-INF/print/" + sysDept.getDeptLogo()));
		paramMap.put("salesCode", busiSales.getSalesCode());
		paramMap.put("clientName", busiSales.getBusiClient().getClientName());
		paramMap.put("clientPhone", PhoneUtils.decode(busiSales.getBusiClient().getAreacode(), busiSales.getBusiClient().getPhone()));
		paramMap.put("clientCellPhone", busiSales.getBusiClient().getCellPhone());
		paramMap.put("sysUser", busiSales.getHandleUser());
		paramMap.put("clientAddress", busiSales.getBusiClient().getAddress());
		paramMap.put("salesRemarks", busiSales.getSalesRemarks());
		paramMap.put("servLogis", dictionaryHelper.lookupDictValue0("serv_logis", busiSales.getServLogisKey()));
		paramMap.put("servGetmethod", dictionaryHelper.lookupDictValue0("serv_getmethod", busiSales.getServGetmethodKey()));
		paramMap.put("servInstallmethod", dictionaryHelper.lookupDictValue0("serv_installmethod", busiSales.getServInstallmethodKey()));
		paramMap.put("feeSum", busiSales.getFeeSum() == null ? "0.00" : busiSales.getFeeSum().toString());
		paramMap.put("feePrepay", busiSales.getFeePrepay() == null ? "0.00" : busiSales.getFeePrepay().toString());
		paramMap.put("feePrepayCard", busiSales.getFeePrepayCard() == null ? "0.00" : busiSales.getFeePrepayCard().toString());
		paramMap.put("feePrepayCash", busiSales.getFeePrepayCash() == null ? "0.00" : busiSales.getFeePrepayCash().toString());
		paramMap.put("feeRemain", busiSales.getFeeRemain() == null ? "0.00" : busiSales.getFeeRemain().toString());
		paramMap.put("createTime", StringUtils.substring(busiSales.getCreateTime(), 0, 8));
		paramMap.put("otherRemarks", busiSales.getOtherRemarks());
		paramMap.put("salesContract", busiSales.getSalesContract());
		
		paramMap.put("deptAddress", sysDept.getDeptAddress());
		paramMap.put("deptPhone", sysDept.getDeptPhone());
		paramMap.put("deptFax", sysDept.getDeptFax());
		paramMap.put("deptServicePhone", sysDept.getDeptServicePhone());
		
		List<Map<String, String>> entries = new ArrayList<Map<String, String>>();
		for (BusiSalesItem busiSalesItem : busiSalesItemList) {
			Map<String, String> entry = new HashMap<String, String>();
			entry.put("itemType", dictionaryHelper.lookupDictValue0("item_type", busiSalesItem.getItemTypeKey()));
			entry.put("cateName", busiSalesItem.getCateName());
			entry.put("itemName", busiSalesItem.getItemName());
			entry.put("itemUnit", dictionaryHelper.lookupDictValue0("item_unit", busiSalesItem.getItemUnitKey()) );
			entry.put("itemAmount", busiSalesItem.getItemAmount() == null ? "0" : busiSalesItem.getItemAmount().toString());
			entry.put("itemPrice", busiSalesItem.getItemPrice() == null ? "0.00" : busiSalesItem.getItemPrice().toString());
			entry.put("itemSum", busiSalesItem.getItemSum() == null ? "0.00" : busiSalesItem.getItemSum().toString());
			entry.put("itemRemarks", busiSalesItem.getItemRemarks());
			entries.add(entry);
		}
		
		String filePath = getRealPath("/WEB-INF/print/sales.jasper");
		
		try {
			JasperReportUtils.exportPdf(response, filePath, paramMap, entries, "sales");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
    }
    
    @RequestMapping(value = "/{salesId}/remove", method = GET)
    public String remove(@PathVariable("salesId") Integer salesId, Model model) {
        busiSalesService.remove(salesId);
        return "redirect:/busiSales";
    }
    
    @RequestMapping(value = "/ajaxFindSalesBySalesCode", method = GET)
    @ResponseBody
    public JSONArray ajaxFindSalesBySalesCode(@RequestParam("term") String term) {
        
    	List<BusiSales> busiSalesList = busiSalesService.findSalesBySalesCode(term);
    	
    	JSONArray result = new JSONArray();
    	for (BusiSales busiSales : busiSalesList) {
    		JSONObject jsonObject = getJsonObject(busiSales);
    		result.add(jsonObject);
		}
    	
    	return result;
    }

	private JSONObject getJsonObject(BusiSales busiSales) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.element("label", String.format("%s %s %s", busiSales.getSalesCode(), busiSales.getBusiClient().getClientName(), busiSales.getBusiClient().getCellPhone()));
		jsonObject.element("value", busiSales.getSalesCode());
		jsonObject.element("clientName", busiSales.getBusiClient().getClientName());
		jsonObject.element("address", busiSales.getBusiClient().getAddress());
		jsonObject.element("areacode", busiSales.getBusiClient().getAreacode());
		jsonObject.element("phone", busiSales.getBusiClient().getPhone());
		jsonObject.element("cellPhone", busiSales.getBusiClient().getCellPhone());
		jsonObject.element("deptName", busiSales.getSysDept().getDeptName());
		jsonObject.element("sysUser", busiSales.getHandleUser());
		jsonObject.element("salesCode", busiSales.getSalesCode());
		jsonObject.element("salesRemarks", busiSales.getSalesRemarks());
		jsonObject.element("salesId", busiSales.getSalesId());
		jsonObject.element("servLogis", dictionaryHelper.lookupDictValue0("serv_logis",  busiSales.getServGetmethodKey()));
		jsonObject.element("servGetmethod", dictionaryHelper.lookupDictValue0("serv_getmethod",  busiSales.getServGetmethodKey()));
		jsonObject.element("servInstallmethod", dictionaryHelper.lookupDictValue0("serv_logis",  busiSales.getServInstallmethodKey()));
		jsonObject.element("feeSum", busiSales.getFeeSum());
		jsonObject.element("feePrepayCash", busiSales.getFeePrepayCash());
		jsonObject.element("feePrepayCard", busiSales.getFeePrepayCard());
		jsonObject.element("feePrepayRemain", busiSales.getFeeRemain());
		jsonObject.element("otherRemarks", busiSales.getOtherRemarks());
		return jsonObject;
	}
    
    @RequestMapping(value = "/ajaxFindSalesByClientCellPhone", method = GET)
    @ResponseBody
    public JSONArray ajaxFindSalesByClientCellPhone(@RequestParam("term") String term) {
        
    	List<BusiSales> busiSalesList = busiSalesService.findSalesByClientCellPhone(term);
    	
    	JSONArray result = new JSONArray();
    	for (BusiSales busiSales : busiSalesList) {
    		JSONObject jsonObject = getJsonObject(busiSales);
    		result.add(jsonObject);
		}
    	
    	return result;

    }
    
}

