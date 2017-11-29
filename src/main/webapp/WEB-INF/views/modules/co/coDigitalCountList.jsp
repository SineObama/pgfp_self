<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>未有数码设备用户名单管理</title>
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
		<li class="active"><a href="${ctx}/co/coDigitalCount/">未有数码设备用户名单列表</a></li>
		<shiro:hasPermission name="co:coDigitalCount:edit"><li><a href="${ctx}/co/coDigitalCount/form">未有数码设备用户名单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="coDigitalCount" action="${ctx}/co/coDigitalCount/" method="post" class="breadcrumb form-search">
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
				<shiro:hasPermission name="co:coDigitalCount:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="coDigitalCount">
			<tr>
				<td><a href="${ctx}/co/coDigitalCount/form?id=${coDigitalCount.id}">
					<fmt:formatDate value="${coDigitalCount.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${coDigitalCount.remarks}
				</td>
				<shiro:hasPermission name="co:coDigitalCount:edit"><td>
    				<a href="${ctx}/co/coDigitalCount/form?id=${coDigitalCount.id}">修改</a>
					<a href="${ctx}/co/coDigitalCount/delete?id=${coDigitalCount.id}" onclick="return confirmx('确认要删除该未有数码设备用户名单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>