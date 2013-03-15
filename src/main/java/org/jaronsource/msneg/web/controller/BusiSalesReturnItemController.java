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

import org.jaronsource.msneg.domain.BusiSalesReturnItem;
import org.jaronsource.msneg.service.BusiSalesReturnItemService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiSalesReturnItem")
@Controller
public class BusiSalesReturnItemController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesReturnItemController.class);	
	
	@Autowired
	private BusiSalesReturnItemService busiSalesReturnItemService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiSalesReturnItem> busiSalesReturnItemPage = busiSalesReturnItemService.findPage(searchForm);
		model.addAttribute("busiSalesReturnItemPage", busiSalesReturnItemPage);
		
		return "busiSalesReturnItem/list";
	}
	
	@RequestMapping(value = "/{returnItemId}/update", method = GET)
    public String update(@PathVariable("returnItemId") Integer returnItemId, Model model) {
        model.addAttribute("busiSalesReturnItem", busiSalesReturnItemService.findByPk(returnItemId));
        return "busiSalesReturnItem/update";
	}	
	
	@RequestMapping(value = "/{returnItemId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiSalesReturnItem busiSalesReturnItem, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesReturnItem", busiSalesReturnItem);
            return "busiSalesReturnItem/update";
        }

        busiSalesReturnItemService.save(busiSalesReturnItem);
        return "redirect:/busiSalesReturnItem/" + busiSalesReturnItem.getReturnItemId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiSalesReturnItem busiSalesReturnItem = new BusiSalesReturnItem();
        model.addAttribute("busiSalesReturnItem", busiSalesReturnItem);
        return "busiSalesReturnItem/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSalesReturnItem busiSalesReturnItem, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesReturnItem", busiSalesReturnItem);
            return "busiSalesReturnItem/create";
        }

        busiSalesReturnItemService.save(busiSalesReturnItem);
        return "redirect:/busiSalesReturnItem/" + busiSalesReturnItem.getReturnItemId() + "/show";
    }	
	
	@RequestMapping(value = "/{returnItemId}/show", method = GET)
    public String show(@PathVariable("returnItemId") Integer returnItemId, Model model) {
        BusiSalesReturnItem busiSalesReturnItem = busiSalesReturnItemService.findByPk(returnItemId);
		model.addAttribute("busiSalesReturnItem", busiSalesReturnItem);
        return "busiSalesReturnItem/show";
    }
    
    @RequestMapping(value = "/{returnItemId}/remove", method = GET)
    public String remove(@PathVariable("returnItemId") Integer returnItemId, Model model) {
        busiSalesReturnItemService.remove(returnItemId);
        return "redirect:/busiSalesReturnItem";
    }
}

