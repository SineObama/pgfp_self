<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, rootId = "0";
			addRow("#treeTableList", tpl, data, rootId, true);
			$("#treeTable").treeTable({expandLevel : 5});
		});

		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
			return false;
		}
		<%--function addRow(list, tpl, data, pid, root){--%>
			<%--for (var i=0; i<data.length; i++){--%>
				<%--var row = data[i];--%>
				<%--if ((${fns:jsGetVal('row.parentId')}) == pid){--%>
					<%--$(list).append(Mustache.render(tpl, {--%>
						<%--dict: {--%>
							<%--type: getDictLabel(${fns:toJson(fns:getDictList('sys_area_type'))}, row.type)--%>
						<%--}, pid: (root?0:pid), row: row--%>
					<%--}));--%>
					<%--addRow(list, tpl, data, row.id);--%>
				<%--}--%>
			<%--}--%>
		<%--}--%>
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/area/">区域列表</a></li>
		<shiro:hasPermission name="sys:area:edit"><li><a href="${ctx}/sys/area/form">区域添加</a></li></shiro:hasPermission>
	</ul>

	<form:form id="searchForm" modelAttribute="area" action="${ctx}/sys/area/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>上级区域：</label>
				<sys:treeselect id="area" name="parent.id" value="${area.parent.id}" labelName="parent.name" labelValue="${area.parent.name}"
								title="上级区域" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true"/>
			</li>
			<li><label>区域名：</label>
				<form:input path="name" htmlEscape="false" maxlength="22" class="input-medium"/>
			</li>
			<li><label>区域编码：</label>
				<form:input path="code" htmlEscape="false" maxlength="22" class="input-medium"/>
			</li>
			<li><label>类型：</label>
					<%--<div class="controls">--%>
				<form:select path="type" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sys_area_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
					<%--</div>--%>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>

	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>区域名称</th>
			<th>区域编码</th>
			<th>区域类型</th>
			<%--<th>备注</th>--%>
			<shiro:hasPermission name="sys:area:edit">
				<th>操作</th>
			</shiro:hasPermission>
		</tr>
		</thead>
		<tbody id="treeTableList">
		<c:forEach items="${page.list}" var="area" >

		<tr>
			<td><a href="${ctx}/sys/area/form?id=${area.id}">${area.name}</a></td>
			<td>${area.code}</td>
			<td>${fns:getDictLabel(area.type,'sys_area_type' ,'' )}</td>
			<%--<td>${area.remarks}</td>--%>
			<td>
				<shiro:hasPermission name="sys:area:edit">
					<a href="${ctx}/sys/area/form?parent.id=${area.id}">添加下级区域</a>
					<a href="${ctx}/sys/area/form?id=${area.id}">修改</a>
					<a href="${ctx}/sys/area/delete?id=${area.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</shiro:hasPermission>
			</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>