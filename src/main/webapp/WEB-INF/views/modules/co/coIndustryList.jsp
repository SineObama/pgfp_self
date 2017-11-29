<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>1-3个特色产业管理</title>
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
		<li class="active"><a href="${ctx}/co/coIndustry/">1-3个特色产业列表</a></li>
		<shiro:hasPermission name="co:coIndustry:edit"><li><a href="${ctx}/co/coIndustry/form">1-3个特色产业添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="coIndustry" action="${ctx}/co/coIndustry/" method="post" class="breadcrumb form-search">
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
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="co:coIndustry:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="coIndustry">
			<tr>
				<td><a href="${ctx}/co/coIndustry/form?id=${coIndustry.id}">
					<fmt:formatDate value="${coIndustry.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${coIndustry.remarks}
				</td>
				<shiro:hasPermission name="co:coIndustry:edit"><td>
    				<a href="${ctx}/co/coIndustry/form?id=${coIndustry.id}">修改</a>
					<a href="${ctx}/co/coIndustry/delete?id=${coIndustry.id}" onclick="return confirmx('确认要删除该1-3个特色产业吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>