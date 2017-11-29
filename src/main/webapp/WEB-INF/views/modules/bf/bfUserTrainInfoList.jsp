<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训报名管理</title>
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
		<li class="active"><a href="${ctx}/bf/bfUserTrainInfo/">培训报名列表</a></li>
		<%-- <shiro:hasPermission name="bf:bfUserTrainInfo:edit"><li><a href="${ctx}/bf/bfUserTrainInfo/form">培训报名添加</a></li></shiro:hasPermission>
	 --%>
	</ul>
	<form:form id="searchForm" modelAttribute="bfUserTrainInfo" action="${ctx}/bf/bfUserTrainInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>报名人：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>手机号码：</label>
				<form:input path="phone" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>培训项目</th>
				<th>报名人</th>
				<th>手机号码</th>
				<th>身份证号</th>
				<th>报名时间</th>
				<shiro:hasPermission name="bf:bfUserTrainInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfUserTrainInfo">
			<tr>
				<td>
					${bfUserTrainInfo.trainName}
				</td>
				<td>
					${bfUserTrainInfo.name}
				</td>
				<td>
					${bfUserTrainInfo.phone}
				</td>
				<td>
					${bfUserTrainInfo.idCard}
				</td>
				<td>
					${bfUserTrainInfo.applyDate}
				</td>
				<shiro:hasPermission name="bf:bfUserTrainInfo:edit"><td>
    				<a href="${ctx}/bf/bfUserTrainInfo/form?id=${bfUserTrainInfo.id}">修改</a>
					<a href="${ctx}/bf/bfUserTrainInfo/delete?id=${bfUserTrainInfo.id}" onclick="return confirmx('确认要删除该培训报名吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>