<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>网上办事业务</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

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
		<li class="active"><a href="${ctx}/bs/bsBasicinfo/">网上办事业务列表</a></li>
		<shiro:hasPermission name="bs:bsBasicinfo:edit"><li><a href="${ctx}/bs/bsBasicinfo/form">网上办事业务添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bsBasicinfo" action="${ctx}/bs/bsBasicinfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<style type="text/css">
			.ul-form li{
				margin-bottom: 5px;
			}
		</style>
		<ul class="ul-form">
			<li><label>责任部门：</label>
				<sys:treeselect id="office" name="office.id" value="${bsBasicinfo.office.id}" labelName="office.name" labelValue="${bsBasicinfo.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>办件类型：</label>
				<form:input path="bsType" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
		</ul>
	</form:form>

	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th >办事业务标题</th>
				<th >办件类型</th>
				<th >更新时间</th>
				<shiro:hasPermission name="bs:bsBasicinfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bsBasicinfo">
			<tr>
				<td><a href="${ctx}/bs/bsBasicinfo/form?id=${bsBasicinfo.id}">
					${bsBasicinfo.title}
				</a></td>
				<td>
					<%--${fns:getDictLabel(bsBasicinfo.type,'project_type','0')}--%>
					${bsBasicinfo.bsType}
				</td>
				<td>
					<fmt:formatDate value="${bsBasicinfo.updateDate}" pattern="yyyy-MM-dd"/>

				</td>
				<shiro:hasPermission name="bs:bsBasicinfo:edit"><td>
    				<a href="${ctx}/bs/bsBasicinfo/form?id=${bsBasicinfo.id}">修改</a>
					<%--<a href="${ctx}/bs/bsBasicinfo/print?id=${bsBasicinfo.id}" target="_blank">打印</a>--%>
					<a href="${ctx}/bs/bsBasicinfo/delete?id=${bsBasicinfo.id}" onclick="return confirmx('确认要删除该项目档案吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>