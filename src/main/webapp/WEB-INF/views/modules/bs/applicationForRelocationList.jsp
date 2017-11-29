<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>移民搬迁申请表管理</title>
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
		<li class="active"><a href="${ctx}/bs/applicationForRelocation/">移民搬迁申请表列表</a></li>
		<%--<shiro:hasPermission name="bs:applicationForRelocation:edit"><li><a href="${ctx}/bs/applicationForRelocation/form">移民搬迁申请表添加</a></li></shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="applicationForRelocation" action="${ctx}/bs/applicationForRelocation/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label style="width: auto">姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label style="width: auto">状态：</label>
				<form:select path="checkState" class="input-large">
					<form:option value="" label="       "/>
					<form:options items="${fns:getDictList('check_state')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>姓名</th>
				<th>申请时间</th>
				<th>状态</th>
				<shiro:hasPermission name="bs:applicationForRelocation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="applicationForRelocation">
			<tr>
				<td><a href="${ctx}/bs/applicationForRelocation/form?id=${applicationForRelocation.id}">
					${applicationForRelocation.name}
				</a></td>
				<td>
					<fmt:formatDate value="${applicationForRelocation.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(applicationForRelocation.checkState,"check_state","")}
				</td>
				<shiro:hasPermission name="bs:applicationForRelocation:edit"><td>
					<a href="${ctx}/bs/applicationForRelocation/export?id=${applicationForRelocation.id}">导出移民申请表</a>
    				<a href="${ctx}/bs/applicationForRelocation/form?id=${applicationForRelocation.id}">查看</a>
					<a href="${ctx}/bs/applicationForRelocation/delete?id=${applicationForRelocation.id}" onclick="return confirmx('确认要删除该移民搬迁申请表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>