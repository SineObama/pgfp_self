<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户生产生活条件管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
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
	<ul class="nav nav-tabs">
	<li><a href="${ctx}/record/basePoorerRegCard/">建档立卡表列表</a></li>
		<%--<li><a href="${ctx}/record/baseProductionLivingCondition/">贫困户生产生活条件列表</a></li>--%>
		<li class="active"><a href="${ctx}/record/baseProductionLivingCondition/form?poorerRegCardId=${condition.poorerRegCardId}">贫困户生产生活条件<shiro:hasPermission name="record:baseProductionLivingCondition:edit">${not empty baseProductionLivingCondition.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:baseProductionLivingCondition:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<div class="header">
		<a href="" class="header-lt">贫困户建档立卡</a>
		<a href="" class="header-rt">生产生活条件</a>
	</div>
	<div class="content tabs f-clear">
		<ul class="content-nav">
			<li><a href="${ctx}/record/basePoorerRegCard/form?id=${condition.poorerRegCardId}">基本情况</a></li>
			<li><a href="${ctx}/record/basePoorerFamilyMember/form?poorerRegCardId=${condition.poorerRegCardId}">家庭成员</a></li>
			<li><a href="${ctx}/record/baseMemberTrainingStatus/form?cardId=${condition.poorerRegCardId}">家庭成员受培训情况</a></li>
			<li><a href="${ctx}/record/baseMemberWorkStatus/form?cardId=${condition.poorerRegCardId}">家庭成员就业情况</a> </li>
			<li><a href="${ctx}/bf/insuredSituation/form?poorerRegCardId=${condition.poorerRegCardId}">家庭成员参保情况</a></li>
			<li class="active">生产生活条件</li>
			<li><a href="${ctx}/record/baseFamilyEconomicInfo/form?poorerRegCardId=${condition.poorerRegCardId}">家庭经济情况</a></li>
			<li><a href="${ctx}/record/baseRegCardBiz/form?regCardId=${condition.poorerRegCardId}">特色产业增收</a></li>
			<li><a href="${ctx}/record/basePoorerHelpDetail/form?poorerRegCardId=${condition.poorerRegCardId}">帮扶需求</a></li>
			<li><a href="${ctx}/record/basePoorerSupportUnitInfo/form?poorerRegCardId=${condition.poorerRegCardId}">帮扶单位及责任人</a></li>
			<li><a href="${ctx}/record/basePoorerStudentHelpInfo/form?poorerRegCardId=${condition.poorerRegCardId}">家庭在校生受帮扶情况</a></li>
			<li><a href="${ctx}/record/basePoorerRegCard/tpPlan?id=${condition.poorerRegCardId}">填表记录</a></li>
		</ul>
		<div id="tab-15" class="content-detail">
	<form:form id="inputForm" modelAttribute="condition" action="${ctx}/record/baseProductionLivingCondition/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="poorerRegCardId"/>
		<sys:message content="${message}"/>

		<br/>
		<table style="border: 0px #FFFFFF;">
			<tbody>
			<tr style="border: 0px #FFFFFF; ">
				<td class="sec-td bg-white" colspan="2" style="border: 0px #FFFFFF;">

				</td>

				<td class="sec-td bg-white" style="border: 0px #FFFFFF; text-align: right;">归属年度:</td>
				<td class="sec-td bg-white" style="border: 0px #FFFFFF;">
					<input id="years" name="years" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						   value="<fmt:formatDate value="${condition.yearDate}" pattern="yyyy"/>"
						   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" style="width: 120px;background-color: #FFFFFF;"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>房屋情况，新建住房或是已有住房</span></td>
				<td class="fou-td bg-white">
					<%--<form:input type="text" maxlength="10" class="inp-right int" path="houseSaveLevel"/>--%>
					<form:select path="newOrOld" class="newOrOld" maxlength="10" style="width:120px;">
						<form:option value="" label="-------------"/>
						<form:option value="0" label="无住房"/>
						<form:option value="1" label="新建住房"/>
						<form:option value="2" label="已有住房"/>
					</form:select>
				</td>
				<td class="sec-td"><span>A25 耕地面积（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" name="agriculturalAcreage" id="agriculturalAcreage" maxlength="11"
						   value="<fmt:formatNumber value='${condition.agriculturalAcreage}' pattern='#0.##'/>" class="inp-left decimal"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>住房结构</span></td>
				<td class="sec-td bg-white">
					<form:select path="houseStructure" class="houseStructure" maxlength="11" style="width:120px;">
						<form:option value="" label="-------------"/>
						<form:options  items="${fns:getDictList('housing_structure')}" itemLabel="label" itemValue="value"/>
					</form:select>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：水田面积（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text"  class="inp-right decimal" name="paddyFieldArea" id="paddyFieldArea" maxlength="11"
						   value="<fmt:formatNumber value='${condition.paddyFieldArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>房屋安全等级</span></td>
				<td class="fou-td bg-white">
					<%--<form:input type="text" maxlength="10" class="inp-right int" path="houseSaveLevel"/>--%>
					<form:select path="houseSaveLevel" class="houseSaveLevel" maxlength="10" style="width:120px;">
						<form:option value="" label="-------------"/>
						<form:option value="1" label="A"/>
						<form:option value="2" label="B"/>
						<form:option value="3" label="C"/>
						<form:option value="4" label="D"/>
					</form:select>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：缺水灌溉面积（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-right decimal" name="unwateredIrrigationArea"  id="unwateredIrrigationArea" maxlength="11"
						   value="<fmt:formatNumber value='${condition.unwateredIrrigationArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>A18 住房面积（平方米）</span></td>
				<td class="sec-td bg-white">
					<input type="text" name="livingArea" id="livingArea"  class="inp-left decimal" maxlength="11"
						   value="<fmt:formatNumber value='${condition.livingArea}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;旱地（坡地）面积（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-right decimal" name="uplandArea" maxlength="11"  id="uplandArea"
						   value="<fmt:formatNumber value='${condition.uplandArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：砖混或纯木结构（平方米）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" name="brickOrPureWoodStruct"  id="brickOrPureWoodStruct" maxlength="11"
						   value="<fmt:formatNumber value='${condition.brickOrPureWoodStruct}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>A26 人均耕地面积（亩）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="avgAgriculturalAcreage"  id="avgAgriculturalAcreage"
						   value="<fmt:formatNumber value='${condition.avgAgriculturalAcreage}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;砖木结构（平方米）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" name="brickStructure"  id="brickStructure" maxlength="11"
						   value="<fmt:formatNumber value='${condition.brickStructure}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>A27 水产养殖面积（亩）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="aquicultureArea"  id="aquicultureArea"
						   value="<fmt:formatNumber value='${condition.aquicultureArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;土木结构（平方米）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" name="civilStructure" maxlength="11"  id="civilStructure"
						   value="<fmt:formatNumber value='${condition.civilStructure}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：淡水养殖面积（亩）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="freshwaterAquicultureArea"  id="freshwaterAquicultureArea"
						   value="<fmt:formatNumber value='${condition.freshwaterAquicultureArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;木瓦结构（平方米）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" id="shinglesStructure" name="shinglesStructure"
						   value="<fmt:formatNumber value='${condition.shinglesStructure}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;海水养殖面积（亩）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="maricultureArea" id="maricultureArea"
						   value="<fmt:formatNumber value='${condition.maricultureArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;危房（平方米）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" name="dangerousHouse"  id="dangerousHouse"
						   value="<fmt:formatNumber value='${condition.dangerousHouse}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>A28 牲畜存栏数（头）</span></td>
				<td class="fou-td bg-white"><form:input type="text" maxlength="8" class="inp-right int" path="livestockInventory"/></td>
			</tr>
			<tr>
				<td class="sec-td"><span>A19人均住房面积（平方米）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" name="avgLivingArea" id="avgLivingArea"
						   value="<fmt:formatNumber value='${condition.avgLivingArea}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：牛（头）</span></td>
				<td class="fou-td bg-white"><form:input type="text" maxlength="8" class="inp-right int" path="cattleInventory"/></td>
			</tr>
			<tr>
				<td class="sec-td"><span>A20 主要住房是否危房</span></td>
				<td class="sec-td bg-white">
					<form:radiobuttons class="inp-left" items="${fns:getDictList('yes_no')}"
									   itemLabel="label" itemValue="value" path="dangerousHouseFlag"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;马（匹）</span></td>
				<td class="fou-td bg-white"><form:input type="text" maxlength="8" class="inp-right int" path="horseInventory"/></td>
			</tr>
			<tr>
				<td class="sec-td"><span>A21 是否享受农村危房改造政策</span></td>
				<td class="sec-td bg-white">
					<form:radiobuttons class="inp-left" items="${fns:getDictList('yes_no')}"
									   itemLabel="label" itemValue="value" path="enjoyHouseReformPolicy"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;羊（只）</span></td>
				<td class="fou-td bg-white"><form:input type="text" maxlength="8" class="inp-right int" path="sheepInventory"/></td>
			</tr>
			<tr>
				<td class="sec-td"><span>A22 家电（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="homeAppliance"/></td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;猪（头）</span></td>
				<td class="fou-td bg-white"><form:input type="text" maxlength="8" class="inp-right int" path="pigInventory"/></td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：洗衣机或热水器或电脑或较大音响设备（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="washerPc"/></td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其它牲畜</span></td>
				<td class="fou-td bg-white"><form:input type="text" maxlength="8" class="inp-right int" path="otherLivestockInventory"/></td>
			</tr>
			<tr>
				<td class="sec-td"><span>A22 家电（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="homeAppliance"/></td>

				<td class="sec-td"><span>A29 家禽存栏数（羽）</span></td>
				<td class="fou-td bg-white"><form:input type="text" maxlength="8" class="inp-right int" path="poultryInventory"/></td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;电视机（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="televisionAmount"/></td>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：鸡（羽）</span></td>
				<td class="fou-td bg-white"><form:input type="text" maxlength="8" class="inp-right int" path="chickenAmount"/></td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;电冰箱（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="fridgeAmount"/></td>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;鸭（羽）</span></td>
				<td class="fou-td bg-white"><form:input type="text" maxlength="8" class="inp-right int" path="duckAmount"/></td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其他家电</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="otherHomeAppliance"/></td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;鹅（羽）</span></td>
				<td class="fou-td bg-white"><form:input type="text" maxlength="8" class="inp-right int" path="gooseAmount"/></td>
			</tr>
			<tr>

				<td class="sec-td"><span>A23 农机（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="agriculturalMachinery"/></td>


				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其它家禽</span></td>
				<td class="fou-td bg-white"><form:input type="text" maxlength="8" class="inp-right int" path="otherPoultryAmount"/></td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：拖拉机（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="tractorAmount"/></td>
				<td class="sec-td"><span>A30 林地面积（亩）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="forestlandArea"
						   value="<fmt:formatNumber value='${condition.forestlandArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;收割机（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="harvesterAmount"/></td>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：松木（亩）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="pineArea" id="pineArea"
						   value="<fmt:formatNumber value='${condition.pineArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;插秧机（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="riceTransplanterAmount"/></td>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;杉木（亩）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="firArea" id="firArea"
						   value="<fmt:formatNumber value='${condition.firArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;打田机（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="fieldMachineAmount"/></td>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;桉树（亩）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="eucalyptusArea" id="eucalyptusArea"
						   value="<fmt:formatNumber value='${condition.eucalyptusArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;碾米机（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="riceMillAmount"/></td>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;八角（亩）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="aniseArea" id="aniseArea"
						   value="<fmt:formatNumber value='${condition.aniseArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其它农机</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="otherAgriculturalMachinery"/></td>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;油茶（亩）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="sasanquaArea" id="sasanquaArea"
						   value="<fmt:formatNumber value='${condition.sasanquaArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>A24 机动车（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="motorVehicleAmount"/></td>


				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其它林地：</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="otherForestlandArea" id="otherForestlandArea"
						   value="<fmt:formatNumber value='${condition.otherForestlandArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：机动三轮车（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="motorTricycleAmount"/></td>

				<td class="sec-td"><span>A34 退耕还林面积（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" name="grainForGreenArea" id="grainForGreenArea"
						   value="<fmt:formatNumber value='${condition.grainForGreenArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;或电动车（台）</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="motorcycleAmount"/></td>


				<td class="sec-td"><span>A35 荒山荒坡面积（亩）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="barrenHillsArea" id="barrenHillsArea"
						   value="<fmt:formatNumber value='${condition.barrenHillsArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其他机动车：</span></td>
				<td class="sec-td bg-white"><form:input type="text" maxlength="8" class="inp-left int" path="otherMotorVehicleAmount"/></td>


				<td class="sec-td"><span>A36 饮水是否困难</span></td>
				<td class="fou-td bg-white">
					<form:radiobuttons class="inp-right" path="dysdipsiaFlag"
									   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>A31果园面积（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" name="orchardArea" id="orchardArea"
						   value="<fmt:formatNumber value='${condition.orchardArea}' pattern='#0.##'/>"/>
				</td>


				<td class="sec-td"><span>A37 饮水状况</span></td>
				<td class="fou-td bg-white">
					<%--<form:input type="text" maxlength="10" class="inp-right" path="drinkingStatus"/>--%>
					<form:select path="drinkingStatus" style="width:120px;">
						<form:option value="" label="----------"/>
						<form:options items="${fns:getDictList('drinking_water_status')}" itemLabel="label" itemValue="value"/>
					</form:select>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：板栗（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" name="chestnutArea" id="chestnutArea"
						   value="<fmt:formatNumber value='${condition.chestnutArea}' pattern='#0.##'/>"/>
				</td>

				<td class="sec-td"><span>A38 饮水取水距离（公里）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="fetchWaterDistance" id="fetchWaterDistance"
						   value="<fmt:formatNumber value='${condition.fetchWaterDistance}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;核桃（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" name="walnutArea" id="walnutArea"
						   value="<fmt:formatNumber value='${condition.walnutArea}' pattern='#0.##'/>"/>
				</td>



				<td class="sec-td"><span>A39 年缺水时间（月）</span></td>
				<td class="fou-td bg-white"><form:input type="text" maxlength="8" class="inp-right decimal" path="waterScarcityTime"/></td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;龙眼、荔枝（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" name="longanLitchiArea" id="longanLitchiArea"
						   value="<fmt:formatNumber value='${condition.longanLitchiArea}' pattern='#0.##'/>"/>
				</td>

				<td class="sec-td"><span>A40 饮水是否安全</span></td>
				<td class="fou-td bg-white">
					<form:radiobuttons  class="inp-right" path="waterSecureFlag" items="${fns:getDictList('yes_no')}"
										itemLabel="label" itemValue="value"/>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;葡萄（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" name="grapeArea" id="grapeArea"
						   value="<fmt:formatNumber value='${condition.grapeArea}' pattern='#0.##'/>"/>
				</td>

				<td class="sec-td"><span>A41 是否通电</span></td>
				<td class="fou-td bg-white">
					<form:radiobuttons class="inp-right" path="powerOnFlag"
									   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;芒果（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" name="mangoArea" id="mangoArea"
						   value="<fmt:formatNumber value='${condition.mangoArea}' pattern='#0.##'/>"/>
				</td>



				<td class="sec-td"><span>A42 是否通广播电视</span></td>
				<td class="fou-td bg-white">
					<form:radiobuttons  class="inp-right" path="conRadioAndTvFlag"
										items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;香蕉（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" name="bananaArea" id="bananaArea" maxlength="11"
						   value="<fmt:formatNumber value='${condition.bananaArea}' pattern='#0.##'/>"/>
				</td>


				<td class="sec-td"><span>A43 距离村级以上主干路最近里程（公里）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" maxlength="11" name="mainRoadDistance" id="mainRoadDistance"
						   value="<fmt:formatNumber value='${condition.mainRoadDistance}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;柑桔（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" name="citrusArea" maxlength="11" id="citrusArea"
						   value="<fmt:formatNumber value='${condition.citrusArea}' pattern='#0.##'/>"/>
				</td>


				<td class="sec-td"><span>A44 入户路类型</span></td>
				<td class="fou-td bg-white">
					<%--<form:input type="text" maxlength="10" class="inp-right" path="roadType"/>--%>
					<form:select path="roadType" style="width:120px;">
						<form:option value="" label="-------------"/>
						<form:options items="${fns:getDictList('entrance_road_type')}" itemLabel="label" itemValue="value"/>
					</form:select>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其他水果：</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" name="otherFruitArea" id="otherFruitArea"
						   value="<fmt:formatNumber value='${condition.otherFruitArea}' pattern='#0.##'/>"/>
				</td>


				<td class="sec-td"><span>A45 到最近就医点看病里程（公里）</span></td>
				<td class="fou-td bg-white">
					<input type="text" class="inp-right decimal" name="nearestHospitalDistance" maxlength="11" id="nearestHospitalDistance"
						   value="<fmt:formatNumber value='${condition.nearestHospitalDistance}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>A32 经济作物（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" name="industrialCropArea" id="industrialCropArea"
						   value="<fmt:formatNumber value='${condition.industrialCropArea}' pattern='#0.##'/>"/>
				</td>


				<td class="sec-td"><span>A46 有无卫生厕所</span></td>
				<td class="fou-td bg-white">
					<form:radiobuttons class="inp-right" path="toiletFlag"
									   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/></td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：甘蔗（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" name="sugarcaneArea" id="sugarcaneArea"
						   value="<fmt:formatNumber value='${condition.sugarcaneArea}' pattern='#0.##'/>"/>
				</td>


				<td class="sec-td"><span>A47 主要燃料类型（单选）</span></td>
				<td class="fou-td bg-white">
					<form:radiobuttons  class="inp-right" path="mainFuelType"
										items="${fns:getDictList('main_fuel_type')}" itemLabel="label" itemValue="value"/>
				</td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;茶园（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" name="teaGardenArea" maxlength="11" id="teaGardenArea"
						   value="<fmt:formatNumber value='${condition.teaGardenArea}' pattern='#0.##'/>"/>
				</td>


				<td class="sec-td"><span>A48 是否参与农民合作社</span></td>
				<td class="fou-td bg-white">
					<form:radiobuttons class="inp-right" path="joinCooperativeFlag"
									   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/></td>
			</tr>
			<tr>

				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;桑园（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" name="mulberryField" maxlength="11" id="mulberryField"
						   value="<fmt:formatNumber value='${condition.mulberryField}' pattern='#0.##'/>"/>
				</td>



				<td class="sec-td"><span>A49 家庭常年稳定外出务工人数（人）</span></td>
				<td class="fou-td bg-white"><form:input type="text" maxlength="8" class="inp-right int" path="worker"/></td>

			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其他经济作物：</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" name="otherIndustrialCropArea" maxlength="11" id="otherIndustrialCropArea"
						   value="<fmt:formatNumber value='${condition.otherIndustrialCropArea}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>A33 人均林地面积（亩）</span></td>
				<td class="sec-td bg-white">
					<input type="text" class="inp-left decimal" maxlength="11" name="perCapitaForestlandArea" id="perCapitaForestlandArea"
						   value="<fmt:formatNumber value='${condition.perCapitaForestlandArea}' pattern='#0.##'/>"/>
				</td>
			</tr>
			</tbody>
		</table>

		<div class="content-save">
			<shiro:hasPermission name="record:basePoorerRegCard:edit">
				<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
		</div>

		<%--<div class="form-actions">--%>
			<%--<shiro:hasPermission name="record:baseProductionLivingCondition:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>--%>
			<%--<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>--%>
		<%--</div>--%>
	</form:form>
		</div>
		</div>
</body>
</html>