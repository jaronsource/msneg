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

import org.jaronsource.msneg.domain.BusiSalesMakeup;
import org.jaronsource.msneg.service.BusiSalesMakeupService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiSalesMakeup")
@Controller
public class BusiSalesMakeupController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesMakeupController.class);	
	
	@Autowired
	private BusiSalesMakeupService busiSalesMakeupService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiSalesMakeup> busiSalesMakeupPage = busiSalesMakeupService.findPage(searchForm);
		model.addAttribute("busiSalesMakeupPage", busiSalesMakeupPage);
		
		return "busiSalesMakeup/list";
	}
	
	@RequestMapping(value = "/{makeupId}/update", method = GET)
    public String update(@PathVariable("makeupId") Integer makeupId, Model model) {
        model.addAttribute("busiSalesMakeup", busiSalesMakeupService.findByPk(makeupId));
        return "busiSalesMakeup/update";
	}	
	
	@RequestMapping(value = "/{makeupId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiSalesMakeup busiSalesMakeup, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesMakeup", busiSalesMakeup);
            return "busiSalesMakeup/update";
        }

        busiSalesMakeupService.save(busiSalesMakeup);
        return "redirect:/busiSalesMakeup/" + busiSalesMakeup.getMakeupId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiSalesMakeup busiSalesMakeup = new BusiSalesMakeup();
        model.addAttribute("busiSalesMakeup", busiSalesMakeup);
        return "busiSalesMakeup/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSalesMakeup busiSalesMakeup, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesMakeup", busiSalesMakeup);
            return "busiSalesMakeup/create";
        }

        busiSalesMakeupService.save(busiSalesMakeup);
        return "redirect:/busiSalesMakeup/" + busiSalesMakeup.getMakeupId() + "/show";
    }	
	
	@RequestMapping(value = "/{makeupId}/show", method = GET)
    public String show(@PathVariable("makeupId") Integer makeupId, Model model) {
        BusiSalesMakeup busiSalesMakeup = busiSalesMakeupService.findByPk(makeupId);
		model.addAttribute("busiSalesMakeup", busiSalesMakeup);
        return "busiSalesMakeup/show";
    }
    
    @RequestMapping(value = "/{makeupId}/remove", method = GET)
    public String remove(@PathVariable("makeupId") Integer makeupId, Model model) {
        busiSalesMakeupService.remove(makeupId);
        return "redirect:/busiSalesMakeup";
    }
}

