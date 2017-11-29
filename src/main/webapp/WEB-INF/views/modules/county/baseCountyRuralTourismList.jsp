<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>乡村旅游管理</title>
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
		<li class="active"><a href="${ctx}/county/baseCountyRuralTourism/">乡村旅游列表</a></li>
		<shiro:hasPermission name="county:baseCountyRuralTourism:edit"><li><a href="${ctx}/county/baseCountyRuralTourism/form">饮水安全添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="baseCountyKeyWorkInfo" action="${ctx}/county/baseCountyRuralTourism/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="county:baseCountyRuralTourism:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="baseCountyKeyWorkInfo">
			<tr>
				<shiro:hasPermission name="county:baseCountyRuralTourism:edit"><td>
    				<a href="${ctx}/county/baseCountyRuralTourism/form?id=${baseCountyKeyWorkInfo.id}">修改</a>
					<a href="${ctx}/county/baseCountyRuralTourism/delete?id=${baseCountyKeyWorkInfo.id}" onclick="return confirmx('确认要删除乡村旅游吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>