<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困县脱贫摘帽认定表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s,v){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#funcParam").val(v);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/report/poorCountyIdentification/">贫困县脱贫摘帽认定表列表</a></li>
		<%--<shiro:hasPermission name="report:poorCountyIdentification:edit"><li><a href="${ctx}/report/poorCountyIdentification/form">贫困县脱贫摘帽认定表添加</a></li></shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="baseCountyInfo" action="${ctx}/report/poorCountyIdentification/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="funcParam" name="funcParam" type="hidden" value="${page.funcParam}"/>
		<ul class="ul-form">
			<li><label style="width: 60px">归属年度：</label>
				<form:input path="years" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>

	<ul class="nav nav-tabs">
		<c:if test="${years != null}">
			<c:forEach items="${years}" var="year">
				<c:if test="${yearNow == year}">
					<li class="active"><a href="${ctx}/report/poorCountyIdentification/list?years=${year}">${year}</a></li>
				</c:if>
				<c:if test="${yearNow != year}">
					<li><a href="${ctx}/report/poorCountyIdentification/list?years=${year}">${year}</a></li>
				</c:if>
			</c:forEach>
		</c:if>
	</ul>

	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>区（县）名</th>
			<th>县属性</th>
			<th>归属年度</th>
			<%--<th>更新时间</th>--%>
			<%--<th>备注</th>--%>
			<shiro:hasPermission name="county:baseCountyInfo:edit"><th>操作</th></shiro:hasPermission>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="baseCountyInfo">
			<tr>
				<td><a href="${ctx}/county/baseCountyInfo/form?id=${baseCountyInfo.id}">
						${baseCountyInfo.area.name}
				</a></td>
				<td>${fns:getDictLabel(baseCountyInfo.countyAttribute, 'county_attribute', '')}</td>
				<td>${baseCountyInfo.years}</td>
					<%--<td>--%>
					<%--${baseCountyInfo.remarks}--%>
					<%--</td>--%>
				<shiro:hasPermission name="report:poorCountyIdentification:edit">
					<td>
						<a href="${ctx}/report/poorCountyIdentification/reports?years=${baseCountyInfo.years}">生成报表</a>
						<a href="${ctx}/report/PovertyCountyToCapPDF/exportPDF?year=${baseCountyInfo.years}">导出PDF</a>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>