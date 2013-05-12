package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.jaronsource.msneg.domain.BusiSalesItem;
import org.jaronsource.msneg.domain.BusiSalesReturn;
import org.jaronsource.msneg.domain.BusiSalesReturnItem;
import org.jaronsource.msneg.service.BusiSalesReturnItemService;
import org.jaronsource.msneg.service.BusiSalesReturnService;
import org.jaronsource.msneg.utils.PhoneUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ccesun.framework.core.dao.support.Page;
import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.web.controller.BaseController;
import com.ccesun.framework.plugins.dictionary.DictionaryHelper;
import com.ccesun.framework.plugins.report.JasperReportUtils;
import com.ccesun.framework.util.NumberUtils;
import com.ccesun.framework.util.StringUtils;

@RequestMapping("/busiSalesReturn")
@Controller
public class BusiSalesReturnController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiSalesReturnController.class);	
	
	@Autowired
	private BusiSalesReturnService busiSalesReturnService;

	@Autowired
	private BusiSalesReturnItemService busiSalesReturnItemService;
	
	@Autowired
	private DictionaryHelper dictionaryHelper;

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
		
		HttpServletRequest request = getHttpServletRequest();
		String[] salesItemIds = request.getParameterValues("salesItemId");
		String[] returnAmounts = request.getParameterValues("returnAmount");
		String[] returnReasonKeys = request.getParameterValues("returnReasonKey");
		String[] returnSum = request.getParameterValues("returnItemSum");
		String[] returnPrices = request.getParameterValues("returnPrice");
		//String[] returnMarkers0 = requst.getParameterValues("returnMarkers");
		
		List<BusiSalesReturnItem> busiSalesReturnItems = new ArrayList<BusiSalesReturnItem>();
		for (int i = 0; i < salesItemIds.length; i++) {
			if (StringUtils.isNotBlank(salesItemIds[i])) {
				
				BusiSalesReturnItem busiSalesReturnItem = new BusiSalesReturnItem();
				busiSalesReturnItem.setReturnPrice(NumberUtils.toFloat(returnPrices[i]));
				//busiSalesReturnItem.setReturnSum(NumberUtils.toFloat(returnSum[i]));
				busiSalesReturnItem.setReturnAmount(NumberUtils.toInt(returnAmounts[i]));
				busiSalesReturnItem.setReturnSum(NumberUtils.toFloat(returnPrices[i]) * NumberUtils.toInt(returnAmounts[i]));
				busiSalesReturnItem.setReturnReasonKey(returnReasonKeys[i]);
				//busiSalesReturnItem.setReturnRemarks(returnMarkers0[i]);
				busiSalesReturnItem.setBusiSalesItem(new BusiSalesItem(NumberUtils.toInt(salesItemIds[i])));
				busiSalesReturnItems.add(busiSalesReturnItem);
			}
		}
		
		busiSalesReturnService.save(busiSalesReturn, busiSalesReturnItems);
		
        return "redirect:/busiSalesReturn/" + busiSalesReturn.getReturnId() + "/show";
    }	
	
	@RequestMapping(value = "/{returnId}/show", method = GET)
    public String show(@PathVariable("returnId") Integer returnId, Model model) {
        BusiSalesReturn busiSalesReturn = busiSalesReturnService.findByPk(returnId);
        List<BusiSalesReturnItem> salesReturnItemList = busiSalesReturnItemService.findBusiSalesReturnItemByReturnId(returnId);
		model.addAttribute("busiSalesReturn", busiSalesReturn);
		model.addAttribute("salesReturnItemList", salesReturnItemList);
        return "busiSalesReturn/show";
    }
    
    @RequestMapping(value = "/{returnId}/remove", method = GET)
    public String remove(@PathVariable("returnId") Integer returnId, Model model) {
        busiSalesReturnService.remove(returnId);
        return "redirect:/busiSalesReturn";
    }
    
    @RequestMapping(value = "/{returnId}/print", method = GET)
	@ResponseBody
    public void print(@PathVariable("returnId") Integer returnId, HttpServletResponse response) {
    	BusiSalesReturn busiSalesReturn = busiSalesReturnService.findByPk(returnId);
    	List<BusiSalesReturnItem> salesReturnItemList = busiSalesReturnItemService.findBusiSalesReturnItemByReturnId(returnId);
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("salesCode", busiSalesReturn.getBusiSales().getSalesCode());
		paramMap.put("clientName", busiSalesReturn.getBusiSales().getBusiClient().getClientName());
		paramMap.put("clientPhone", PhoneUtils.decode(busiSalesReturn.getBusiSales().getBusiClient().getAreacode(), busiSalesReturn.getBusiSales().getBusiClient().getPhone()));
		paramMap.put("clientCellPhone", busiSalesReturn.getBusiSales().getBusiClient().getCellPhone());
		paramMap.put("sysUser", busiSalesReturn.getBusiSales().getSysUser().getRealName());
		paramMap.put("clientAddress", busiSalesReturn.getBusiSales().getBusiClient().getAddress());
		paramMap.put("salesRemarks", busiSalesReturn.getBusiSales().getSalesRemarks());
		paramMap.put("servLogis", dictionaryHelper.lookupDictValue0("serv_logis", busiSalesReturn.getBusiSales().getServLogisKey()));
		paramMap.put("servGetmethod", dictionaryHelper.lookupDictValue0("serv_getmethod", busiSalesReturn.getBusiSales().getServGetmethodKey()));
		paramMap.put("servInstallmethod", dictionaryHelper.lookupDictValue0("serv_installmethod", busiSalesReturn.getBusiSales().getServInstallmethodKey()));
		
		
		paramMap.put("returnSum", busiSalesReturn.getReturnSum() == null ? "0.00" : busiSalesReturn.getReturnSum().toString());
		paramMap.put("returnLoss", busiSalesReturn.getReturnLoss() == null ? "0.00" : busiSalesReturn.getReturnLoss().toString());
		paramMap.put("rerateLoss", busiSalesReturn.getRerateLoss() == null ? "0.00" : busiSalesReturn.getRerateLoss().toString());
		paramMap.put("actReturnSum", busiSalesReturn.getActReturnSum() == null ? "0.00" : busiSalesReturn.getActReturnSum().toString());
		paramMap.put("clearMethod", dictionaryHelper.lookupDictValue0("clear_method", busiSalesReturn.getClearMethodKey()));
		paramMap.put("createTime", busiSalesReturn.getCreateTime());
		paramMap.put("otherRemarks", busiSalesReturn.getOtherRemarks());
		
		List<Map<String, String>> entries = new ArrayList<Map<String, String>>();
		for (BusiSalesReturnItem busiSalesReturnItem : salesReturnItemList) {
			Map<String, String> entry = new HashMap<String, String>();
			entry.put("cateName", busiSalesReturnItem.getBusiSalesItem().getCateName());
			entry.put("itemName", busiSalesReturnItem.getBusiSalesItem().getItemName());
			entry.put("itemUnit", dictionaryHelper.lookupDictValue0("item_unit", busiSalesReturnItem.getBusiSalesItem().getItemUnitKey()) );
			entry.put("returnReason", dictionaryHelper.lookupDictValue0("return_reason", busiSalesReturnItem.getReturnReasonKey()) );
			entry.put("returnAmount", busiSalesReturnItem.getReturnAmount() == null ? "0" : busiSalesReturnItem.getReturnAmount().toString());
			entry.put("returnPrice", busiSalesReturnItem.getReturnPrice() == null ? "0.00" : busiSalesReturnItem.getReturnPrice().toString());
			entry.put("itemReturnSum", busiSalesReturnItem.getReturnSum() == null ? "0.00" : busiSalesReturnItem.getReturnSum().toString());
			entry.put("itemRemarks", busiSalesReturnItem.getBusiSalesItem().getItemRemarks());
			entries.add(entry);
		}
		
		String filePath = getRealPath("/WEB-INF/print/sales_return.jasper");
		
		try {
			JasperReportUtils.exportPdf(response, filePath, paramMap, entries, "sales_return");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
    }
}

