package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.List;

import javax.validation.Valid;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.jaronsource.msneg.domain.BusiItem;
import org.jaronsource.msneg.service.BusiItemService;
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

@RequestMapping("/busiItem")
@Controller
public class BusiItemController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiItemController.class);	
	
	@Autowired
	private BusiItemService busiItemService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiItem> busiItemPage = busiItemService.findPage(searchForm);
		model.addAttribute("busiItemPage", busiItemPage);
		
		return "busiItem/list";
	}
	
	@RequestMapping(value = "/{itemId}/update", method = GET)
    public String update(@PathVariable("itemId") Integer itemId, Model model) {
        model.addAttribute("busiItem", busiItemService.findByPk(itemId));
        return "busiItem/update";
	}	
	
	@RequestMapping(value = "/{itemId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiItem busiItem, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiItem", busiItem);
            return "busiItem/update";
        }

        busiItemService.save(busiItem);
        return "redirect:/busiItem/" + busiItem.getItemId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiItem busiItem = new BusiItem();
        model.addAttribute("busiItem", busiItem);
        return "busiItem/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiItem busiItem, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiItem", busiItem);
            return "busiItem/create";
        }

        busiItemService.save(busiItem);
        return "redirect:/busiItem/" + busiItem.getItemId() + "/show";
    }	
	
	@RequestMapping(value = "/{itemId}/show", method = GET)
    public String show(@PathVariable("itemId") Integer itemId, Model model) {
        BusiItem busiItem = busiItemService.findByPk(itemId);
		model.addAttribute("busiItem", busiItem);
        return "busiItem/show";
    }
    
    @RequestMapping(value = "/{itemId}/remove", method = GET)
    public String remove(@PathVariable("itemId") Integer itemId, Model model) {
        busiItemService.remove(itemId);
        return "redirect:/busiItem";
    }
    
    @RequestMapping(value = "/ajaxFindItem", method = GET)
    @ResponseBody
    public JSONArray ajaxFindItem(@RequestParam("itemType") String itemType, @RequestParam("term") String term) {
        
    	List<BusiItem> busiItemList = busiItemService.findItemByTypeAndTerm(itemType, term);
    	
    	JSONArray result = new JSONArray();
    	for (BusiItem busiItem : busiItemList) {
    		JSONObject jsonObject = new JSONObject();
    		jsonObject.element("label", String.format("%s %s %s", busiItem.getItemCode(), busiItem.getItemName(), busiItem.getItemFormat()));
    		jsonObject.element("value", busiItem.getItemCode());
    		jsonObject.element("itemId", busiItem.getItemId());
    		jsonObject.element("unit", busiItem.getItemUnit());
    		jsonObject.element("price", MoneyUtils.encode(busiItem.getItemPrice()));
    		jsonObject.element("stockAmount", busiItem.getItemStockAmount());
    		result.add(jsonObject);
		}
    	
    	return result;

    }
}

