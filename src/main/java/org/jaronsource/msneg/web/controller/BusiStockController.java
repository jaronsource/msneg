package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.List;

import javax.validation.Valid;

import org.jaronsource.msneg.domain.BusiCategory;
import org.jaronsource.msneg.domain.BusiItem;
import org.jaronsource.msneg.service.BusiCategoryService;
import org.jaronsource.msneg.service.BusiItemService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	//@Autowired
	//private BusiItemService busiItemService;
	
	@Autowired
	private BusiCategoryService busiCategoryService;
	
	@RequestMapping(method = {GET, POST})
	@RequestHistory
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiCategory> busiCategoryPage = busiCategoryService.findPage(searchForm);
		
		model.addAttribute("busiCategoryPage", busiCategoryPage);
		
		return "busiStock/list";
	}
	
	@RequestMapping(value = "/changeStock", method = {GET, POST})
	@ResponseBody
	public void changeStock(@RequestParam("itemId") Integer itemId, @RequestParam("stock") Integer stock) {

		busiCategoryService.changeStock(itemId, stock);
	}
	
	@RequestMapping(value = "/{itemId}/update", method = GET)
    public String update(@PathVariable("itemId") Integer itemId, Model model) {
		//List<BusiCategory> categories = busiCategoryService.findAll();
		//model.addAttribute("categories", categories);
        model.addAttribute("busiCatetory", busiCategoryService.findByPk(itemId));
        return "busiStock/edit";
	}	
	
	@RequestMapping(value = "/{itemId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiCategory busiCategory, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
        	//List<BusiCategory> categories = busiCategoryService.findAll();
    		//model.addAttribute("categories", categories);
            model.addAttribute("busiCategory", busiCategory);
            return "busiStock/edit";
        }

        busiCategoryService.save(busiCategory);
        return "history:/busiStock";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		List<BusiCategory> categories = busiCategoryService.findAll();
		model.addAttribute("categories", categories);
		BusiItem busiItem = new BusiItem();
        model.addAttribute("busiItem", busiItem);
        return "busiStock/edit";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiCategory busiCategory, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
        	//List<BusiCategory> categories = busiCategoryService.findAll();
    		//model.addAttribute("categories", categories);
            model.addAttribute("busiCategory", busiCategory);
            return "busiStock/edit";
        }
        busiCategory.setItemStockAmount(0);
        busiCategoryService.save(busiCategory);
        return "history:/busiStock";
    }	
    
    @RequestMapping(value = "/{itemId}/remove", method = GET)
    public String remove(@PathVariable("itemId") Integer cateId, Model model) {
    	busiCategoryService.remove(cateId);
        return "history:/busiStock";
    }
	
}

