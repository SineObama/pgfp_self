<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产业信息类别管理</title>
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
		<li class="active"><a href="${ctx}/cms/cmsBizinfoType/">产业信息类别列表</a></li>
		<shiro:hasPermission name="cms:cmsBizinfoType:edit"><li><a href="${ctx}/cms/cmsBizinfoType/form">产业类别添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmsBizinfoType" action="${ctx}/cms/cmsBizinfoType/" method="post" class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>类别名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>类别名称</th>
				<th>描述</th>
				<th>更新时间</th>
				<shiro:hasPermission name="cms:cmsBizinfoType:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/cms/cmsBizinfoType/form?id={{row.id}}">
				{{row.name}}
			</a></td>
			<td>
				{{row.description}}
			</td>
			<td>
				{{row.updateDate}}
			</td>
			<shiro:hasPermission name="cms:cmsBizinfoType:edit"><td>
   				<a href="${ctx}/cms/cmsBizinfoType/form?id={{row.id}}">修改</a>
				<a href="${ctx}/cms/cmsBizinfoType/delete?id={{row.id}}" onclick="return confirmx('确认要删除该产业类别及所有子类别吗？', this.href)">删除</a>
				<a href="${ctx}/cms/cmsBizinfoType/form?parent.id={{row.id}}">添加下级类别</a> 
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>