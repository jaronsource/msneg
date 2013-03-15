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

import org.jaronsource.msneg.domain.BusiSales;
import org.jaronsource.msneg.service.BusiSalesService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiSales")
@Controller
public class BusiSalesController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesController.class);	
	
	@Autowired
	private BusiSalesService busiSalesService;
	
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
        model.addAttribute("busiSales", busiSales);
        return "busiSales/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSales busiSales, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSales", busiSales);
            return "busiSales/create";
        }

        busiSalesService.save(busiSales);
        return "redirect:/busiSales/" + busiSales.getSalesId() + "/show";
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
}

