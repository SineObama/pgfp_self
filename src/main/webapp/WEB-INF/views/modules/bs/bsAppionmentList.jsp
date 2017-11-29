<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>办事受理管理</title>
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
		<li class="active"><a href="${ctx}/bs/bsAppionment/">办事受理列表</a></li>
		<%--<shiro:hasPermission name="bs:bsAppionment:edit"><li><a href="${ctx}/bs/bsAppionment/form">办事受理添加</a></li></shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="bsAppionment" action="${ctx}/bs/bsAppionment/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>办事事项：</label>
				<form:input path="baseTitle" htmlEscape="false" maxlength="250" class="input-medium"/>
			</li>
			<li><label>申请人姓名：</label>
				<form:input path="applyName" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>联系电话：</label>
				<form:input path="linkTel" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>处理状态：</label>
				<%--<form:input path="status" htmlEscape="false" maxlength="2" class="input-medium"/>--%>
				<form:select path="status">
					<form:option value="">------------</form:option>
					<form:options items="${fns:getDictList('auditing_status' )}" itemLabel="label" itemValue="value"/>
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
				<th>办事事项</th>
				<th>申请人姓名</th>
				<th>联系电话</th>
				<th>预约时间</th>
				<th>处理状态</th>
				<shiro:hasPermission name="bs:bsAppionment:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bsAppionment">
			<tr>
				<td>
					${bsAppionment.baseTitle}
				</td>
				<td>
					<a href="${ctx}/bs/bsAppionment/form?id=${bsAppionment.id}">
						${bsAppionment.applyName}
					</a>
				</td>
				<td>
					${bsAppionment.linkTel}
				</td>
				<td>
					<fmt:formatDate value="${bsAppionment.appointmentTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(bsAppionment.status, 'auditing_status', '' )}
					<%--${bsAppionment.status}--%>
				</td>
				<shiro:hasPermission name="bs:bsAppionment:edit"><td>
    				<a href="${ctx}/bs/bsAppionment/form?id=${bsAppionment.id}">审批</a>
					<a href="${ctx}/bs/bsAppionment/delete?id=${bsAppionment.id}" onclick="return confirmx('确认要删除该办事受理吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>