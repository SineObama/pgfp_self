<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村 基本情况管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/pgfp/css/style.css"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();e
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
	<li class="active"><a href="${ctx}/record/countryBasic/form?id=${countryBasic.id}">村 基本情况<shiro:hasPermission name="record:countryBasic:edit">${not empty countryBasic.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:countryBasic:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li class="active">基本情况</li>
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
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${countryBasic.id}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${countryBasic.id}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${countryBasic.id}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${countryBasic.id}">两委班子情况</a></li>
	</ul>
	<div id="tab-1" class="content-detail">
		<form:form id="inputForm" modelAttribute="countryBasic" action="${ctx}/record/countryBasic/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="type" value="1"/>
			<sys:message content="${message}"/>
			<div class="control-group" style="float: left">
				<label class="control-label">村名  <font color="red">*</font>:</label>
				<div class="controls">
					<sys:treeselect id="area" name="area.id" value="${countryBasic.area.id}" labelName="area.name" labelValue="${countryBasic.area.name}"
									title="上级行政区划" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true" />
			</div>
			</div>
			<div class="control-group" style="float: left">
				<label class="control-label" style="width:100px;">归属年度  <font color="red">*</font>:</label>
				<div class="controls" style="margin-left: 100px">
					<input name="years" id="years" type="text"  maxlength="20" class="input-medium Wdate required"
						   value="<fmt:formatDate value="${countryBasic.yearsDate}" pattern="yyyy"/>"
						   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
				</div>
			</div>
			<div class="control-group" style="float: left"><input id="userQuery" class="btn btn-default" type="button" value="点击查询" style="background: #6196bb;color: #fff;text-shadow: none;margin-left: 50px;"/></div>
			<%--<li style="display: inline-block"><label style="width: 50px">年度：</label>--%>

			</li>
			<table>
				<tbody>
				<tr>
					<td class="fir-td" ><span>村负责人</span></td>
					<td class="sec-td bg-white">
						<form:input path="leader" htmlEscape="false" maxlength="20" class="input-xlarge"/>
					</td>
					<td class="thr-td"><span>40-49岁劳动力人数（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="worker2" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>村办公电话</span></td>
					<td class="sec-td bg-white">
						<form:input path="mobile" htmlEscape="false" maxlength="20" class="input-xlarge phoneChange" />
					</td>
					<td class="thr-td"><span>50-60岁劳动力人数（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="worker3" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>贫困村分类</span></td>
					<td class="sec-td bg-white">
							<%--<form:input path="category" htmlEscape="false" maxlength="11" class="input-xlarge"/>--%>
						<form:select path="category">
							<form:option value="" label="-----------"/>
							<form:options items="${fns:getDictList('Classification_poor_villages')}" itemValue="value" itemLabel="label"/>
						</form:select>
					</td>
					<td class="thr-td"><span>B6 女性劳动力人数（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b6WorkWom" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>贫困村属性</span></td>
					<td class="sec-td bg-white">
							<%--<form:input path="attribute" htmlEscape="false" maxlength="50" class="input-xlarge"/>--%>
						<form:select path="attribute" >
							<form:option value="" label="-----------"/>
							<form:options itemLabel="label" itemValue="value" items="${fns:getDictList('poor_village_property')}"/>
						</form:select>
					</td>
					<td class="thr-td"><span>B7 外出务工人数（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b7WorkOut" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>发展方向</span></td>
					<td class="sec-td bg-white">
							<%--<form:input path="direction" htmlEscape="false" maxlength="20" class="input-xlarge"/>--%>
						<form:select path="direction" >
							<form:option value="" label="-----------"/>
							<form:options items="${fns:getDictList('development_direction_attribute')}" itemLabel="label" itemValue="value"/>
						</form:select>
					</td>
					<td class="thr-td"><span>务工时间：外出务工半年以上1年以内（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="workOut1" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>地形地貌</span></td>
					<td class="sec-td bg-white">
						<form:select path="terrain">
							<form:option value="" label="-----------"/>
							<form:options items="${fns:getDictList('topographic_attributes')}" itemLabel="label" itemValue="value"/>
						</form:select>
					</td>
					<td class="thr-td"><span>外出务工1-5年（含1年）</span></td>
					<td class="fou-td bg-white">
						<form:input path="workOut2" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr class="tuopin-btn">
					<td class="fir-td"><span>脱贫时间  <font color="red">*</font></span></td>
					<!--<td class="sec-td"><input type="radio" name="tuopin-time" value="2016" checked><span>2016</span><input type="radio" name="tuopin-time" value="2017"><span>2017</span></td>-->
					<td class="sec-td bg-white">
						<input name="overpoorTime" id="overpoorTime" type="text"  maxlength="20" class="input-medium Wdate required"
							   value="<fmt:formatDate value="${countryBasic.yearDate}" pattern="yyyy"/>"
							   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
					</td>
					<td class="thr-td"><span>外出务工5年以上（含5年）</span></td>
					<td class="fou-td bg-white">
						<form:input path="workOut3" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr class="tez-btn">
					<td class="fir-td"><span>村特征（可复选）</span></td>
					<td class="sec-td bg-white" style="min-width:190px;">
						<form:checkboxes path="characteristicList" items="${fns:getDictList('country_cha')}" itemValue="value" itemlabel="label"/>
					</td>
					<td class="thr-td"><span>务工区域：乡（镇）外县内务工（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="townOut" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>中共党员数量（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="partyMember" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>大学生村官数量（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="stuVillagerOff" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>其他</span></td>
					<td class="sec-td bg-white">
						<form:input path="other" htmlEscape="false" maxlength="50" class="input-xlarge"/>
					</td>
					<td class="thr-td"><span>县外省内务工（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="countyOut" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B1 自然村（屯）数（个）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b1NatureVillage" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>省外务工（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="provinceOut" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B2 村民小组数（个）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b2VillagerGroup" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B8 文化程度：文盲或半文盲（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b8Illiteracy" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B3 总户数（户）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b3TotalHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>小学（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="primarysch" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>其中：B3-1 贫困户数（户）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b31PoorHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>初中（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="junior" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>其中：B3-1-1 一般贫困户（户）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b31ComPoor" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>高中、中职中专（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="highSecondary" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B3-1-2 有劳动能力的扶贫低保户（户）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b312LabHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>高职高专（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="vocational" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B3-1-3 无劳动能力的低保户（户）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b312NolabHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>大学及以上（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="university" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B3-2 低保户数（户）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b32LowHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B9 在校生情况：学前教育（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b9Preschool" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B3-3 五保户数（户）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b33FiveHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>小学在读（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="primarying" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B4 总人口数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b4TotalPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>初中在读（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="junioring" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>其中：B4-1 贫困人口数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b41PoorPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>高中、中职中专在读 （人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="highSecondaryIng" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>其中：B4-1-1 一般贫困人口数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b411ComPoorPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>高职高专在读（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="vocationaling" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B4-1-2 有劳动能力的扶贫低保人口数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b412LabPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>大学及以上在读 （人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="universitying" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B4-1-3 无劳动能力的低保人口数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b413NolabPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B10 耕地面积（亩）</span></td>
					<td class="fou-td bg-white">
						<input id="b10Cultivate" name="b10Cultivate" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;color: #555;text-align: center;" value="<fmt:formatNumber value="${countryBasic.b10Cultivate}" pattern="#0.##"/>" />
						<%--<form:input path="b10Cultivate" htmlEscape="false" maxlength="11" class="input-xlarge"/>--%>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B4-2 低保人口数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b42LowPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B10-1 水田面积（亩）</span></td>
					<td class="fou-td bg-white">
						<input id="b101Field" name="b101Field" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="color: #555;border: none;text-align: center;" value="<fmt:formatNumber value="${countryBasic.b101Field}" pattern="#0.##"/>" />
						<%--<form:input path="b101Field" htmlEscape="false" maxlength="11" class="input-xlarge"/>--%>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B4-3 五保人口数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b43FivePer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>其中：缺水灌溉面积（亩）</span></td>
					<td class="fou-td bg-white">
						<input id="needWater" name="needWater" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;color: #555;text-align: center;" value="<fmt:formatNumber value="${countryBasic.needWater}" pattern="#0.##"/>" />
						<%--<form:input path="needWater" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>--%>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B4-4 残疾人口数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b44Disabled" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B10-2 旱地面积（亩）</span></td>
					<td class="fou-td bg-white">
						<input id="b102Dryland" name="b102Dryland" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555;" value="<fmt:formatNumber value="${countryBasic.b102Dryland}" pattern="#0.##"/>" />
						<%--<form:input path="b102Dryland" htmlEscape="false" maxlength="11" class="input-xlarge"/>--%>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B4-5 少数民族人口数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b45Minority" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B11 林地面积（亩）</span></td>
					<td class="fou-td bg-white">
						<input id="b11Woodland" name="b11Woodland" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555;" value="<fmt:formatNumber value="${countryBasic.b11Woodland}" pattern="#0.##"/>" />
						<%--<form:input path="b11Woodland" htmlEscape="false" maxlength="11" class="input-xlarge"/>--%>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B4-6 妇女人口数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b46Woman" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>其中：退耕还林面积（亩）</span></td>
					<td class="fou-td bg-white">
						<%--<input id="reforest" name="reforest" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555;" value="<fmt:formatNumber value="${countryBasic.reforest}" pattern="#0.##"/>" />--%>
						<form:input path="reforest" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B4-7 留守儿童数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b47Children" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>林果面积（亩）</span></td>
					<td class="fou-td bg-white">
						<input id="treefruit" name="treefruit" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555;" value="<fmt:formatNumber value="${countryBasic.treefruit}" pattern="#0.##"/>" />
						<%--<form:input path="treefruit" htmlEscape="false" maxlength="11" class="input-xlarge"/>--%>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B4-8 空巢老人数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b48Oldman" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B12 荒山荒坡面积（亩）</span></td>
					<td class="fou-td bg-white">
						<input id="b12Undeveloped" name="b12Undeveloped" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555;" value="<fmt:formatNumber value="${countryBasic.b12Undeveloped}" pattern="#0.##"/>" />
						<%--<form:input path="b12Undeveloped" htmlEscape="false" maxlength="11" class="input-xlarge"/>--%>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B5 劳动力人数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b5TotalWorker" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B13 养殖水面面积（亩）</span></td>
					<td class="fou-td bg-white">
						<input id="b13Breed" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" name="b13Breed" value="<fmt:formatNumber value="${countryBasic.b13Breed}" pattern="#0.##"/>" />
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>其中：16-39岁劳动力人数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="worker1" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B14 牲畜（马、牛、驴、骡等）存栏数（头）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b14Livestock" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B15 生猪存栏数（头）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b15Pig" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B16 其他牲畜存栏数（头）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b16Other" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>二级及以上公立医院个数</span></td>
					<td class="sec-td bg-white">
						<form:input path="hospital" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td">是否脱贫村<span></span></td>
					<td class="fou-td bg-white">
						<form:radiobuttons path="isPoverCountry" items="${fns:getDictList('yes_no')}" itemValue="value" itemlabel="label"/>
						<%--<form:input path="isPoverCountry" htmlEscape="false" maxlength="20" class="input-xlarge int"/>--%>
					</td>
				</tr>

				</tbody>
				<!--<tfooter>-->
				<!--<tr>-->
				<!--<input type="submit" value="保存">-->
				<!--</tr>-->
				<!--</tfooter>-->
			</table>
			<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
		</form:form>

	</div>
	</div>

	<script>
		$(function () {
//			$('.tabs').tabslet({
//				animation: true,
//				active: 1
//			});
			$(".content-nav li").each(function () {
				$(this).click(function () {
					$(".header-rt").text($(this).text())
				})
			})
			var trHtml = '<tr><td class="bg-white"><input type="text"></td><td class="bg-white"><input type="text"></td><td class="bg-white"><input type="text"></td><td class="bg-white"><input type="text"></td><td class="bg-white"><input type="text"></td><td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td></tr>';
			$(".add-tr-btn").click(function(){
				$(this).parents("tbody").append(trHtml);
			})
			$("#tab-15").delegate(".del-thistd-btn","click",function(){
				$(this).parents("tr").remove()
			})
			$("#userQuery").click(function(){
				if($("#areaId")){
					var areaId = $("#areaId").val();
					var years = $dp.cal.date.y;
					$.ajax({
						url:'${ctx}/record/countryBasic/yearAndArea',
						data:{areaId:areaId,years:years},
						type:'post',
						async:false,
						success:function(countryBasicId){
							console.log(countryBasicId)
							if(countryBasicId != "") {
								console.trace()
								if(confirm("该村该年度数据已经存在，是否显示数据？")){
									window.location.href = "${ctx}/record/countryBasic/toHref?id="+countryBasicId;
								}
							}
							else{
								if(confirm("该村该年度还未有数据！是否刷新此页面？")){
									window.location.href = "${ctx}/record/countryBasic/toHref?id="+countryBasicId;
								}else{

								}
							}
						}
					})
				}
			})

		})
	</script>
</body>
</html>