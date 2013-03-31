package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/sysConfig")
@Controller
public class SysConfigController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(SysConfigController.class);	
	
	@RequestMapping(method = {GET, POST})
	public String main(@ModelAttribute SearchForm searchForm, Model model) {
		return "sysConfig/main";
	}
	
	@RequestMapping(value="/changePassword", method = {GET})
	public String changePassword() {
		return "sysConfig/changePassword";
	}
	
	@RequestMapping(value="/changePassword", method = {POST})
	public String changePassword(
			@RequestParam("oldPassword") String oldPassword, 
			@RequestParam("newPassword") String newPassword, 
			@RequestParam("confirmPassword") String confirmPassword) {
		
		return "redirect:/logout";
	}
	
}

