package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.jaronsource.msneg.domain.BusiItem;
import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.service.BusiSalesService;
import org.jaronsource.msneg.utils.MoneyUtils;
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
import com.ccesun.framework.util.NumberUtils;
import com.ccesun.framework.util.StringUtils;

@RequestMapping("/busiSales")
@Controller
public class BusiSalesController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesController.class);	
	
	@Autowired
	private BusiSalesService busiSalesService;
	
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
		
		String salesCode = busiSalesService.generateSalesCode();
		
        model.addAttribute("form", form);
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
		String[] itemIds = requst.getParameterValues("itemId");
		String[] itemAmounts = requst.getParameterValues("itemAmount");
		String[] itemSums = requst.getParameterValues("itemSum");
		String[] itemRemarks = requst.getParameterValues("itemRemarks");
		
		List<BusiSalesItem> busiSalesItems = new ArrayList<BusiSalesItem>();
		for (int i = 0; i < itemIds.length; i++) {
			if (StringUtils.isNotBlank(itemIds[i])) {
				BusiSalesItem busiSalesItem = new BusiSalesItem();
				busiSalesItem.setItemAmount(NumberUtils.toInt(itemAmounts[i]));
				busiSalesItem.setItemRemarks(itemRemarks[i]);
				busiSalesItem.setItemSum(MoneyUtils.decode(itemSums[i]));
				busiSalesItem.setBusiItem(new BusiItem(NumberUtils.toInt(itemIds[i])));
				busiSalesItems.add(busiSalesItem);
			}
		}
		
		busiSalesService.save(busiSalesForm.getBusiSales(), busiSalesItems);
		
        return "redirect:/busiSales/create";
    }	
	
	@RequestMapping(value = "/{salesId}/show", method = GET)
    public String show(@PathVariable("salesId") Integer salesId, Model model) {
        BusiSales busiSales = busiSalesService.findByPk(salesId);
		model.addAttribute("busiSales", busiSales);
        return "busiSales/show";
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
		jsonObject.element("sysUser", busiSales.getBusiClient().getCellPhone());
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

