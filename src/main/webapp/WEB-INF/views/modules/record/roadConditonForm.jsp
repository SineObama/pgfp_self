<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村级道路情况管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
	<ul class="nav nav-tabs">
	
		<li><a href="${ctx}/record/countryBasic/">村 基本情况列表</a></li>
		<%--<li><a href="${ctx}/record/roadConditon/">村级道路情况列表</a></li>--%>
		<li class="active"><a href="${ctx}/record/roadConditon/form?id=${roadConditon.id}">村级道路情况<shiro:hasPermission name="record:roadConditon:edit">${not empty roadConditon.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:roadConditon:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${roadConditon.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${roadConditon.countryBasicId}">收入状况</a></li>
		<li class="active">村级道路情况</li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${roadConditon.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${roadConditon.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${roadConditon.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${roadConditon.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${roadConditon.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${roadConditon.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${roadConditon.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${roadConditon.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${roadConditon.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${roadConditon.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${roadConditon.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${roadConditon.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${roadConditon.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${roadConditon.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${roadConditon.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${roadConditon.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${roadConditon.countryBasicId}">两委班子情况</a></li>
	</ul>
	<div id="tab-2" class="content-detail">
		<c:choose>
		<c:when test="${empty roadConditon.countryBasicId}">
		<script>
			alert("请先填写基本情况！");
			window.history.back(-1);
		</script>
		</c:when>
		<c:otherwise>
	<form:form id="inputForm" modelAttribute="roadConditon" action="${ctx}/record/roadConditon/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="countryBasicId"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>
		<table>
			<tbody>
			<tr>
				<td rowspan="5">B21未通路的 自然村（屯）</td>
				<td>村屯户数</td>
				<td>B21-1村屯数（个）</td>
				<td>B21-2需修村（屯）内道路里程（公里）</td>
				<td>村屯户数</td>
				<td>B21-3村屯数（个）</td>
				<td>B21-4需修村（屯）内道路里程（公里）</td>
			</tr>
			<tr>
				<td>5户以下</td>
				<td class="bg-white">
					<form:input path="b211Village1" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<input id="b212Road1" name="b212Road1" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.b212Road1}" pattern="#0.##"/>" />
					<%--<form:input path="b212Road1" htmlEscape="false" class="input-xlarge decimal" />--%>
				</td>
				<td>30-40户（含30户）</td>
				<td class="bg-white">
					<form:input path="b211Village5" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<input id="b212Road5" name="b212Road5" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.b212Road5}" pattern="#0.##"/>" />
					<%--<form:input path="b212Road5" htmlEscape="false" class="input-xlarge decimal"/>--%>
				</td>
			</tr>
			<tr>
				<td>5-10户(含5户)</td>
				<td class="bg-white" class="bg-white">
					<form:input path="b211Village2" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<input id="b212Road2" name="b212Road2" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.b212Road2}" pattern="#0.##"/>" />
					<%--<form:input path="b212Road2" htmlEscape="false" class="input-xlarge decimal"/>--%>
				</td>
				<td>40-50户（含40户）</td>
				<td class="bg-white">
					<form:input path="b211Village6" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<input id="b212Road6" name="b212Road6" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.b212Road6}" pattern="#0.##"/>" />
					<%--<form:input path="b212Road6" htmlEscape="false" class="input-xlarge decimal"/>--%>
				</td>
			</tr>
			<tr>
				<td>10-20户(含10户)</td>
				<td class="bg-white">
					<form:input path="b211Village3" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<input id="b212Road3" name="b212Road3" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.b212Road3}" pattern="#0.##"/>" />
					<%--<form:input path="b212Road3" htmlEscape="false" class="input-xlarge decimal"/>--%>
				</td>
				<td>50-100户（含50户）</td>
				<td class="bg-white">
					<form:input path="b211Village7" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<input id="b212Road7" name="b212Road7" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.b212Road7}" pattern="#0.##"/>" />
					<%--<form:input path="b212Road7" htmlEscape="false" class="input-xlarge decimal"/>--%>
				</td>
			</tr>
			<tr>
				<td>20-30户(含20户)</td>
				<td class="bg-white">
					<form:input path="b211Village4" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<input id="b212Road4" name="b212Road4" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.b212Road4}" pattern="#0.##"/>" />
					<%--<form:input path="b212Road4" htmlEscape="false" class="input-xlarge decimal"/>--%>
				</td>
				<td>100户以上（含100户）</td>
				<td class="bg-white">
					<form:input path="b211Village8" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<input id="b212Road8" name="b212Road8" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.b212Road8}" pattern="#0.##"/>" />
					<%--<form:input path="b212Road8" htmlEscape="false" class="input-xlarge decimal"/>--%>
				</td>
			</tr>
			<tr>
				<td rowspan="5">已经通路的 自然村（屯）</td>
				<td>村屯户数</td>
				<td>已通路村屯数（个）</td>
				<td>通砂石路屯数（个）</td>
				<td>村屯户数</td>
				<td>已通路村屯数（个）</td>
				<td>通砂石路屯数（个）</td>
			</tr>
			<tr>
				<td>5户以下</td>
				<td class="bg-white">
					<form:input path="roadVillage1" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<%--<input id="sandRoad1" name="sandRoad1" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.sandRoad1}" pattern="#0.##"/>" />--%>
					<form:input path="sandRoad1" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td>30-40户（含30户）</td>
				<td class="bg-white">
					<form:input path="roadVillage5" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<%--<input id="sandRoad5" name="sandRoad5" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.sandRoad5}" pattern="#0.##"/>" />--%>
					<form:input path="sandRoad5" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td>5-10户(含5户)</td>
				<td class="bg-white">
					<form:input path="roadVillage2" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<%--<input id="sandRoad2" name="sandRoad2" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.sandRoad2}" pattern="#0.##"/>" />--%>
					<form:input path="sandRoad2" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td>40-50户（含40户）</td>
				<td class="bg-white">
					<form:input path="roadVillage6" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<%--<input id="sandRoad6" name="sandRoad6" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.sandRoad6}" pattern="#0.##"/>" />--%>
					<form:input path="sandRoad6" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td>10-20户(含10户)</td>
				<td class="bg-white">
					<form:input path="roadVillage3" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<%--<input id="sandRoad3" name="sandRoad3" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.sandRoad3}" pattern="#0.##"/>" />--%>
					<form:input path="sandRoad3" maxlength="8" htmlEscape="false" class="input-xlarge int"/>
				</td>
				<td>50-100户（含50户）</td>
				<td class="bg-white">
					<form:input path="roadVillage7" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<%--<input id="sandRoad7" name="sandRoad7" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.sandRoad7}" pattern="#0.##"/>" />--%>
					<form:input path="sandRoad7" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td>20-30户(含20户)</td>
				<td class="bg-white">
					<form:input path="roadVillage4" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<%--<input id="sandRoad4" name="sandRoad4" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.sandRoad4}" pattern="#0.##"/>" />--%>
					<form:input path="sandRoad4" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td>100户以上（含100户）</td>
				<td class="bg-white">
					<form:input path="roadVillage8" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="bg-white">
					<%--<input id="sandRoad8" name="sandRoad8" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.sandRoad8}" pattern="#0.##"/>" />--%>
					<form:input path="sandRoad8" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td colspan="3">B22 村委会所在地到乡镇未通沥青（水泥）路里程（公里）</td>
				<td class="bg-white">
					<input id="b22Length" name="b22Length" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.b22Length}" pattern="#0.##"/>" />
					<%--<form:input path="b22Length" htmlEscape="false" class="input-xlarge decimal"/>--%>
				</td>
				<td colspan="2">B24 到村委会所在地未通沥青（水泥）路的自然村（屯）数（个）</td>
				<td class="bg-white">
					<form:input path="b24Village" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td colspan="3">B23 村委会所在地是否通客运班车</td>
				<td class="bg-white">
					<form:radiobuttons path="b23Istrans" items="${fns:getDictList('yes_no')}" itemValue="value" itemlabel="label"/>
				</td>
				<td colspan="2">B25 自然村（屯）到村委会所在地未通沥青（水泥）路里程（公里）</td>
				<td class="bg-white">
					<input id="b25VtocLength" name="b25VtocLength" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.b25VtocLength}" pattern="#0.##"/>" />
					<%--<form:input path="b25VtocLength" htmlEscape="false" class="input-xlarge decimal"/>--%>
				</td>
			</tr>
			<tr>
				<td colspan="3">行政村所通道路</td>
				<td class="bg-white">
					<form:input path="road" htmlEscape="false" class="input-xlarge"/>
				</td>
				<td colspan="2">20户以上（含）的自然村（屯）（个）</td>
				<td class="bg-white">
					<form:input path="over20Village" maxlength="8" htmlEscape="false" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td colspan="3">道路路基宽度（米）</td>
				<td class="bg-white">
					<input id="subgrade" name="subgrade" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.subgrade}" pattern="#0.##"/>" />
					<%--<form:input path="subgrade" htmlEscape="false" class="input-xlarge decimal"/>--%>
				</td>
				<td colspan="2">其中通砂石路以上（含）且路面宽3.5米以上（含）的个数</td>
				<td class="bg-white">
					<form:input path="pavementOver35" maxlength="8" htmlEscape="false" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td colspan="3">道路路面宽度（米）</td>
				<td class="bg-white">
					<input id="pavement" name="pavement" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${roadConditon.pavement}" pattern="#0.##"/>" />
					<%--<form:input path="pavement" htmlEscape="false" class="input-xlarge decimal"/>--%>
				</td>
				<td colspan="2"></td>
				<td class="bg-white">

				</td>
			</tr>

			</tbody>
		</table>
		<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
	</form:form>
		</c:otherwise>
		</c:choose>
</body>
</html>