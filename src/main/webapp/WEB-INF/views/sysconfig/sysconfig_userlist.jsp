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
		<li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-3" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/sysConfig/dict" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-3">字典</a></li>
		<li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-4" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/sysConfig/dept" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-4">部门</a></li>
		<li class="ui-state-default ui-corner-top ui-tabs-active ui-state-active" role="tab" tabindex="-1" aria-controls="tabs-5" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/sysConfig/user" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-5">用户</a></li>
		<li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-6" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/sysConfig/func" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-6">功能</a></li>
		<li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-7" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/sysConfig/role" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-7">角色</a></li>
		<!-- 
		<li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-8" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/sysConfig/category" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-7">商品系列</a></li>
		 -->
	</ul>
	<div class="customer">
	<form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
    	部门 
    	<form:select path="form['dept.deptId_eq_int']">
    		<form:option value="">全部</form:option> 
			<form:options items="${depts }" itemLabel="deptName" itemValue="deptId"/>
		</form:select>
    	<form:input path="form['userName_blk']" id="search_userName" placeholder="用户名" cssClass="input_text" />
    	<form:input path="form['realName_blk']" id="search_realName" placeholder="姓名" cssClass="input_text" />
    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
    </form:form>
    
	<table class="tbl_l"> 
    	<tr>
	    	<th>主键</th>
	    	<th>部门</th>
	    	<th>用户名</th>
	    	<th>姓名</th>
	    	<th>是否可用</th>
	    	<th>操作</th>
    	</tr>
    	<c:forEach items="${sysUserPage.content}" var="entry">
    	<tr>
	    	<td>${entry.userId}</td>
	    	<td>${entry.dept.deptName}</td>
	    	<td>${entry.userName}</td>
	    	<td>${entry.realName}</td>
	    	<td>${entry.isAvailable}</td>
	    	<td>
	    		<a href="${pageContext.request.contextPath}/sysConfig/user/${entry.userId}/assignRole" class="btn btn-small">分配角色</a> 
	    		<a href="${pageContext.request.contextPath}/sysConfig/user/${entry.userId}/update" class="btn btn-small">修改</a> 
	    		<a href="${pageContext.request.contextPath}/sysConfig/user/${entry.userId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')">删除</a> 
	    	</td>
    	</tr>	
    	</c:forEach>
    </table> 
   	
	<div class="paging"> 
		<pg:pager url="${baseUrl}" page="${sysUserPage}" />
	    <%@ include file="/WEB-INF/pagers/pager-default.jsp" %>	
	    <div class="sys_btnBox">
			<input type="button" onclick="window.location='${pageContext.request.contextPath}/sysConfig/user/create'" value="创建新用户">
		</div>
	</div>
	</div>	
</div>