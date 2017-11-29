<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>移民搬迁规划管理</title>
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
		<li class="active"><a href="${ctx}/migration/bNaturalVillageRelocationPlan/">移民搬迁规划列表</a></li>
		<shiro:hasPermission name="migration:bNaturalVillageRelocationPlan:edit"><li><a href="${ctx}/migration/bNaturalVillageRelocationPlan/form">移民搬迁规划修改</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bNaturalVillageRelocationPlan" action="${ctx}/migration/bNaturalVillageRelocationPlan/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>年份：</label>
				<input name="particularYear" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${bNaturalVillageRelocationPlan.particularYear}" pattern="yyyy"/>"
					onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>纳入移民搬迁规划户数</th>
				<th>纳入移民搬迁规划人数</th>
				<th>纳入移民搬迁规划年份</th>
				<shiro:hasPermission name="migration:bNaturalVillageRelocationPlan:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bNaturalVillageRelocationPlan">
			<tr>
				<td><a href="${ctx}/migration/bNaturalVillageRelocationPlan/form?id=${bNaturalVillageRelocationPlan.id}">
					${bNaturalVillageRelocationPlan.households}
				</a></td>
				<td>
					${bNaturalVillageRelocationPlan.peoplePopulations}
				</td>
				<td>
					${bNaturalVillageRelocationPlan.particularYear}
				</td>
				<shiro:hasPermission name="migration:bNaturalVillageRelocationPlan:edit"><td>
    				<a href="${ctx}/migration/bNaturalVillageRelocationPlan/form?id=${bNaturalVillageRelocationPlan.id}">修改</a>
					<a href="${ctx}/migration/bNaturalVillageRelocationPlan/delete?id=${bNaturalVillageRelocationPlan.id}" onclick="return confirmx('确认要删除该移民搬迁规划吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>