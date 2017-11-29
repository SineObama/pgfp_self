<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>帮扶需求及帮扶情况管理</title>
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
		<%--<li><a href="${ctx}/record/demandAndSituation/">帮扶需求及帮扶情况列表</a></li>--%>
		<li class="active"><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${countryBasic.id}">帮扶需求及帮扶情况<shiro:hasPermission name="record:demandAndSituation:edit">${not empty demandAndSituation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:demandAndSituation:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${countryBasic.id}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${countryBasic.id}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${countryBasic.id}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${countryBasic.id}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${countryBasic.id}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${countryBasic.id}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${countryBasic.id}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${countryBasic.id}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${countryBasic.id}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${countryBasic.id}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${countryBasic.id}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${countryBasic.id}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${countryBasic.id}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${countryBasic.id}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${countryBasic.id}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${countryBasic.id}">驻村干部</a></li>
		<li class="active"><a>帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${countryBasic.id}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${countryBasic.id}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${countryBasic.id}">两委班子情况</a></li>
	</ul>
	<div id="tab-1" class="content-detail">
		<c:choose>
		<c:when test="${empty countryBasic.id}">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
	<form:form id="inputForm" modelAttribute="countryBasic" action="${ctx}/record/demandAndSituation/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="years"/>
		<c:forEach var= "temp" begin= "0" step= "1"  end= "33">
			<form:hidden path="demans[${temp}].id"/>
			<form:hidden path="demans[${temp}].type" value="1"/>
		</c:forEach>
		<sys:message content="${message}"/>
		<table>
			<tbody>
			<tr>
				<td colspan="2" rowspan="2" class="fir-td"><span>规划建设项目</span></td>
				<td rowspan="2" class="thr-td"><span>单位</span></td>
				<td rowspan="2" class="thr-td"><span>建设规模</span></td>
				<td rowspan="2" class="thr-td"><span>B91-5帮扶时间</span></td>
				<td rowspan="2" class="thr-td"><span>建设地点</span></td>
				<td colspan="2" class="thr-td"><span>投资估算（万元）</span></td>
				<td style="text-align: center;" colspan="5" class="thr-td"><span>覆盖范围</span></td>
			</tr>
			<tr>
				<td class="thr-td"><span>单价</span></td>
				<td class="thr-td"><span>总投入</span></td>
				<td class="thr-td"><span>自然村数</span></td>
				<td class="thr-td"><span>户数</span></td>
				<td class="thr-td"><span>贫困户数</span></td>
				<td class="thr-td"><span>人数（人）</span></td>
				<td class="thr-td"><span>年度实施及完成情况</span></td>
			</tr>
			<tr>
				<td rowspan="3" class="thr-td"><span>1.村级道路畅通</span></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="村（组）路" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="公里" readonly="true"></td>
				<input type="hidden" name="demans[0].serial" value="0">
				<td class="sec-td bg-white">
					<%--<form:input path="scaleList[0]" htmlEscape="false" maxlength="255" class="input-xlarge "/> --%>
					<input type="text" name="demans[0].scale" value="${countryBasic.demans[0].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[0].idx" value="${countryBasic.demans[0].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[0].constructionSite" value="${countryBasic.demans[0].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[0].unitPrice" maxlength="11" class="decimal"
						   value="<fmt:formatNumber value='${countryBasic.demans[0].unitPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[0].totalPrice" maxlength="11" class="decimal"
							value="<fmt:formatNumber value='${countryBasic.demans[0].totalPrice}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[0].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[0].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[0].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[0].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[0].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[0].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[0].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[0].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[0].implementAndCompletion" value="${countryBasic.demans[0].implementAndCompletion}" />
				</td>
			</tr>
			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="生产便道（机耕路）" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="公里" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[1].serial" value="1">
					<input type="text" name="demans[1].scale" value="${countryBasic.demans[1].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[1].idx" value="${countryBasic.demans[1].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[1].constructionSite" value="${countryBasic.demans[1].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[1].unitPrice" maxlength="11" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[1].unitPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[1].totalPrice" maxlength="11" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[1].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[1].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[1].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[1].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[1].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[1].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[1].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[1].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[1].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[1].implementAndCompletion" value="${countryBasic.demans[1].implementAndCompletion}" />
				</td>
			</tr>
			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="建档立卡贫困户入户路" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="处" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[2].serial" value="2">
					<input type="text" name="demans[2].scale" value="${countryBasic.demans[2].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[2].idx" value="${countryBasic.demans[2].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[2].constructionSite" value="${countryBasic.demans[2].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[2].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[2].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[2].totalPrice" maxlength="11"   class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[2].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[2].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[2].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[2].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[2].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[2].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[2].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[2].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[2].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[2].implementAndCompletion" value="${countryBasic.demans[2].implementAndCompletion}" />
				</td>
			</tr>



			<tr>
				<td rowspan="5" class="thr-td"><span>2.人饮和灌溉设施</span></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="集中供水点" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="处" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[3].serial" value="3">
					<input type="text" name="demans[3].scale" value="${countryBasic.demans[3].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[3].idx" value="${countryBasic.demans[3].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[3].constructionSite" value="${countryBasic.demans[3].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[3].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[3].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[3].totalPrice" maxlength="11"  class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[3].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[3].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[3].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[3].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[3].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[3].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[3].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[3].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[3].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[3].implementAndCompletion" value="${countryBasic.demans[3].implementAndCompletion}" />
				</td>
			</tr>


			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="灌溉渠" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="公里" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[4].serial" value="4">
					<input type="text" name="demans[4].scale" value="${countryBasic.demans[4].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[4].idx" value="${countryBasic.demans[4].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[4].constructionSite" value="${countryBasic.demans[4].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[4].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[4].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[4].totalPrice" maxlength="11"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[4].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[4].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[4].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[4].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[4].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[4].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[4].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[4].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[4].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[4].implementAndCompletion" value="${countryBasic.demans[4].implementAndCompletion}" />
				</td>
			</tr>


			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="灌溉塘（堰、井）" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="口" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[5].serial" value="5">
					<input type="text" name="demans[5].scale" value="${countryBasic.demans[5].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[5].idx" value="${countryBasic.demans[5].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[5].constructionSite" value="${countryBasic.demans[5].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[5].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[5].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[5].totalPrice" maxlength="11"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[5].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[5].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[5].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[5].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[5].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[5].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[5].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[5].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[5].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[5].implementAndCompletion" value="${countryBasic.demans[5].implementAndCompletion}" />
				</td>
			</tr>



			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="地头水柜" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="个" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[6].serial" value="6">
					<input type="text" name="demans[6].scale" value="${countryBasic.demans[6].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[6].idx" value="${countryBasic.demans[6].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[6].constructionSite" value="${countryBasic.demans[6].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[6].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[6].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[6].totalPrice" maxlength="11"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[6].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[6].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[6].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[6].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[6].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[6].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[6].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[6].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[6].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[6].implementAndCompletion" value="${countryBasic.demans[6].implementAndCompletion}" />
				</td>
			</tr>



			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="小型灌站" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="个" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[7].serial" value="7">
					<input type="text" name="demans[7].scale" value="${countryBasic.demans[7].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[7].idx" value="${countryBasic.demans[7].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[7].constructionSite" value="${countryBasic.demans[7].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[7].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[7].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[7].totalPrice" maxlength="11"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[7].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[7].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[7].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[7].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[7].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[7].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[7].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[7].peopleNumber" maxlength="8"   class="int" value="${countryBasic.demans[7].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[7].implementAndCompletion" value="${countryBasic.demans[7].implementAndCompletion}" />
				</td>
			</tr>



			<tr>
				<td rowspan="2" class="thr-td"><span>3.生活和生产用电</span></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="自然村生产用电输变电线路和设施" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="千米" readonly="true"></td>
				<input type="hidden" name="demans[8].serial" value="8">
				<td class="sec-td bg-white">
					<input type="text" name="demans[8].scale" value="${countryBasic.demans[8].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[8].idx" value="${countryBasic.demans[8].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[8].constructionSite" value="${countryBasic.demans[8].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[8].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[8].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[8].totalPrice" maxlength="11"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[8].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[8].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[8].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[8].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[8].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[8].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[8].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[8].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[8].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[8].implementAndCompletion" value="${countryBasic.demans[8].implementAndCompletion}" />
				</td>
			</tr>



			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="贫困户生活生产用电输变电线路和设施" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="千米" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[9].serial" value="9">
					<input type="text" name="demans[9].scale" value="${countryBasic.demans[9].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[9].idx" value="${countryBasic.demans[9].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[9].constructionSite" value="${countryBasic.demans[9].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[9].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[9].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[9].totalPrice" maxlength="11"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[9].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[9].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[9].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[9].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[9].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[9].poorHouseholdNumber" maxlength="8"  class="int" value="${countryBasic.demans[9].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[9].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[9].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[9].implementAndCompletion" value="${countryBasic.demans[9].implementAndCompletion}" />
				</td>
			</tr>



			<tr>
				<td rowspan="3" class="thr-td"><span>4.已通电自然村(屯)通宽带（20户以上）</span></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="移动基站" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="处" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[10].serial" value="10">
					<input type="text" name="demans[10].scale" value="${countryBasic.demans[10].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[10].idx" value="${countryBasic.demans[10].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[10].constructionSite" value="${countryBasic.demans[10].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[10].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[10].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[10].totalPrice" maxlength="11"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[10].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[10].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[10].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[10].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[10].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[10].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[10].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[10].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[10].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[10].implementAndCompletion" value="${countryBasic.demans[10].implementAndCompletion}" />
				</td>
			</tr>



			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="乡镇到自然村光缆线路" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="千米" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[11].serial" value="11">
					<input type="text" name="demans[11].scale" value="${countryBasic.demans[11].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[11].idx" value="${countryBasic.demans[11].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[11].constructionSite" value="${countryBasic.demans[11].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[11].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[11].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[11].totalPrice" maxlength="11"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[11].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[11].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[11].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[11].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[11].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[11].poorHouseholdNumber" maxlength="8"  class="int" value="${countryBasic.demans[11].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[11].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[11].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[11].implementAndCompletion" value="${countryBasic.demans[11].implementAndCompletion}" />
				</td>
			</tr>



			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="自然村内光缆线路和接入设备" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="户" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[12].serial" value="12">
					<input type="text" name="demans[12].scale" value="${countryBasic.demans[12].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[12].idx" value="${countryBasic.demans[12].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[12].constructionSite" value="${countryBasic.demans[12].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[12].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[12].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[12].totalPrice" maxlength="11"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[12].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[12].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[12].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[12].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[12].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[12].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[12].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[12].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[12].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[12].implementAndCompletion" value="${countryBasic.demans[12].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td rowspan="6" class="thr-td"><span>5.环境保护和改善</span></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="公共卫生厕所" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="个" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[13].serial" value="13">
					<input type="text" name="demans[13].scale" value="${countryBasic.demans[13].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[13].idx" value="${countryBasic.demans[13].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[13].constructionSite" value="${countryBasic.demans[13].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[13].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[13].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[13].totalPrice" class="decimal" maxlength="11" value="<fmt:formatNumber value='${countryBasic.demans[13].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[13].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[13].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[13].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[13].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[13].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[13].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[13].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[13].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[13].implementAndCompletion" value="${countryBasic.demans[13].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="垃圾集中收集点" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="个" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[14].serial" value="14">
					<input type="text" name="demans[14].scale" value="${countryBasic.demans[14].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[14].idx" value="${countryBasic.demans[14].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[14].constructionSite" value="${countryBasic.demans[14].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[14].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[14].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[14].totalPrice" maxlength="11" class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[14].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[14].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[14].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[14].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[14].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[14].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[14].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[14].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[14].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[14].implementAndCompletion" value="${countryBasic.demans[14].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="污水处理" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="处" readonly="true"></td>
				<td class="sec-td bg-white">
					<input type="hidden" name="demans[15].serial" value="15">
					<input type="text" name="demans[15].scale" value="${countryBasic.demans[15].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[15].idx" value="${countryBasic.demans[15].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[15].constructionSite" value="${countryBasic.demans[15].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[15].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[15].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[15].totalPrice"  class="decimal" maxlength="11" value="<fmt:formatNumber value='${countryBasic.demans[15].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[15].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[15].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[15].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[15].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[15].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[15].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[15].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[15].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[15].implementAndCompletion" value="${countryBasic.demans[15].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="集中沼气池" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="口" readonly="true"></td>
				<input type="hidden" name="demans[16].serial" value="16">
				<td class="sec-td bg-white">
					<input type="text" name="demans[16].scale" value="${countryBasic.demans[16].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[16].idx" value="${countryBasic.demans[16].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[16].constructionSite" value="${countryBasic.demans[16].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[16].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[16].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[16].totalPrice"   class="decimal" maxlength="11" value="<fmt:formatNumber value='${countryBasic.demans[16].totalPrice}' pattern='#0.##'/>" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[16].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[16].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[16].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[16].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[16].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[16].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[16].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[16].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[16].implementAndCompletion" value="${countryBasic.demans[16].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="两旁绿化" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="千米" readonly="true"></td>
				<input type="hidden" name="demans[17].serial" value="17">
				<td class="sec-td bg-white">
					<input type="text" name="demans[17].scale" value="${countryBasic.demans[17].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[17].idx" value="${countryBasic.demans[17].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[17].constructionSite" value="${countryBasic.demans[17].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[17].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[17].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[17].totalPrice"  class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[17].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[17].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[17].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[17].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[17].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[17].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[17].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[17].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[17].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[17].implementAndCompletion" value="${countryBasic.demans[17].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="旅游村停车场" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="处" readonly="true"></td>
				<input type="hidden" name="demans[18].serial" value="18">
				<td class="sec-td bg-white">
					<input type="text" name="demans[18].scale" value="${countryBasic.demans[18].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[18].idx" value="${countryBasic.demans[18].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[18].constructionSite" value="${countryBasic.demans[18].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[18].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[18].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[18].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[18].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[18].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[18].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[18].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[18].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[18].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[18].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[18].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[18].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[18].implementAndCompletion" value="${countryBasic.demans[18].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td rowspan="2" class="thr-td"><span>6.防灾避灾基础设施</span></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="防洪堤" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="千米" readonly="true"></td>
				<input type="hidden" name="demans[19].serial" value="19">
				<td class="sec-td bg-white">
					<input type="text" name="demans[19].scale" value="${countryBasic.demans[19].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[19].idx" value="${countryBasic.demans[19].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[19].constructionSite" value="${countryBasic.demans[19].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[19].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[19].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[19].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[19].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[19].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[19].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[19].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[19].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[19].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[19].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[19].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[19].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[19].implementAndCompletion" value="${countryBasic.demans[19].implementAndCompletion}" />
				</td>
			</tr>



			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="护坡" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="千米" readonly="true"></td>
				<input type="hidden" name="demans[20].serial" value="20">
				<td class="sec-td bg-white">
					<input type="text" name="demans[20].scale" value="${countryBasic.demans[20].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[20].idx" value="${countryBasic.demans[20].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[20].constructionSite" value="${countryBasic.demans[20].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[20].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[20].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[20].totalPrice"  class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[20].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[20].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[20].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[20].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[20].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[20].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[20].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[20].peopleNumber" maxlength="8"   class="int" value="${countryBasic.demans[20].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[20].implementAndCompletion" value="${countryBasic.demans[20].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td rowspan="6" class="thr-td"><span>7.扶贫生态移民</span></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="就地安置" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="户" readonly="true"></td>
				<input type="hidden" name="demans[21].serial" value="21">
				<td class="sec-td bg-white">
					<input type="text" name="demans[21].scale" value="${countryBasic.demans[21].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[21].idx" value="${countryBasic.demans[21].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[21].constructionSite" value="${countryBasic.demans[21].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[21].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[21].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[21].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[21].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[21].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[21].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[21].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[21].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[21].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[21].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[21].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[21].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[21].implementAndCompletion" value="${countryBasic.demans[21].implementAndCompletion}" />
				</td>
			</tr>





			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="中心村安置" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="户" readonly="true"></td>
				<input type="hidden" name="demans[22].serial" value="22">
				<td class="sec-td bg-white">
					<input type="text" name="demans[22].scale" value="${countryBasic.demans[22].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[22].idx" value="${countryBasic.demans[22].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[22].constructionSite" value="${countryBasic.demans[22].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[22].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[22].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[22].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[22].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[22].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[22].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[22].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[22].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[22].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[22].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[22].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[22].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[22].implementAndCompletion" value="${countryBasic.demans[22].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="乡（镇）安置" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="户" readonly="true"></td>
				<input type="hidden" name="demans[23].serial" value="23">
				<td class="sec-td bg-white">
					<input type="text" name="demans[23].scale" value="${countryBasic.demans[23].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[23].idx" value="${countryBasic.demans[23].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[23].constructionSite" value="${countryBasic.demans[23].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[23].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[23].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[23].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[23].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[23].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[23].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[23].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[23].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[23].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[23].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[23].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[23].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[23].implementAndCompletion" value="${countryBasic.demans[23].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="县城安置" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="户" readonly="true"></td>
				<input type="hidden" name="demans[24].serial" value="24">
				<td class="sec-td bg-white">
					<input type="text" name="demans[24].scale" value="${countryBasic.demans[24].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[24].idx" value="${countryBasic.demans[24].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[24].constructionSite" value="${countryBasic.demans[24].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[24].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[24].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[24].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[24].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[24].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[24].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[24].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[24].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[24].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[24].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[24].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[24].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[24].implementAndCompletion" value="${countryBasic.demans[24].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="工业园区" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="户" readonly="true"></td>
				<input type="hidden" name="demans[25].serial" value="25">
				<td class="sec-td bg-white">
					<input type="text" name="demans[25].scale" value="${countryBasic.demans[25].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[25].idx" value="${countryBasic.demans[25].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[25].constructionSite" value="${countryBasic.demans[25].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[25].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[25].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[25].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[25].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[25].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[25].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[25].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[25].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[25].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[25].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[25].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[25].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[25].implementAndCompletion" value="${countryBasic.demans[25].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="旅游区" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="户" readonly="true"></td>
				<input type="hidden" name="demans[26].serial" value="26">
				<td class="sec-td bg-white">
					<input type="text" name="demans[26].scale" value="${countryBasic.demans[26].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[26].idx" value="${countryBasic.demans[26].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[26].constructionSite" value="${countryBasic.demans[26].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[26].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[26].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[26].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[26].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[26].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[26].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[26].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[26].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[26].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[26].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[26].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[26].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[26].implementAndCompletion" value="${countryBasic.demans[26].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td rowspan="6" class="thr-td"><span>8.产业发展</span></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="种植类" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="亩" readonly="true"></td>
				<input type="hidden" name="demans[27].serial" value="27">
				<td class="sec-td bg-white">
					<input type="text" name="demans[27].scale" value="${countryBasic.demans[27].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[27].idx" value="${countryBasic.demans[27].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[27].constructionSite" value="${countryBasic.demans[27].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[27].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[27].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[27].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[27].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[27].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[27].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[27].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[27].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[27].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[27].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[27].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[27].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[27].implementAndCompletion" value="${countryBasic.demans[27].implementAndCompletion}" />
				</td>
			</tr>


			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="中药材类" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="亩" readonly="true"></td>
				<input type="hidden" name="demans[28].serial" value="28">
				<td class="sec-td bg-white">
					<input type="text" name="demans[28].scale" value="${countryBasic.demans[28].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[28].idx" value="${countryBasic.demans[28].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[28].constructionSite" value="${countryBasic.demans[28].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[28].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[28].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[28].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[28].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[28].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[28].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[28].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[28].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[28].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[28].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[28].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[28].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[28].implementAndCompletion" value="${countryBasic.demans[28].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="养殖类" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="-" readonly="true"></td>
				<input type="hidden" name="demans[29].serial" value="29">
				<td class="sec-td bg-white">
					<input type="text" name="demans[29].scale" value="${countryBasic.demans[29].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[29].idx" value="${countryBasic.demans[29].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[29].constructionSite" value="${countryBasic.demans[29].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[29].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[29].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[29].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[29].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[29].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[29].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[29].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[29].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[29].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[29].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[29].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[29].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[29].implementAndCompletion" value="${countryBasic.demans[29].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="水果类" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="亩" readonly="true"></td>
				<input type="hidden" name="demans[30].serial" value="30">
				<td class="sec-td bg-white">
					<input type="text" name="demans[30].scale" value="${countryBasic.demans[30].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[30].idx" value="${countryBasic.demans[30].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[30].constructionSite" value="${countryBasic.demans[30].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[30].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[30].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[30].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[30].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[30].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[30].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[30].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[30].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[30].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[30].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[30].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[30].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[30].implementAndCompletion" value="${countryBasic.demans[30].implementAndCompletion}" />
				</td>
			</tr>




			<tr>

				<td class="sec-td bg-white"><input type="text" class="inp-left" value="坚果类" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="亩" readonly="true"></td>
				<input type="hidden" name="demans[31].serial" value="31">
				<td class="sec-td bg-white">
					<input type="text" name="demans[31].scale" value="${countryBasic.demans[31].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[31].idx" value="${countryBasic.demans[31].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[31].constructionSite" value="${countryBasic.demans[31].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[31].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[31].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[31].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[31].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[31].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[31].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[31].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[31].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[31].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[31].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[31].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[31].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[31].implementAndCompletion" value="${countryBasic.demans[31].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="其他类" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="-" readonly="true"></td>
				<input type="hidden" name="demans[32].serial" value="32">
				<td class="sec-td bg-white">
					<input type="text" name="demans[32].scale" value="${countryBasic.demans[32].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[32].idx" value="${countryBasic.demans[32].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[32].constructionSite" value="${countryBasic.demans[32].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[32].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[32].unitPrice}' pattern='#0.##'/>"maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[32].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[32].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[32].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[32].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[32].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[32].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[32].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[32].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[32].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[32].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[32].implementAndCompletion" value="${countryBasic.demans[32].implementAndCompletion}" />
				</td>
			</tr>




			<tr>
				<td class="thr-td"><span>9.其他</span></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" value="基础设施" readonly="true"></td>
				<td class="sec-td bg-white"><input type="text" class="inp-left" readonly="true"></td>
				<input type="hidden" name="demans[33].serial" value="33">
				<td class="sec-td bg-white">
					<input type="text" name="demans[33].scale" value="${countryBasic.demans[33].scale}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[33].idx" value="${countryBasic.demans[33].idx}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[33].constructionSite" value="${countryBasic.demans[33].constructionSite}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[33].unitPrice" class="decimal" value="<fmt:formatNumber value='${countryBasic.demans[33].unitPrice}' pattern='#0.##'/>"maxlength="11"/>
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[33].totalPrice"  class="decimal"value="<fmt:formatNumber value='${countryBasic.demans[33].totalPrice}' pattern='#0.##'/>" maxlength="11" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[33].villageNumber" maxlength="8" class="int" value="${countryBasic.demans[33].villageNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[33].householdNumber" maxlength="8" class="int" value="${countryBasic.demans[33].householdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[33].poorHouseholdNumber" maxlength="8" class="int" value="${countryBasic.demans[33].poorHouseholdNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[33].peopleNumber" maxlength="8"  class="int" value="${countryBasic.demans[33].peopleNumber}" />
				</td>
				<td class="sec-td bg-white">
					<input type="text" name="demans[33].implementAndCompletion" value="${countryBasic.demans[33].implementAndCompletion}" />
				</td>
			</tr>


			</tbody>
		</table>
		<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
		</div>
	</form:form>
	</c:otherwise></c:choose>
</body>
</html>