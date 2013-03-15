<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiSalesWorkingItem" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiSalesWorkingItemInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>工时单商品ID</td>
                <td>${busiSalesWorkingItem.workingItemId}</td>
            </tr>
	    	<tr>
                <td>工时单ID</td>
                <td>${busiSalesWorkingItem.busiSalesWorking}</td>
            </tr>
	    	<tr>
                <td>商品ID</td>
                <td>${busiSalesWorkingItem.busiItem}</td>
            </tr>
	    	<tr>
                <td>回访</td>
                <td>${busiSalesWorkingItem.returnVisitKey}</td>
            </tr>
	    	<tr>
                <td>备注</td>
                <td>${busiSalesWorkingItem.itemRemarks}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiSalesWorkingItem.workingItemId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiSalesWorkingItem.workingItemId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>
