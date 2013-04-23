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

import org.jaronsource.msneg.domain.SysFunc;
import org.jaronsource.msneg.service.SysFuncService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/sysConfig/func")
@Controller
public class SysFuncController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(SysFuncController.class);	
	
	@Autowired
	private SysFuncService sysFuncService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<SysFunc> sysFuncPage = sysFuncService.findPage(searchForm);
		model.addAttribute("sysFuncPage", sysFuncPage);
		
		return "sysConfig/func/list";
	}
	
	@RequestMapping(value = "/{funcId}/update", method = GET)
    public String update(@PathVariable("funcId") Integer funcId, Model model) {
        model.addAttribute("sysFunc", sysFuncService.findByPk(funcId));
        return "sysConfig/func/edit";
	}	
	
	@RequestMapping(value = "/{funcId}/update", method = POST)
    public String update(@Valid @ModelAttribute SysFunc sysFunc, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("sysFunc", sysFunc);
            return "sysConfig/func/edit";
        }

        sysFuncService.save(sysFunc);
        return "history:/sysConfig/func";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		SysFunc sysFunc = new SysFunc();
        model.addAttribute("sysFunc", sysFunc);
        return "sysConfig/func/edit";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid SysFunc sysFunc, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("sysFunc", sysFunc);
            return "sysConfig/func/edit";
        }

        sysFuncService.save(sysFunc);
        return "history:/sysConfig/func";
    }	
	
    @RequestMapping(value = "/{funcId}/remove", method = GET)
    public String remove(@PathVariable("funcId") Integer funcId, Model model) {
        sysFuncService.remove(funcId);
        return "history:/sysConfig/func";
    }
}

