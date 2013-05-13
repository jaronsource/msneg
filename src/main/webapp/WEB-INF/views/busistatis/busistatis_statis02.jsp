<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>

		<div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
	<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all" role="tablist">
		<li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-1" aria-labelledby="ui-id-1" aria-selected="false"><a href="${pageContext.request.contextPath}/busiStatis/statis01" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-1">财务数据分析</a></li>
		<li class="ui-state-default ui-corner-top ui-tabs-active ui-state-active" role="tab" tabindex="-1" aria-controls="tabs-4" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/busiStatis/statis02" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-4">商品销量分析</a></li>
	</ul>
	<div id="tabs-2">	
			<div class="title_box">
				<h2>商品销量分析 </h2>
			</div>
			

				<form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
			<div class="customer">
				<p>部门
					<form:select path="form['deptId']" id="search_deptId" >
						<form:option value="">全部</form:option>
						<form:options items="${depts }" itemLabel="deptName" itemValue="deptId" />
					</form:select>
					<form:input path="form['startTime']" id="search_startTime" cssClass="input_text w_172 input_date" placeholder="开始日期"/>
					<form:input path="form['endTime']" id="search_endTime" cssClass="input_text w_172 input_date" placeholder="结束日期"/>
					<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
				</p>
			</div>
			</form:form>
			<script>
				$('.input_date').datepicker({ dateFormat: "yymmdd" });
			</script>
		<div class="order_box"> 
			<!--box-->
			<div class="com_box">
				<h3 class="title_line">统计信息<a href="#this" class="toggle_table">折叠</a></h3>
				<table width="100%" border="1" class="tbl_l" cellspacing="0" cellpadding="0">
					<colgroup>
					<col width="120" />
					<col width="120" />
					<col width="*" />
				</colgroup>
				<thead>
					<tr>
						<th>类别</th>
						<th>系列</th>
						<th>数量</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${busiSalesStatis}" var="entry">
					<tr>
						<td><dict:lookupDictValue key="${entry[0] }" type="item_type"/> </td>
						<td>${entry[1] }</td>
						<td>${entry[2] }</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
				</div>
			<!--//box--> 
		</div>
			
		</div>	
	