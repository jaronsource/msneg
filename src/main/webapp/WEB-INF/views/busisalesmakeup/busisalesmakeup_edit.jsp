<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/busiSalesMakeup" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="busiSalesMakeup.makeupId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="busiSalesMakeup" id="busiSalesMakeupForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="makeupId" />
	        
	        <form:label path="makeupSum">补价总额</form:label>
	        <form:input path="makeupSum" />
	        <form:errors path="makeupSum" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="sysUser">经手人</form:label>
	        <form:input path="sysUser" />
	        <form:errors path="sysUser" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="addItem1">新增临时性损耗费用</form:label>
	        <form:input path="addItem1" />
	        <form:errors path="addItem1" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="addItem2">增值服务取费</form:label>
	        <form:input path="addItem2" />
	        <form:errors path="addItem2" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="addItem3">上衣托管安装（含多施工费用）</form:label>
	        <form:input path="addItem3" />
	        <form:errors path="addItem3" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="addItem4">变更议价补价</form:label>
	        <form:input path="addItem4" />
	        <form:errors path="addItem4" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="addItem5">新增运输及商品管理费用</form:label>
	        <form:input path="addItem5" />
	        <form:errors path="addItem5" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="addItem6">其他商议费用</form:label>
	        <form:input path="addItem6" />
	        <form:errors path="addItem6" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="minusItem1">递减临时性损耗费用</form:label>
	        <form:input path="minusItem1" />
	        <form:errors path="minusItem1" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="minusItem2">补退议价差额</form:label>
	        <form:input path="minusItem2" />
	        <form:errors path="minusItem2" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="minusItem3">递减托管安装（含少施工费用）</form:label>
	        <form:input path="minusItem3" />
	        <form:errors path="minusItem3" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="minusItem4">遇零取整差价</form:label>
	        <form:input path="minusItem4" />
	        <form:errors path="minusItem4" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="minusItem5">商品瑕疵/破损议价差额</form:label>
	        <form:input path="minusItem5" />
	        <form:errors path="minusItem5" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="minusItem6"> 其他商议费用</form:label>
	        <form:input path="minusItem6" />
	        <form:errors path="minusItem6" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="makeupRemarks">补价信息备注</form:label>
	        <form:input path="makeupRemarks" />
	        <form:errors path="makeupRemarks" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="otherRemarks">其他备注</form:label>
	        <form:input path="otherRemarks" />
	        <form:errors path="otherRemarks" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="createTime">创建时间</form:label>
	        <form:input path="createTime" />
	        <form:errors path="createTime" cssClass="error" element="div" />
	        <p/>
	        
	        
	        <button type="submit" class="btn btn-primary">提交</button>
	        <button type="reset" class="btn">重置</button>
	        <a href="${baseUrl}" class="btn">返回列表</a>
        </fieldset>              
    </form:form>   
    </div>

</div>
