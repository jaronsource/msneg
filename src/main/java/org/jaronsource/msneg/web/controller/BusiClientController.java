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

import org.jaronsource.msneg.domain.BusiClient;
import org.jaronsource.msneg.service.BusiClientService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiClient")
@Controller
public class BusiClientController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiClientController.class);	
	
	@Autowired
	private BusiClientService busiClientService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiClient> busiClientPage = busiClientService.findPage(searchForm);
		model.addAttribute("busiClientPage", busiClientPage);
		
		return "busiClient/list";
	}
	
	@RequestMapping(value = "/{clientId}/update", method = GET)
    public String update(@PathVariable("clientId") Integer clientId, Model model) {
        model.addAttribute("busiClient", busiClientService.findByPk(clientId));
        return "busiClient/update";
	}	
	
	@RequestMapping(value = "/{clientId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiClient busiClient, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiClient", busiClient);
            return "busiClient/update";
        }

        busiClientService.save(busiClient);
        return "redirect:/busiClient/" + busiClient.getClientId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiClient busiClient = new BusiClient();
        model.addAttribute("busiClient", busiClient);
        return "busiClient/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiClient busiClient, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiClient", busiClient);
            return "busiClient/create";
        }

        busiClientService.save(busiClient);
        return "redirect:/busiClient/" + busiClient.getClientId() + "/show";
    }	
	
	@RequestMapping(value = "/{clientId}/show", method = GET)
    public String show(@PathVariable("clientId") Integer clientId, Model model) {
        BusiClient busiClient = busiClientService.findByPk(clientId);
		model.addAttribute("busiClient", busiClient);
        return "busiClient/show";
    }
    
    @RequestMapping(value = "/{clientId}/remove", method = GET)
    public String remove(@PathVariable("clientId") Integer clientId, Model model) {
        busiClientService.remove(clientId);
        return "redirect:/busiClient";
    }
}

