<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>城乡居民参保标准管理</title>
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
		<li class="active"><a href="${ctx}/bf/insuredStandard/">城乡居民参保标准</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="insuredStandard" action="${ctx}/bf/insuredStandard/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<%--<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>--%>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>城乡居民基本医疗保险金额标准</th>
				<th>城乡居民基本医疗保险报销比例标准(%)</th>
				<th>城乡居民基本养老保险金额标准</th>
				<th>城乡居民基本养老保险报销比例标准(%)</th>
				<shiro:hasPermission name="bf:insuredStandard:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="insuredStandard">
			<tr>
				<td>${insuredStandard.medicalInsuranceMoney}</td>
				<td>${insuredStandard.medicalInsuranceRate}</td>
				<td>${insuredStandard.endowmentInsuranceMoney}</td>
				<td>${insuredStandard.endowmentInsuranceRate}</td>
				<shiro:hasPermission name="bf:insuredStandard:edit"><td>
    				<a href="${ctx}/bf/insuredStandard/form?id=${insuredStandard.id}">修改</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>