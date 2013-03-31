package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.domain.BusiSalesReturn;
import org.jaronsource.msneg.domain.BusiSalesReturnItem;
import org.jaronsource.msneg.service.BusiSalesReturnService;
import org.jaronsource.msneg.utils.MoneyUtils;
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
import com.ccesun.framework.util.NumberUtils;
import com.ccesun.framework.util.StringUtils;

@RequestMapping("/busiSalesReturn")
@Controller
public class BusiSalesReturnController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesReturnController.class);	
	
	@Autowired
	private BusiSalesReturnService busiSalesReturnService;

	@RequestMapping(method = {GET, POST})
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		Page<BusiSalesReturn> busiSalesReturnPage = busiSalesReturnService.findPage(searchForm);
		model.addAttribute("busiSalesReturnPage", busiSalesReturnPage);
		
		return "busiSalesReturn/list";
	}
	
	@RequestMapping(value = "/{returnId}/update", method = GET)
    public String update(@PathVariable("returnId") Integer returnId, Model model) {
        model.addAttribute("busiSalesReturn", busiSalesReturnService.findByPk(returnId));
        return "busiSalesReturn/update";
	}	
	
	@RequestMapping(value = "/{returnId}/update", method = POST)
    public String update(@Valid @ModelAttribute BusiSalesReturn busiSalesReturn, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("busiSalesReturn", busiSalesReturn);
            return "busiSalesReturn/update";
        }

        busiSalesReturnService.save(busiSalesReturn);
        return "redirect:/busiSalesReturn/" + busiSalesReturn.getReturnId() + "/show";
    }	
	
	@RequestMapping(value = "/create", method = GET)
    public String create(Model model) {
		BusiSalesReturn busiSalesReturn = new BusiSalesReturn();
        model.addAttribute("busiSalesReturn", busiSalesReturn);
        return "busiSalesReturn/create";
    }
    
	@RequestMapping(value = "/create", method = POST)
    public String create(@Valid BusiSalesReturn busiSalesReturn, BindingResult bindingResult, Model model) {
		
		HttpServletRequest requst = getHttpServletRequest();
		String[] salesItemIds = requst.getParameterValues("salesItemId");
		String[] returnAmounts = requst.getParameterValues("returnAmount");
		String[] returnReasonKeys = requst.getParameterValues("returnReasonKey");
		String[] returnSum = requst.getParameterValues("returnSum");
		String[] returnPrices = requst.getParameterValues("returnPrice");
		//String[] returnMarkers0 = requst.getParameterValues("returnMarkers");
		
		List<BusiSalesReturnItem> busiSalesReturnItems = new ArrayList<BusiSalesReturnItem>();
		for (int i = 0; i < salesItemIds.length; i++) {
			if (StringUtils.isNotBlank(salesItemIds[i])) {
				BusiSalesReturnItem busiSalesReturnItem = new BusiSalesReturnItem();
				busiSalesReturnItem.setReturnPrice(MoneyUtils.decode(returnPrices[i]));
				busiSalesReturnItem.setReturnSum(MoneyUtils.decode(returnSum[i]));
				busiSalesReturnItem.setReturnAmount(NumberUtils.toInt(returnAmounts[i]));
				busiSalesReturnItem.setReturnReasonKey(returnReasonKeys[i]);
				//busiSalesReturnItem.setReturnRemarks(returnMarkers0[i]);
				busiSalesReturnItem.setBusiSalesItem(new BusiSalesItem(NumberUtils.toInt(salesItemIds[i])));
				busiSalesReturnItems.add(busiSalesReturnItem);
			}
		}
		
		busiSalesReturnService.save(busiSalesReturn, busiSalesReturnItems);
		
        return "redirect:/busiSalesReturn/create";
    }	
	
	@RequestMapping(value = "/{returnId}/show", method = GET)
    public String show(@PathVariable("returnId") Integer returnId, Model model) {
        BusiSalesReturn busiSalesReturn = busiSalesReturnService.findByPk(returnId);
		model.addAttribute("busiSalesReturn", busiSalesReturn);
        return "busiSalesReturn/show";
    }
    
    @RequestMapping(value = "/{returnId}/remove", method = GET)
    public String remove(@PathVariable("returnId") Integer returnId, Model model) {
        busiSalesReturnService.remove(returnId);
        return "redirect:/busiSalesReturn";
    }
}

