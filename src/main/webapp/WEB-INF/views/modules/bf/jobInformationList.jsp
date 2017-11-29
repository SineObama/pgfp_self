<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>求职信息管理</title>
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
		<li class="active"><a href="${ctx}/bf/jobInformation/">求职信息列表</a></li>
		<shiro:hasPermission name="bf:jobInformation:edit"><li><a href="${ctx}/bf/jobInformation/form">求职信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="jobInformation" action="${ctx}/bf/jobInformation/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>姓名：</label>
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
				<th>姓名</th>
				<th>年龄</th>
				<th>联系电话</th>
				<th>地址</th>
				<th>期望工作</th>
				<th>自我简介</th>
				<th>学历</th>
				<shiro:hasPermission name="bf:jobInformation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="jobInformation">
			<tr>
				<td><a href="${ctx}/bf/jobInformation/form?id=${jobInformation.id}">
					${jobInformation.name}
				</a></td>
				<td>
					${jobInformation.age}
				</td>
				<td>
					${jobInformation.phone}
				</td>
				<td>
					${jobInformation.address}
				</td>
				<td>
					${jobInformation.expectedWork}
				</td>
				<td>
					${jobInformation.selfIntroduction}
				</td>
				<td>
					${jobInformation.education}
				</td>
				<shiro:hasPermission name="bf:jobInformation:edit"><td>
    				<a href="${ctx}/bf/jobInformation/form?id=${jobInformation.id}">修改</a>
					<a href="${ctx}/bf/jobInformation/delete?id=${jobInformation.id}" onclick="return confirmx('确认要删除该求职信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>