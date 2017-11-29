<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>异地扶贫搬迁管理</title>
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
		<li class="active"><a href="${ctx}/county/offSiteRelocation/">异地扶贫搬迁列表</a></li>
		<shiro:hasPermission name="county:offSiteRelocation:edit"><li><a href="${ctx}/county/offSiteRelocation/form">异地扶贫搬迁添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="baseCountySpecialPovertyInfo" action="${ctx}/county/offSiteRelocation/" method="post" class="breadcrumb form-search">
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
				<th>C99 纳入易地扶贫搬迁规划户数（户）</th>
				<th>C100 纳入易地扶贫搬迁规划人数（人）</th>
				<th>C103 易地扶贫搬迁资金投入（万元）</th>
				<shiro:hasPermission name="county:offSiteRelocation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="offSiteRelocation">
			<tr>
				<td><a href="${ctx}/county/offSiteRelocation/form?id=${offSiteRelocation.id}">
					${offSiteRelocation.changeRelocationPlanHouse}
				</a></td>
				<td>
					${offSiteRelocation.changeRelocationPlanNum}
				</td>
				<td>
					${offSiteRelocation.changeRelocationFunding}
				</td>
				<shiro:hasPermission name="county:offSiteRelocation:edit"><td>
    				<a href="${ctx}/county/offSiteRelocation/form?id=${offSiteRelocation.id}">修改</a>
					<a href="${ctx}/county/offSiteRelocation/delete?id=${offSiteRelocation.id}" onclick="return confirmx('确认要删除该异地扶贫搬迁吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>