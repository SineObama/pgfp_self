<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>安全饮水分析表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/report/drinkGuarantee/">安全饮水分析表列表</a></li>
		<shiro:hasPermission name="report:drinkGuarantee:edit"><li><a href="${ctx}/report/drinkGuarantee/form">安全饮水分析表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="drinkGuarantee" action="${ctx}/report/drinkGuarantee/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>update_date</th>
				<th>remarks</th>
				<shiro:hasPermission name="report:drinkGuarantee:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="drinkGuarantee">
			<tr>
				<td><a href="${ctx}/report/drinkGuarantee/form?id=${drinkGuarantee.id}">
					<fmt:formatDate value="${drinkGuarantee.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${drinkGuarantee.remarks}
				</td>
				<shiro:hasPermission name="report:drinkGuarantee:edit"><td>
    				<a href="${ctx}/report/drinkGuarantee/form?id=${drinkGuarantee.id}">修改</a>
					<a href="${ctx}/report/drinkGuarantee/delete?id=${drinkGuarantee.id}" onclick="return confirmx('确认要删除该安全饮水分析表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>