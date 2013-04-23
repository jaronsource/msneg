package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.List;

import javax.validation.Valid;

import org.jaronsource.msneg.domain.SysFunc;
import org.jaronsource.msneg.domain.SysRole;
import org.jaronsource.msneg.service.SysFuncService;
import org.jaronsource.msneg.service.SysRoleService;
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

@RequestMapping("/sysConfig/role")
@Controller
public class SysRoleController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(SysRoleController.class);	
	
	@Autowired
	private SysRoleService sysRoleService;
	
	@Autowired
	private SysFuncService sysFuncService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<SysRole> sysRolePage = sysRoleService.findPage(searchForm);
		model.addAttribute("sysRolePage", sysRolePage);
		
		return "sysConfig/role/list";
	}
	
	@RequestMapping(value = "/{roleId}/update", method = GET)
    public String update(@PathVariable("roleId") Integer roleId, Model model) {
		
        model.addAttribute("sysRole", sysRoleService.findByPk(roleId));
        return "sysConfig/role/edit";
	}	
	
	@RequestMapping(value = "/{roleId}/update", method = POST)
    public String update(@Valid @ModelAttribute SysRole sysRole, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("sysRole", sysRole);
            return "sysConfig/role/edit";
        }

        sysRoleService.save(sysRole);
        return "history:/sysConfig/role";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		SysRole sysRole = new SysRole();
		
        model.addAttribute("sysRole", sysRole);
        return "sysConfig/role/edit";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid SysRole sysRole, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("sysRole", sysRole);
            return "sysConfig/role/edit";
        }

        sysRoleService.save(sysRole);
        return "history:/sysConfig/role";
    }	
	
    @RequestMapping(value = "/{roleId}/remove", method = GET)
    public String remove(@PathVariable("roleId") Integer roleId, Model model) {
        sysRoleService.remove(roleId);
        return "history:/sysConfig/role";
    }
    
    @RequestMapping(value = "/{roleId}/assignFunc", method = GET)
    public String assignFunc(@PathVariable("roleId") Integer roleId, Model model) {
        
    	SysRole sysRole = sysRoleService.findByPk(roleId);
        
        List<SysFunc> functions = sysFuncService.findAll();
        AssignFuncForm assignFuncForm = new AssignFuncForm();
        assignFuncForm.setRoleId(roleId);
        Integer[] funcIds = getFuncIds(sysRole.getFunctions());
        assignFuncForm.setFuncIds(funcIds);
        
        model.addAttribute("assignFuncForm", assignFuncForm);
        model.addAttribute("sysRole", sysRole);
        model.addAttribute("functions", functions);
        return "sysConfig/role/assignFunc";
    }
    
    private Integer[] getFuncIds(List<SysFunc> functions) {

    	Integer[] funcIds = new Integer[functions.size()];
    	for (int i = 0; i < funcIds.length; i++) {
    		funcIds[i] = functions.get(i).getFuncId();
		}
    	
		return funcIds;
	}

	@RequestMapping(value = "/{roleId}/assignFunc", method = POST)
    public String assignFunc(@ModelAttribute("assignFuncForm") AssignFuncForm assignFuncForm, Model model ) {
    	
    	Integer roleId = assignFuncForm.getRoleId();
    	Integer[] funcIds = assignFuncForm.getFuncIds();
    	
    	sysRoleService.assignFunc(roleId, funcIds);
    	return "history:/sysConfig/role";
    }
}

