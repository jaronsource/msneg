<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/busiSalesItem" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="busiSalesItem.salesItemId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="busiSalesItem" id="busiSalesItemForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="salesItemId" />
	        
	        <form:label path="busiSales">销售单ID</form:label>
	        <form:input path="busiSales" />
	        <form:errors path="busiSales" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="busiItem">商品ID</form:label>
	        <form:input path="busiItem" />
	        <form:errors path="busiItem" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="itemAmount">商品数量</form:label>
	        <form:input path="itemAmount" />
	        <form:errors path="itemAmount" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="itemSum">合计</form:label>
	        <form:input path="itemSum" />
	        <form:errors path="itemSum" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="itemRemarks">信息备注</form:label>
	        <form:input path="itemRemarks" />
	        <form:errors path="itemRemarks" cssClass="error" element="div" />
	        <p/>
	        
	        
	        <button type="submit" class="btn btn-primary">提交</button>
	        <button type="reset" class="btn">重置</button>
	        <a href="${baseUrl}" class="btn">返回列表</a>
        </fieldset>              
    </form:form>   
    </div>

</div>
