<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困家庭学生享受教育精准扶贫政策情况统计表管理</title>
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
		<li class="active"><a href="${ctx}/co/coPoorStudentPolicy/">贫困家庭学生享受教育精准扶贫政策情况统计表列表</a></li>
		<shiro:hasPermission name="co:coPoorStudentPolicy:edit"><li><a href="${ctx}/co/coPoorStudentPolicy/form">贫困家庭学生享受教育精准扶贫政策情况统计表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="coPoorStudentPolicy" action="${ctx}/co/coPoorStudentPolicy/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="co:coPoorStudentPolicy:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="coPoorStudentPolicy">
			<tr>
				<td><a href="${ctx}/co/coPoorStudentPolicy/form?id=${coPoorStudentPolicy.id}">
					<fmt:formatDate value="${coPoorStudentPolicy.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${coPoorStudentPolicy.remarks}
				</td>
				<shiro:hasPermission name="co:coPoorStudentPolicy:edit"><td>
    				<a href="${ctx}/co/coPoorStudentPolicy/form?id=${coPoorStudentPolicy.id}">修改</a>
					<a href="${ctx}/co/coPoorStudentPolicy/delete?id=${coPoorStudentPolicy.id}" onclick="return confirmx('确认要删除该贫困家庭学生享受教育精准扶贫政策情况统计表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>