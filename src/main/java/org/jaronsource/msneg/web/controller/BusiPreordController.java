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

import org.jaronsource.msneg.domain.BusiPreord;
import org.jaronsource.msneg.service.BusiPreordService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.spring.RequestHistory;
import com.ccesun.framework.core.web.controller.BaseController;
import com.ccesun.framework.util.BeanUtils;
import com.ccesun.framework.util.DateUtils;

@RequestMapping("/busiPreord")
@Controller
public class BusiPreordController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiPreordController.class);	
	
	@Autowired
	private BusiPreordService busiPreordService;
	
	@RequestMapping(method = {GET, POST})
	@RequestHistory
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiPreord> busiPreordPage = busiPreordService.findPage(searchForm);
		model.addAttribute("busiPreordPage", busiPreordPage);
		
		return "busiPreord/list";
	}
	
	@RequestMapping(value = "/{preordId}/update", method = GET)
    public String update(@PathVariable("preordId") Integer preordId, Model model) {
        model.addAttribute("busiPreord", busiPreordService.findByPk(preordId));
        model.addAttribute("preordId", preordId);
        return "busiPreord/update";
	}	
	
	@RequestMapping(value = "/{preordId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiPreord busiPreord, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiPreord", busiPreord);
            return "busiPreord/update";
        }
        
        BusiPreord original = busiPreordService.findByPk(busiPreord.getPreordId());
        BeanUtils.mergeProperties(original, busiPreord);
        busiPreordService.save(original);
        return "history:/busiPreord";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiPreord busiPreord = new BusiPreord();
        model.addAttribute("busiPreord", busiPreord);
        return "busiPreord/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiPreord busiPreord, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiPreord", busiPreord);
            return "busiPreord/create";
        }
        
        String currentDatetime = DateUtils.currentDateTime();
        busiPreord.setCreateTime(currentDatetime);
        busiPreord.setPreordStateKey("A");
        busiPreordService.save(busiPreord);
        return "history:/busiPreord";
    }	
	
	@RequestMapping(value = "/{preordId}/show", method = GET)
    public String show(@PathVariable("preordId") Integer preordId, Model model) {
        BusiPreord busiPreord = busiPreordService.findByPk(preordId);
		model.addAttribute("busiPreord", busiPreord);
        return "busiPreord/show";
    }
    
    @RequestMapping(value = "/{preordId}/remove", method = GET)
    public String remove(@PathVariable("preordId") Integer preordId, Model model) {
        busiPreordService.remove(preordId);
        return "history:/busiPreord";
    }
}

