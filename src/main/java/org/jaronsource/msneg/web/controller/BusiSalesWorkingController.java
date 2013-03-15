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

import org.jaronsource.msneg.domain.BusiSalesWorking;
import org.jaronsource.msneg.service.BusiSalesWorkingService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiSalesWorking")
@Controller
public class BusiSalesWorkingController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesWorkingController.class);	
	
	@Autowired
	private BusiSalesWorkingService busiSalesWorkingService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiSalesWorking> busiSalesWorkingPage = busiSalesWorkingService.findPage(searchForm);
		model.addAttribute("busiSalesWorkingPage", busiSalesWorkingPage);
		
		return "busiSalesWorking/list";
	}
	
	@RequestMapping(value = "/{workingId}/update", method = GET)
    public String update(@PathVariable("workingId") Integer workingId, Model model) {
        model.addAttribute("busiSalesWorking", busiSalesWorkingService.findByPk(workingId));
        return "busiSalesWorking/update";
	}	
	
	@RequestMapping(value = "/{workingId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiSalesWorking busiSalesWorking, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesWorking", busiSalesWorking);
            return "busiSalesWorking/update";
        }

        busiSalesWorkingService.save(busiSalesWorking);
        return "redirect:/busiSalesWorking/" + busiSalesWorking.getWorkingId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiSalesWorking busiSalesWorking = new BusiSalesWorking();
        model.addAttribute("busiSalesWorking", busiSalesWorking);
        return "busiSalesWorking/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSalesWorking busiSalesWorking, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesWorking", busiSalesWorking);
            return "busiSalesWorking/create";
        }

        busiSalesWorkingService.save(busiSalesWorking);
        return "redirect:/busiSalesWorking/" + busiSalesWorking.getWorkingId() + "/show";
    }	
	
	@RequestMapping(value = "/{workingId}/show", method = GET)
    public String show(@PathVariable("workingId") Integer workingId, Model model) {
        BusiSalesWorking busiSalesWorking = busiSalesWorkingService.findByPk(workingId);
		model.addAttribute("busiSalesWorking", busiSalesWorking);
        return "busiSalesWorking/show";
    }
    
    @RequestMapping(value = "/{workingId}/remove", method = GET)
    public String remove(@PathVariable("workingId") Integer workingId, Model model) {
        busiSalesWorkingService.remove(workingId);
        return "redirect:/busiSalesWorking";
    }
}

