<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村民住房管理</title>
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
		<li class="active"><a href="${ctx}/record/countryHouse/">村民住房列表</a></li>
		<shiro:hasPermission name="record:countryHouse:edit"><li><a href="${ctx}/record/countryHouse/form">村民住房添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="countryHouse" action="${ctx}/record/countryHouse/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="record:countryHouse:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="countryHouse">
			<tr>
				<shiro:hasPermission name="record:countryHouse:edit"><td>
    				<a href="${ctx}/record/countryHouse/form?id=${countryHouse.id}">修改</a>
					<a href="${ctx}/record/countryHouse/delete?id=${countryHouse.id}" onclick="return confirmx('确认要删除该村民住房吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>