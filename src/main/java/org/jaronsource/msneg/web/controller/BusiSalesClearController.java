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

import org.jaronsource.msneg.domain.BusiSalesClear;
import org.jaronsource.msneg.service.BusiSalesClearService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiSalesClear")
@Controller
public class BusiSalesClearController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesClearController.class);	
	
	@Autowired
	private BusiSalesClearService busiSalesClearService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiSalesClear> busiSalesClearPage = busiSalesClearService.findPage(searchForm);
		model.addAttribute("busiSalesClearPage", busiSalesClearPage);
		
		return "busiSalesClear/list";
	}
	
	@RequestMapping(value = "/{clearId}/update", method = GET)
    public String update(@PathVariable("clearId") Integer clearId, Model model) {
        model.addAttribute("busiSalesClear", busiSalesClearService.findByPk(clearId));
        return "busiSalesClear/update";
	}	
	
	@RequestMapping(value = "/{clearId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiSalesClear busiSalesClear, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesClear", busiSalesClear);
            return "busiSalesClear/update";
        }

        busiSalesClearService.save(busiSalesClear);
        return "redirect:/busiSalesClear/" + busiSalesClear.getClearId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiSalesClear busiSalesClear = new BusiSalesClear();
        model.addAttribute("busiSalesClear", busiSalesClear);
        return "busiSalesClear/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSalesClear busiSalesClear, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesClear", busiSalesClear);
            return "busiSalesClear/create";
        }

        busiSalesClearService.save(busiSalesClear);
        return "redirect:/busiSalesClear/" + busiSalesClear.getClearId() + "/show";
    }	
	
	@RequestMapping(value = "/{clearId}/show", method = GET)
    public String show(@PathVariable("clearId") Integer clearId, Model model) {
        BusiSalesClear busiSalesClear = busiSalesClearService.findByPk(clearId);
		model.addAttribute("busiSalesClear", busiSalesClear);
        return "busiSalesClear/show";
    }
    
    @RequestMapping(value = "/{clearId}/remove", method = GET)
    public String remove(@PathVariable("clearId") Integer clearId, Model model) {
        busiSalesClearService.remove(clearId);
        return "redirect:/busiSalesClear";
    }
}

