<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>记录村民收入状况管理</title>
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
		<li class="active"><a href="${ctx}/record/devIncome/">记录村民收入状况列表</a></li>
		<shiro:hasPermission name="record:devIncome:edit"><li><a href="${ctx}/record/devIncome/form">记录村民收入状况添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="devIncome" action="${ctx}/record/devIncome/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="record:devIncome:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="devIncome">
			<tr>
				<shiro:hasPermission name="record:devIncome:edit"><td>
    				<a href="${ctx}/record/devIncome/form?id=${devIncome.id}">修改</a>
					<a href="${ctx}/record/devIncome/delete?id=${devIncome.id}" onclick="return confirmx('确认要删除该记录村民收入状况吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>