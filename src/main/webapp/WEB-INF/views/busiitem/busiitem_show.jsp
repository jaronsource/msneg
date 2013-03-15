<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiItem" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiItemInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>商品ID</td>
                <td>${busiItem.itemId}</td>
            </tr>
	    	<tr>
                <td>货号</td>
                <td>${busiItem.itemCode}</td>
            </tr>
	    	<tr>
                <td>名称</td>
                <td>${busiItem.itemName}</td>
            </tr>
	    	<tr>
                <td>型号</td>
                <td>${busiItem.itemFormat}</td>
            </tr>
	    	<tr>
                <td>单位</td>
                <td>${busiItem.itemUnit}</td>
            </tr>
	    	<tr>
                <td>单价</td>
                <td>${busiItem.itemPrice}</td>
            </tr>
	    	<tr>
                <td>助记符</td>
                <td>${busiItem.itemCnspell}</td>
            </tr>
	    	<tr>
                <td>类别</td>
                <td>${busiItem.itemTypeKey}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiItem.itemId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiItem.itemId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>
