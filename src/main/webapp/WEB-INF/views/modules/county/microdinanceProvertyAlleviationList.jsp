<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>扶贫小额信贷管理</title>
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
		<li class="active"><a href="${ctx}/county/microdinanceProvertyAlleviation/">扶贫小额信贷列表</a></li>
		<shiro:hasPermission name="county:microdinanceProvertyAlleviation:edit"><li><a href="${ctx}/county/microdinanceProvertyAlleviation/form">扶贫小额信贷添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="baseCountySpecialPovertyInfo" action="${ctx}/county/microdinanceProvertyAlleviation/" method="post" class="breadcrumb form-search">
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
				<th>C92 扶贫小额信贷覆盖贫困村数（个）： </th>
				<th>C93 扶贫小额信贷贷款户数（户）：</th>
				<th>C94 扶贫小额信贷发放总额（万元）：</th>
				<shiro:hasPermission name="county:microdinanceProvertyAlleviation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="microdinanceProvertyAlleviation">
			<tr>
				<td><a href="${ctx}/county/microdinanceProvertyAlleviation/form?id=${microdinanceProvertyAlleviation.id}">
					${microdinanceProvertyAlleviation.microfinanceCoverVillages}
				</a></td>
				<td>
					${microdinanceProvertyAlleviation.microfinanceLoanHouseholds}
				</td>
				<td>
					${microdinanceProvertyAlleviation.microfinanceLoanAmount}
				</td>
				<shiro:hasPermission name="county:microfinanceProvertyAlleviation:edit"><td>
    				<a href="${ctx}/county/microdinanceProvertyAlleviation/form?id=${microdinanceProvertyAlleviation.id}">修改</a>
					<a href="${ctx}/county/microdinanceProvertyAlleviation/delete?id=${microdinanceProvertyAlleviation.id}" onclick="return confirmx('确认要删除扶贫小额信贷吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>