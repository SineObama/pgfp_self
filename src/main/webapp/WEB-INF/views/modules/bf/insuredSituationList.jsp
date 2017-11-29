<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>家庭成员参保情况表管理</title>
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
		<li class="active"><a href="${ctx}/bf/insuredSituation/">家庭成员参保情况表列表</a></li>
		<shiro:hasPermission name="bf:insuredSituation:edit"><li><a href="${ctx}/bf/insuredSituation/form">家庭成员参保情况表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="insuredSituation" action="${ctx}/bf/insuredSituation/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>name：</label>
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
				<th>name</th>
				<th>update_date</th>
				<th>remarks</th>
				<shiro:hasPermission name="bf:insuredSituation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="insuredSituation">
			<tr>
				<td><a href="${ctx}/bf/insuredSituation/form?id=${insuredSituation.id}">
					${insuredSituation.name}
				</a></td>
				<td>
					<fmt:formatDate value="${insuredSituation.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${insuredSituation.remarks}
				</td>
				<shiro:hasPermission name="bf:insuredSituation:edit"><td>
    				<a href="${ctx}/bf/insuredSituation/form?id=${insuredSituation.id}">修改</a>
					<a href="${ctx}/bf/insuredSituation/delete?id=${insuredSituation.id}" onclick="return confirmx('确认要删除该家庭成员参保情况表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>