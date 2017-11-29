<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>饮水情况管理</title>
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
		<%--<li><a href="${ctx}/record/drinkWater/">饮水情况列表</a></li>--%>
		<li class="active"><a href="${ctx}/record/drinkWater/form?id=${drinkWater.id}">饮水情况<shiro:hasPermission name="record:drinkWater:edit">${not empty drinkWater.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:drinkWater:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${drinkWater.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${drinkWater.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${drinkWater.countryBasicId}">村级道路情况</a></li>
		<li class="active"><a>饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${drinkWater.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${drinkWater.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${drinkWater.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${drinkWater.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${drinkWater.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${drinkWater.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?id=countryBasicId=${drinkWater.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${drinkWater.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${drinkWater.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${drinkWater.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${drinkWater.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${drinkWater.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${drinkWater.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${drinkWater.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${drinkWater.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${drinkWater.countryBasicId}">两委班子情况</a></li>
	</ul>
	<div id="tab-2" class="content-detail">
		<c:choose>
		<c:when test="${empty drinkWater.countryBasicId}">
		<script>
			alert("请先填写基本情况！");
			window.history.back(-1);
		</script>
		</c:when>
		<c:otherwise>
	<form:form id="inputForm" modelAttribute="drinkWater" action="${ctx}/record/drinkWater/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="countryBasicId"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>
		<table>
			<tbody>


			<tr>
				<td class="fir-td"><span>B26饮用自来水户数（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b26TapHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>其中：B31-1 人均容积在5立方米以下（人）</span></td>
				<td class="fou-td bg-white">
					<form:input path="b311Per" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>B27 饮用自来水人数（人）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b27TapPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>B31-2 人均容积在5-10立方米（含5立方米）（人）</span></td>
				<td class="fou-td bg-white">
					<form:input path="b312Per" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>B28 饮用井水户数（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b28WellsHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>B31-3 人均容积在10立方米以上（含10立方米）（人）</span></td>
				<td class="fou-td bg-white">
					<form:input path="b313Per" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>B29 饮用井水人数（人）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b29WellsPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>B32 饮水困难户数（户）</span></td>
				<td class="fou-td bg-white">
					<form:input path="b32HardHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>B30 饮用水柜（窖）水的户数（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b30TankHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>其中：B32-1 取水往返时间超过30分钟的户数（户）</span></td>
				<td class="fou-td bg-white">
					<form:input path="b321TakeHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>其中：B30-1 人均容积在5立方米以下（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b301Hou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>B32-2 全年缺水三个月以上的户数（户））</span></td>
				<td class="fou-td bg-white">
					<form:input path="b322LackHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>B30-2 人均容积在5-10立方米（含5立方米）（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b302Hou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>B33 饮水困难人数（人）</span></td>
				<td class="fou-td bg-white">
					<form:input path="b33HardPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>B30-3 人均容积在10立方米以上（含10立方米）（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b303Hou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>其中：B33-1 取水往返时间超过30分钟的人数（人）</span></td>
				<td class="fou-td bg-white">
					<form:input path="b331TakePer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>B31 饮用水柜（窖）水的人口数（人）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b31TankPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>B33-2 全年缺水三个月以上的人数（人）</span></td>
				<td class="fou-td bg-white">
					<form:input path="b332LackPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			</tbody>
		</table><div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>

	</form:form>
		</c:otherwise>
		</c:choose>
</body>
</html>