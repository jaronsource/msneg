<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.ccesun.com/tags/security" %>

<ul class="lnb">
   	<security:permList var="permList"/>
   	<c:forEach items="${permList }" var="perm">
   	<li>
		<a <security:hasPerm permCode="${perm.code }">
			href="${pageContext.request.contextPath}${perm.url }"
		</security:hasPerm>
		<security:noPerm permCode="${perm.code }">
			href="javascript: void(0)"
			onclick="alert('对不起，您无权操作本功能'); return false;"
		</security:noPerm> 
		class="${perm.funcRemarks } <c:if test="${fn:startsWith(RELATIVE_REQUESTURI_QUERYSTR, perm.url)}" >hover</c:if>">${perm.name }</a></li>
   	</c:forEach>
</ul>