<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/busiSalesWorking" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="busiSalesWorking.workingId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="busiSalesWorking" id="busiSalesWorkingForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="workingId" />
	        
	        <form:label path="otherItemName">其他项目名称</form:label>
	        <form:input path="otherItemName" />
	        <form:errors path="otherItemName" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="otherItemPrice">其他项目单价</form:label>
	        <form:input path="otherItemPrice" />
	        <form:errors path="otherItemPrice" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="otherItemAmount">其他项目数量</form:label>
	        <form:input path="otherItemAmount" />
	        <form:errors path="otherItemAmount" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="otherItemSum">其他项目合计</form:label>
	        <form:input path="otherItemSum" />
	        <form:errors path="otherItemSum" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="otherItemRemarks">项目备注</form:label>
	        <form:input path="otherItemRemarks" />
	        <form:errors path="otherItemRemarks" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="feeSum">工时总额</form:label>
	        <form:input path="feeSum" />
	        <form:errors path="feeSum" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="clearMethodKey">结算形式</form:label>
	        <form:input path="clearMethodKey" />
	        <form:errors path="clearMethodKey" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="sysDept">安装部门</form:label>
	        <form:input path="sysDept" />
	        <form:errors path="sysDept" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="otherRemarks"></form:label>
	        <form:input path="otherRemarks" />
	        <form:errors path="otherRemarks" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="createTime">创建时间</form:label>
	        <form:input path="createTime" />
	        <form:errors path="createTime" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="sysUser">经手人</form:label>
	        <form:input path="sysUser" />
	        <form:errors path="sysUser" cssClass="error" element="div" />
	        <p/>
	        
	        
	        <button type="submit" class="btn btn-primary">提交</button>
	        <button type="reset" class="btn">重置</button>
	        <a href="${baseUrl}" class="btn">返回列表</a>
        </fieldset>              
    </form:form>   
    </div>

</div>
