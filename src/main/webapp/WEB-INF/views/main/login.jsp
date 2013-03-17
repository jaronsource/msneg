<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/css/styles.css" />

<!-- jQuery and jQuery UI -->
<script src="${pageContext.request.contextPath}/scripts/jquery-1.7.1.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/artTemplate/template.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/scripts/pager.js"></script>
<title><spring:message code="application_name" htmlEscape="false" /></title>
</head>
<body class="bg_none">
<div id="login_outer">
	<div class="login">
		<h2>日</h2>
		<p class="news">公告信息：本系统12.20日晚升级维护，21日正常使用...</p>
		<div class="login_form">
			<form:form modelAttribute="loginForm" id="loginForm">
			<h3>欢迎您使用MSNEG OA在线办公系统</h3>
			<p>帐&nbsp;&nbsp;号： <form:input cssClass="input_style w_172" path="username" id="username" /></p>
			<p>密&nbsp;&nbsp;码： <form:password cssClass="input_style w_172" path="passwd" id="passwd" /></p>
			<p>验证码： <form:input path="validateCode" cssClass="input_style w_172" id="validateCode" /></p>
			<p class="tanzheng">
				<span><img src="${pageContext.request.contextPath }/validate.images" id="validateCodeImg" width="80" height="30"/></span>
				<a href="#this" id="changeValidateCode" style="font-size: 12px;">看不清，换一张</a>
				<script>
					$('#changeValidateCode').click(function() {
						var orginSrc = $('#validateCodeImg').attr('src');
						$('#validateCodeImg').attr('src', orginSrc + '?');
					});
				</script>
			</p>
			<c:if test="!empty errMsg"><p class="id_worong">对不起，您输入有误！</p></c:if>
			<p class="btn_login"><a href="#this"><img src="${pageContext.request.contextPath}/images/btn/btn01.jpg" width="118" height="39" alt="离线登录" /></a> <a href="#this" id="submit"><img src="${pageContext.request.contextPath}/images/btn/btn02.jpg" width="118" height="39" alt="在线登录" /></a></p>
			<script>
				$("#submit").click(function() {
					$('#loginForm').submit();
				});
			</script>
			</form:form>
		</div>
	</div>
</div>
</body>

</html>
