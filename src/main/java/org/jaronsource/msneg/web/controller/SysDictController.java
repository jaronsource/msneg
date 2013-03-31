package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import javax.validation.Valid;

import org.jaronsource.msneg.domain.SysDict;
import org.jaronsource.msneg.service.SysDictService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/sysConfig/dict")
@Controller
public class SysDictController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(SysDictController.class);	
	
	@Autowired
	private SysDictService sysDictService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<SysDict> sysDictPage = sysDictService.findPage(searchForm);
		model.addAttribute("sysDictPage", sysDictPage);
		
		return "sysConfig/dict/list";
	}
	
	@RequestMapping(value = "/{recordId}/update", method = GET)
    public String update(@PathVariable("dictId") Integer dictId, Model model) {
        model.addAttribute("sysDict", sysDictService.findByPk(dictId));
        return "sysDict/update";
	}	
	
	@RequestMapping(value = "/{recordId}/update", method = POST)
    public String update(@Valid @ModelAttribute SysDict sysDict, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("sysDict", sysDict);
            return "sysDict/update";
        }

        sysDictService.save(sysDict);
        return "redirect:/sysDict/" + sysDict.getRecordId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		SysDict sysDict = new SysDict();
        model.addAttribute("sysDict", sysDict);
        return "sysDict/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid SysDict sysDict, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("sysDict", sysDict);
            return "sysDict/create";
        }

        sysDictService.save(sysDict);
        return "redirect:/sysDict/" + sysDict.getRecordId() + "/show";
    }	
	
	@RequestMapping(value = "/{dictId}/show", method = GET)
    public String show(@PathVariable("dictId") Integer dictId, Model model) {
        SysDict sysDict = sysDictService.findByPk(dictId);
		model.addAttribute("sysDict", sysDict);
        return "sysDict/show";
    }
    
    @RequestMapping(value = "/{dictId}/remove", method = GET)
    public String remove(@PathVariable("dictId") Integer dictId, Model model) {
        sysDictService.remove(dictId);
        return "redirect:/sysDict";
    }
}

