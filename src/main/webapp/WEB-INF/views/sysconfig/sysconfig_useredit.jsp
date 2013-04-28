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
	<form:form modelAttribute="sysUser">
	<table width="100%" cellspacing="0" cellpadding="0" border="1" class="tbl_w">
		<colgroup>
			<col width="140">
			<col width="*">
		</colgroup>
		<tbody>
			<tr>
				<th>部门</th>
				<td>
					<form:select path="dept.deptId">
						<form:options items="${depts }" itemLabel="deptName" itemValue="deptId"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>用户名</th>
				<td><form:input path="userName" cssClass="input_text"/></td>
			</tr>
			<tr>
				<th>姓名</th>
				<td><form:input path="realName" cssClass="input_text"/></td>
			</tr>
			<tr>
				<th>密码</th>
				<td><form:input path="passwd" cssClass="input_text"/></td>
			</tr>
			<tr>
				<th>是否可用</th>
				<td><form:select path="isAvailable">
						<form:option label="TRUE" value="1"/>
						<form:option label="FALSE" value="0"/>
					</form:select></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="保存" /> <input type="button" value="返回" onclick="window.location='${pageContext.request.contextPath}/sysConfig/user';" /> </td>
			</tr>
		</tbody>
	</table>
	</form:form>
	</div>
</div>