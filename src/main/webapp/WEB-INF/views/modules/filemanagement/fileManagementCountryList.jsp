<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困村档案目录管理管理</title>
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
		<li class="active"><a href="${ctx}/filemanagement/fileManagementCountry/">贫困村档案目录管理列表</a></li>
		<shiro:hasPermission name="filemanagement:fileManagementCountry:edit"><li><a href="${ctx}/filemanagement/fileManagementCountry/form">贫困村档案目录管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="fileManagementCountry" action="${ctx}/filemanagement/fileManagementCountry/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="filemanagement:fileManagementCountry:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="fileManagementCountry">
			<tr>
				<td><a href="${ctx}/filemanagement/fileManagementCountry/form?id=${fileManagementCountry.id}">
					<fmt:formatDate value="${fileManagementCountry.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<shiro:hasPermission name="filemanagement:fileManagementCountry:edit"><td>
    				<a href="${ctx}/filemanagement/fileManagementCountry/form?id=${fileManagementCountry.id}">修改</a>
					<a href="${ctx}/filemanagement/fileManagementCountry/delete?id=${fileManagementCountry.id}" onclick="return confirmx('确认要删除该贫困村档案目录管理吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>