package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import javax.validation.Valid;

import org.jaronsource.msneg.domain.BusiCategory;
import org.jaronsource.msneg.service.BusiCategoryService;
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
import org.springframework.web.multipart.commons.CommonsMultipartFile;

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
	public void changeStock(@RequestParam("cateId") Integer cateId, @RequestParam("stock") Integer stock) {

		busiCategoryService.changeStock(cateId, stock);
	}
	
	@RequestMapping(value = "/{cateId}/update", method = GET)
    public String update(@PathVariable("cateId") Integer cateId, Model model) {
		//List<BusiCategory> categories = busiCategoryService.findAll();
		//model.addAttribute("categories", categories);
        model.addAttribute("busiCategory", busiCategoryService.findByPk(cateId));
        return "busiStock/edit";
	}	
	
	@RequestMapping(value = "/{cateId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiCategory busiCategory, BindingResult bindingResult, @RequestParam CommonsMultipartFile file, Model model) {
        if (bindingResult.hasErrors()) {
        	//List<BusiCategory> categories = busiCategoryService.findAll();
    		//model.addAttribute("categories", categories);
            model.addAttribute("busiCategory", busiCategory);
            return "busiStock/edit";
        }

        String basePath = getRealPath("/upload/stock/");
        busiCategoryService.save(busiCategory, basePath, file);
        return "history:/busiStock";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiCategory busiCategory = new BusiCategory();
        model.addAttribute("busiCategory", busiCategory);
        return "busiStock/edit";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiCategory busiCategory, BindingResult bindingResult, @RequestParam CommonsMultipartFile file, Model model) {
        if (bindingResult.hasErrors()) {
        	//List<BusiCategory> categories = busiCategoryService.findAll();
    		//model.addAttribute("categories", categories);
            model.addAttribute("busiCategory", busiCategory);
            return "busiStock/edit";
        }
        busiCategory.setItemStockAmount(0);
        String basePath = getRealPath("/upload/stock/");
        busiCategoryService.save(busiCategory, basePath, file);
        return "history:/busiStock";
    }	
    
    @RequestMapping(value = "/{cateId}/remove", method = GET)
    public String remove(@PathVariable("cateId") Integer cateId, Model model) {
    	busiCategoryService.remove(cateId);
        return "history:/busiStock";
    }
	
}

