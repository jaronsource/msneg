<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="security" uri="http://www.ccesun.com/tags/security" %>
<security:securityUser var="user"/>
<div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
	<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all" role="tablist">
		<li class="ui-state-default ui-corner-top" role="tab" tabindex="0" aria-controls="tabs-1" aria-labelledby="ui-id-1" aria-selected="true"><a href="${pageContext.request.contextPath}/sysConfig" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-1">用户信息</a></li>
		<li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-2" aria-labelledby="ui-id-2" aria-selected="false"><a href="${pageContext.request.contextPath}/sysConfig/changePassword" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-2">更改密码</a></li>
		<li class="ui-state-default ui-corner-top ui-tabs-active ui-state-active" role="tab" tabindex="-1" aria-controls="tabs-3" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/sysConfig/dict" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-3">字典</a></li>
		<li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-4" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/sysConfig/dept" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-4">部门</a></li>
		<li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-5" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/sysConfig/user" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-5">用户</a></li>
		<li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-6" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/sysConfig/func" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-6">功能</a></li>
		<li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-7" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/sysConfig/role" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-7">角色</a></li>
		<li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-8" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/sysConfig/category" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-7">商品系列</a></li>
	</ul>
	
	<div class="customer">
		<form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['dictType_eq']" id="search_dictType" placeholder="类型" cssClass="input_text" />
	    	<form:input path="form['dictKey_eq']" id="search_dictKey" placeholder="键" cssClass="input_text" />
	    	<form:input path="form['parentKey_eq']" id="search_parentKey" placeholder="父级键" cssClass="input_text" />
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="tbl_l"> 
	    	<tr>
		    	<th>主键</th>
		    	<th>类型</th>
		    	<th>键</th>
		    	<th>父级键</th>
		    	<th>值0</th>
		    	<th>值1</th>
		    	<th>值2</th>
		    	<th>值3</th>
		    	<th>操作</th>
	    	</tr>
	    	<c:forEach items="${sysDictPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.recordId}</td>
		    	<td>${entry.dictType}</td>
		    	<td>${entry.dictKey}</td>
		    	<td>${entry.parentKey}</td>
		    	<td>${entry.dictValue0}</td>
		    	<td>${entry.dictValue1}</td>
		    	<td>${entry.dictValue2}</td>
		    	<td>${entry.dictValue3}</td>
		    	<td>
		    		<a href="${pageContext.request.contextPath}/sysConfig/dict/${entry.recordId}/update" class="btn btn-small">修改</a> 
		    		<a href="${pageContext.request.contextPath}/sysConfig/dict/${entry.recordId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')">删除</a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
		<div class="paging"> 
			<pg:pager url="${baseUrl}" page="${sysDictPage}" />
		    <%@ include file="/WEB-INF/pagers/pager-default.jsp" %>	
		    <div class="sys_btnBox">
				<input type="button" onclick="window.location='${pageContext.request.contextPath}/sysConfig/dict/create'" value="创建新字典">
			</div>
		</div>	
	</div>
	
</div>