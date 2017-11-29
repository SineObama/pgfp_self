<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>&ldquo;双认定&rdquo;验收表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});

		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			console.debug("page2");
			$("#searchForm").submit();
			return false;

		}

		function page(n,s,v){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("funcParam").val(v);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/report/doubleCognizance/">&ldquo;双认定&rdquo;验收表列表</a></li>
		<%--<shiro:hasPermission name="report:doubleCognizance:edit"><li><a href="${ctx}/report/doubleCognizance/form">&ldquo;双认定&rdquo;验收表添加</a></li></shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="basePoorerRegCard" action="${ctx}/report/doubleCognizance/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="funcParam" name="funcParam" type="hidden" value="${yearTemp}"/>
		<ul class="ul-form">
			<li><label style="width: 60px">户主姓名：</label>
				<form:input path="houseHolderName" htmlEscape="false" maxlength="64" class="input-medium"/>
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
					<li class="active"><a href="${ctx}/report/doubleCognizance/list?years=${year}">${year}</a></li>
				</c:if>
				<c:if test="${yearTemp != year}">
					<li><a href="${ctx}/report/doubleCognizance/list?years=${year}">${year}</a></li>
				</c:if>
			</c:forEach>
		</ul>
	</c:if>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>户主姓名</th>
				<th>归属年度</th>
				<th>是否脱贫</th>
				<th>更新时间</th>
				<shiro:hasPermission name="report:doubleCognizance:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="basePoorerRegCard">
			<tr>
				<td>
					<%--<a href="${ctx}/record/basePoorerRegCard/form?id=${basePoorerRegCard.id}">--%>
						${basePoorerRegCard.houseHolderName}
					<%--</a>--%>
				</td>
				<td>
						${basePoorerRegCard.years}
				</td>
				<td>
					<c:if test="${basePoorerRegCard.povertyFlag == '1'}">是</c:if>
					<c:if test="${basePoorerRegCard.povertyFlag != '1'}">否</c:if>
				</td>
				<td>
					<fmt:formatDate value="${basePoorerRegCard.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<shiro:hasPermission name="report:doubleCognizance:edit"><td>
					<a href="${ctx}/report/doubleCognizance/reports?id=${basePoorerRegCard.id}">生成报表</a>
					<a href="${ctx}/report/doubleCognizance/exportPDF?id=${basePoorerRegCard.id}">导出PDF</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>