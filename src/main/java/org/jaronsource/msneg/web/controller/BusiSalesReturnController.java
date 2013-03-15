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

import org.jaronsource.msneg.domain.BusiSalesReturn;
import org.jaronsource.msneg.service.BusiSalesReturnService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiSalesReturn")
@Controller
public class BusiSalesReturnController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesReturnController.class);	
	
	@Autowired
	private BusiSalesReturnService busiSalesReturnService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiSalesReturn> busiSalesReturnPage = busiSalesReturnService.findPage(searchForm);
		model.addAttribute("busiSalesReturnPage", busiSalesReturnPage);
		
		return "busiSalesReturn/list";
	}
	
	@RequestMapping(value = "/{returnId}/update", method = GET)
    public String update(@PathVariable("returnId") Integer returnId, Model model) {
        model.addAttribute("busiSalesReturn", busiSalesReturnService.findByPk(returnId));
        return "busiSalesReturn/update";
	}	
	
	@RequestMapping(value = "/{returnId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiSalesReturn busiSalesReturn, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesReturn", busiSalesReturn);
            return "busiSalesReturn/update";
        }

        busiSalesReturnService.save(busiSalesReturn);
        return "redirect:/busiSalesReturn/" + busiSalesReturn.getReturnId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiSalesReturn busiSalesReturn = new BusiSalesReturn();
        model.addAttribute("busiSalesReturn", busiSalesReturn);
        return "busiSalesReturn/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSalesReturn busiSalesReturn, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesReturn", busiSalesReturn);
            return "busiSalesReturn/create";
        }

        busiSalesReturnService.save(busiSalesReturn);
        return "redirect:/busiSalesReturn/" + busiSalesReturn.getReturnId() + "/show";
    }	
	
	@RequestMapping(value = "/{returnId}/show", method = GET)
    public String show(@PathVariable("returnId") Integer returnId, Model model) {
        BusiSalesReturn busiSalesReturn = busiSalesReturnService.findByPk(returnId);
		model.addAttribute("busiSalesReturn", busiSalesReturn);
        return "busiSalesReturn/show";
    }
    
    @RequestMapping(value = "/{returnId}/remove", method = GET)
    public String remove(@PathVariable("returnId") Integer returnId, Model model) {
        busiSalesReturnService.remove(returnId);
        return "redirect:/busiSalesReturn";
    }
}

