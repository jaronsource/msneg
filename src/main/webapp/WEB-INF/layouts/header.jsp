<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="security" uri="http://www.ccesun.com/tags/security"%>
<security:securityUser var="sysUser" />
<h1><a href="#this"><img src="${pageContext.request.contextPath}/images/guide/logo.png" width="301" height="59" alt="MSNEG" /></a></h1>
<p class="admin"><a href="${pageContext.request.contextPath}/sysConfig"><img src="${pageContext.request.contextPath}/images/ico/ico03.jpg" width="16" height="16" alt="设置"/>设置</a> 
<a href="${pageContext.request.contextPath}/login"><img src="${pageContext.request.contextPath}/images/ico/ico04.jpg" width="16" height="16" alt="切换用户" />切换用户</a> 
<a href="javascript: void(0)" onclick="window.location.reload()"><img src="${pageContext.request.contextPath}/images/ico/ico05.jpg" width="16" height="16" alt="刷新" />刷新</a> 
<a href="javascript: void(0)" onclick="alert('正在建设中...');"><img src="${pageContext.request.contextPath}/images/ico/ico06.jpg" width="16" height="16" alt="帮助" />帮助</a></p>
<div class="bar">
	<p><span class="user">您好：${sysUser.userName }</span>       
	<span class="bumen">隶属：${sysUser.dept.deptName }</span> 
	<span class="news_text">新消息</span> 
	<span class="date">2012.11.20 星期六</span> 
	<span class="help">系统提示：<a href="#this"></a></span>      
	<a href="${pageContext.request.contextPath }/logout" class="out_link">安全退出</a></p>
</div>