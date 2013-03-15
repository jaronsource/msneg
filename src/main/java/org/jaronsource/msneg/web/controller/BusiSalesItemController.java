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

import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.service.BusiSalesItemService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiSalesItem")
@Controller
public class BusiSalesItemController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesItemController.class);	
	
	@Autowired
	private BusiSalesItemService busiSalesItemService;
	
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
}

