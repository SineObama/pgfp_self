<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>搬迁意愿</title>
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
	<li class="active"><a href="${ctx}/record/basePoorerHelpDetail">贫困户搬迁意愿</a></li>`
	<%--<shiro:hasPermission name="record:basePoorerHelpDetail:edit"><li><a href="${ctx}/bf/basePoorerHelpDetail/edit">贫困户搬迁意愿修改</a></li></shiro:hasPermission>--%>
</ul>
<form:form id="searchForm" modelAttribute="baseHelpDetail2" action="${ctx}/record/basePoorerHelpDetail/" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<%--<li>--%>
		<%--<label>归属年度：</label>--%>
		<%--<form:input path="year"/>--%>
	<%--</li>--%>
	<li>
		<label>户主姓名</label>
		<form:input path="houseHolderName"/>
	</li>
	<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>户主姓名</th>
		<th>户口本号</th>
		<th>是否愿意搬迁</th>
		<th>计划搬迁时间</th>
		<th>希望安置地点</th>
		<th>希望安置类型</th>
		<th>搬迁原因</th>
		<th>填报年度</th>
		<shiro:hasPermission name="record:basePoorerHelpDetail:edit"><th>操作</th></shiro:hasPermission>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="detail">
		<tr>
			<td>
				<%--<a href="${ctx}/record/basePoorerHelpDetail/edit?id=${detail.id}">--%>

			             ${detail.houseHolderName}
			<%--</a>--%>
			</td>
			<td>
					  ${detail.residenceBookletNumber}
			</td>
			<td>
					${fns:getDictLabel(detail.string1,'yes_no' ,'')}
					<%--${basePoorerHelpDetail.relocateFlag}--%>
			</td>
			<td>
				<fmt:formatDate value="${detail.date1}" pattern="yyyy-MM-dd"/>
			</td>
			<td>
					${detail.string5}
			</td>
			<td>
						<c:choose>
							<c:when test="${detail.string3 == '1'}">有地安置</c:when>
							<c:when test="${detail.string3 == '2'}">无地安置</c:when>
						</c:choose>
			</td>
			<td>
					<c:choose>
						<c:when test="${detail.string4 == '1'}">缺乏生存条件</c:when>
						<c:when test="${detail.string4 == '2'}">生态脆弱</c:when>
						<c:when test="${detail.string4 == '3'}">避灾避险</c:when>
						<c:when test="${detail.string4 == '4'}">自然保护区</c:when>
					</c:choose>
			</td>
			<td>
					${detail.year}
			</td>
			<%--<td>--%>
					<%--${basePoorerHelpDetail.relocateYear}--%>
			<%--</td>--%>
			<%--<td>--%>
					<%--${fns:getDictLabel(basePoorerHelpDetail.settingPlace,'place_of_resettlement' ,'')}--%>
					<%--&lt;%&ndash;${basePoorerHelpDetail.settingPlace}&ndash;%&gt;--%>
			<%--</td>--%>
			<%--<td>--%>
					<%--${fns:getDictLabel(basePoorerHelpDetail.housingTypes, 'housing_types','' )}--%>
					<%--&lt;%&ndash;${basePoorerHelpDetail.housingTypes}&ndash;%&gt;--%>
			<%--</td>--%>

			<%--<td>--%>
					<%--&lt;%&ndash;${basePoorerHelpDetail.relocateReason}&ndash;%&gt;--%>
				<%--${fns:getDictLabel(basePoorerHelpDetail.relocateReason,'relocation_reasons','' )}--%>
			<%--</td>--%>
			  <%--<td>--%>
					  <%--${basePoorerHelpDetail.year}--%>
			<%--<shiro:hasPermission name="record:basePoorerHelpDetail:edit"><td>--%>
				<%--<a href="${ctx}/record/basePoorerHelpDetail/edit?id=${basePoorerHelpDetail.id}">修改</a>--%>
				<%--<a href="${ctx}/record/basePoorerHelpDetail/delete?id=${basePoorerHelpDetail.id}" onclick="return confirmx('确认要删除该表吗？', this.href)">删除</a>--%>
			<%--</td></shiro:hasPermission>--%>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>