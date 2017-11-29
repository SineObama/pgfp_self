<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>填表管理</title>
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
	<li class="active"><a href="${ctx}/migration/table/">填表列表</a></li>
	<shiro:hasPermission name="migration:table:edit"><li><a href="${ctx}/migration/table/form">填表修改</a></li></shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="tableInfo" action="${ctx}/migration/table/" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>负责人联系电话：</label>
			<form:input path="moblie" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>负责人联系电话</th>
		<th>填报人姓名及联系电话</th>
		<th>审核人联系电话</th>
		<th>填表日期</th>
		<th>更新时间</th>
		<shiro:hasPermission name="migration:table:edit"><th>操作</th></shiro:hasPermission>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="table">
		<tr>
			<td><a href="${ctx}/migration/table/form?id=${table.id}">
				${table.moblie}
			</a></td>
			<td>
				${table.nameMoblie}
			</td>
			<td>
				${table.auditorMoblie}
			</td>
			<td>
				<fmt:formatDate value="${table.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</td>

			<td>
				<fmt:formatDate value="${table.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</td>
			<shiro:hasPermission name="migration:table:edit"><td>
				<a href="${ctx}/migration/table/form?id=${table.id}">修改</a>
				<a href="${ctx}/migration/table/delete?id=${table.id}" onclick="return confirmx('确认要删除该填表吗？', this.href)">删除</a>
			</td></shiro:hasPermission>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>