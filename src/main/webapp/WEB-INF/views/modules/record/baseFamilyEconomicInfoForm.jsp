<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户经济状况管理</title>
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
		<%--<li><a href="${ctx}/record/baseFamilyEconomicInfo/">贫困户经济状况列表</a></li>--%>
		<li class="active"><a href="${ctx}/record/baseFamilyEconomicInfo/form?poorerRegCardId=${info.poorerRegCardId}">经济状况<shiro:hasPermission name="record:baseFamilyEconomicInfo:edit">${not empty baseFamilyEconomicInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:baseFamilyEconomicInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<div class="header">
		<a href="" class="header-lt">贫困户建档立卡</a>
		<a href="" class="header-rt">家庭经济情况</a>
	</div>
	<div class="content tabs f-clear">
		<ul class="content-nav">
			<li><a href="${ctx}/record/basePoorerRegCard/form?id=${info.poorerRegCardId}">基本情况</a></li>
			<li><a href="${ctx}/record/basePoorerFamilyMember/form?poorerRegCardId=${info.poorerRegCardId}">家庭成员</a></li>
			<li><a href="${ctx}/record/baseMemberTrainingStatus/form?cardId=${info.poorerRegCardId}">家庭成员受培训情况</a></li>
			<li><a href="${ctx}/record/baseMemberWorkStatus/form?cardId=${info.poorerRegCardId}">家庭成员就业情况</a> </li>
			<li><a href="${ctx}/bf/insuredSituation/form?poorerRegCardId=${info.poorerRegCardId}">家庭成员参保情况</a></li>
			<li><a href="${ctx}/record/baseProductionLivingCondition/form?poorerRegCardId=${info.poorerRegCardId}">生产生活条件</a></li>
			<li class="active">家庭经济情况</li>
			<li><a href="${ctx}/record/baseRegCardBiz/form?regCardId=${info.poorerRegCardId}">特色产业增收</a></li>
			<li><a href="${ctx}/record/basePoorerHelpDetail/form?poorerRegCardId=${info.poorerRegCardId}">帮扶需求</a></li>
			<li><a href="${ctx}/record/basePoorerSupportUnitInfo/form?poorerRegCardId=${info.poorerRegCardId}">帮扶单位及责任人</a></li>
			<li><a href="${ctx}/record/basePoorerStudentHelpInfo/form?poorerRegCardId=${info.poorerRegCardId}">家庭在校生受帮扶情况</a></li>
			<li><a href="${ctx}/record/basePoorerRegCard/tpPlan?id=${info.poorerRegCardId}">填表记录</a></li>
		</ul>
		<div id="tab-15" class="content-detail">
	<form:form id="inputForm" modelAttribute="info" action="${ctx}/record/baseFamilyEconomicInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="poorerRegCardId"/>
		<sys:message content="${message}"/><br/>

		<table style="border: 0px #FFFFFF;">
			<tbody>
			<tr style="border: 0px #FFFFFF; ">
				<td class="sec-td bg-white" colspan="2" style="border: 0px #FFFFFF;">

				</td>

				<td class="sec-td bg-white" style="border: 0px #FFFFFF; text-align: right;">归属年度:</td>
				<td class="sec-td bg-white" style="border: 0px #FFFFFF;">
					<input id="years" name="years" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						   value="<fmt:formatDate value="${info.yearDate}" pattern="yyyy"/>"
						   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" style="width: 120px;background-color: #FFFFFF;"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>A50 家庭全年总收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" name="familyAnnualIncome" id="familyAnnualIncome" class="inp-left decimal"  maxlength="11"
						   value="<fmt:formatNumber value='${info.familyAnnualIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-1-5甘蔗收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" name="sugarcaneIncome"  class="inp-left decimal" id="sugarcaneIncome" maxlength="11"
						   value="<fmt:formatNumber value='${info.sugarcaneIncome}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：A50-1工资性收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="wages" id="wages"
						   value="<fmt:formatNumber value='${info.wages}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-1-6其他种植业收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="otherPlantIncome" id="otherPlantIncome"
						   value="<fmt:formatNumber value='${info.otherPlantIncome}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;A50-2生产经营性收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="productionIncome" id="productionIncome"
						   value="<fmt:formatNumber value='${info.productionIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-2林业收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="forestryIncome" id="forestryIncome"
						   value="<fmt:formatNumber value='${info.forestryIncome}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：A50-2-1种植业收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="plantIncome" id="plantIncome"
						   value="<fmt:formatNumber value='${info.plantIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：A50-2-2-1木材收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="woodIncome" id="woodIncome"
						   value="<fmt:formatNumber value='${info.woodIncome}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：A50-2-1-1稻谷收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="riceIncome" id="riceIncome"
						   value="<fmt:formatNumber value='${info.riceIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-2-2八角、油茶籽等林果收入</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="forestFruitIncomse" id="forestFruitIncomse"
						   value="<fmt:formatNumber value='${info.forestFruitIncomse}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-1-2玉米收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="cornIncome" id="cornIncome"
						   value="<fmt:formatNumber value='${info.cornIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-2-3其他林业收入</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="otherWoodIncome" id="otherWoodIncome"
						   value="<fmt:formatNumber value='${info.otherWoodIncome}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-1-3蔬菜收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="vegetableIncome" id="vegetableIncome"
						   value="<fmt:formatNumber value='${info.vegetableIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-3畜牧业收入</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="livestockFarmingIncome" id="livestockFarmingIncome"
						   value="<fmt:formatNumber value='${info.livestockFarmingIncome}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-1-4水果收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="fruitIncome" id="fruitIncome"
						   value="<fmt:formatNumber value='${info.fruitIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：A50-2-3-1出栏牛、马、羊收入</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="horseSheetIncome" id="horseSheetIncome"
						   value="<fmt:formatNumber value='${info.horseSheetIncome}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-3-2出栏生猪收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="pigIncome" id="pigIncome"
						   value="<fmt:formatNumber value='${info.pigIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;国家惠农补贴收入</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="stateSubsidies" id="stateSubsidies"
						   value="<fmt:formatNumber value='${info.stateSubsidies}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-3-3其他畜牧业收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="otherLivestockFarmingIncome" id="otherLivestockFarmingIncome"
						   value="<fmt:formatNumber value='${info.otherLivestockFarmingIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：退耕还林补贴</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="forestSubsidies" id="forestSubsidies"
						   value="<fmt:formatNumber value='${info.forestSubsidies}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-4出栏鸡、鸭、鹅收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="poultryIncome" id="poultryIncome"
						   value="<fmt:formatNumber value='${info.poultryIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;粮食补贴</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="foodstuffSubsidies" id="foodstuffSubsidies"
						   value="<fmt:formatNumber value='${info.foodstuffSubsidies}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-5养蚕收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="sericultureIncome" id="sericultureIncome"
						   value="<fmt:formatNumber value='${info.sericultureIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;良种补贴</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="seedSubsidies" id="seedSubsidies"
						   value="<fmt:formatNumber value='${info.seedSubsidies}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-6渔业收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="fisheryIncome" id="fisheryIncome"
						   value="<fmt:formatNumber value='${info.fisheryIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;农资综合补贴</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="comprehensiveSubsidies" id="comprehensiveSubsidies"
						   value="<fmt:formatNumber value='${info.comprehensiveSubsidies}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A50-2-7其他生产经营收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="otherProductionIncome" id="otherProductionIncome"
						   value="<fmt:formatNumber value='${info.otherProductionIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;农机具购置补贴</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="farmMachinerySubsidies" id="farmMachinerySubsidies"
						   value="<fmt:formatNumber value='${info.farmMachinerySubsidies}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;A50-3 财产性收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="propertyIncome" id="propertyIncome"
						   value="<fmt:formatNumber value='${info.propertyIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其他转移性收入</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="otherTransferIncome" id="otherTransferIncome"
						   value="<fmt:formatNumber value='${info.otherTransferIncome}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：土地转包、入股收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="landIncome" id="landIncome"
						   value="<fmt:formatNumber value='${info.landIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>A51 生产经营费用支出</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="productionExpense" id="productionExpense"
						   value="<fmt:formatNumber value='${info.productionExpense}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其他财产性收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="otherPropertyIncome" id="otherPropertyIncome"
						   value="<fmt:formatNumber value='${info.otherPropertyIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：购买化肥支出</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="fertilizerExpense" id="fertilizerExpense"
						   value="<fmt:formatNumber value='${info.fertilizerExpense}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;A50-4 转移性收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="transferIncome" id="transferIncome"
						   value="<fmt:formatNumber value='${info.transferIncome}' pattern='#0.##'/>"/></td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;购买农药支出</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="pesticideExpense" id="pesticideExpense"
						   value="<fmt:formatNumber value='${info.pesticideExpense}' pattern='#0.##'/>"/></td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其中：领取计划生育金（含“少生快富”和“奖励扶助”）</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="familyPlanning" id="familyPlanning"
						   value="<fmt:formatNumber value='${info.familyPlanning}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;种子支出</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="seedsExpense" id="seedsExpense"
						   value="<fmt:formatNumber value='${info.seedsExpense}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;领取养老保险金</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="endowmentInsurance" id="endowmentInsurance"
								value="<fmt:formatNumber value='${info.endowmentInsurance}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;租用农机具或请帮工支出</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="machineryExpense" id="machineryExpense"
						   value="<fmt:formatNumber value='${info.machineryExpense}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;边民生活补贴</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="livingAllowances" id="livingAllowances"
						   value="<fmt:formatNumber value='${info.livingAllowances}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其他生产经营费用支出</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="otherProductionExpense" id="otherProductionExpense"
						   value="<fmt:formatNumber value='${info.otherProductionExpense}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;最低生活保障收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="minLivingStandard" id="minLivingStandard"
						   value="<fmt:formatNumber value='${info.minLivingStandard}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>A52 家庭年纯收入</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="familyAnnualNetIncome" id="familyAnnualNetIncome"
						   value="<fmt:formatNumber value='${info.familyAnnualNetIncome}' pattern='#0.##'/>"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在外务工人员寄回带回收入</span></td>
				<td class="sec-td bg-white">
					<input type="text" maxlength="11" class="inp-left decimal" name="backIncome" id="backIncome"
						   value="<fmt:formatNumber value='${info.backIncome}' pattern='#0.##'/>"/>
				</td>
				<td class="sec-td"><span>A53 家庭年人均纯收入</span></td>
				<td class="fou-td bg-white">
					<input type="text" maxlength="11" class="inp-right decimal" name="perCapitaNetIncome" id="perCapitaNetIncome"
						   value="<fmt:formatNumber value='${info.perCapitaNetIncome}' pattern='#0.##'/>"/>
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


	</form:form>
			</div>
		</div>
</body>
</html>