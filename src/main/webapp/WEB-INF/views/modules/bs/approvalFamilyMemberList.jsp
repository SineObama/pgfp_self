<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>扶贫搬迁审批家庭成员表管理</title>
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
		<li class="active"><a href="${ctx}/bs/approvalFamilyMember/">扶贫搬迁审批家庭成员表列表</a></li>
		<shiro:hasPermission name="bs:approvalFamilyMember:edit"><li><a href="${ctx}/bs/approvalFamilyMember/form">扶贫搬迁审批家庭成员表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="approvalFamilyMember" action="${ctx}/bs/approvalFamilyMember/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>姓名</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="bs:approvalFamilyMember:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="approvalFamilyMember">
			<tr>
				<td><a href="${ctx}/bs/approvalFamilyMember/form?id=${approvalFamilyMember.id}">
					${approvalFamilyMember.name}
				</a></td>
				<td>
					<fmt:formatDate value="${approvalFamilyMember.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${approvalFamilyMember.remarks}
				</td>
				<shiro:hasPermission name="bs:approvalFamilyMember:edit"><td>
    				<a href="${ctx}/bs/approvalFamilyMember/form?id=${approvalFamilyMember.id}">修改</a>
					<a href="${ctx}/bs/approvalFamilyMember/delete?id=${approvalFamilyMember.id}" onclick="return confirmx('确认要删除该扶贫搬迁审批家庭成员表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>