<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户收入详情管理</title>
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
		<li class="active"><a href="${ctx}/bf/bfRecordIncomeDetails/">贫困户收入详情列表</a></li>
		<shiro:hasPermission name="bf:bfRecordIncomeDetails:edit"><li><a href="${ctx}/bf/bfRecordIncomeDetails/form">贫困户收入详情添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bfRecordIncomeDetails" action="${ctx}/bf/bfRecordIncomeDetails/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>月度：</label>
				<form:input path="month" htmlEscape="false" maxlength="2" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>年度</th>
				<th>月份</th>
				<th>更新时间</th>
				<shiro:hasPermission name="record:countryBasic:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfRecordIncomeDetails">
			<tr>
				<td><a href="${ctx}/bf/bfRecordIncomeDetails/form?id=${bfRecordIncomeDetails.id}&regCardId=${regCardId}">
					${bfRecordIncomeDetails.bfRecordIncome.years}
				</a></td>
				<td><a href="${ctx}/bf/bfRecordIncomeDetails/form?id=${bfRecordIncomeDetails.id}&regCardId=${regCardId}">
					${bfRecordIncomeDetails.month}
				</a></td>
				<td>
					<fmt:formatDate value="${bfRecordIncomeDetails.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="record:countryBasic:edit"><td>
    				<a href="${ctx}/bf/bfRecordIncomeDetails/form?id=${bfRecordIncomeDetails.id}&regCardId=${regCardId}">修改</a>
					<a href="${ctx}/bf/bfRecordIncomeDetails/delete?id=${bfRecordIncomeDetails.id}" onclick="return confirmx('确认要删除该贫困户收入详情吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>