package org.jaronsource.msneg.web.controller;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import org.jaronsource.msneg.domain.BusiSalesBrokerageItem;
import org.jaronsource.msneg.service.BusiSalesBrokerageItemService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiSalesBrokerageItem")
@Controller
public class BusiSalesBrokerageItemController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesBrokerageItemController.class);	
	
	@Autowired
	private BusiSalesBrokerageItemService busiSalesBrokerageItemService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiSalesBrokerageItem> busiSalesBrokerageItemPage = busiSalesBrokerageItemService.findPage(searchForm);
		model.addAttribute("busiSalesBrokerageItemPage", busiSalesBrokerageItemPage);
		
		return "busiSalesBrokerageItem/list";
	}
	
	@RequestMapping(value = "/{brokItemId}/update", method = GET)
    public String update(@PathVariable("brokItemId") Integer brokItemId, Model model) {
        model.addAttribute("busiSalesBrokerageItem", busiSalesBrokerageItemService.findByPk(brokItemId));
        return "busiSalesBrokerageItem/update";
	}	
	
	@RequestMapping(value = "/{brokItemId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiSalesBrokerageItem busiSalesBrokerageItem, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesBrokerageItem", busiSalesBrokerageItem);
            return "busiSalesBrokerageItem/update";
        }

        busiSalesBrokerageItemService.save(busiSalesBrokerageItem);
        return "redirect:/busiSalesBrokerageItem/" + busiSalesBrokerageItem.getBrokItemId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiSalesBrokerageItem busiSalesBrokerageItem = new BusiSalesBrokerageItem();
        model.addAttribute("busiSalesBrokerageItem", busiSalesBrokerageItem);
        return "busiSalesBrokerageItem/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSalesBrokerageItem busiSalesBrokerageItem, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesBrokerageItem", busiSalesBrokerageItem);
            return "busiSalesBrokerageItem/create";
        }

        busiSalesBrokerageItemService.save(busiSalesBrokerageItem);
        return "redirect:/busiSalesBrokerageItem/" + busiSalesBrokerageItem.getBrokItemId() + "/show";
    }	
	
	@RequestMapping(value = "/{brokItemId}/show", method = GET)
    public String show(@PathVariable("brokItemId") Integer brokItemId, Model model) {
        BusiSalesBrokerageItem busiSalesBrokerageItem = busiSalesBrokerageItemService.findByPk(brokItemId);
		model.addAttribute("busiSalesBrokerageItem", busiSalesBrokerageItem);
        return "busiSalesBrokerageItem/show";
    }
    
    @RequestMapping(value = "/{brokItemId}/remove", method = GET)
    public String remove(@PathVariable("brokItemId") Integer brokItemId, Model model) {
        busiSalesBrokerageItemService.remove(brokItemId);
        return "redirect:/busiSalesBrokerageItem";
    }
}

