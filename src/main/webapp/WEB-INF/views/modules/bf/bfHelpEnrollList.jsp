<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>社会扶贫报名信息管理</title>
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
		<li class="active"><a href="${ctx}/bf/bfHelpEnroll/">社会扶贫报名信息列表</a></li>
		<%-- <shiro:hasPermission name="bf:bfHelpEnroll:edit"><li><a href="${ctx}/bf/bfHelpEnroll/form">社会扶贫报名信息添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="bfHelpEnroll" action="${ctx}/bf/bfHelpEnroll/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>报名人：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<%-- <li><label>手机号码：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>身份证号：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>工种：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li> --%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>所属内容</th>
				<th>归属栏目</th>
				<!-- <th>培训内容</th> -->
				<th>报名人</th>
				<th>手机号码</th>
				<th>身份证号</th>
				<!-- <th>工种</th> -->
				<shiro:hasPermission name="bf:bfHelpEnroll:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfHelpEnroll">
			<tr>
				<td><a href="${ctx}/bf/bfHelpEnroll/form?id=${bfHelpEnroll.id}">
					${bfHelpEnroll.contentId.title}
				</a></td>
				<td>
					${bfHelpEnroll.categoryId.name}
				</td>
				<%-- <td>
					${bfHelpEnroll.trainName}
				</td> --%>
				<td>
					${bfHelpEnroll.name}
				</td>
				<td>
					${bfHelpEnroll.phone}
				</td>
				<td>
					${bfHelpEnroll.idCard}
				</td>
				<%--<td>--%>
					<%--${bfHelpEnroll.workType}--%>
				<%--</td>--%>
				<shiro:hasPermission name="bf:bfHelpEnroll:edit"><td>
    				<a href="${ctx}/bf/bfHelpEnroll/form?id=${bfHelpEnroll.id}">修改</a>
					<a href="${ctx}/bf/bfHelpEnroll/delete?id=${bfHelpEnroll.id}" onclick="return confirmx('确认要删除该社会扶贫报名信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>