<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>移民后期跟踪记录</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
</head>
<body>

<ul class="nav nav-tabs">
	<li><a href="${ctx}/bf/ImmigrationTracking/">移民后期跟踪记录</a></li>
	<li class="active"><a href="${ctx}/bf/ImmigrationTracking/work?roomId=${tracking.roomId}">移民后期就业情况</a></li>
</ul><br/>
<div class="header">
	<a href="" class="header-lt">移民后期跟踪</a>
	<a href="" class="header-rt">${tracking.houseHolderName}</a>
</div>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/bf/ImmigrationTracking/form?roomId=${tracking.roomId}">信息概览</a></li>
		<li><a href="${ctx}/bf/ImmigrationTracking/training?roomId=${tracking.roomId}">移民后期培训情况</a></li>
		<li class="active"><a>移民后期就业情况</a></li>
	</ul>
	<div id="tab-1" class="content-detail">

			<br/>
			<table>
				<tbody id="accpitem">
				<tr class="titleTd">
					<td>姓名</td>
					<td>务工情况</td>
					<td>就业单位</td>
					<td>就业行业</td>
					<td>月收入</td>
					<td>年内务工时间<br/>（月数）</td>
					<td>工作意愿</td>
					<td>意愿去向</td>
					<td>意愿行业</td>
					<td>是否搬迁后数据</td>
				</tr>
				<sys:message content="${message}"/>
					<c:forEach items="${tracking.workStatusList}" var="work" varStatus="status">
						<tr class="bg-white">
							<td>
								${work.member.name}
							</td>
							<td>
								<%--${work.workStation}--%>
									<%--'<select id="works[0].workStation" name="works[0].workStation" class="workStation select2-offscreen" tabindex="-1">' +--%>
									<%--'<option value="01">县内</option>' +--%>
									<%--'<option value="02">省内县外</option>' +--%>
									<%--'<option value="03">省外务工</option>' +--%>
									<%--'<option value="99">其他</option>' +--%>
									<%--'</select>'+--%>
								<c:choose>
									<c:when test="${work.workStation == '01'}">县内</c:when>
									<c:when test="${work.workStation == '02'}">省内县外</c:when>
									<c:when test="${work.workStation == '03'}">省外务工</c:when>
									<c:when test="${work.workStation == '99'}">其他</c:when>
								</c:choose>
							</td>
							<td>
								${work.unit}
							</td>
							<td>
								${work.industry}
							</td>
							<td>
								${work.income}
							</td>
							<td>
								${work.workMonth}
							</td>
							<td>
								${work.workWilling}
							</td>
							<td>
								<%--${work.willDestination}--%>
									<%--'<select id="works[0].willDestination" name="works[0].willDestination" class="willDestination select2-offscreen" tabindex="-1">' +--%>
									<%--'<option value="01">县内</option>' +--%>
									<%--'<option value="02">省内县外</option>' +--%>
									<%--'<option value="03">省外务工</option>' +--%>
									<%--'<option value="99">其他</option>' +--%>
									<%--'</select>'+--%>
								<c:choose>
									<c:when test="${work.willDestination == '01'}">县内</c:when>
									<c:when test="${work.willDestination == '02'}">省内县外</c:when>
									<c:when test="${work.willDestination == '03'}">省外务工</c:when>
									<c:when test="${work.willDestination == '99'}">其他</c:when>
								</c:choose>
							</td>
							<td>
								${work.willIndustry}
							</td>
							<td>
								<c:choose>
									<c:when test="${train.removalFlag eq '1'}">
										搬迁前
									</c:when>
									<c:otherwise>
										搬迁后
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="content-save">
				<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
			</div>
	</div>
</div>
<style>
	.titleTd{
		font-weight: bold;
	}
</style>

</body>
</html>