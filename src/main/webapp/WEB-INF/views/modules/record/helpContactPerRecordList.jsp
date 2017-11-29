<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>帮扶成效记录管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
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
		<li class="active"><a href="${ctx}/record/helpContactPerRecord/">帮扶成效记录列表</a></li>
		<shiro:hasPermission name="record:helpContactPerRecord:edit"><li><a href="${ctx}/record/helpContactPerRecord/form">帮扶成效记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="helpContactPerRecord" action="${ctx}/record/helpContactPerRecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="funcParam" name="funcParam" type="hidden" value="${yearTemp}"/>
		<ul class="ul-form">
			<li><label>户主姓名：</label>
				<form:input path="regCardName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<%--<li><label>年度：</label>--%>
				<%--<form:input path="years" htmlEscape="false" maxlength="64" class="input-medium"/>--%>
			<%--</li>--%>
			<li><label>帮扶联系事项：</label>
				<form:input path="helpContanctMatters" htmlEscape="false" maxlength="64" class="input-medium"/>
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
			<li class="active"><a href="${ctx}/record/helpContactPerRecord/list?years=${year}">${year}</a></li>
			</c:if>
			<c:if test="${yearTemp != year}">
			<li><a href="${ctx}/record/helpContactPerRecord/list?years=${year}">${year}</a></li>
			</c:if>
		</c:forEach>
	</ul>
	</c:if>
	
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>户主姓名</th>
				<th>归属年度</th>
				<th>帮扶联系事项</th>
				<th>帮扶联系成效（数量、金额等）</th>
				<th>取得成效时间</th>
				<shiro:hasPermission name="record:helpContactPerRecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="record">
			<tr>
				<td>
					<a href="${ctx}/record/helpContactPerRecord/form?regCardId=${record.regCardId}">
					${record.regCardName}
					</a>
				</td>
				<td>
					${record.years}
				</td>
				<td>
					${record.helpContanctMatters}
				</td>
				<td>
					${record.helpContactEffectiveness}
				</td>
				<td>
					${record.effectivenessDate}
				</td>
				<shiro:hasPermission name="record:helpContactPerRecord:edit"><td>
    				<a href="${ctx}/record/helpContactPerRecord/form?id=${record.id}">修改</a>
					<a href="${ctx}/record/helpContactPerRecord/delete?id=${record.id}&years=${record.years}" onclick="return confirmx('确认要删除该帮扶记录吗？', this.href)">删除</a>
    				<%--<a href="${ctx}/record/helpContactPerRecord/exportPDF?regCardId=${record.regCardId}">生成帮扶手册</a>--%>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>