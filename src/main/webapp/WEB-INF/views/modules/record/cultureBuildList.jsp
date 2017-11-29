<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文化建设管理</title>
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
		<li class="active"><a href="${ctx}/record/cultureBuild/">文化建设列表</a></li>
		<shiro:hasPermission name="record:cultureBuild:edit"><li><a href="${ctx}/record/cultureBuild/form">文化建设添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cultureBuild" action="${ctx}/record/cultureBuild/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="record:cultureBuild:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cultureBuild">
			<tr>
				<td><a href="${ctx}/record/cultureBuild/form?id=${cultureBuild.id}">
					<fmt:formatDate value="${cultureBuild.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<shiro:hasPermission name="record:cultureBuild:edit"><td>
    				<a href="${ctx}/record/cultureBuild/form?id=${cultureBuild.id}">修改</a>
					<a href="${ctx}/record/cultureBuild/delete?id=${cultureBuild.id}" onclick="return confirmx('确认要删除该文化建设吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>