<%@ taglib prefix="html" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户建档立卡表管理</title>
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
	<li class="active"><a href="${ctx}/record/basePoorerRegCard/form?id=${basePoorerRegCard.id}">建档立卡表<shiro:hasPermission name="record:basePoorerRegCard:edit">${not empty basePoorerRegCard.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:basePoorerRegCard:edit">查看</shiro:lacksPermission></a></li>
</ul>
<div class="header">
	<a href="" class="header-lt">贫困户建档立卡</a>
	<a href="" class="header-rt">基本情况</a>
</div>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li class="active">基本情况</li>
		<li><a href="${ctx}/record/basePoorerFamilyMember/form?poorerRegCardId=${basePoorerRegCard.id}">家庭成员</a></li>
		<li><a href="${ctx}/record/baseMemberTrainingStatus/form?cardId=${basePoorerRegCard.id}">家庭成员受培训情况</a></li>
		<li><a href="${ctx}/record/baseMemberWorkStatus/form?cardId=${basePoorerRegCard.id}">家庭成员就业情况</a> </li>
		<li><a href="${ctx}/bf/insuredSituation/form?poorerRegCardId=${basePoorerRegCard.id}">家庭成员参保情况</a></li>
		<li><a href="${ctx}/record/baseProductionLivingCondition/form?poorerRegCardId=${basePoorerRegCard.id}">生产生活条件</a></li>
		<li><a href="${ctx}/record/baseFamilyEconomicInfo/form?poorerRegCardId=${basePoorerRegCard.id}">家庭经济情况</a></li>
		<li><a href="${ctx}/record/baseRegCardBiz/form?regCardId=${basePoorerRegCard.id}">特色产业增收</a></li>
		<li><a href="${ctx}/record/basePoorerHelpDetail/form?poorerRegCardId=${basePoorerRegCard.id}">帮扶需求</a></li>
		<li><a href="${ctx}/record/basePoorerSupportUnitInfo/form?poorerRegCardId=${basePoorerRegCard.id}">帮扶单位及责任人</a></li>
		<li><a href="${ctx}/record/basePoorerStudentHelpInfo/form?poorerRegCardId=${basePoorerRegCard.id}">家庭在校生受帮扶情况</a></li>
		<li><a href="${ctx}/record/basePoorerRegCard/tpPlan?id=${basePoorerRegCard.id}">填表记录</a></li>
	</ul>
	<div id="tab-1" class="content-detail">

		<form:form id="inputForm" modelAttribute="basePoorerRegCard" action="${ctx}/record/basePoorerRegCard/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="houseId"/>
			<sys:message content="${message}"/>
			<br/>
			<table style="border: 0px #FFFFFF;">
				<tbody>
				<tr style="border: 0px #FFFFFF; ">
					<td class="sec-td bg-white" colspan="2" style="border: 0px #FFFFFF;">
						<div class="control-group" style="float: left;border-bottom: 0px;">
							<label class="control-label" style="font-size: 12px;font-family: 'Microsoft Yahei',arial;font-weight: lighter;">村名:</label>
							<div class="controls">
								<sys:treeselect id="country" name="country.id" value="${basePoorerRegCard.country.id}"
												labelName="country.name" labelValue="${basePoorerRegCard.country.name}"
												title="村（屯）" url="/sys/area/treeData" extId="${country.id}" allowClear="true"/>
							</div>
						</div>
					</td>

					<td class="sec-td bg-white" style="border: 0px #FFFFFF; text-align: right;">归属年度:<font color="red">&nbsp;&nbsp;*</font></td>
					<td class="sec-td bg-white" style="border: 0px #FFFFFF;">
						<input id="years" name="years" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
							   value="<fmt:formatDate value="${basePoorerRegCard.yearDate}" pattern="yyyy"/>"
							   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
				</tr>
				<tr>
					<td class="sec-td"><span>家庭住址<font color="red">&nbsp;&nbsp;*</font></span></td>
					<td class="sec-td bg-white" colspan="3">
						<form:input path="address"  class="inp-left required"/></td>
				</tr>
				<tr>
					<td class="sec-td"><span>门牌号<font color="red">&nbsp;&nbsp;*</font></span></td>
					<td class="sec-td bg-white">
						<form:input class="inp-left required" maxlength="22" path="houseNumber"/>
					</td>
					<td class="sec-td"><span>识别得分</span></td>
					<td class="sec-td bg-white">
						<form:input class="inp-right required int" path="sbScore"/>
					</td>
				</tr>
				<tr>
					<td class="sec-td"><span>户主姓名</span></td>
					<td class="sec-td bg-white">
						<form:input type="text" class="inp-left required" path="houseHolderName" disabled="true" cssStyle="background-color: #FFFFFF" placeholder="维护户主信息后自动回显"/>
					</td>
					<td class="sec-td"><span>联系电话</span></td>
					<td class="sec-td bg-white">
						<form:input type="text" class="inp-right phone" path="mobile"/>
					</td>
				</tr>
				<tr>
					<td class="sec-td"><span>开户银行</span></td>
					<td class="sec-td bg-white" colspan="3">
						<form:input type="text" class="inp-left" path="bankName"/>
					</td>
				</tr>
				<tr>
					<td class="sec-td"><span>开户人</span></td>
					<td class="sec-td bg-white">
						<form:input type="text" class="inp-right " path="bankHolder" maxlength="20"/>
					</td>
					<td class="sec-td"><span>银行帐号（财政一卡通）</span></td>
					<td class="sec-td bg-white">
						<form:input type="text" class="inp-right " path="bankAccount" maxlength="20"/>
					</td>
				</tr>
				<tr>
					<td class="sec-td"><span>户口本号(户编号)</span></td>
					<td class="sec-td bg-white">
						<form:input type="text"  class="inp-left" path="residenceBookletNumber" maxlength="100" />
					</td>



					<td class="sec-td"><span>A1 贫困户属性(单选) <font color="red">&nbsp;&nbsp;*</font></span></td>
					<td class="sec-td bg-white">
						<form:radiobuttons  class="inp-left required" path="poorerType"
											items="${fns:getDictList('poor_households_attributes')}" itemLabel="label" itemValue="value"/>
					</td>
				</tr>
				<tr>
					<td class="sec-td"><span>A2 户中是否有三留人员</span></td>
					<td class="fou-td bg-white">
						<form:radiobuttons class="inp-right" path="slry"
										   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
					</td>
					<td class="sec-td"><span>A3 主要致贫原因（不超过两项）</span></td>
					<td class="sec-td bg-white">
							<%--<c:forEach items="${fns:getDictList('mainPoorReason')}" var="dict">--%>
							<%--<html:checkbox path="mainPoorReason" htmlEscape="false"--%>
							<%--value="${dict.value}" label="${dict.label}"/>--%>
							<%--</c:forEach>--%>

						<form:checkboxes class="inp-left" path="mainPoorReasonList" htmlEscape="false"
										 items="${fns:getDictList('mainPoorReason')}" itemValue="value" itemLabel="label"/>
					</td>
				</tr>
				<tr>
					<td class="sec-td"><span>其中最主要致贫原因（限一项）</span></td>
					<td class="fou-td bg-white">
						<form:radiobuttons class="inp-right" path="primaryPoorReason"
										   items="${fns:getDictList('mainPoorReason')}" itemLabel="label" itemValue="value"/>
					</td>
					<td class="sec-td"><span>是否军烈属</span></td>
					<td class="sec-td bg-white">
						<html:radiobuttons class="inp-left" path="militarySpouse" htmlEscape="false"
										   items="${fns:getDictList('yes_no')}" itemValue="value" itemLabel="label"/>
					</td>
				</tr>
				<tr>
					<td class="sec-td"><span>是否独生子女户</span></td>
					<td class="fou-td bg-white">
						<html:radiobuttons class="inp-right" path="onlyChild"
										   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
					</td>
					<td class="sec-td"><span>是否双女户</span></td>
					<td class="sec-td bg-white">
						<html:radiobuttons class="inp-left" path="twoDaughtersFamily" htmlEscape="false"
										   items="${fns:getDictList('yes_no')}" itemValue="value" itemLabel="label"/>
					</td>
				</tr>
				<tr>
					<td class="sec-td"><span> 是否脱贫<font color="red">&nbsp;&nbsp;*</font></span></td>
					<td class="sec-td bg-white" >
						<form:radiobuttons path="povertyFlag"  class="inp-left required"
										   items="${fns:getDictList('yes_no')}" itemValue="value" itemLabel="label"/></td>
					<td class="sec-td"><span> 通过何种方式脱贫</span></td>
					<td class="sec-td bg-white">
							<%--<td class="sec-td bg-white" colspan="3">--%>
						<%--<form:input class="inp-left required" path="povertyWay"/>--%>
						<form:select path="povertyWay" style="width:120px;">
							<form:option value="" label="----------"/>
							<form:options items="${fns:getDictList('poverty_alleviation_way')}" itemLabel="label" itemValue="value"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="sec-td"><span>计划脱贫时间</span></td>
					<td class="sec-td bg-white">
							<%--<form:input class="inp-right required" path="povertyExpected"/>--%>
						<input id="povertyExpected" name="povertyExpected" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
							   value="<fmt:formatDate value="${basePoorerRegCard.expectedDate}" pattern="yyyy"/>"
							   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:true});" style="width: 120px;background-color: #FFFFFF;"/>
					</td>
					<td class="sec-td"><span>脱贫时间</span></td>
					<td class="sec-td bg-white">
							<%--<form:input class="inp-right required" path="povertyExpected"/>--%>
						<input id="povertyTime" name="povertyTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
							   value="<fmt:formatDate value="${basePoorerRegCard.povertyDate}" pattern="yyyy"/>"
							   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:true});" style="width: 120px;background-color: #FFFFFF;"/>
					</td>
				</tr>
				<tr>
					<td class="sec-td"><span> 是否库区移民户</span></td>
					<td class="sec-td bg-white" >
						<form:radiobuttons path="isImmigrant"  class="inp-left"
										   items="${fns:getDictList('yes_no')}" itemValue="value" itemLabel="label"/></td>
					<td class="sec-td"><span> 移民库区名字</span></td>
							<%--<td class="sec-td bg-white" colspan="3">--%>
							<%--<form:input class="inp-left required" path="povertyWay"/>--%>
					<td class="sec-td bg-white">
						<form:input type="text" class="inp-right" path="immigrantName" maxlength="20"/>
					</td>
				</tr>
				<tr>
					<td class="sec-td"><span>是否易地搬迁户</span></td>
					<td class="sec-td bg-white">
						<form:radiobuttons path="isChangeMove"  class="inp-left"
										   items="${fns:getDictList('yes_no')}" itemValue="value" itemLabel="label"/>
					</td>
					<td class="sec-td"><span>安置类型</span></td>
					<td class="sec-td bg-white">
						<form:select path="placementType" class="placementType" style="width:120px;">
							<form:option value="">--------</form:option>
							<form:option value="1">集中安置</form:option>
							<form:option value="2">分散安置</form:option>
						</form:select>
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