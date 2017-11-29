<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>有电视看分析表管理</title>
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
		<li class="active"><a href="${ctx}/report/digitalGuarantee/">有电视看分析表列表</a></li>
		<shiro:hasPermission name="report:digitalGuarantee:edit"><li><a href="${ctx}/report/digitalGuarantee/form">有电视看分析表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="digitalGuarantee" action="${ctx}/report/digitalGuarantee/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="report:digitalGuarantee:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="digitalGuarantee">
			<tr>
				<td><a href="${ctx}/report/digitalGuarantee/form?id=${digitalGuarantee.id}">
					<fmt:formatDate value="${digitalGuarantee.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${digitalGuarantee.remarks}
				</td>
				<shiro:hasPermission name="report:digitalGuarantee:edit"><td>
    				<a href="${ctx}/report/digitalGuarantee/form?id=${digitalGuarantee.id}">修改</a>
					<a href="${ctx}/report/digitalGuarantee/delete?id=${digitalGuarantee.id}" onclick="return confirmx('确认要删除该有电视看分析表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>