<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
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
	<form:form modelAttribute="assignRoleForm">
    	<form:hidden path="userId" />
    	<table width="100%" cellspacing="0" cellpadding="0" border="1" class="tbl_w">
		<colgroup>
			<col width="40">
			<col width="40">
			<col width="140">
			<col width="*">
		</colgroup>
		<tr>
	    	<th><input type="checkbox" id="checkHandler"/></th>
	    	<script>
				$('#checkHandler').click(function() {
					var checked = $(this).attr('checked');
					if (!checked) checked = false;
					$('.checkboxes').attr('checked', checked);
				});
	    	</script>
	    	<th>主键</th>
	    	<th>角色名</th>
	    	<th>描述</th>
    	</tr>
    	<c:forEach items="${roles}" var="entry">
    	<tr>
	    	<td><form:checkbox path="roleIds" cssClass="checkboxes" value="${entry.roleId}"/> </td>
	    	<td>${entry.roleId}</td>
	    	<td>${entry.roleName}</td>
	    	<td>${entry.roleRemarks}</td>
    	</tr>	
    	</c:forEach>
    	<tr>
			<td colspan="4"><input type="submit" value="保存" /> <input type="button" value="返回" onclick="window.location='${pageContext.request.contextPath}/sysConfig/user';" /> </td>
		</tr>
	</table>
    </form:form>	
	</div>
</div>
