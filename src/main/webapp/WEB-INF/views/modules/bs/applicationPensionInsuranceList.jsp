<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>社会养老保险金申请表管理</title>
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
		<li class="active"><a href="${ctx}/bs/applicationPensionInsurance/">社会养老保险金申请表列表</a></li>
		<%--<shiro:hasPermission name="bs:applicationPensionInsurance:edit"><li><a href="${ctx}/bs/applicationPensionInsurance/form">社会养老保险金申请表添加</a></li></shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="applicationPensionInsurance" action="${ctx}/bs/applicationPensionInsurance/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label style="width: auto;">姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label style="width: auto">状态：</label>
				<form:select path="checkState" class="input-large">
					<form:option value="" label="       "/>
					<form:options items="${fns:getDictList('check_state')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
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
				<th>申请时间</th>
				<th>审核状态</th>
				<shiro:hasPermission name="bs:applicationPensionInsurance:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="applicationPensionInsurance">
			<tr>
				<td><a href="${ctx}/bs/applicationPensionInsurance/form?id=${applicationPensionInsurance.id}">
					${applicationPensionInsurance.name}
				</a></td>
				<td>
					<fmt:formatDate value="${applicationPensionInsurance.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
						${fns:getDictLabel(applicationPensionInsurance.checkState,"check_state","")}
				</td>
				<shiro:hasPermission name="bs:applicationPensionInsurance:edit"><td>
    				<a href="${ctx}/bs/applicationPensionInsurance/export?id=${applicationPensionInsurance.id}">导出表格</a>
    				<a href="${ctx}/bs/applicationPensionInsurance/form?id=${applicationPensionInsurance.id}">查看</a>
					<a href="${ctx}/bs/applicationPensionInsurance/delete?id=${applicationPensionInsurance.id}" onclick="return confirmx('确认要删除该社会养老保险金申请表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>