<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>有电用分析表管理</title>
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
		<li class="active"><a href="${ctx}/report/electricGuarantee/">有电用分析表列表</a></li>
		<shiro:hasPermission name="report:electricGuarantee:edit"><li><a href="${ctx}/report/electricGuarantee/form">有电用分析表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="electricGuarantee" action="${ctx}/report/electricGuarantee/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="report:electricGuarantee:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="electricGuarantee">
			<tr>
				<td><a href="${ctx}/report/electricGuarantee/form?id=${electricGuarantee.id}">
					<fmt:formatDate value="${electricGuarantee.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${electricGuarantee.remarks}
				</td>
				<shiro:hasPermission name="report:electricGuarantee:edit"><td>
    				<a href="${ctx}/report/electricGuarantee/form?id=${electricGuarantee.id}">修改</a>
					<a href="${ctx}/report/electricGuarantee/delete?id=${electricGuarantee.id}" onclick="return confirmx('确认要删除该有电用分析表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>