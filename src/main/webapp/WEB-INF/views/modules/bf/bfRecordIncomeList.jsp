<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户收入登记管理</title>
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
	<li class="active"><a href="${ctx}/bf/bfRecordIncome/">贫困户收入登记列表</a></li>
	<%--<shiro:hasPermission name="bf:bfRecordIncome:edit"><li><a href="${ctx}/bf/bfRecordIncome/form">贫困户收入登记添加</a></li></shiro:hasPermission>--%>
</ul>
<form:form id="searchForm" modelAttribute="bfRecordIncome" action="${ctx}/bf/bfRecordIncome/" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<input id="funcParam" name="funcParam" type="hidden" value="${yearTemp}"/>
	<ul class="ul-form">
		<li><label>年度：</label>
			<form:input path="years" htmlEscape="false" maxlength="4" class="input-medium"/>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<c:if test="${yearsList != null}">
	<ul class="nav nav-tabs nav-year">
		<c:forEach items="${yearsList}" var="year">
			<c:if test="${yearTemp == year}">
				<li class="active"><a href="${ctx}/bf/bfRecordIncome/list?years=${year}">${year}</a></li>
			</c:if>
			<c:if test="${yearTemp != year}">
				<li><a href="${ctx}/bf/bfRecordIncome/list?years=${year}">${year}</a></li>
			</c:if>
		</c:forEach>
	</ul>
</c:if>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>户主</th>
		<th>年度</th>
		<%--<th>更新时间</th>--%>
		<shiro:hasPermission name="record:countryBasic:edit"><th>操作</th></shiro:hasPermission>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="bfRecordIncome">
		<tr>
			<td>
					${bfRecordIncome.regCard.houseHolderName}
			</td>
			<td><a href="${ctx}/bf/bfRecordIncomeDetails/preview?recordIncomeId=${bfRecordIncome.id}">
					${bfRecordIncome.years}
			</a></td>
				<%--<td>--%>
				<%--<fmt:formatDate value="${bfRecordIncome.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>--%>
				<%--</td>--%>
			<shiro:hasPermission name="record:countryBasic:edit"><td>
				<a href="${ctx}/bf/bfRecordIncomeDetails/preview?recordIncomeId=${bfRecordIncome.id}">查看</a>
				<a href="${ctx}/bf/bfRecordIncome/delete?id=${bfRecordIncome.id}" onclick="return confirmx('确认要删除该贫困户收入登记吗？', this.href)">删除</a>
					<%--<a href="${ctx}/bf/bfRecordIncomeDetails/exportPDF?recordIncomeId=${bfRecordIncome.id}">生成帮扶手册</a>--%>
			</td></shiro:hasPermission>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>