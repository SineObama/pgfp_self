<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>基本公共服务表管理</title>
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
		<li class="active"><a href="${ctx}/record/basicPublicService/">基本公共服务表列表</a></li>
		<shiro:hasPermission name="record:basicPublicService:edit"><li><a href="${ctx}/record/basicPublicService/form">基本公共服务表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="basicPublicService" action="${ctx}/record/basicPublicService/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="record:basicPublicService:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="basicPublicService">
			<tr>
				<td><a href="${ctx}/record/basicPublicService/form?id=${basicPublicService.id}">
					${basicPublicService.remarks}
				</a></td>
				<td>
					<fmt:formatDate value="${basicPublicService.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="record:basicPublicService:edit"><td>
    				<a href="${ctx}/record/basicPublicService/form?id=${basicPublicService.id}">修改</a>
					<a href="${ctx}/record/basicPublicService/delete?id=${basicPublicService.id}" onclick="return confirmx('确认要删除该基本公共服务表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>