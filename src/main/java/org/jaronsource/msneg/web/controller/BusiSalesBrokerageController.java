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

import org.jaronsource.msneg.domain.BusiSalesBrokerage;
import org.jaronsource.msneg.service.BusiSalesBrokerageService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiSalesBrokerage")
@Controller
public class BusiSalesBrokerageController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesBrokerageController.class);	
	
	@Autowired
	private BusiSalesBrokerageService busiSalesBrokerageService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiSalesBrokerage> busiSalesBrokeragePage = busiSalesBrokerageService.findPage(searchForm);
		model.addAttribute("busiSalesBrokeragePage", busiSalesBrokeragePage);
		
		return "busiSalesBrokerage/list";
	}
	
	@RequestMapping(value = "/{brokId}/update", method = GET)
    public String update(@PathVariable("brokId") Integer brokId, Model model) {
        model.addAttribute("busiSalesBrokerage", busiSalesBrokerageService.findByPk(brokId));
        return "busiSalesBrokerage/update";
	}	
	
	@RequestMapping(value = "/{brokId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiSalesBrokerage busiSalesBrokerage, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesBrokerage", busiSalesBrokerage);
            return "busiSalesBrokerage/update";
        }

        busiSalesBrokerageService.save(busiSalesBrokerage);
        return "redirect:/busiSalesBrokerage/" + busiSalesBrokerage.getBrokId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiSalesBrokerage busiSalesBrokerage = new BusiSalesBrokerage();
        model.addAttribute("busiSalesBrokerage", busiSalesBrokerage);
        return "busiSalesBrokerage/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSalesBrokerage busiSalesBrokerage, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesBrokerage", busiSalesBrokerage);
            return "busiSalesBrokerage/create";
        }

        busiSalesBrokerageService.save(busiSalesBrokerage);
        return "redirect:/busiSalesBrokerage/" + busiSalesBrokerage.getBrokId() + "/show";
    }	
	
	@RequestMapping(value = "/{brokId}/show", method = GET)
    public String show(@PathVariable("brokId") Integer brokId, Model model) {
        BusiSalesBrokerage busiSalesBrokerage = busiSalesBrokerageService.findByPk(brokId);
		model.addAttribute("busiSalesBrokerage", busiSalesBrokerage);
        return "busiSalesBrokerage/show";
    }
    
    @RequestMapping(value = "/{brokId}/remove", method = GET)
    public String remove(@PathVariable("brokId") Integer brokId, Model model) {
        busiSalesBrokerageService.remove(brokId);
        return "redirect:/busiSalesBrokerage";
    }
}

