<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<ul class="lnb">
	
	<li><a href="${pageContext.request.contextPath}/sales" class="lnb01 <c:if test="${RELATIVE_REQUESTURI == '/sales' || fn:startsWith(RELATIVE_REQUESTURI, '/busiSales')}" >hover</c:if>">销售开单打印</a></li>
    <li><a href="${pageContext.request.contextPath}/busiBills" class="lnb03 <c:if test="${RELATIVE_REQUESTURI == '/busiBills'}" >hover</c:if>">单据查看管理</a></li>
    <li><a href="${pageContext.request.contextPath}/busiOrders" class="lnb02 <c:if test="${RELATIVE_REQUESTURI == '/busiOrders'}" >hover</c:if>">定金预定管理</a></li>
    <li><a href="${pageContext.request.contextPath}/busiAssign?form['salesStateKey_eq']=B" class="lnb05 <c:if test="${RELATIVE_REQUESTURI == '/busiAssign'}" >hover</c:if>">货物发配管理</a></li>
    <li><a href="#" class="lnb06">库存管理查询</a></li>
    <li><a href="#" class="lnb08">综合数据分析</a></li> 
    <li><a href="${pageContext.request.contextPath}/busiClient" class="lnb11 <c:if test="${RELATIVE_REQUESTURI == '/busiClient'}" >hover</c:if>">客户信息调整</a></li>
    <li><a href="#" class="lnb12">报备</a></li>
    <li><a href="#" class="lnb12">设置</a></li>
</ul>