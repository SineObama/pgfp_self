<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>两委班子情况表管理</title>
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
		<li class="active"><a href="${ctx}/record/committeesTeam/">两委班子情况表列表</a></li>
		<shiro:hasPermission name="record:committeesTeam:edit"><li><a href="${ctx}/record/committeesTeam/form">两委班子情况表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="committeesTeam" action="${ctx}/record/committeesTeam/" method="post" class="breadcrumb form-search">
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
				<th>remarks</th>
				<th>update_date</th>
				<shiro:hasPermission name="record:committeesTeam:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="committeesTeam">
			<tr>
				<td><a href="${ctx}/record/committeesTeam/form?id=${committeesTeam.id}">
					${committeesTeam.remarks}
				</a></td>
				<td>
					<fmt:formatDate value="${committeesTeam.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="record:committeesTeam:edit"><td>
    				<a href="${ctx}/record/committeesTeam/form?id=${committeesTeam.id}">修改</a>
					<a href="${ctx}/record/committeesTeam/delete?id=${committeesTeam.id}" onclick="return confirmx('确认要删除该两委班子情况表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>