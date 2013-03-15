<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/busiSales" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="busiSales.salesId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="busiSales" id="busiSalesForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="salesId" />
	        
	        <form:label path="salesCode">编码</form:label>
	        <form:input path="salesCode" />
	        <form:errors path="salesCode" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="sysDept">销售部门</form:label>
	        <form:input path="sysDept" />
	        <form:errors path="sysDept" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="sysUser">经手人</form:label>
	        <form:input path="sysUser" />
	        <form:errors path="sysUser" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="createTime">创建时间</form:label>
	        <form:input path="createTime" />
	        <form:errors path="createTime" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="salesRemarks">备注</form:label>
	        <form:input path="salesRemarks" />
	        <form:errors path="salesRemarks" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="salesTypeKey">销售单类型</form:label>
	        <form:input path="salesTypeKey" />
	        <form:errors path="salesTypeKey" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="busiClient">客户ID</form:label>
	        <form:input path="busiClient" />
	        <form:errors path="busiClient" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="salesStateKey">状态</form:label>
	        <form:input path="salesStateKey" />
	        <form:errors path="salesStateKey" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="servLogisKey">物流信息</form:label>
	        <form:input path="servLogisKey" />
	        <form:errors path="servLogisKey" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="servGetmethodKey">取货方式</form:label>
	        <form:input path="servGetmethodKey" />
	        <form:errors path="servGetmethodKey" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="servInstallmethodKey">安装方式</form:label>
	        <form:input path="servInstallmethodKey" />
	        <form:errors path="servInstallmethodKey" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="feeSum">总金额</form:label>
	        <form:input path="feeSum" />
	        <form:errors path="feeSum" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="feePrepay">预付金额</form:label>
	        <form:input path="feePrepay" />
	        <form:errors path="feePrepay" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="feePrepayCash">预付金现金</form:label>
	        <form:input path="feePrepayCash" />
	        <form:errors path="feePrepayCash" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="feePrepayCard">预付金刷卡</form:label>
	        <form:input path="feePrepayCard" />
	        <form:errors path="feePrepayCard" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="feeRemain">剩余尾款</form:label>
	        <form:input path="feeRemain" />
	        <form:errors path="feeRemain" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="otherRemarks">其他备注</form:label>
	        <form:input path="otherRemarks" />
	        <form:errors path="otherRemarks" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="salesContract">合同条款</form:label>
	        <form:input path="salesContract" />
	        <form:errors path="salesContract" cssClass="error" element="div" />
	        <p/>
	        
	        
	        <button type="submit" class="btn btn-primary">提交</button>
	        <button type="reset" class="btn">重置</button>
	        <a href="${baseUrl}" class="btn">返回列表</a>
        </fieldset>              
    </form:form>   
    </div>

</div>
