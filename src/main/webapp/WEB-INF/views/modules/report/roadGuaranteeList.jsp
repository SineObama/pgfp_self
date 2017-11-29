<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>有路通村屯分析表管理</title>
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
		<li class="active"><a href="${ctx}/report/roadGuarantee/">有路通村屯分析表列表</a></li>
		<shiro:hasPermission name="report:roadGuarantee:edit"><li><a href="${ctx}/report/roadGuarantee/form">有路通村屯分析表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="roadGuarantee" action="${ctx}/report/roadGuarantee/" method="post" class="breadcrumb form-search">
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
				<th>update_date</th>
				<th>remarks</th>
				<shiro:hasPermission name="report:roadGuarantee:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="roadGuarantee">
			<tr>
				<td><a href="${ctx}/report/roadGuarantee/form?id=${roadGuarantee.id}">
					<fmt:formatDate value="${roadGuarantee.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${roadGuarantee.remarks}
				</td>
				<shiro:hasPermission name="report:roadGuarantee:edit"><td>
    				<a href="${ctx}/report/roadGuarantee/form?id=${roadGuarantee.id}">修改</a>
					<a href="${ctx}/report/roadGuarantee/delete?id=${roadGuarantee.id}" onclick="return confirmx('确认要删除该有路通村屯分析表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>