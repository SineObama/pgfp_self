<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困村脱贫摘帽认定表管理</title>
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
		<li class="active"><a href="${ctx}/report/countryIdentification/">贫困村脱贫摘帽认定表列表</a></li>
		<%--<shiro:hasPermission name="report:countryIdentification:edit"><li><a href="${ctx}/report/countryIdentification/form">贫困村脱贫摘帽认定表添加</a></li></shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="countryBasic" action="${ctx}/report/countryIdentification/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="funcParam" name="funcParam" type="hidden" value="${yearNow}"/>
		<ul class="ul-form">

			<div class="control-group" style="float:left;padding-top: 2px">
				<label class="control-label">村名:</label>
				<sys:treeselect id="area" name="area.id" value="${area.id}" labelName="area.name" labelValue="${countryBasic.area.name}"
								title="村" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true"/>

			</div>

			<%--<li><label style="width: 60px">归属年度：</label>--%>
				<%--<form:input path="years" htmlEscape="false" maxlength="64" class="input-medium"/>--%>
			<%--</li>--%>
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
					<li class="active"><a href="${ctx}/report/countryIdentification/list?years=${year}">${year}</a></li>
				</c:if>
				<c:if test="${yearNow != year}">
					<li><a href="${ctx}/report/countryIdentification/list?years=${year}">${year}</a></li>
				</c:if>
			</c:forEach>
		</c:if>
	</ul>

	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>村名</th>
				<th>归属年度</th>
				<th>更新时间</th>
				<shiro:hasPermission name="record:countryBasic:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="countryBasic">
			<tr>
				<td><a href="${ctx}/report/countryIdentification/reports?id=${countryBasic.id}&years=${countryBasic.years}">
						${countryBasic.area.name}
				</a>
				</td>
				<td>
						${countryBasic.years}
				</td>
				<td>
					<fmt:formatDate value="${countryBasic.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="record:countryBasic:edit"><td>
					<a href="${ctx}/report/countryIdentification/reports?id=${countryBasic.id}&years=${countryBasic.years}">生成报表</a>
					<a href="${ctx}/report/countryIdentification/export?id=${countryBasic.id}">导出报表</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>