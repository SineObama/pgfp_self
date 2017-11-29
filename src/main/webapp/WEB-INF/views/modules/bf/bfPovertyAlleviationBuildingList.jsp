<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>扶贫楼管理</title>
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
		<li class="active"><a href="${ctx}/bf/bfPovertyAlleviationBuilding/">扶贫楼列表</a></li>
		<shiro:hasPermission name="bf:bfPovertyAlleviationBuilding:edit">
			<li><a href="${ctx}/bf/bfPovertyAlleviationBuilding/form">扶贫楼添加</a></li>
		</shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bfPovertyAlleviationBuilding" action="${ctx}/bf/bfPovertyAlleviationBuilding/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>楼栋名称：</label>
				<form:input path="buildingName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>地址：</label>
				<form:input path="address" htmlEscape="false" maxlength="128" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>小区名称</th>
				<th>楼栋名称</th>
				<th>用途</th>
				<th>竣工时间</th>
				<th>建筑结构</th>
				<th>占地面积</th>
				<th>地址</th>
				<th>高度</th>
				<shiro:hasPermission name="bf:bfPovertyAlleviationBuilding:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfPovertyAlleviationBuilding">
			<tr>
				<td>
						${bfPovertyAlleviationBuilding.communityName}
				</td>
				<td><a href="${ctx}/bf/bfPovertyAlleviationRoom?building.id=${bfPovertyAlleviationBuilding.id}">
					${bfPovertyAlleviationBuilding.buildingName}
				</a></td>
				<td>
					${fns:getDictLabel(bfPovertyAlleviationBuilding.useFor, 'building_use_for', '')}
				</td>
				<td>
					<fmt:formatDate value="${bfPovertyAlleviationBuilding.finishDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${fns:getDictLabel(bfPovertyAlleviationBuilding.buildingStructure,'housing_structure','')}
				</td>
				<td>
					${bfPovertyAlleviationBuilding.areaCovered}
				</td>
				<td>
					${bfPovertyAlleviationBuilding.address}
				</td>
				<td>
					${fns:getDictLabel(bfPovertyAlleviationBuilding.buildingHeight , 'room_floor' , '')}
				</td>
				<shiro:hasPermission name="bf:bfPovertyAlleviationBuilding:edit"><td>
    				<a href="${ctx}/bf/bfPovertyAlleviationBuilding/form?id=${bfPovertyAlleviationBuilding.id}">修改</a>
					<a href="${ctx}/bf/bfPovertyAlleviationRoom?building.id=${bfPovertyAlleviationBuilding.id}">楼栋单元维护</a>
					<a href="${ctx}/bf/bfPovertyAlleviationBuilding/delete?id=${bfPovertyAlleviationBuilding.id}" onclick="return confirmx('确认要删除该扶贫楼吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>