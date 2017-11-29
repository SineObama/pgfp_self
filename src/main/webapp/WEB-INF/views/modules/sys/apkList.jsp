<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>apk管理管理</title>
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
		<li class="active"><a href="${ctx}/sys/apkManage/">移动终端列表</a></li>
		<shiro:hasPermission name="sys:apkManage:edit"><li><a href="${ctx}/sys/apkManage/form">添加移动终端</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="apkManage" action="${ctx}/sys/apkManage/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>类别：</label>
				<form:select path="type" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('mt_type')}" itemLabel="label" itemValue="value"/>
				</form:select>
			</li>
			<li><label>文件名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>删除标记：</label>
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>文件名称</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="sys:apkManage:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="apkManage">
			<tr>
				<td><a href="${ctx}/sys/apkManage/form?id=${apkManage.id}">
					${apkManage.name}
				</a></td>
				<td>
					<fmt:formatDate value="${apkManage.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${apkManage.remarks}
				</td>
				<shiro:hasPermission name="sys:apkManage:edit"><td>
    				<a href="${ctx}/sys/apkManage/form?id=${apkManage.id}">修改</a>
					<a href="${ctx}/sys/apkManage/delete?id=${apkManage.id}" onclick="return confirmx('确认要删除该apk管理吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>