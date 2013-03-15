<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/busiSalesBrokerageItem" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="busiSalesBrokerageItem.brokItemId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="busiSalesBrokerageItem" id="busiSalesBrokerageItemForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="brokItemId" />
	        
	        <form:label path="busiSalesBrokerage">提成单ID</form:label>
	        <form:input path="busiSalesBrokerage" />
	        <form:errors path="busiSalesBrokerage" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="busiItem">商品ID</form:label>
	        <form:input path="busiItem" />
	        <form:errors path="busiItem" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="brokReturn">返销</form:label>
	        <form:input path="brokReturn" />
	        <form:errors path="brokReturn" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="brokInstall">安装</form:label>
	        <form:input path="brokInstall" />
	        <form:errors path="brokInstall" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="brokMakeup">辅差</form:label>
	        <form:input path="brokMakeup" />
	        <form:errors path="brokMakeup" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="brokRatio">比率</form:label>
	        <form:input path="brokRatio" />
	        <form:errors path="brokRatio" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="brokMerePrice">净价</form:label>
	        <form:input path="brokMerePrice" />
	        <form:errors path="brokMerePrice" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="brokMereAmount">净量</form:label>
	        <form:input path="brokMereAmount" />
	        <form:errors path="brokMereAmount" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="brokSum">提成合计</form:label>
	        <form:input path="brokSum" />
	        <form:errors path="brokSum" cssClass="error" element="div" />
	        <p/>
	        
	        
	        <button type="submit" class="btn btn-primary">提交</button>
	        <button type="reset" class="btn">重置</button>
	        <a href="${baseUrl}" class="btn">返回列表</a>
        </fieldset>              
    </form:form>   
    </div>

</div>
