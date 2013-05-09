package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.List;

import javax.validation.Valid;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.service.BusiSalesItemService;
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

@RequestMapping("/busiSalesItem")
@Controller
public class BusiSalesItemController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesItemController.class);	
	
	@Autowired
	private BusiSalesItemService busiSalesItemService;
	
	@Autowired
	private DictionaryHelper dictionaryHelper;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiSalesItem> busiSalesItemPage = busiSalesItemService.findPage(searchForm);
		model.addAttribute("busiSalesItemPage", busiSalesItemPage);
		
		return "busiSalesItem/list";
	}
	
	@RequestMapping(value = "/{salesItemId}/update", method = GET)
    public String update(@PathVariable("salesItemId") Integer salesItemId, Model model) {
        model.addAttribute("busiSalesItem", busiSalesItemService.findByPk(salesItemId));
        return "busiSalesItem/update";
	}	
	
	@RequestMapping(value = "/{salesItemId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiSalesItem busiSalesItem, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesItem", busiSalesItem);
            return "busiSalesItem/update";
        }

        busiSalesItemService.save(busiSalesItem);
        return "redirect:/busiSalesItem/" + busiSalesItem.getSalesItemId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiSalesItem busiSalesItem = new BusiSalesItem();
        model.addAttribute("busiSalesItem", busiSalesItem);
        return "busiSalesItem/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSalesItem busiSalesItem, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesItem", busiSalesItem);
            return "busiSalesItem/create";
        }

        busiSalesItemService.save(busiSalesItem);
        return "redirect:/busiSalesItem/" + busiSalesItem.getSalesItemId() + "/show";
    }	
	
	@RequestMapping(value = "/{salesItemId}/show", method = GET)
    public String show(@PathVariable("salesItemId") Integer salesItemId, Model model) {
        BusiSalesItem busiSalesItem = busiSalesItemService.findByPk(salesItemId);
		model.addAttribute("busiSalesItem", busiSalesItem);
        return "busiSalesItem/show";
    }
    
    @RequestMapping(value = "/{salesItemId}/remove", method = GET)
    public String remove(@PathVariable("salesItemId") Integer salesItemId, Model model) {
        busiSalesItemService.remove(salesItemId);
        return "redirect:/busiSalesItem";
    }
    
    @RequestMapping(value = "/ajaxFindSalesItem", method = GET)
    @ResponseBody
    public JSONArray ajaxFindSalesItem(@RequestParam(value = "salesId", required = false) Integer salesId) {
        
    	List<BusiSalesItem> busiSalesItemList = busiSalesItemService.findSalesItemBySalesId(salesId);
    	
    	JSONArray result = new JSONArray();
    	for (BusiSalesItem busiSalesItem : busiSalesItemList) {
    		JSONObject jsonObject = new JSONObject();
    		jsonObject.element("salesItemId", busiSalesItem.getSalesItemId());
    		jsonObject.element("itemName", busiSalesItem.getItemName());
    		jsonObject.element("itemUnit", dictionaryHelper.lookupDictValue0("item_unit", busiSalesItem.getItemUnitKey()));
    		jsonObject.element("itemPrice", busiSalesItem.getItemPrice().toString());
    		jsonObject.element("itemSum", busiSalesItem.getItemSum().toString());
    		jsonObject.element("itemAmount", busiSalesItem.getItemAmount());
    		jsonObject.element("itemRemarks", busiSalesItem.getItemRemarks());
    		jsonObject.element("category", busiSalesItem.getBusiCategory().getCateName());
    		result.add(jsonObject);
		}
    	
    	return result;

    }
    
}

