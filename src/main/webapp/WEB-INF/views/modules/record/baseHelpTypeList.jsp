<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>帮扶需求类别表管理</title>
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
		<li class="active"><a href="${ctx}/record/baseHelpType/">帮扶需求类别表列表</a></li>
		<shiro:hasPermission name="record:baseHelpType:edit"><li><a href="${ctx}/record/baseHelpType/form">帮扶需求类别表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="baseHelpType" action="${ctx}/record/baseHelpType/" method="post" class="breadcrumb form-search">
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
				<th>备注</th>
				<shiro:hasPermission name="record:baseHelpType:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="baseHelpType">
			<tr>
				<td><a href="${ctx}/record/baseHelpType/form?id=${baseHelpType.id}">
					<fmt:formatDate value="${baseHelpType.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${baseHelpType.remarks}
				</td>
				<shiro:hasPermission name="record:baseHelpType:edit"><td>
    				<a href="${ctx}/record/baseHelpType/form?id=${baseHelpType.id}">修改</a>
					<a href="${ctx}/record/baseHelpType/delete?id=${baseHelpType.id}" onclick="return confirmx('确认要删除该帮扶需求类别表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>