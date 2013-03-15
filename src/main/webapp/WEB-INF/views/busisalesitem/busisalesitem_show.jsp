<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiSalesItem" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiSalesItemInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>销售商品ID</td>
                <td>${busiSalesItem.salesItemId}</td>
            </tr>
	    	<tr>
                <td>销售单ID</td>
                <td>${busiSalesItem.busiSales}</td>
            </tr>
	    	<tr>
                <td>商品ID</td>
                <td>${busiSalesItem.busiItem}</td>
            </tr>
	    	<tr>
                <td>商品数量</td>
                <td>${busiSalesItem.itemAmount}</td>
            </tr>
	    	<tr>
                <td>合计</td>
                <td>${busiSalesItem.itemSum}</td>
            </tr>
	    	<tr>
                <td>信息备注</td>
                <td>${busiSalesItem.itemRemarks}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiSalesItem.salesItemId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiSalesItem.salesItemId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>
