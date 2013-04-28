<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
<%@ taglib prefix="utils" uri="http://www.ccesun.com/tags/utils" %>
<dict:loadDictList var="item_type" type="item_type"></dict:loadDictList>

<div class="title_box">
	<h2>库存管理查询</h2>
</div>
<form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
<div class="customer">
	<p>类型
		<form:select path="form['itemTypeKey_eq']"> 
    		<form:option value="">全部</form:option>
    		<form:options items="${item_type }" itemLabel="dictValue0" itemValue="dictKey" />
    	</form:select>
    	<form:input path="form['cateName_blk']" id="search_itemCode" cssClass="input_text w_172" placeholder="系列名称"/>
		<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	</p>
</div>
</form:form>
<div class="order_box"> 
	<!--box-->
	<div class="com_box">
		<h3 class="title_line">系列信息列表<a href="#this" class="toggle_table">折叠</a></h3>
		<table class="tbl_l" border="1" cellpadding="0" cellspacing="0" width="100%">
				<colgroup>
					<col width="100">
					<col width="240">
					<col width="100">
					<col width="120">
				</colgroup>
				<thead>
					<tr>
						<th>类型</th>
						<th>系列名称</th>
						<th>管理库存</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${busiCategoryPage.content}" var="entry">
					<tr>
						<td><dict:lookupDictValue key="${entry.itemTypeKey }" type="item_type" /></td>
						<td class="tl">${entry.cateName }</td>
						<td>
							<span class="changeStockLink"><a href="javascript: void(0)" title="更新库存" cateId="${entry.cateId }" stock="${entry.itemStockAmount }">${entry.itemStockAmount }</a></span>
							<span class="changeStockForm" style="display: none;">
								<input type="text" class="stockInput w_40" value="${entry.itemStockAmount }" />
								<input type="button" class="stockSubmit" value="更新" />
								<input type="button" class="stockCancel" value="取消" />
							</span>
						</td>
						<td>
							<a href="${pageContext.request.contextPath}/busiStock/${entry.cateId}/update" class="btn btn-small">修改</a> 
		    		<a href="${pageContext.request.contextPath}/busiStock/${entry.cateId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')">删除</a>
						</td>
					</tr>
					</c:forEach>
					
					<script>
								
						$('.changeStockLink a').click(function() {
							var $parentTd = $(this).parents('td');
							$parentTd.find('.changeStockLink').hide();
							$parentTd.find('.changeStockForm').show();
						});
						
						$('.stockSubmit').click(function() {
							
							var $parentTd = $(this).parents('td');
							var stockValue = $(this).siblings('.stockInput').val();
							var $link = $parentTd.find('a');
							
							$.post('${pageContext.request.contextPath}/busiStock/changeStock', {'cateId': $link.attr('cateId'), 'stock': stockValue}, function() {
								alert('库存更新成功！');
								$parentTd.find('.changeStockLink').show();
								$parentTd.find('.changeStockForm').hide();
								$link.text(stockValue);
								$link.attr('stock', stockValue);
							});
						});
						
						$('.stockCancel').click(function() {
							var $parentTd = $(this).parents('td');
							$parentTd.find('.changeStockLink').show();
							$parentTd.find('.changeStockForm').hide();
							var stock = $parentTd.find('a').attr("stock");
							$parentTd.find('a').text(stock);
						});
							
						</script>
				</tbody>
			</table>
			<div class="paging"> 
				<pg:pager url="${baseUrl}" page="${busiCategoryPage}" />
			    <%@ include file="/WEB-INF/pagers/pager-default.jsp" %>	
			    <div class="sys_btnBox">
					<input type="button" onclick="window.location='${pageContext.request.contextPath}/busiStock/create'" value="创建新库存">
				</div>
			</div>				
		</div>
	<!--//box--> 
</div>
	