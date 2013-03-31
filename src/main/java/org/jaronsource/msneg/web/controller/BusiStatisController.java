package org.jaronsource.msneg.web.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.jaronsource.msneg.domain.SysDept;
import org.jaronsource.msneg.service.BusiOrdersService;
import org.jaronsource.msneg.service.BusiSalesMakeupService;
import org.jaronsource.msneg.service.BusiSalesReturnService;
import org.jaronsource.msneg.service.BusiSalesService;
import org.jaronsource.msneg.service.SysDeptService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ccesun.framework.core.dao.support.SearchForm;
import com.ccesun.framework.core.spring.RequestHistory;
import com.ccesun.framework.core.web.controller.BaseController;
import com.ccesun.framework.util.DateUtils;
import com.ccesun.framework.util.MapUtils;

@RequestMapping("/busiStatis")
@Controller
public class BusiStatisController extends BaseController {

	final Logger logger = LoggerFactory.getLogger(BusiStatisController.class);	
	
	@Autowired
	private BusiSalesService busiSalesService;
	
	@Autowired
	private BusiSalesMakeupService busiSalesMakeupService;
	
	@Autowired
	private BusiSalesReturnService busiSalesReturnService;
	
	@Autowired
	private BusiOrdersService busiOrdersService;
	
	@Autowired
	private SysDeptService sysDeptService;
	
	@RequestMapping(method = {GET, POST})
	@RequestHistory
	public String list(@ModelAttribute SearchForm searchForm, Model model) {
		
		List<SysDept> depts = sysDeptService.findAll();
		
		Integer deptId = MapUtils.getInteger(searchForm.getForm(), "deptId");
		String startTime = MapUtils.getString(searchForm.getForm(), "startTime");
		String endTime = MapUtils.getString(searchForm.getForm(), "endTime");
		
		Date now = new Date();
		String weekTime = DateUtils.format(DateUtils.addDays(now, 7), DateUtils.PATTERN_DATE);
		//String monthTime = DateUtils.format(DateUtils.addDays(now, 30), DateUtils.PATTERN_DATE);
		//String threeMonthTime = DateUtils.format(DateUtils.addDays(now, 90), DateUtils.PATTERN_DATE);
		
		deptId = deptId == null ? 0 : deptId;
		startTime = startTime == null ? weekTime : startTime;
		endTime = endTime == null ? DateUtils.currentDate() : endTime;
		
		searchForm.getForm().put("deptId", deptId.toString());
		searchForm.getForm().put("startTime", startTime);
		searchForm.getForm().put("endTime", endTime);
		
		
		Map<String, Long> busiSalesStatisA = busiSalesService.statis(deptId, "A", startTime, endTime);
		Map<String, Long> busiSalesStatisB = busiSalesService.statis(deptId, "B", startTime, endTime);
		Map<String, Long> busiSalesMakeupStatis = busiSalesMakeupService.statis(deptId, startTime, endTime);
		Map<String, Long> busiSalesReturnStatis = busiSalesReturnService.statis(deptId, startTime, endTime);
		Map<String, Long> busiSalesOrdersStatis = busiOrdersService.statis(deptId, startTime, endTime);
		
		model.addAttribute("busiSalesStatisA", busiSalesStatisA);
		model.addAttribute("busiSalesStatisB", busiSalesStatisB);
		model.addAttribute("busiSalesMakeupStatis", busiSalesMakeupStatis);
		model.addAttribute("busiSalesReturnStatis", busiSalesReturnStatis);
		model.addAttribute("busiSalesOrdersStatis", busiSalesOrdersStatis);

		//model.addAttribute("weekTime", weekTime);
		//model.addAttribute("monthTime", monthTime);
		//model.addAttribute("threeMonthTime", threeMonthTime);

		model.addAttribute("depts", depts);
		
		return "busiStatis/view";
	}
	
}

