<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>帮扶政策管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, ids = [], rootIds = [];
			for (var i=0; i<data.length; i++){
				ids.push(data[i].id);
			}
			ids = ',' + ids.join(',') + ',';
			for (var i=0; i<data.length; i++){
				if (ids.indexOf(','+data[i].parentId+',') == -1){
					if ((','+rootIds.join(',')+',').indexOf(','+data[i].parentId+',') == -1){
						rootIds.push(data[i].parentId);
					}
				}
			}
			for (var i=0; i<rootIds.length; i++){
				addRow("#treeTableList", tpl, data, rootIds[i], true);
			}
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
						blank123:0}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/bf/bfSubsidyType/">帮扶政策列表</a></li>
		<shiro:hasPermission name="bf:bfSubsidyType:edit"><li><a href="${ctx}/bf/bfSubsidyType/form">帮扶政策添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bfSubsidyType" action="${ctx}/bf/bfSubsidyType/" method="post" class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>父类型：</label>
				<sys:treeselect id="parent" name="parent.id" value="${bfSubsidyType.parent.id}" labelName="parent.subsidyType" labelValue="${bfSubsidyType.parent.subsidyType}"
					title="父类型" url="/bf/bfSubsidyType/treeData" extId="${bfSubsidyType.id}" cssClass="" allowClear="true"/>

			</li>
			<li><label>补贴类型：</label>
				<form:input path="subsidyType" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<%--<th>父类型</th>--%>
				<th>补贴类型</th>
				<th>责任部门</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="bf:bfSubsidyType:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<%--<td>--%>
				<%--{{row.parent.id}}--%>
			<%--</td>--%>
			<td><a href="${ctx}/bf/bfSubsidyType/form?id={{row.id}}">
				{{row.code}}&nbsp;&nbsp;&nbsp;&nbsp;{{row.subsidyType}}
				</a>
			</td>
				<td>
					{{row.office.name}}
				</td>
			<td>
				{{row.updateDate}}
			</td>
			<td>
				{{row.remarks}}
			</td>
			<shiro:hasPermission name="bf:bfSubsidyType:edit"><td>
   				<a href="${ctx}/bf/bfSubsidyType/form?id={{row.id}}">修改</a>
				<a href="${ctx}/bf/bfSubsidyType/delete?id={{row.id}}" onclick="return confirmx('确认要删除该扶贫补助类型及所有子扶贫补助类型吗？', this.href)">删除</a>
				<a href="${ctx}/bf/bfSubsidyType/form?parent.id={{row.id}}">添加下级扶贫补助类型</a> 
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>