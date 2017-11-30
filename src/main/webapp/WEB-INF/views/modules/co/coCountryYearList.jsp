<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村和年表管理</title>
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
		<li class="active"><a href="${ctx}/co/coCountryYear/">行政村档案清单列表</a></li>
		<shiro:hasPermission name="co:coCountryYear:edit"><li><a href="${ctx}/co/coCountryYear/form">行政村档案</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="coCountryYear" action="${ctx}/co/coCountryYear/" method="post" class="breadcrumb form-search">
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
				<th>村名</th>
				<th>归属年度</th>
				<th>更新时间</th>
				<%--<th>备注信息</th>--%>
				<shiro:hasPermission name="co:coCountryYear:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="coCountryYear">
			<tr>
				<td><a href="${ctx}/co/coCountryYear/form?id=${coCountryYear.id}">
						${coCountryYear.area.name}
					</a>
				</td>
				<td>
						${coCountryYear.years}
				</td>
				<td>
					<fmt:formatDate value="${coCountryYear.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<%--<td>--%>
					<%--${coCountryYear.remarks}--%>
				<%--</td>--%>
				<shiro:hasPermission name="co:coCountryYear:edit"><td>
    				<a href="${ctx}/co/coCountryYear/form?id=${coCountryYear.id}">修改</a>
					<a href="${ctx}/co/coCountryYear/delete?id=${coCountryYear.id}" onclick="return confirmx('确认要删除该村和年表吗？', this.href)">删除</a>
					<%--<a href="${ctx}/record/countryBasic/exportDoc?countryId=${countryId}&years=${coCountryYear.years}">导出doc</a>--%>
					<a href="${ctx}/record/countryBasic/exportDoc1?countryId=${countryId}&coId=${coCountryYear.id}&years=${coCountryYear.years}&countryName=${coCountryYear.area.name}">行政村档案归档清单</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>