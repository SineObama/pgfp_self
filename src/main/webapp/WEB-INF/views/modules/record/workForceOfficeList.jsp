<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>驻村工作队情况_干部表管理</title>
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
		<li class="active"><a href="${ctx}/record/workForceOffice/">驻村工作队情况_干部表列表</a></li>
		<shiro:hasPermission name="record:workForceOffice:edit"><li><a href="${ctx}/record/workForceOffice/form">驻村工作队情况_干部表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="workForceOffice" action="${ctx}/record/workForceOffice/" method="post" class="breadcrumb form-search">
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
				<th>更新时间</th>
				<shiro:hasPermission name="record:workForceOffice:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="workForceOffice">
			<tr>
				<td><a href="${ctx}/record/workForceOffice/form?id=${workForceOffice.id}">
					<fmt:formatDate value="${workForceOffice.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<shiro:hasPermission name="record:workForceOffice:edit"><td>
    				<a href="${ctx}/record/workForceOffice/form?id=${workForceOffice.id}">修改</a>
					<a href="${ctx}/record/workForceOffice/delete?id=${workForceOffice.id}" onclick="return confirmx('确认要删除该驻村工作队情况_干部表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>