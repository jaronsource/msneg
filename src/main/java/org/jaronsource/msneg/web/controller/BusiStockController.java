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

import org.jaronsource.msneg.domain.BusiStock;
import org.jaronsource.msneg.service.BusiStockService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiStock")
@Controller
public class BusiStockController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiStockController.class);	
	
	@Autowired
	private BusiStockService busiStockService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiStock> busiStockPage = busiStockService.findPage(searchForm);
		model.addAttribute("busiStockPage", busiStockPage);
		
		return "busiStock/list";
	}
	
	@RequestMapping(value = "/{stockId}/update", method = GET)
    public String update(@PathVariable("stockId") Integer stockId, Model model) {
        model.addAttribute("busiStock", busiStockService.findByPk(stockId));
        return "busiStock/update";
	}	
	
	@RequestMapping(value = "/{stockId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiStock busiStock, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiStock", busiStock);
            return "busiStock/update";
        }

        busiStockService.save(busiStock);
        return "redirect:/busiStock/" + busiStock.getStockId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiStock busiStock = new BusiStock();
        model.addAttribute("busiStock", busiStock);
        return "busiStock/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiStock busiStock, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiStock", busiStock);
            return "busiStock/create";
        }

        busiStockService.save(busiStock);
        return "redirect:/busiStock/" + busiStock.getStockId() + "/show";
    }	
	
	@RequestMapping(value = "/{stockId}/show", method = GET)
    public String show(@PathVariable("stockId") Integer stockId, Model model) {
        BusiStock busiStock = busiStockService.findByPk(stockId);
		model.addAttribute("busiStock", busiStock);
        return "busiStock/show";
    }
    
    @RequestMapping(value = "/{stockId}/remove", method = GET)
    public String remove(@PathVariable("stockId") Integer stockId, Model model) {
        busiStockService.remove(stockId);
        return "redirect:/busiStock";
    }
}

