<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>

			
			<div class="title_box">
				<h2>综合数据分析 </h2>
			</div>
			

				<form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
			<div class="customer">
				<p>部门
					<form:select path="form['deptId']" id="search_deptId" >
						<form:option value="">全部</form:option>
						<form:options items="${depts }" itemLabel="deptName" itemValue="deptId" />
					</form:select>
					<form:input path="form['startTime']" id="search_startTime" cssClass="input_text w_172" placeholder="开始日期"/>
					<form:input path="form['endTime']" id="search_endTime" cssClass="input_text w_172" placeholder="结束日期"/>
					<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
				</p>
			</div>
			</form:form>
			
		<div class="order_box"> 
			<!--box-->
			<div class="com_box">
				<h3 class="title_line">统计信息<a href="#this" class="toggle_table">折叠</a></h3>
				<table class="tbl_l" border="1" cellpadding="0" cellspacing="0" width="100%">
						<colgroup>
							<col width="200">
							<col width="200">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th rowspan="5">销售单</th>
								<th>总计</th>
								<td>${busiSalesStatisA['zongji'] }</td>
							</tr>
							<tr>
								<th>结算</th>
								<td>${busiSalesStatisA['jiesuan'] }</td>
							</tr>
							<tr>
								<th>尾款</th>
								<td>${busiSalesStatisA['weikuan'] }</td>
							</tr>
							<tr>
								<th>补价</th>
								<td>${busiSalesStatisA['bujia'] }</td>
							</tr>
							<tr>
								<th>返销</th>
								<td>${busiSalesStatisA['fanxiao'] }</td>
							</tr>
							
							<tr>
								<th rowspan="5">内销单</th>
								<th>总计</th>
								<td>${busiSalesStatisB['zongji'] }</td>
							</tr>
							<tr>
								<th>结算</th>
								<td>${busiSalesStatisB['jiesuan'] }</td>
							</tr>
							<tr>
								<th>尾款</th>
								<td>${busiSalesStatisB['weikuan'] }</td>
							</tr>
							<tr>
								<th>补价</th>
								<td>${busiSalesStatisB['bujia'] }</td>
							</tr>
							<tr>
								<th>返销</th>
								<td>${busiSalesStatisB['fanxiao'] }</td>
							</tr>
							
							<tr>
								<th rowspan="3">定金单</th>
								<th>总计</th>
								<td>${busiSalesOrdersStatis['zongji'] }</td>
							</tr>
							<tr>
								<th>已使用</th>
								<td>${busiSalesOrdersStatis['yishiyong'] }</td>
							</tr>
							<tr>
								<th>已退</th>
								<td>${busiSalesOrdersStatis['yitui'] }</td>
							</tr>
							
							<tr>
								<th rowspan="3">补价单</th>
								<th>总计</th>
								<td>${busiSalesMakeupStatis['zongji'] }</td>
							</tr>
							<tr>
								<th>增加</th>
								<td>${busiSalesMakeupStatis['zengjia'] }</td>
							</tr>
							<tr>
								<th>减少</th>
								<td>${busiSalesMakeupStatis['jiashao'] }</td>
							</tr>
							
							<tr>
								<th>返销单</th>
								<th>总计</th>
								<td>${busiSalesReturnStatis['zongji'] }</td>
							</tr>
							
						</tbody>
					</table>
				</div>
			<!--//box--> 
		</div>
			
			
	