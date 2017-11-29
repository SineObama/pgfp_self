<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村城乡居民养老保险未参保人员名单管理</title>
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
		<li class="active"><a href="${ctx}/co/coNoEndowmentInsured/">村城乡居民养老保险未参保人员名单列表</a></li>
		<shiro:hasPermission name="co:coNoEndowmentInsured:edit"><li><a href="${ctx}/co/coNoEndowmentInsured/form">村城乡居民养老保险未参保人员名单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="coNoEndowmentInsured" action="${ctx}/co/coNoEndowmentInsured/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>未参加居民养老保险人员姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>未参加居民养老保险人员姓名</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="co:coNoEndowmentInsured:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="coNoEndowmentInsured">
			<tr>
				<td><a href="${ctx}/co/coNoEndowmentInsured/form?id=${coNoEndowmentInsured.id}">
					${coNoEndowmentInsured.name}
				</a></td>
				<td>
					<fmt:formatDate value="${coNoEndowmentInsured.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${coNoEndowmentInsured.remarks}
				</td>
				<shiro:hasPermission name="co:coNoEndowmentInsured:edit"><td>
    				<a href="${ctx}/co/coNoEndowmentInsured/form?id=${coNoEndowmentInsured.id}">修改</a>
					<a href="${ctx}/co/coNoEndowmentInsured/delete?id=${coNoEndowmentInsured.id}" onclick="return confirmx('确认要删除该村城乡居民养老保险未参保人员名单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>