<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户帮扶需求管理</title>
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
	<%--<li><a href="${ctx}/record/basePoorerHelpDetail/">贫困户帮扶需求列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/basePoorerHelpDetail/form?poorerRegCardId=${card.id}">贫困户帮扶需求<shiro:hasPermission name="record:basePoorerHelpDetail:edit">${not empty basePoorerHelpDetail.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:basePoorerHelpDetail:edit">查看</shiro:lacksPermission></a></li>
</ul>
<div class="header">
	<a href="" class="header-lt">贫困户建档立卡</a>
	<a href="" class="header-rt">帮扶需求</a>
</div>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/basePoorerRegCard/form?id=${card.id}">基本情况</a></li>
		<li><a href="${ctx}/record/basePoorerFamilyMember/form?poorerRegCardId=${card.id}">家庭成员</a></li>
		<li><a href="${ctx}/record/baseMemberTrainingStatus/form?cardId=${card.id}">家庭成员受培训情况</a></li>
		<li><a href="${ctx}/record/baseMemberWorkStatus/form?cardId=${card.id}">家庭成员就业情况</a> </li>
		<li><a href="${ctx}/bf/insuredSituation/form?poorerRegCardId=${card.id}">家庭成员参保情况</a></li>
		<li><a href="${ctx}/record/baseProductionLivingCondition/form?poorerRegCardId=${card.id}">生产生活条件</a></li>
		<li><a href="${ctx}/record/baseFamilyEconomicInfo/form?poorerRegCardId=${card.id}">家庭经济情况</a></li>
		<li><a href="${ctx}/record/baseRegCardBiz/form?regCardId=${card.id}">特色产业增收</a></li>
		<li class="active">帮扶需求</li>
		<li><a href="${ctx}/record/basePoorerSupportUnitInfo/form?poorerRegCardId=${card.id}">帮扶单位及责任人</a></li>
		<li><a href="${ctx}/record/basePoorerStudentHelpInfo/form?poorerRegCardId=${card.id}">家庭在校生受帮扶情况</a></li>
		<li><a href="${ctx}/record/basePoorerRegCard/tpPlan?id=${card.id}">填表记录</a></li>
	</ul>
	<div id="tab-15" class="content-detail">

		<form:form id="inputForm" modelAttribute="card" action="${ctx}/record/basePoorerHelpDetail/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="years"/>
			<%--<form:hidden path="poorerRegCardId"/>--%>
			<sys:message content="${message}"/>
		<br/>
		<table id="table">
			<tbody id="1">
			<%----%>
			<tr class="trTitle">
				<td rowspan="10" style="min-width:30px;">
					<input type="checkbox" name="isfirst" class="isfirst">  主要帮扶类别<br/>
					<input type="checkbox" name="isassist" class="isassist">辅助帮扶类别
				</td>
				<td rowspan="10" style="min-width: 15px !important;">扶持生产</td>
				<td colspan="2">分类</td>
				<td colspan="2">种类</td>
				<td style="min-width: 60px;">规模(数量)</td>
				<td style="min-width: 80px;">种养时间</td>
				<td>出产收入年月</td>
				<td>年收入(元)</td>
				<td >操作</td>
			</tr>
			<tr class="1_1_1">
				<td rowspan="4" colspan="2">
					种植
				</td>
				<td colspan="2" class="">
					<input type="hidden" name="" class="classify" value="1"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td style="min-width: 60px;"><input type="text" class="decimal1"/> </td>
				<td style="min-width: 80px;">
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							   style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>

				</td>
				<td><input type="text" class="string2"/></td>
				<td><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="1_1_2">
				<td colspan="2" class="">
					<input type="hidden" name="" class="classify" value="1"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td style="min-width: 60px;"><input type="text" class="decimal1"/> </td>
				<td style="min-width: 80px;" >
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
													  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
													  style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td ><input type="text" class="string2"/></td>
				<td ><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="1_1_3">
				<td colspan="2" class="">
					<input type="hidden" name="" class="classify" value="1"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td style="min-width: 60px;" ><input type="text" class="decimal1"/> </td>
				<td style="min-width: 80px;">
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td ><input type="text" class="string2"/></td>
				<td ><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="1_1_4">
				<td colspan="2" class="">
					<input type="hidden" name="" class="classify" value="1"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td style="min-width: 60px;"><input type="text" class="decimal1"/> </td>
				<td style="min-width: 80px;" >
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td ><input type="text" class="string2"/></td>
				<td><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>

			</tr>


			<tr>
				<td colspan="2" rowspan="3">
					养殖
				</td>
				<td colspan="2">
					<input type="hidden" name="" class="classify" value="1"/>
					<input type="hidden" name="" class="type" value="2"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td style="min-width: 60px;"><input type="text" class="decimal1"/> </td>
				<td style="min-width: 80px;">
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td ><input type="text" class="string2"/></td>
				<td ><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="1_2_1">
				<td colspan="2" >
					<input type="hidden" name="" class="classify" value="1"/>
					<input type="hidden" name="" class="type" value="2"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td style="min-width: 60px;"><input type="text" class="decimal1"/> </td>
				<td style="min-width: 80px;">
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td ><input type="text" class="string2"/></td>
				<td ><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="1_2_2">
				<td colspan="2" >
					<input type="hidden" name="" class="classify" value="1"/>
					<input type="hidden" name="" class="type" value="2"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td style="min-width: 60px;" ><input type="text" class="decimal1"/> </td>
				<td style="min-width: 80px;" >
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td ><input type="text" class="string2"/></td>
				<td ><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>

			<tr class="1_3_1">
				<td colspan="2" rowspan="2">
					其他
				</td>
				<td colspan="2" >
					<input type="hidden" name="" class="classify" value="1"/>
					<input type="hidden" name="" class="type" value="3"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td style="min-width: 60px;" ><input type="text" class="decimal1"/> </td>
				<td style="min-width: 80px;" >
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td ><input type="text" class="string2"/></td>
				<td ><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="1_3_2">
				<td colspan="2" >
					<input type="hidden" name="" class="classify" value="1"/>
					<input type="hidden" name="" class="type" value="3"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td style="min-width: 60px;" ><input type="text" class="decimal1"/> </td>
				<td style="min-width: 80px;" >
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td ><input type="text" class="string2"/></td>
				<td ><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
		</tbody>

			<tbody id="2">

				<%--转移就业--%>
			<tr class="trTitle">
				<td rowspan="4" style="min-width:30px;">
					<input type="checkbox" name="isfirst" class="isfirst">  主要帮扶类别<br/>
					<input type="checkbox" name="isassist" class="isassist">辅助帮扶类别
				</td>
				<td rowspan="4" style="min-width: 15px !important;">
					转移就业
				</td>
				<td colspan="2">
					分类
				</td>
				<td colspan="1" style="min-width: 80px;">
					就业人数
				</td>
				<td colspan="1" style="min-width: 60px;">年就业时间(月)</td>
				<td colspan="2">就业工种</td>
				<td colspan="2">年收入(元)</td>
				<td >操作</td>
			</tr>
			<tr class="2_1_1">
				<td colspan="2">
					临时工
				</td>
				<td colspan="1" style="min-width: 80px;" >
					<input type="hidden" name="" class="classify" value="2"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="decimal1"/>
				</td>
				<td colspan="1" style="min-width: 60px;" ><input type="text" class="decimal2"/> </td>
				<td colspan="2" ><input type="text" class="string1"/></td>
				<td colspan="2" ><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="2_2_1">
				<td colspan="2">
					季节工
				</td>
				<td colspan="1" style="min-width: 80px;" >
					<input type="hidden" name="" class="classify" value="2"/>
					<input type="hidden" name="" class="type" value="2"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="decimal1"/>
				</td>
				<td colspan="1" style="min-width: 60px;" ><input type="text" class="decimal2"/> </td>
				<td colspan="2" ><input type="text" class="string1"/></td>
				<td colspan="2" ><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="2_3_1">
				<td colspan="2">
					长期工
				</td>
				<td colspan="1" style="min-width: 80px;" >
					<input type="hidden" name="" class="classify" value="2"/>
					<input type="hidden" name="" class="type" value="3"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="decimal1"/>
				</td>
				<td colspan="1" style="min-width: 60px;" ><input type="text" class="decimal2"/> </td>
				<td colspan="2" ><input type="text" class="string1"/></td>
				<td colspan="2" ><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>

			</tbody>

			<tbody id="3" class="3_1_1">
				<%--移民搬迁--%>
			<tr >
				<td rowspan="3" style="min-width:30px;" class="tdTitle">
					<input type="checkbox" name="isfirst" class="isfirst">  主要帮扶类别<br/>
					<input type="checkbox" name="isassist" class="isassist">辅助帮扶类别
				</td>
				<td class="tdTitle" style="min-width: 15px !important;" colspan="1" rowspan="3">
					移民搬迁
				</td>
				<td colspan="2">是否意愿移民搬迁户</td>
				<td >
					<input type="hidden" name="" class="classify" value="3"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<%--<input type="text" class="string1">--%>
					<input type="radio" name="string1" value="0">否&nbsp;&nbsp;
					<input type="radio" name="string1" value="1">是
						<%--${fns:getDictLabel(detail.string1,'yes_no' ,'')}--%>
				</td>
				<td colspan="1">安置方式</td>
				<td colspan="4" >
					<%--<input type="text" class="string2"/>--%>
					<select class="string2" style="width:120px;">
						<option value="">------</option>
						<option value="1">集中安置</option>
						<option value="2">分散安置</option>
					</select>
				</td>
				<td rowspan="3"><a class="clear">清除</a></td>
			</tr>
			<tr>
				<td>安置类型</td>
				<td >
					<%--<input type="text" class="string3"/>--%>
					<select class="string3" style="width:120px;">
						<option value="">------</option>
						<option value="1">有地安置</option>
						<option value="2">无地安置</option>
					</select>
				</td>
				<td>搬迁原因</td>
				<td colspan="5" >
					<%--<input type="text" class="string4"/>--%>
					<select class="string4" style="width:120px;">
						<option value="">------</option>
						<option value="1">缺乏生存条件</option>
						<option value="2">生态脆弱</option>
						<option value="3">避灾避险</option>
						<option value="4">自然保护区</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>计划搬迁时间</td>
				<td >
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td>安置点名称</td>
				<td colspan="2" ><input type="text" class="string5"/> </td>
				<td>搬迁补助</td>
				<td colspan="2" ><input type="text" class="income decimal"/> </td>
			</tr>
			</tbody>

			<tbody id="4">
				<%--生态补偿--%>
			<tr class="trTitle">
				<td rowspan="4" style="min-width:30px;">
					<input type="checkbox" name="isfirst" class="isfirst">  主要帮扶类别<br/>
					<input type="checkbox" name="isassist" class="isassist">辅助帮扶类别
				</td>
				<td rowspan="4" style="min-width: 15px !important;">生态补偿</td>
				<td colspan="2">种类</td>
				<td colspan="2">面积</td>
				<td colspan="2">补偿金额(元)</td>
				<td colspan="2">补偿时间</td>
				<td >操作</td>
			</tr>
			<tr class="4_1_1">
				<td colspan="2">退耕还林</td>
				<td colspan="2" >
					<input type="hidden" name="" class="classify" value="4"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="decimal1"/>
				</td>
				<td colspan="2" ><input type="text" class="income decimal"/></td>
				<td colspan="2" >
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="4_2_1">
				<td colspan="2">公益林</td>
				<td colspan="2" >
					<input type="hidden" name="" class="classify" value="4"/>
					<input type="hidden" name="" class="type" value="2"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="decimal1"/>
				</td>
				<td colspan="2" ><input type="text" class="income decimal"/></td>
				<td colspan="2" >
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="4_3_1">
				<td colspan="2">其他</td>
				<td colspan="2" >
					<input type="hidden" name="" class="classify" value="4"/>
					<input type="hidden" name="" class="type" value="3"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="decimal1"/>
				</td>
				<td colspan="2" ><input type="text" class="income decimal"/></td>
				<td colspan="2" >
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td><a class="clear">清除</a></td>
			</tr>
			</tbody>

			<tbody id="5">
				<%--教育培训--%>
			<tr class="trTitle" >
				<td rowspan="22" style="min-width:30px;">
					<input type="checkbox" name="isfirst" class="isfirst">  主要帮扶类别<br/>
					<input type="checkbox" name="isassist" class="isassist">辅助帮扶类别
				</td>
				<td rowspan="22" style="min-width: 15px !important;">
					教育培训
				</td>
				<td>
					学生姓名
				</td>
				<td>类别</td>
				<td colspan="2">就业学校、年级</td>
				<td colspan="2">毕业时间</td>
				<td colspan="2">获得补助(元)</td>
				<td >操作</td>
			</tr>

			<tr class="5_1_1">
				<td>
					<input type="hidden" name="" class="classify" value="5"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>

				<td>
					<%--<input type="text" class="string2"/>--%>
						<select class="string2">
							<option value="">-----</option>
							<option value="1">幼儿园</option>
							<option value="2">小学</option>
							<option value="3">初中</option>
							<option value="4">高中</option>
							<option value="5">中职</option>
							<option value="6">高职</option>
							<option value="7">本科</option>
						</select>
				</td>
				<td colspan="2"><input type="text" class="string3"/></td>
				<td colspan="2">
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td colspan="2"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="5_1_2">
				<td>
					<input type="hidden" name="" class="classify" value="5"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>

				<td><select class="string2">
					<option value="">-----</option>
					<option value="1">幼儿园</option>
					<option value="2">小学</option>
					<option value="3">初中</option>
					<option value="4">高中</option>
					<option value="5">中职</option>
					<option value="6">高职</option>
					<option value="7">本科</option>
				</select></td>
				<td colspan="2"><input type="text" class="string3"/></td>
				<td colspan="2">
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td colspan="2"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="5_1_3">
				<td>
					<input type="hidden" name="" class="classify" value="5"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td><select class="string2">
					<option value="">-----</option>
					<option value="1">幼儿园</option>
					<option value="2">小学</option>
					<option value="3">初中</option>
					<option value="4">高中</option>
					<option value="5">中职</option>
					<option value="6">高职</option>
					<option value="7">本科</option>
				</select></td>
				<td colspan="2"><input type="text" class="string3"/></td>
				<td colspan="2">
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td colspan="2"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="5_1_4">
				<td>
					<input type="hidden" name="" class="classify" value="5"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td><select class="string2">
					<option value="">-----</option>
					<option value="1">幼儿园</option>
					<option value="2">小学</option>
					<option value="3">初中</option>
					<option value="4">高中</option>
					<option value="5">中职</option>
					<option value="6">高职</option>
					<option value="7">本科</option>
				</select></td>
				<td colspan="2"><input type="text" class="string3"/></td>
				<td colspan="2">
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td colspan="2"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
				<tr class="5_1_5">
					<td>
						<input type="hidden" name="" class="classify" value="5"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td><select class="string2">
						<option value="">-----</option>
						<option value="1">幼儿园</option>
						<option value="2">小学</option>
						<option value="3">初中</option>
						<option value="4">高中</option>
						<option value="5">中职</option>
						<option value="6">高职</option>
						<option value="7">本科</option>
					</select></td>
					<td colspan="2"><input type="text" class="string3"/></td>
					<td colspan="2">
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="5_1_6">
					<td>
						<input type="hidden" name="" class="classify" value="5"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td><select class="string2">
						<option value="">-----</option>
						<option value="1">幼儿园</option>
						<option value="2">小学</option>
						<option value="3">初中</option>
						<option value="4">高中</option>
						<option value="5">中职</option>
						<option value="6">高职</option>
						<option value="7">本科</option>
					</select></td>
					<td colspan="2"><input type="text" class="string3"/></td>
					<td colspan="2">
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="5_1_7">
					<td>
						<input type="hidden" name="" class="classify" value="5"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td><select class="string2">
						<option value="">-----</option>
						<option value="1">幼儿园</option>
						<option value="2">小学</option>
						<option value="3">初中</option>
						<option value="4">高中</option>
						<option value="5">中职</option>
						<option value="6">高职</option>
						<option value="7">本科</option>
					</select></td>
					<td colspan="2"><input type="text" class="string3"/></td>
					<td colspan="2">
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="5_1_8">
					<td>
						<input type="hidden" name="" class="classify" value="5"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td><select class="string2">
						<option value="">-----</option>
						<option value="1">幼儿园</option>
						<option value="2">小学</option>
						<option value="3">初中</option>
						<option value="4">高中</option>
						<option value="5">中职</option>
						<option value="6">高职</option>
						<option value="7">本科</option>
					</select></td>
					<td colspan="2"><input type="text" class="string3"/></td>
					<td colspan="2">
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="5_1_9">
					<td>
						<input type="hidden" name="" class="classify" value="5"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td><select class="string2">
						<option value="">-----</option>
						<option value="1">幼儿园</option>
						<option value="2">小学</option>
						<option value="3">初中</option>
						<option value="4">高中</option>
						<option value="5">中职</option>
						<option value="6">高职</option>
						<option value="7">本科</option>
					</select></td>
					<td colspan="2"><input type="text" class="string3"/></td>
					<td colspan="2">
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="5_1_10">
					<td>
						<input type="hidden" name="" class="classify" value="5"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td><select class="string2">
						<option value="">-----</option>
						<option value="1">幼儿园</option>
						<option value="2">小学</option>
						<option value="3">初中</option>
						<option value="4">高中</option>
						<option value="5">中职</option>
						<option value="6">高职</option>
						<option value="7">本科</option>
					</select></td>
					<td colspan="2"><input type="text" class="string3"/></td>
					<td colspan="2">
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
			<tr class="trTitle" >
				<td>
					受培训人姓名
				</td>
				<td>天数(天)</td>
				<td colspan="2">培训内容</td>
				<td colspan="2">培训地点</td>
				<td>培训单位、形式</td>
				<td>培训金额(元)</td>
				<td >操作</td>
			</tr>

			<tr class="5_2_1">
				<td>
					<input type="hidden" name="" class="classify" value="5"/>
					<input type="hidden" name="" class="type" value="2"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td><input type="text" class="decimal1"/></td>
				<td colspan="2"><input type="text" class="string2"/></td>
				<td colspan="2"><input type="text" class="string3"/></td>
				<td><input type="text" class="string4"/></td>
				<td><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="5_2_2">
				<td>
					<input type="hidden" name="" class="classify" value="5"/>
					<input type="hidden" name="" class="type" value="2"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td><input type="text" class="decimal1"/></td>
				<td colspan="2"><input type="text" class="string2"/></td>
				<td colspan="2"><input type="text" class="string3"/></td>
				<td><input type="text" class="string4"/></td>
				<td><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="5_2_3">
				<td>
					<input type="hidden" name="" class="classify" value="5"/>
					<input type="hidden" name="" class="type" value="2"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td><input type="text" class="decimal1"/></td>
				<td colspan="2"><input type="text" class="string2"/></td>
				<td colspan="2"><input type="text" class="string3"/></td>
				<td><input type="text" class="string4"/></td>
				<td><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="5_2_4">
				<td>
					<input type="hidden" name="" class="classify" value="5"/>
					<input type="hidden" name="" class="type" value="2"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td><input type="text" class="decimal1"/></td>
				<td colspan="2"><input type="text" class="string2"/></td>
				<td colspan="2"><input type="text" class="string3"/></td>
				<td><input type="text" class="string4"/></td>
				<td><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr><tr class="5_2_5">
					<td>
						<input type="hidden" name="" class="classify" value="5"/>
						<input type="hidden" name="" class="type" value="2"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td><input type="text" class="decimal1"/></td>
					<td colspan="2"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="string3"/></td>
					<td><input type="text" class="string4"/></td>
					<td><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="5_2_6">
					<td>
						<input type="hidden" name="" class="classify" value="5"/>
						<input type="hidden" name="" class="type" value="2"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td><input type="text" class="decimal1"/></td>
					<td colspan="2"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="string3"/></td>
					<td><input type="text" class="string4"/></td>
					<td><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="5_2_7">
					<td>
						<input type="hidden" name="" class="classify" value="5"/>
						<input type="hidden" name="" class="type" value="2"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td><input type="text" class="decimal1"/></td>
					<td colspan="2"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="string3"/></td>
					<td><input type="text" class="string4"/></td>
					<td><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="5_2_8">
					<td>
						<input type="hidden" name="" class="classify" value="5"/>
						<input type="hidden" name="" class="type" value="2"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td><input type="text" class="decimal1"/></td>
					<td colspan="2"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="string3"/></td>
					<td><input type="text" class="string4"/></td>
					<td><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="5_2_9">
					<td>
						<input type="hidden" name="" class="classify" value="5"/>
						<input type="hidden" name="" class="type" value="2"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td><input type="text" class="decimal1"/></td>
					<td colspan="2"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="string3"/></td>
					<td><input type="text" class="string4"/></td>
					<td><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="5_2_10">
					<td>
						<input type="hidden" name="" class="classify" value="5"/>
						<input type="hidden" name="" class="type" value="2"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td><input type="text" class="decimal1"/></td>
					<td colspan="2"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="string3"/></td>
					<td><input type="text" class="string4"/></td>
					<td><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
			</tbody>

			<tbody id="6">
				<%--医疗救助--%>
			<tr class="trTitle">
				<td rowspan="11" style="min-width:30px;">
					<input type="checkbox" name="isfirst" class="isfirst">  主要帮扶类别<br/>
					<input type="checkbox" name="isassist" class="isassist">辅助帮扶类别
				</td>
				<td rowspan="11" style="min-width: 15px !important;">医疗救助</td>
				<td colspan="2">患者姓名</td>
				<td colspan="2">患病种类</td>
				<td>患病时间</td>
				<td colspan="2">救助途径</td>
				<td colspan="1">救助金额(元)</td>
				<td >操作</td>
			</tr>
			<tr class="6_1_1">
				<td colspan="2">
					<input type="hidden" name="" class="classify" value="6"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td colspan="2"><input type="text" class="string2"/></td>
				<td>
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td colspan="2">
					<select class="string3"  style="width:180px;">
						<option value="">------------------</option>
						<option value="1">资助参加医保（新农合）</option>
						<option value="2">医保（新农合）补偿</option>
						<option value="3">大病保险赔付</option>
						<option value="4">疾病应急救助</option>
						<option value="5">医疗救助（民政救助）</option>
						<option value="6">社会捐助</option>
						<option value="7">其他</option>

					</select>

				</td>
				<td colspan="1"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="6_1_2">
				<td colspan="2">
					<input type="hidden" name="" class="classify" value="6"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td colspan="2"><input type="text" class="string2"/></td>
				<td>
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td colspan="2"><select class="string3"  style="width:180px;">
					<option value="">------------------</option>
					<option value="1">资助参加医保（新农合）</option>
					<option value="2">医保（新农合）补偿</option>
					<option value="3">大病保险赔付</option>
					<option value="4">疾病应急救助</option>
					<option value="5">医疗救助（民政救助）</option>
					<option value="6">社会捐助</option>
					<option value="7">其他</option>

				</select></td>
				<td colspan="1"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="6_1_3">
				<td colspan="2">
					<input type="hidden" name="" class="classify" value="6"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td colspan="2"><input type="text" class="string2"/></td>
				<td>
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td colspan="2"><select class="string3"  style="width:180px;">
					<option value="">------------------</option>
					<option value="1">资助参加医保（新农合）</option>
					<option value="2">医保（新农合）补偿</option>
					<option value="3">大病保险赔付</option>
					<option value="4">疾病应急救助</option>
					<option value="5">医疗救助（民政救助）</option>
					<option value="6">社会捐助</option>
					<option value="7">其他</option>

				</select></td>
				<td colspan="1"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
				<tr class="6_1_4">
					<td colspan="2">
						<input type="hidden" name="" class="classify" value="6"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="2"><input type="text" class="string2"/></td>
					<td>
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td colspan="2"><select class="string3"  style="width:180px;">
						<option value="">------------------</option>
						<option value="1">资助参加医保（新农合）</option>
						<option value="2">医保（新农合）补偿</option>
						<option value="3">大病保险赔付</option>
						<option value="4">疾病应急救助</option>
						<option value="5">医疗救助（民政救助）</option>
						<option value="6">社会捐助</option>
						<option value="7">其他</option>

					</select></td>
					<td colspan="1"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="6_1_5">
					<td colspan="2">
						<input type="hidden" name="" class="classify" value="6"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="2"><input type="text" class="string2"/></td>
					<td>
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td colspan="2"><select class="string3"  style="width:180px;">
						<option value="">------------------</option>
						<option value="1">资助参加医保（新农合）</option>
						<option value="2">医保（新农合）补偿</option>
						<option value="3">大病保险赔付</option>
						<option value="4">疾病应急救助</option>
						<option value="5">医疗救助（民政救助）</option>
						<option value="6">社会捐助</option>
						<option value="7">其他</option>

					</select></td>
					<td colspan="1"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="6_1_6">
					<td colspan="2">
						<input type="hidden" name="" class="classify" value="6"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="2"><input type="text" class="string2"/></td>
					<td>
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td colspan="2"><select class="string3"  style="width:180px;">
						<option value="">------------------</option>
						<option value="1">资助参加医保（新农合）</option>
						<option value="2">医保（新农合）补偿</option>
						<option value="3">大病保险赔付</option>
						<option value="4">疾病应急救助</option>
						<option value="5">医疗救助（民政救助）</option>
						<option value="6">社会捐助</option>
						<option value="7">其他</option>

					</select></td>
					<td colspan="1"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="6_1_7">
					<td colspan="2">
						<input type="hidden" name="" class="classify" value="6"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="2"><input type="text" class="string2"/></td>
					<td>
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td colspan="2"><select class="string3"  style="width:180px;">
						<option value="">------------------</option>
						<option value="1">资助参加医保（新农合）</option>
						<option value="2">医保（新农合）补偿</option>
						<option value="3">大病保险赔付</option>
						<option value="4">疾病应急救助</option>
						<option value="5">医疗救助（民政救助）</option>
						<option value="6">社会捐助</option>
						<option value="7">其他</option>

					</select></td>
					<td colspan="1"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="6_1_8">
					<td colspan="2">
						<input type="hidden" name="" class="classify" value="6"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="2"><input type="text" class="string2"/></td>
					<td>
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td colspan="2"><select class="string3"  style="width:180px;">
						<option value="">------------------</option>
						<option value="1">资助参加医保（新农合）</option>
						<option value="2">医保（新农合）补偿</option>
						<option value="3">大病保险赔付</option>
						<option value="4">疾病应急救助</option>
						<option value="5">医疗救助（民政救助）</option>
						<option value="6">社会捐助</option>
						<option value="7">其他</option>

					</select></td>
					<td colspan="1"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="6_1_9">
					<td colspan="2">
						<input type="hidden" name="" class="classify" value="6"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="2"><input type="text" class="string2"/></td>
					<td>
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td colspan="2"><select class="string3"  style="width:180px;">
						<option value="">------------------</option>
						<option value="1">资助参加医保（新农合）</option>
						<option value="2">医保（新农合）补偿</option>
						<option value="3">大病保险赔付</option>
						<option value="4">疾病应急救助</option>
						<option value="5">医疗救助（民政救助）</option>
						<option value="6">社会捐助</option>
						<option value="7">其他</option>

					</select></td>
					<td colspan="1"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="6_1_10">
					<td colspan="2">
						<input type="hidden" name="" class="classify" value="6"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="2"><input type="text" class="string2"/></td>
					<td>
						<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td colspan="2"><select class="string3"  style="width:180px;">
						<option value="">------------------</option>
						<option value="1">资助参加医保（新农合）</option>
						<option value="2">医保（新农合）补偿</option>
						<option value="3">大病保险赔付</option>
						<option value="4">疾病应急救助</option>
						<option value="5">医疗救助（民政救助）</option>
						<option value="6">社会捐助</option>
						<option value="7">其他</option>

					</select></td>
					<td colspan="1"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
			</tbody>

			<tbody id="7">
				<%--低保救助--%>
			<tr class="trTitle">
				<td rowspan="11" style="min-width:30px;">
					<input type="checkbox" name="isfirst" class="isfirst">  主要帮扶类别<br/>
					<input type="checkbox" name="isassist" class="isassist">辅助帮扶类别
				</td>
				<td rowspan="11" style="min-width: 15px !important;">低保救助</td>
				<td colspan="3">低保人姓名</td>
				<td colspan="3">享受低保起始月份</td>
				<td colspan="2">年享受低保总额(元)</td>
				<td >操作</td>
			</tr>
			<tr class="7_1_1">
				<td colspan="3">
					<input type="hidden" name="" class="classify" value="7"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td colspan="3"><input type="text" class="string2"/></td>
				<td colspan="2"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="7_1_2">
				<td colspan="3">
					<input type="hidden" name="" class="classify" value="7"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td colspan="3"><input type="text" class="string2"/></td>
				<td colspan="2"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="7_1_3">
				<td colspan="3">
					<input type="hidden" name="" class="classify" value="7"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td colspan="3"><input type="text" class="string2"/></td>
				<td colspan="2"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="7_1_4">
				<td colspan="3">
					<input type="hidden" name="" class="classify" value="7"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td colspan="3"><input type="text" class="string2"/></td>
				<td colspan="2"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="7_1_5">
				<td colspan="3">
					<input type="hidden" name="" class="classify" value="7"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td colspan="3"><input type="text" class="string2"/></td>
				<td colspan="2"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
				</tr>
				<tr class="7_1_6">
					<td colspan="3">
						<input type="hidden" name="" class="classify" value="7"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="3"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="7_1_7">
					<td colspan="3">
						<input type="hidden" name="" class="classify" value="7"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="3"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="7_1_8">
					<td colspan="3">
						<input type="hidden" name="" class="classify" value="7"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="3"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="7_1_9">
					<td colspan="3">
						<input type="hidden" name="" class="classify" value="7"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="3"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="7_1_10">
					<td colspan="3">
						<input type="hidden" name="" class="classify" value="7"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="3"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
			</tbody>

			<tbody id="8">
				<%--养老金、高龄补贴等--%>
			<tr class="trTitle">
				<td rowspan="11" style="min-width:30px;">
					<input type="checkbox" name="isfirst" class="isfirst">  主要帮扶类别<br/>
					<input type="checkbox" name="isassist" class="isassist">辅助帮扶类别
				</td>
				<td rowspan="11" style="min-width: 15px !important;">养老金、高龄补贴等</td>
				<td colspan="3">享受补贴人姓名</td>
				<td colspan="3">享受补贴起始月份</td>
				<td colspan="2">年享受补贴总额(元)</td>
				<td >操作</td>
			</tr>
			<tr class="8_1_1">
				<td colspan="3">
					<input type="hidden" name="" class="classify" value="8"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td colspan="3"><input type="text" class="string2"/></td>
				<td colspan="2"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="8_1_2">
				<td colspan="3">
					<input type="hidden" name="" class="classify" value="8"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td colspan="3"><input type="text" class="string2"/></td>
				<td colspan="2"><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
				<tr class="8_1_3">
					<td colspan="3">
						<input type="hidden" name="" class="classify" value="8"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="3"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="8_1_4">
					<td colspan="3">
						<input type="hidden" name="" class="classify" value="8"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="3"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="8_1_5">
					<td colspan="3">
						<input type="hidden" name="" class="classify" value="8"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="3"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="8_1_6">
					<td colspan="3">
						<input type="hidden" name="" class="classify" value="8"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="3"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="8_1_7">
					<td colspan="3">
						<input type="hidden" name="" class="classify" value="8"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="3"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="8_1_8">
					<td colspan="3">
						<input type="hidden" name="" class="classify" value="8"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="3"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="8_1_9">
					<td colspan="3">
						<input type="hidden" name="" class="classify" value="8"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="3"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
				<tr class="8_1_10">
					<td colspan="3">
						<input type="hidden" name="" class="classify" value="8"/>
						<input type="hidden" name="" class="type" value="1"/>
						<input type="hidden" name="" class="isfirsthelp"/>
						<input type="hidden" class="isassisthelp"/>
						<input type="hidden" class="id"/>
						<input type="text" class="string1"/>
					</td>
					<td colspan="3"><input type="text" class="string2"/></td>
					<td colspan="2"><input type="text" class="income decimal"/></td>
					<td><a class="clear">清除</a></td>
				</tr>
			</tbody>

			<tbody id="9">
				<%--边贸政策--%>
			<tr class="trTitle">
				<td rowspan="3" style="min-width:30px;">
					<input type="checkbox" name="isfirst" class="isfirst">  主要帮扶类别<br/>
					<input type="checkbox" name="isassist" class="isassist">辅助帮扶类别
				</td>
				<td rowspan="3" style="min-width: 15px !important;">边贸政策</td>
				<td colspan="2">种类</td>
				<td colspan="2">年营业额(元)</td>
				<td colspan="2">年收入(元)</td>
				<td colspan="2">免税金额(元)</td>
				<td >操作</td>
			</tr>
			<tr class="9_1_1">
				<td colspan="2">
					<input type="hidden" name="" class="classify" value="9"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td colspan="2"><input type="text" class="decimal1"/></td>
				<td colspan="2"><input type="text" class="income decimal"/></td>
				<td colspan="2"><input type="text" class="decimal2"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="9_1_2">
				<td colspan="2">
					<input type="hidden" name="" class="classify" value="9"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td colspan="2"><input type="text" class="decimal1"/></td>
				<td colspan="2"><input type="text" class="income decimal"/></td>
				<td colspan="2"><input type="text" class="decimal2"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			</tbody>

			<tbody id="10">
				<%--金融扶持--%>
			<tr class="trTitle">
				<td rowspan="4" style="min-width:30px;">
					<input type="checkbox" name="isfirst" class="isfirst">  主要帮扶类别<br/>
					<input type="checkbox" name="isassist" class="isassist">辅助帮扶类别
				</td>
				<td rowspan="4" style="min-width: 15px !important;">金融扶持</td>
				<td colspan="1">种类</td>
				<td colspan="1">贷款名称</td>
				<td>贷款用途</td>
				<td>贷款金额(元)</td>
				<td>贴息(元)</td>
				<td>借贷时间</td>
				<td>还贷时间</td>
				<td>年度获得收入(元)</td>
				<td >操作</td>
			</tr>

			<tr class="10_1_1">
				<td>小额信贷</td>
				<td>
					<input type="hidden" name="" class="classify" value="10"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td><input type="text" class="string2"/></td>
				<td><input type="text" class="decimal1"/></td>
				<td><input type="text" class="decimal2"/></td>
				<td>
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td>
					<input  name = "date2" type="text" readonly="readonly" maxlength="20" class="date2 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="10_2_1">
				<td rowspan="2">其他</td>
				<td>
					<input type="hidden" name="" class="classify" value="10"/>
					<input type="hidden" name="" class="type" value="2"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td><input type="text" class="string2"/></td>
				<td><input type="text" class="decimal1"/></td>
				<td><input type="text" class="decimal2"/></td>
				<td>
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td>
					<input  name = "date2" type="text" readonly="readonly" maxlength="20" class="date2 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			<tr class="10_2_2">
				<td>
					<input type="hidden" name="" class="classify" value="10"/>
					<input type="hidden" name="" class="type" value="2"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
				</td>
				<td><input type="text" class="string2"/></td>
				<td><input type="text" class="decimal1"/></td>
				<td><input type="text" class="decimal2"/></td>
				<td>
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td>
					<input  name = "date2" type="text" readonly="readonly" maxlength="20" class="date2 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>
			</tbody>

			<tbody id="11">
				<%--危房改造--%>
			<tr class="trTitle">
				<td rowspan="2" style="min-width:30px;">
					<input type="checkbox" name="isfirst" class="isfirst">  主要帮扶类别<br/>
					<input type="checkbox" name="isassist" class="isassist">辅助帮扶类别
				</td>
				<td rowspan="2" style="min-width: 15px !important;">危房改造</td>
				<td>类型</td>
				<td colspan="2">改造面积(平方米)</td>
				<td colspan="2">改造时间</td>
				<td colspan="2">改造完成时间</td>
				<td>补助金额(元)</td>
				<td >操作</td>
			</tr>
			<tr class="11_1_1">
				<td>
					<input type="hidden" name="" class="classify" value="11"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<%--<input type="text" class="type"/>--%>
					<select class="string1">
						<option value="">------------</option>
						<option value="1">修缮加固</option>
						<option value="2">原址翻建</option>
						<option value="3">异地非集中新建</option>
						<option value="4">异地相对集中新建</option>
						<option value="5">房屋置换</option>
					</select>
				</td>
				<td colspan="2"><input type="text" class="decimal1"/></td>
				<td colspan="2">
					<input  name = "date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td colspan="2">
					<input  name = "date2" type="text" readonly="readonly" maxlength="20" class="date2 input-medium Wdate "
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
							style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td><input type="text" class="income decimal"/></td>
				<td><a class="clear">清除</a></td>
			</tr>

			</tbody>

			<tbody id="12">
			<%--其他--%>
			<tr class="12_1_1">
				<td style="min-width:30px;" class="tdTitle">
					<input type="checkbox" name="isfirst" class="isfirst">  主要帮扶类别<br/>
					<input type="checkbox" name="isassist" class="isassist">辅助帮扶类别
				</td>
				<td class="tdTitle" style="min-width: 15px !important;">其他</td>
				<td colspan="8" >
					<input type="hidden" name="" class="classify" value="12"/>
					<input type="hidden" name="" class="type" value="1"/>
					<input type="hidden" name="" class="isfirsthelp"/>
					<input type="hidden" class="isassisthelp"/>
					<input type="hidden" class="id"/>
					<input type="text" class="string1"/>
					<%--<input type="text" class="string2" value="other"/>--%>
				</td>
				<td><a class="clear">清除</a></td>
			</tr>
			</tbody>
		</table>
		<style>
			.trTitle td , .tdTitle{
				font-size: 12px;
				font-weight: bold;
				text-align: center;
				min-width: 60px;
			}
			td{
				min-width: 60px !important;
			}
		</style>
		<div class="content-save">
			<shiro:hasPermission name="record:basePoorerRegCard:edit">
				<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="button" value="保 存"/>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
		</div>
		</form:form>

		<script>
			var card = ${fns:toJson(card)};
			var datailList = card.details2;
			var ctx = ${fns:toJson(ctx)};
//			alert(ctx);
			$(document).ready(function(){
				//设置所有输入框和选择框默认为不可用
				var inputs = document.getElementsByTagName('input');
				for(var i = 0, len = inputs.length; i < len ; i++){
					if(inputs[i].type == "text") {
						inputs[i].disabled = true;
					}
				}
				var selects = document.getElementsByTagName('select');
				for(var i = 0, len = selects.length; i< len ; i++){
					selects[i].disabled = true;
				}
				//设置所有输入框和选择框默认为不可用  ----结束


				//设置数据回显
				if(datailList != null && datailList.length > 0){
					for(var i = 0, len = datailList.length ; i< len ; i++){//循环
						var da = datailList[i];
						var	id=da.id,
							classify=da.classify,
							type=da.type,
							string1=da.string1 ,
							string2=da.string2 ,
							string3=da.string3 ,
							string4=da.string4 ,
							string5=da.string5 ,
							decimal1=da.decimal1,
							decimal2=da.decimal2,
							date1=da.date1,
							date2=da.date2,
							isassisthelp=da.isassisthelp,
							isfirsthelp=da.isfirsthelp,
							income = da.income;
						//找到对应的tbody
						var tbody = $(document).find("#"+classify);
						//把tbody下面所有的input select改成可输入
						tbody.find("input[type='text']").each(function(){
							$(this).removeAttr("disabled");
							$(this).parent().addClass("bg-white");
						});
						tbody.find("select").each(function(){
							$(this).removeAttr("disabled");
							$(this).parent().addClass("bg-white");
						});
						//所有的是否都给勾上
						if(isfirsthelp == 'on'){
							tbody.find('.isfirst').attr("checked",true);
						}
						if(isassisthelp == 'on'){
							tbody.find('.isassist').attr("checked",true);
						}


						var  j = 1 ;
						var tr = $(document).find("."+classify+"_"+type+"_"+j);
						if(tr.length > 0){
							while(1 == 1){
								if(tr.find(".string1").val() == null || tr.find(".string1").val().trim() == ''){
									break;
								}
								j++;
								tr = $(document).find("."+classify+"_"+type+"_"+j);
							}
						}

						tr.find(".id").val(id);
						tr.find(".classify").val(classify);
						tr.find(".type").val(type);
						tr.find(".type option[value='"+type+"']").attr('selected',true);
						tr.find(".string1").val(string1);
						tr.find("input[name=string1]:eq("+string1+")").attr("checked",'checked');
//						console.debug(tr.find(".string1").val());
						tr.find(".string1 option[value='"+string1+"']").attr('selected',true);
						tr.find(".string2").val(string2);
						tr.find(".string2 option[value='"+string2+"']").attr('selected',true);
						tr.find(".string3").val(string3);
						tr.find(".string3 option[value='"+string3+"']").attr('selected',true);
						tr.find(".string4").val(string4);
						tr.find(".string4 option[value='"+string4+"']").attr('selected',true);
						tr.find(".string5").val(string5);
						tr.find(".string5 option[value='"+string5+"']").attr('selected',true);
						tr.find(".decimal1").val(decimal1);
						tr.find(".decimal2").val(decimal2);
						tr.find(".date1").val(date1);
						tr.find(".date2").val(date2);
						tr.find(".isassisthelp").val(isassisthelp);
						tr.find(".isfirsthelp").val(isfirsthelp);
						tr.find(".income").val(income);
						$("select").select2();
					}

				}

				$("select").select2();

				//设置回显 -----结束
			});

			$(document).ready(function(){
				//点击主要类型时
				$(".isfirst").click(function(){
					ableOrNot($(this) ,".isfirsthelp");
				});

				//点击辅助类型时
				$(".isassist").click(function(){
					ableOrNot($(this) ,".isassisthelp");
				});

				//点击保存时
				$("#btnSubmit").click(function(){
					var details2 = eval('('+'[]'+')');
					//获取所有的多选按钮
					var checkboxes = $("#table").find("input[type='checkbox']");
					checkboxes.each(function(){//循环判断
						if($(this).prop("checked")){//如果多选按钮被选中
							var tbody = $(this).parents("tbody");//找到被选中的多选按钮他所在的tbody
							if(tbody.find(".classify").val() == "12"){ // 其他
								var classify = tbody.find(".classify").val();
								var id = tbody.find(".id").val();
								var string1 = tbody.find(".string1").val();
								var type = tbody.find(".type").val();
								var isassisthelp = tbody.find(".isassisthelp").val();
								var isfirsthelp = tbody.find(".isfirsthelp").val();
								var detail = {
									"id":id,
									"classify":classify,
									"type":type,
									"string1":string1 ,
									"isassisthelp":isassisthelp,
									"isfirsthelp":isfirsthelp
								};
								details2.push(detail);//把detail放进去到list中
							} else if(tbody.find(".classify").length == 1){
								//如果是移民搬迁或危房改造
								var id = tbody.find(".id").val();
								var string1 = tbody.find("input[name='string1']:checked").val();
								if(string1 == null || string1 == ''){
									string1 = tbody.find(".string1").find("option:selected").val();
								}
//								console.debug(string1);
								var string2 = tbody.find(".string2").val();
								if(string2 == null || string2 == ''){
									string2 = tbody.find(".string2 option:selected").val();
								}
								var string3 = tbody.find(".string3").val();
								if(string3 == null || string3 == ''){
									string3 = tbody.find(".string3 option:selected").val();
								}
								var string4 = tbody.find(".string4").val();
								if(string4 == null || string4 == ''){
									string4 = tbody.find(".string4 option:selected").val();
								}
								var string5 = tbody.find(".string5").val();

								var decimal1 = tbody.find(".decimal1").val();
								var decimal2 = tbody.find(".decimal2").val();

								var date1 = tbody.find(".date1").val();
								var date2 = tbody.find(".date2").val();

								var classify = tbody.find(".classify").val();
								var type = tbody.find(".type").val();
								var isfirsthelp = tbody.find(".isfirsthelp").val();
								var isassisthelp = tbody.find(".isassisthelp").val();
								var income = tbody.find(".income").val();
								var detail = {
									"id":id,
									"classify":classify,
									"type":type,
									"string1":string1 ,
									"string2":string2 ,
									"string3":string3 ,
									"string4":string4 ,
									"string5":string5 ,
									"decimal1":decimal1,
									"decimal2":decimal2,
									"date1":date1,
									"date2":date2,
									"isassisthelp":isassisthelp,
									"isfirsthelp":isfirsthelp,
									"income":income
								};
								details2.push(detail);//把detail放进去到list中
							} else {
								tbody.find("tr").each(function(){//循环tbody下面的每一行
									//如果不是移民搬迁和危房改造
									var string1 = $(this).find(".string1").val();
									if(string1 == null || string1 == ''){
										string1 = $(this).find(".string1 option:selected").text();
									}
									if( string1 != null && string1 != ''){//如果下面这一行的string1的input不为空
										//在这里循环拼接出提交的记录
										var id = $(this).find(".id").val();
										var string2 = $(this).find(".string2").val();
										if(string2 == null || string2 == ''){
											string2 = $(this).find(".string2 option:selected").val();
										}
										var string3 = $(this).find(".string3").val();
										if(string3 == null || string3 == ''){
											string3 = $(this).find(".string3 option:selected").val();
										}
										var string4 = $(this).find(".string4").val();
										if(string4 == null || string4 == ''){
											string4 = $(this).find(".string4 option:selected").val();
										}
										var string5 = $(this).find(".string5").val();

										var decimal1 = $(this).find(".decimal1").val();
										var decimal2 = $(this).find(".decimal2").val();

										var date1 = $(this).find(".date1").val();
										var date2 = $(this).find(".date2").val();

										var classify = $(this).find(".classify").val();
										var type = $(this).find(".type").val();
										var isassisthelp = $(this).find(".isassisthelp").val();
										var isfirsthelp = $(this).find(".isfirsthelp").val();

										var income = $(this).find(".income").val();
										var detail = {
											"id":id,
											"classify":classify,
											"type":type,
											"string1":string1 ,
											"string2":string2 ,
											"string3":string3 ,
											"string4":string4 ,
											"string5":string5 ,
											"decimal1":decimal1,
											"decimal2":decimal2,
											"date1":date1,
											"date2":date2,
											"isassisthelp":isassisthelp,
											"isfirsthelp":isfirsthelp,
											"income":income
										};
										details2.push(detail);//把detail放进去到list中
									}

								});
							}
						}
					});

					//在这里提交
					$.ajax({
						type: 'POST',
						url: ctx+"/record/basePoorerHelpDetail/save",
						data: {regCardId:card.id , details2 : JSON.stringify(details2)},
						dataType: "JSON",
						success: function(msg){
							if(msg.responseText == 'success'){
								location.href = ctx+"/record/basePoorerHelpDetail/form?poorerRegCardId="+card.id;
							} else {
								alert(msg.responseText);
							}
						},
						error:function(msg){
							alert("error:"+JSON.stringify(msg));
						}
					});
				});
				//保存结束
				//清除
				$('.clear').click(function(){
//					alert('sd');
					var tr = $(this).parents("tr");
					if(tr.find(".classify").val() == "3"){
						var tbody = tr.parents("tbody");
						tbody.find(".string1").val("");
						tbody.find(".string2").val("");
						tbody.find(".string3").val("");
						tbody.find(".string5").val("");
						tbody.find(".string4").val("");
						tbody.find(".decimal1").val("");
						tbody.find(".decimal2").val("");
						tbody.find(".date1").val("");
						tbody.find(".date2").val("");
						tbody.find(".isassisthelp").val("");
						tbody.find(".isfirsthelp").val("");
						tbody.find(".income").val("");

					} else {
						tr.find(".string1").val("");
						tr.find(".string2").val("");
						tr.find(".string3").val("");
						tr.find(".string5").val("");
						tr.find(".string4").val("");
						tr.find(".decimal1").val("");
						tr.find(".decimal2").val("");
						tr.find(".date1").val("");
						tr.find(".date2").val("");
						tr.find(".isassisthelp").val("");
						tr.find(".isfirsthelp").val("");
						tr.find(".income").val("");
					}
				});
			});

			//用来取消禁用或者禁用输入框的
			function ableOrNot(element , firstOrass){
				var tbody = element.parents("tbody");
				var inputs = tbody.find("input[type='text']");
				var selects = tbody.find("select");
				var isInput = tbody.find(firstOrass);
				if(element.prop("checked")){
					isInput.each(function(){
						$(this).val("on");
					});
					inputs.each(function(){
						$(this).removeAttr("disabled");
						$(this).parent().addClass("bg-white");
					});
					selects.each(function(){
						$(this).removeAttr("disabled");
						$(this).parent().addClass("bg-white");
					});
				} else {
					isInput.each(function(){
						$(this).val("");
					});
					inputs.each(function(){
						$(this).attr("disabled" , true);
						$(this).parent().removeClass("bg-white");
					});
					selects.each(function(){
						$(this).attr("disabled" , true);
						$(this).parent().removeClass("bg-white");
					});
				}


			}
		</script>
</body>
</html>