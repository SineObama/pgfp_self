<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>移民搬迁情况管理</title>
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
		<li class="active"><a href="${ctx}/migration/relocationPlanSituation/">移民搬迁情况列表</a></li>
		<shiro:hasPermission name="migration:relocationPlanSituation:edit"><li><a href="${ctx}/migration/relocationPlanSituation/form">移民搬迁情况修改</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="relocationPlanSituation" action="${ctx}/migration/relocationPlanSituation/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>id：</label>
				<form:input path="id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>拟建安置点名称：</label>
				<form:input path="siteName" htmlEscape="false" maxlength="40" class="input-medium"/>
			</li>
			<li><label>拟建安置点地址：</label>
				<form:input path="siteAddress" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>拟建安置点名称</th>
				<th>拟建安置点地址</th>
				<th>纳入规划总户数（户）</th>
				<th>纳入规划总人数（人）</th>
				<th>其中建档立卡户（户）</th>
				<th>其中建档立卡人数（人）</th>
				<th>更新时间</th>
				<shiro:hasPermission name="migration:relocationPlanSituation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="relocationPlanSituation">
			<tr>
				<td><a href="${ctx}/migration/relocationPlanSituation/form?id=${relocationPlanSituation.id}">
					${relocationPlanSituation.siteName}
				</a></td>
				<td>
					${relocationPlanSituation.siteAddress}
				</td>
				<td>
					${relocationPlanSituation.planTotalHou}
				</td>
				<td>
					${relocationPlanSituation.planTotalPer}
				</td>
				<td>
					${relocationPlanSituation.recordHou}
				</td>
				<td>
					${relocationPlanSituation.recordPer}
				</td>
				<td>
					<fmt:formatDate value="${relocationPlanSituation.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="migration:relocationPlanSituation:edit"><td>
    				<a href="${ctx}/migration/relocationPlanSituation/form?id=${relocationPlanSituation.id}">修改</a>
					<a href="${ctx}/migration/relocationPlanSituation/delete?id=${relocationPlanSituation.id}" onclick="return confirmx('确认要删除该移民搬迁情况吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>