<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产业发展帮扶申请表管理</title>
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
		<li class="active"><a href="${ctx}/bs/industryAssistanceApplication/list">产业发展帮扶申请表列表</a></li>
		<%--<shiro:hasPermission name="bs:industryAssistanceApplication:edit"><li><a href="${ctx}/bs/industryAssistanceApplication/form">产业发展帮扶申请表添加</a></li></shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="industryAssistanceApplication" action="${ctx}/bs/industryAssistanceApplication/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>户主姓名：</label>
				<form:input path="householdName" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>户主姓名</th>
				<th>身份证号</th>
				<th>产业名称</th>
				<th>申请补助金额</th>
				<th>更新时间</th>
				<shiro:hasPermission name="bs:industryAssistanceApplication:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="industryAssistanceApplication">
			<tr>
				<td><a href="${ctx}/bs/industryAssistanceApplication/form?id=${industryAssistanceApplication.id}">
					${industryAssistanceApplication.householdName}
				</a></td>
				<td>
						${industryAssistanceApplication.idNumber}
				</td>
				<td>
						${industryAssistanceApplication.name}
				</td>
				<td>
						${industryAssistanceApplication.subsidyMoney}
				</td>
				<td>
					<fmt:formatDate value="${industryAssistanceApplication.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>

				<shiro:hasPermission name="bs:industryAssistanceApplication:edit"><td>
					<a href="${ctx}/bs/industryAssistanceApplication/export?id=${industryAssistanceApplication.id}">导出帮扶申请表</a>
					<a href="${ctx}/bs/industryAssistanceApplication/form?id=${industryAssistanceApplication.id}">查看</a>
					<a href="${ctx}/bs/industryAssistanceApplication/delete?id=${industryAssistanceApplication.id}" onclick="return confirmx('确认要删除该产业发展帮扶申请表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>