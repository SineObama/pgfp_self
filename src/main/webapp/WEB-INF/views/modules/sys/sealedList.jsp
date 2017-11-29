<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>封存数据管理</title>
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
		<li class="active"><a href="${ctx}/sys/sealed/">数据封存年度列表</a></li>
		<shiro:hasPermission name="sys:sealed:edit"><li><a href="${ctx}/sys/sealed/form">封存数据添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sealed" action="${ctx}/sys/sealed/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label>年度：</label>
				<form:input path="years"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>年度</th>
				<th>封存时间</th>
				<th>备注</th>
				<shiro:hasPermission name="sys:sealed:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sealed">
			<tr>
				<td><a href="${ctx}/sys/sealed/form?id=${sealed.id}">
					${sealed.years}
				</a></td>
				<td>
					<fmt:formatDate value="${sealed.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${sealed.remarks}
				</td>
				<shiro:hasPermission name="sys:sealed:edit"><td>
    				<%--<a href="${ctx}/sys/sealed/form?id=${sealed.id}">修改</a>--%>
					<a href="${ctx}/sys/sealed/delete?id=${sealed.id}" onclick="return confirmx('确认要删除该封存数据吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>