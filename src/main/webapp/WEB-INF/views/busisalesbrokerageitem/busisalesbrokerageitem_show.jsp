<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiSalesBrokerageItem" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiSalesBrokerageItemInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>提成商品ID</td>
                <td>${busiSalesBrokerageItem.brokItemId}</td>
            </tr>
	    	<tr>
                <td>提成单ID</td>
                <td>${busiSalesBrokerageItem.busiSalesBrokerage}</td>
            </tr>
	    	<tr>
                <td>商品ID</td>
                <td>${busiSalesBrokerageItem.busiItem}</td>
            </tr>
	    	<tr>
                <td>返销</td>
                <td>${busiSalesBrokerageItem.brokReturn}</td>
            </tr>
	    	<tr>
                <td>安装</td>
                <td>${busiSalesBrokerageItem.brokInstall}</td>
            </tr>
	    	<tr>
                <td>辅差</td>
                <td>${busiSalesBrokerageItem.brokMakeup}</td>
            </tr>
	    	<tr>
                <td>比率</td>
                <td>${busiSalesBrokerageItem.brokRatio}</td>
            </tr>
	    	<tr>
                <td>净价</td>
                <td>${busiSalesBrokerageItem.brokMerePrice}</td>
            </tr>
	    	<tr>
                <td>净量</td>
                <td>${busiSalesBrokerageItem.brokMereAmount}</td>
            </tr>
	    	<tr>
                <td>提成合计</td>
                <td>${busiSalesBrokerageItem.brokSum}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiSalesBrokerageItem.brokItemId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiSalesBrokerageItem.brokItemId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>
