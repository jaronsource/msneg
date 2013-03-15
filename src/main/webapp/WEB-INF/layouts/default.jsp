<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<body>
	<div id="wrap">
		<div id="header">
			<tiles:insertAttribute name="header" ignore="true" />
		</div>
		<div id="container" class="group">
			<div id="left">
				<tiles:insertAttribute name="menu" ignore="true" />
			</div>
			<div id="content">
				<tiles:insertAttribute name="body" />
			</div>
		</div>
		<div id="footer">
			<tiles:insertAttribute name="footer" ignore="true" />
		</div>
	</div>
</body>
</html>
