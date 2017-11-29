<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>行政、自然区划管理</title>
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
							type: getDictLabel(${fns:toJson(fns:getDictList('contryType'))}, row.type),
							classify: getDictLabel(${fns:toJson(fns:getDictList('contryClassify'))}, row.classify),
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
		<li class="active"><a href="${ctx}/record/country/">行政、自然区划列表</a></li>
		<shiro:hasPermission name="record:country:edit"><li><a href="${ctx}/record/country/form">行政、自然区划添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="country" action="${ctx}/record/country/" method="post" class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>名字：</label>
				<form:input path="name" htmlEscape="false" maxlength="40" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名字</th>
				<th>类型</th>
				<th>分类</th>
				<shiro:hasPermission name="record:country:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/record/country/form?id={{row.id}}">
				{{row.name}}
			</a></td>
			<td>
				{{dict.type}}
			</td>
			<td>
				{{dict.classify}}
			</td>
			<shiro:hasPermission name="record:country:edit"><td>
   				<a href="${ctx}/record/country/form?id={{row.id}}">修改</a>
				<a href="${ctx}/record/country/delete?id={{row.id}}" onclick="return confirmx('确认要删除该行政、自然区划及所有子行政、自然区划吗？', this.href)">删除</a>
				<a href="${ctx}/record/country/form?parent.id={{row.id}}">添加下级行政、自然区划</a> 
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>