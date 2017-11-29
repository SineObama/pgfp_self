<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>扶贫搬迁审批表管理</title>
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
		<li class="active"><a href="${ctx}/bs/approvalForRelocation/">扶贫搬迁审批表列表</a></li>
		<shiro:hasPermission name="bs:approvalForRelocation:edit"><li><a href="${ctx}/bs/approvalForRelocation/form">扶贫搬迁审批表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="approvalForRelocation" action="${ctx}/bs/approvalForRelocation/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>户主姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>户主姓名</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="bs:approvalForRelocation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="approvalForRelocation">
			<tr>
				<td><a href="${ctx}/bs/approvalForRelocation/form?id=${approvalForRelocation.id}">
					${approvalForRelocation.name}
				</a></td>
				<td>
					<fmt:formatDate value="${approvalForRelocation.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${approvalForRelocation.remarks}
				</td>
				<shiro:hasPermission name="bs:approvalForRelocation:edit"><td>
    				<a href="${ctx}/bs/approvalForRelocation/form?id=${approvalForRelocation.id}">修改</a>
					<a href="${ctx}/bs/approvalForRelocation/delete?id=${approvalForRelocation.id}" onclick="return confirmx('确认要删除该扶贫搬迁审批表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>