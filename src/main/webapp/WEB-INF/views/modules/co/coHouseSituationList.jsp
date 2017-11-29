<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>住房保障未达标户名单情况表管理</title>
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
		<li class="active"><a href="${ctx}/co/coHouseSituation/">住房保障未达标户名单情况表列表</a></li>
		<shiro:hasPermission name="co:coHouseSituation:edit"><li><a href="${ctx}/co/coHouseSituation/form">住房保障未达标户名单情况表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="coHouseSituation" action="${ctx}/co/coHouseSituation/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="co:coHouseSituation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="coHouseSituation">
			<tr>
				<td><a href="${ctx}/co/coHouseSituation/form?id=${coHouseSituation.id}">
					<fmt:formatDate value="${coHouseSituation.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${coHouseSituation.remarks}
				</td>
				<shiro:hasPermission name="co:coHouseSituation:edit"><td>
    				<a href="${ctx}/co/coHouseSituation/form?id=${coHouseSituation.id}">修改</a>
					<a href="${ctx}/co/coHouseSituation/delete?id=${coHouseSituation.id}" onclick="return confirmx('确认要删除该住房保障未达标户名单情况表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>