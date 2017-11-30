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
	<li class="active"><a href="${ctx}/bf/ImmigrationTracking/training?roomId=${tracking.roomId}">移民后期培训情况</a></li>
</ul><br/>
<div class="header">
	<a href="" class="header-lt">移民后期跟踪</a>
	<a href="" class="header-rt">${tracking.houseHolderName}</a>
</div>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/bf/ImmigrationTracking/form?roomId=${tracking.roomId}">信息概览</a></li>
		<li class="active">移民后期培训情况</li>
		<li><a href="${ctx}/bf/ImmigrationTracking/work?roomId=${tracking.roomId}">移民后期就业情况</a></li>
	</ul>
	<div id="tab-1" class="content-detail">

			<br/>
			<table>
				<tbody id="accpitem">
				<tr class="titleTd">
					<td>姓名</td>
					<td>培训类型</td>
					<td>参加时间</td>
					<td>培训内容</td>
					<td>培训专业</td>
					<td>培训学校</td>
					<td>获得证书</td>
					<td>是否搬迁后数据</td>
				</tr>
				<sys:message content="${message}"/>
					<c:forEach items="${tracking.trainingStatuseList}" var="train" varStatus="status">
						<tr class="bg-white">
							<td>
							<%--${train.member.idNumber}--%>
								${train.member.name}
							</td>
							<td>
								<%--${train.trainingType}--%>
									<%--'<select class="trainingType">' +--%>
									<%--'<option value="01">短期技能培训</option>' +--%>
									<%--'<option value="02">农民实用技术培训</option>' +--%>
									<%--'<option value="99">其他</option>' +--%>
									<%--'</select>'+--%>
								<c:choose>
									<c:when test="${train.trainingType == '01'}">短期技能培训</c:when>
									<c:when test="${train.trainingType == '02'}">农民实用技术培训</c:when>
									<c:otherwise>其他</c:otherwise>
								</c:choose>
							</td>
							<td>
								<fmt:formatDate value="${train.trainingDate}" pattern="yyyy-MM-dd"/>
							</td>
							<td>
								${train.trainingContent}
							</td>
							<td>
								${train.trainingSpecialty}
							</td>
							<td>
								${train.trainingSchool}
							</td>
							<td>
								${train.certificates}
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