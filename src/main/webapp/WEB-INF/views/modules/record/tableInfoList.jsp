<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>填表信息管理</title>
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
		<li class="active"><a href="${ctx}/record/tableInfo/">填表信息列表</a></li>
		<shiro:hasPermission name="record:tableInfo:edit"><li><a href="${ctx}/record/tableInfo/form">填表信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="tableInfo" action="${ctx}/record/tableInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>村委会主任姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>村委会主任姓名</th>
				<shiro:hasPermission name="record:tableInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="tableInfo">
			<tr>
				<td><a href="${ctx}/record/tableInfo/form?id=${tableInfo.id}">
					${tableInfo.name}
				</a></td>
				<shiro:hasPermission name="record:tableInfo:edit"><td>
    				<a href="${ctx}/record/tableInfo/form?id=${tableInfo.id}">修改</a>
					<a href="${ctx}/record/tableInfo/delete?id=${tableInfo.id}" onclick="return confirmx('确认要删除该填表信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>