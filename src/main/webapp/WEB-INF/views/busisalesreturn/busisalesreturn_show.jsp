<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiSalesReturn" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiSalesReturnInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>返销单ID</td>
                <td>${busiSalesReturn.returnId}</td>
            </tr>
	    	<tr>
                <td>销售单ID</td>
                <td>${busiSalesReturn.busiSales}</td>
            </tr>
	    	<tr>
                <td>经手人</td>
                <td>${busiSalesReturn.sysUser}</td>
            </tr>
	    	<tr>
                <td>返销破损</td>
                <td>${busiSalesReturn.returnLoss}</td>
            </tr>
	    	<tr>
                <td>折扣破损</td>
                <td>${busiSalesReturn.rerateLoss}</td>
            </tr>
	    	<tr>
                <td>备注</td>
                <td>${busiSalesReturn.returnRemarks}</td>
            </tr>
	    	<tr>
                <td>结算方式</td>
                <td>${busiSalesReturn.clearMethodKey}</td>
            </tr>
	    	<tr>
                <td>其他备注</td>
                <td>${busiSalesReturn.otherRemarks}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiSalesReturn.returnId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiSalesReturn.returnId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>
