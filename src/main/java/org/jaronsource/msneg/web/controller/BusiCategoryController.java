package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.List;

import javax.validation.Valid;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
import com.ccesun.framework.core.web.controller.BaseController;

@RequestMapping("/sysConfig/category")
@Controller
public class BusiCategoryController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiCategoryController.class);	
	
	@Autowired
	private BusiCategoryService busiCategoryService;
	
	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiCategory> busiCategoryPage = busiCategoryService.findPage(searchForm);
		model.addAttribute("busiCategoryPage", busiCategoryPage);
		
		return "sysConfig/category/list";
	}
	
	@RequestMapping(value = "/{cateId}/update", method = GET)
    public String update(@PathVariable("cateId") Integer cateId, Model model) {
        model.addAttribute("busiCategory", busiCategoryService.findByPk(cateId));
        return "sysConfig/category/edit";
	}	
	
	@RequestMapping(value = "/{cateId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiCategory busiCategory, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiCategory", busiCategory);
            return "sysConfig/category/edit";
        }

        busiCategoryService.save(busiCategory);
        return "history:/sysConfig/category";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiCategory busiCategory = new BusiCategory();
        model.addAttribute("busiCategory", busiCategory);
        return "sysConfig/category/edit";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiCategory busiCategory, BindingResult bindingResult, @RequestParam CommonsMultipartFile file, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiCategory", busiCategory);
            return "sysConfig/category/edit";
        }
        String basePath = getRealPath("/upload/stock/");
        busiCategoryService.save(busiCategory, basePath, file);
        return "history:/sysConfig/category";
    }	
    
    @RequestMapping(value = "/{cateId}/remove", method = GET)
    public String remove(@PathVariable("cateId") Integer cateId, Model model) {
        busiCategoryService.remove(cateId);
        return "history:/sysConfig/category";
    }
    
    @RequestMapping(value = "/ajaxFindBusiCategory", method = {GET, POST})
    @ResponseBody
    public JSONArray ajaxFindBusiCategory(@RequestParam("itemType") String itemType) {
        
    	List<BusiCategory> busiCategoryList = busiCategoryService.findByItemType(itemType);
    	
    	JSONArray result = new JSONArray();
    	for (BusiCategory busiCategory : busiCategoryList) {
    		JSONObject jsonObject = getJsonObject(busiCategory);
    		result.add(jsonObject);
		}
    	
    	return result;

    }
    
    private JSONObject getJsonObject(BusiCategory busiCategory) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.element("cateId", busiCategory.getCateId());
		jsonObject.element("cateName", busiCategory.getCateName());
		jsonObject.element("itemStockAmount", busiCategory.getItemStockAmount());
		return jsonObject;
	}
    
    /*
    @RequestMapping(value = "/ajaxFindStock", method = {GET, POST})
    @ResponseBody
    public JSONObject ajaxFindStock(@RequestParam("cateId") Integer cateId) {
        
    	BusiCategory busiCategory = busiCategoryService.findByPk(cateId);
    	
    	JSONObject result = new JSONObject();
    	Integer stockAmount = busiCategory.getItemStockAmount();
    	stockAmount = stockAmount == null ? 0 : stockAmount;
    	result.element("stockAmount",  stockAmount);
    	
    	return result;

    }
    */
    
    @RequestMapping(value = "/ajaxFindStock", method = {GET, POST})
    @ResponseBody
    public JSONObject ajaxFindStock(@RequestParam("cateName") String cateName, @RequestParam("itemName") String itemName) {
        
    	//BusiCategory busiCategory = busiCategoryService.findByPk(cateId);
    	Long stock = busiCategoryService.findStockByCateNameAndItemName(cateName, itemName);
    	stock = stock == null ? 0 : stock;
    	JSONObject result = new JSONObject();
    	//Integer stockAmount = busiCategory.getItemStockAmount();
    	//stockAmount = stockAmount == null ? 0 : stockAmount;
    	result.element("stockAmount",  stock);
    	
    	return result;

    }
}

