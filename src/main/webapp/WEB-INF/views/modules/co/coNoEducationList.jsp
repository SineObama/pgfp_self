<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村适龄儿童少年应接受义务教育未接受名单管理</title>
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
		<li class="active"><a href="${ctx}/co/coNoEducation/">村适龄儿童少年应接受义务教育未接受名单列表</a></li>
		<shiro:hasPermission name="co:coNoEducation:edit"><li><a href="${ctx}/co/coNoEducation/form">村适龄儿童少年应接受义务教育未接受名单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="coNoEducation" action="${ctx}/co/coNoEducation/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>应接受义务教育未接受适龄儿童少年姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>应接受义务教育未接受适龄儿童少年姓名</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="co:coNoEducation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="coNoEducation">
			<tr>
				<td><a href="${ctx}/co/coNoEducation/form?id=${coNoEducation.id}">
					${coNoEducation.name}
				</a></td>
				<td>
					<fmt:formatDate value="${coNoEducation.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${coNoEducation.remarks}
				</td>
				<shiro:hasPermission name="co:coNoEducation:edit"><td>
    				<a href="${ctx}/co/coNoEducation/form?id=${coNoEducation.id}">修改</a>
					<a href="${ctx}/co/coNoEducation/delete?id=${coNoEducation.id}" onclick="return confirmx('确认要删除该村适龄儿童少年应接受义务教育未接受名单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>