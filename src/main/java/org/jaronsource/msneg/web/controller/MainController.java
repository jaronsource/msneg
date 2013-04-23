package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ccesun.framework.core.web.controller.BaseController;
import com.ccesun.framework.plugins.security.UserNotAvailableException;
import com.ccesun.framework.plugins.security.UserNotFoundException;
import com.ccesun.framework.plugins.security.WrongPasswordException;
import com.ccesun.framework.plugins.security.WrongValidateCodeException;
import com.ccesun.framework.plugins.security.service.ISecurityService;

@RequestMapping("/")
@Controller
public class MainController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(MainController.class);	
	
	@Autowired
	private ISecurityService securityService;
	
	@RequestMapping(value="/main", method = {GET})
	public String main() {
		return "main/index";
		//return "main/sales";
	}
	
	@RequestMapping(value="/login", method = {GET})
	public String login(@ModelAttribute LoginForm loginForm) {
		return "main/login";
	}
	
	@RequestMapping(value="/login", method = {POST})
	public String login(
			@ModelAttribute LoginForm loginForm,
			HttpServletRequest request,
			HttpServletResponse response,
			Model model) {

		try {
			String userName = loginForm.getUsername();
			String password = loginForm.getPasswd();
			Boolean rememberme = Boolean.TRUE;
			String validateCode = loginForm.getValidateCode();
			
			securityService.login(request, response, new String[] {userName}, password, rememberme, validateCode);
		} catch (WrongValidateCodeException e) {
			String errMsg = getMessage("security.errMsg.wrongValidateCode");
			model.addAttribute("errMsg", errMsg);
			return "main/login";
		} catch (UserNotFoundException e) {
			String errMsg = getMessage("security.errMsg.userNotFound");
			model.addAttribute("errMsg", errMsg);
			return "main/login";
		} catch (UserNotAvailableException e) {
			String errMsg = getMessage("security.errMsg.userNotAvailable");
			model.addAttribute("errMsg", errMsg);
			return "main/login";
		} catch (WrongPasswordException e) {
			String errMsg = getMessage("security.errMsg.wrongPassword");
			model.addAttribute("errMsg", errMsg);
			return "main/login";
		}
		return "main/index";
	}
	
	@RequestMapping(value="/logout", method = {GET})
	public String logout(HttpServletResponse response) {
		securityService.logout(response);
		return "redirect:/login";
	}
	
	@RequestMapping(value="/sales", method = {GET})
	public String sales() {
		return "main/sales";
	}
	
	@RequestMapping(value="/bills", method = {GET})
	public String bills() {
		return "main/bills";
	}
	
}

