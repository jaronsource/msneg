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

import org.jaronsource.msneg.domain.BusiSalesWorkingItem;
import org.jaronsource.msneg.service.BusiSalesWorkingItemService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiSalesWorkingItem")
@Controller
public class BusiSalesWorkingItemController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesWorkingItemController.class);	
	
	@Autowired
	private BusiSalesWorkingItemService busiSalesWorkingItemService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiSalesWorkingItem> busiSalesWorkingItemPage = busiSalesWorkingItemService.findPage(searchForm);
		model.addAttribute("busiSalesWorkingItemPage", busiSalesWorkingItemPage);
		
		return "busiSalesWorkingItem/list";
	}
	
	@RequestMapping(value = "/{workingItemId}/update", method = GET)
    public String update(@PathVariable("workingItemId") Integer workingItemId, Model model) {
        model.addAttribute("busiSalesWorkingItem", busiSalesWorkingItemService.findByPk(workingItemId));
        return "busiSalesWorkingItem/update";
	}	
	
	@RequestMapping(value = "/{workingItemId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiSalesWorkingItem busiSalesWorkingItem, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesWorkingItem", busiSalesWorkingItem);
            return "busiSalesWorkingItem/update";
        }

        busiSalesWorkingItemService.save(busiSalesWorkingItem);
        return "redirect:/busiSalesWorkingItem/" + busiSalesWorkingItem.getWorkingItemId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiSalesWorkingItem busiSalesWorkingItem = new BusiSalesWorkingItem();
        model.addAttribute("busiSalesWorkingItem", busiSalesWorkingItem);
        return "busiSalesWorkingItem/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSalesWorkingItem busiSalesWorkingItem, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesWorkingItem", busiSalesWorkingItem);
            return "busiSalesWorkingItem/create";
        }

        busiSalesWorkingItemService.save(busiSalesWorkingItem);
        return "redirect:/busiSalesWorkingItem/" + busiSalesWorkingItem.getWorkingItemId() + "/show";
    }	
	
	@RequestMapping(value = "/{workingItemId}/show", method = GET)
    public String show(@PathVariable("workingItemId") Integer workingItemId, Model model) {
        BusiSalesWorkingItem busiSalesWorkingItem = busiSalesWorkingItemService.findByPk(workingItemId);
		model.addAttribute("busiSalesWorkingItem", busiSalesWorkingItem);
        return "busiSalesWorkingItem/show";
    }
    
    @RequestMapping(value = "/{workingItemId}/remove", method = GET)
    public String remove(@PathVariable("workingItemId") Integer workingItemId, Model model) {
        busiSalesWorkingItemService.remove(workingItemId);
        return "redirect:/busiSalesWorkingItem";
    }
}

