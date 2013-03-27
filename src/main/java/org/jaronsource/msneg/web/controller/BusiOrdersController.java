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

import org.jaronsource.msneg.domain.BusiOrders;
import org.jaronsource.msneg.service.BusiOrdersService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiOrders")
@Controller
public class BusiOrdersController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiOrdersController.class);	
	
	@Autowired
	private BusiOrdersService busiOrdersService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiOrders> busiOrdersPage = busiOrdersService.findPage(searchForm);
		model.addAttribute("busiOrdersPage", busiOrdersPage);
		
		return "busiOrders/list";
	}
	
	@RequestMapping(value = "/{ordersId}/update", method = GET)
    public String update(@PathVariable("ordersId") Integer ordersId, Model model) {
        model.addAttribute("busiOrders", busiOrdersService.findByPk(ordersId));
        return "busiOrders/update";
	}	
	
	@RequestMapping(value = "/{ordersId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiOrders busiOrders, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiOrders", busiOrders);
            return "busiOrders/update";
        }

        busiOrdersService.save(busiOrders);
        return "redirect:/busiOrders/" + busiOrders.getOrdersId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiOrders busiOrders = new BusiOrders();
        model.addAttribute("busiOrders", busiOrders);
        return "busiOrders/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiOrders busiOrders, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiOrders", busiOrders);
            return "busiOrders/create";
        }

        busiOrdersService.save(busiOrders);
        return "redirect:/busiOrders/" + busiOrders.getOrdersId() + "/show";
    }	
	
	@RequestMapping(value = "/{ordersId}/show", method = GET)
    public String show(@PathVariable("ordersId") Integer ordersId, Model model) {
        BusiOrders busiOrders = busiOrdersService.findByPk(ordersId);
		model.addAttribute("busiOrders", busiOrders);
        return "busiOrders/show";
    }
    
    @RequestMapping(value = "/{ordersId}/remove", method = GET)
    public String remove(@PathVariable("ordersId") Integer ordersId, Model model) {
        busiOrdersService.remove(ordersId);
        return "redirect:/busiOrders";
    }
}

