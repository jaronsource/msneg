<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiSalesReturnItem" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiSalesReturnItemInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>返销商品ID</td>
                <td>${busiSalesReturnItem.returnItemId}</td>
            </tr>
	    	<tr>
                <td>返销单ID</td>
                <td>${busiSalesReturnItem.busiSalesReturn}</td>
            </tr>
	    	<tr>
                <td>商品ID</td>
                <td>${busiSalesReturnItem.busiItem}</td>
            </tr>
	    	<tr>
                <td>返销单价</td>
                <td>${busiSalesReturnItem.returnPrice}</td>
            </tr>
	    	<tr>
                <td>返销数量</td>
                <td>${busiSalesReturnItem.returnAmount}</td>
            </tr>
	    	<tr>
                <td>返销合计</td>
                <td>${busiSalesReturnItem.returnSum}</td>
            </tr>
	    	<tr>
                <td>返销事由</td>
                <td>${busiSalesReturnItem.returnReasonKey}</td>
            </tr>
	    	<tr>
                <td>备注</td>
                <td>${busiSalesReturnItem.returnRemarks}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiSalesReturnItem.returnItemId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiSalesReturnItem.returnItemId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>
