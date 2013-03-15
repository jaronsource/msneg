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

import org.jaronsource.msneg.domain.SysDept;
import org.jaronsource.msneg.service.SysDeptService;
import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/sysDept")
@Controller
public class SysDeptController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(SysDeptController.class);	
	
	@Autowired
	private SysDeptService sysDeptService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<SysDept> sysDeptPage = sysDeptService.findPage(searchForm);
		model.addAttribute("sysDeptPage", sysDeptPage);
		
		return "sysDept/list";
	}
	
	@RequestMapping(value = "/{deptId}/update", method = GET)
    public String update(@PathVariable("deptId") Integer deptId, Model model) {
        model.addAttribute("sysDept", sysDeptService.findByPk(deptId));
        return "sysDept/update";
	}	
	
	@RequestMapping(value = "/{deptId}/update", method = POST)
    public String update(@Valid @ModelAttribute SysDept sysDept, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("sysDept", sysDept);
            return "sysDept/update";
        }

        sysDeptService.save(sysDept);
        return "redirect:/sysDept/" + sysDept.getDeptId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		SysDept sysDept = new SysDept();
        model.addAttribute("sysDept", sysDept);
        return "sysDept/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid SysDept sysDept, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("sysDept", sysDept);
            return "sysDept/create";
        }

        sysDeptService.save(sysDept);
        return "redirect:/sysDept/" + sysDept.getDeptId() + "/show";
    }	
	
	@RequestMapping(value = "/{deptId}/show", method = GET)
    public String show(@PathVariable("deptId") Integer deptId, Model model) {
        SysDept sysDept = sysDeptService.findByPk(deptId);
		model.addAttribute("sysDept", sysDept);
        return "sysDept/show";
    }
    
    @RequestMapping(value = "/{deptId}/remove", method = GET)
    public String remove(@PathVariable("deptId") Integer deptId, Model model) {
        sysDeptService.remove(deptId);
        return "redirect:/sysDept";
    }
}

