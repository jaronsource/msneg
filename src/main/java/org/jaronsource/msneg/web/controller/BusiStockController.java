package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import org.jaronsource.msneg.domain.BusiItem;
import org.jaronsource.msneg.service.BusiItemService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.spring.RequestHistory;
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/busiStock")
@Controller
public class BusiStockController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiStockController.class);	
	
	@Autowired
	private BusiItemService busiItemService;
	
	@RequestMapping(method = {GET, POST})
	@RequestHistory
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiItem> busiItemPage = busiItemService.findPage(searchForm);
		model.addAttribute("busiItemPage", busiItemPage);
		
		return "busiStock/list";
	}
	
	@RequestMapping(value = "/changeStock", method = {GET, POST})
	@ResponseBody
	public void changeStock(@RequestParam("itemId") Integer itemId, @RequestParam("stock") Integer stock) {

		busiItemService.changeStock(itemId, stock);
	}
	
}

