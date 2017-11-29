<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>雨露计划管理</title>
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
		<li class="active"><a href="${ctx}/county/baseCountySpecialPovertyInfo/">雨露计划列表</a></li>
		<shiro:hasPermission name="county:baseCountySpecialPovertyInfo:edit"><li><a href="${ctx}/county/baseCountySpecialPovertyInfo/form">雨露计划添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="baseCountySpecialPovertyInfo" action="${ctx}/county/baseCountySpecialPovertyInfo/" method="post" class="breadcrumb form-search">
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
				<th>C90 雨露计划培训人数（人）</th>
				<th>C91 雨露计划资金投入（万元）</th>
				<th>C91a 中央财政专项资金投入（万元）</th>
				<shiro:hasPermission name="county:baseCountySpecialPovertyInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="baseCountySpecialPovertyInfo">
			<tr>
				<td><a href="${ctx}/county/baseCountySpecialPovertyInfo/form?id=${baseCountySpecialPovertyInfo.id}">
					${baseCountySpecialPovertyInfo.ylPlanTrainNum}
				</a></td>
				<td>
					${baseCountySpecialPovertyInfo.ylPlanFunding}
				</td>
				<td>
					${baseCountySpecialPovertyInfo.centralFundingForYl}
				</td>
				<shiro:hasPermission name="county:baseCountySpecialPovertyInfo:edit"><td>
    				<a href="${ctx}/county/baseCountySpecialPovertyInfo/form?id=${baseCountySpecialPovertyInfo.id}">修改</a>
					<a href="${ctx}/county/baseCountySpecialPovertyInfo/delete?id=${baseCountySpecialPovertyInfo.id}" onclick="return confirmx('确认要删除该雨露计划吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>