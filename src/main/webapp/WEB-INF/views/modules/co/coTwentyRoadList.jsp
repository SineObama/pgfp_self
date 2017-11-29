<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>20户以上自然村屯通路情况管理</title>
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
		<li class="active"><a href="${ctx}/co/coTwentyRoad/">20户以上自然村屯通路情况列表</a></li>
		<shiro:hasPermission name="co:coTwentyRoad:edit"><li><a href="${ctx}/co/coTwentyRoad/form">20户以上自然村屯通路情况添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="coTwentyRoad" action="${ctx}/co/coTwentyRoad/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="co:coTwentyRoad:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="coTwentyRoad">
			<tr>
				<td><a href="${ctx}/co/coTwentyRoad/form?id=${coTwentyRoad.id}">
					<fmt:formatDate value="${coTwentyRoad.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${coTwentyRoad.remarks}
				</td>
				<shiro:hasPermission name="co:coTwentyRoad:edit"><td>
    				<a href="${ctx}/co/coTwentyRoad/form?id=${coTwentyRoad.id}">修改</a>
					<a href="${ctx}/co/coTwentyRoad/delete?id=${coTwentyRoad.id}" onclick="return confirmx('确认要删除该20户以上自然村屯通路情况吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>