<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>专项扶贫管理</title>
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
		<li><a href="${ctx}/county/baseCountyInfo/">基本情况列表</a></li>
		<%-- <li><a href="${ctx}/county/offSiteRelocation/">异地扶贫搬迁列表</a></li> --%>
		<li class="active"><a href="${ctx}/county/offSiteRelocation/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=3"">异地扶贫搬迁<shiro:hasPermission name="county:offSiteRelocation:edit">${not empty offSiteRelocation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="county:offSiteRelocation:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>

	<div class="content tabs f-clear">
		<ul class="content-nav">
			<li><a href="${ctx}/county/baseCountyInfo/form?id=${baseCountySpecialPovertyInfo.baseCountyInfoId}">基本情况</a></li>
	        <li><a href="${ctx}/county/baseCountyKeyWorkInfo/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=1">村级道路畅通</a></li>
	        <li><a href="${ctx}/county/baseCountyDrinkSafe/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=2">饮水安全</a></li>
	        <li><a href="${ctx}/county/baseCountyPowerSupport/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=3">农村电力保障</a></li>
	        <li><a href="${ctx}/county/baseCountyDangerRoom/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=4">危房改造</a></li>
	        <li><a href="${ctx}/county/baseCountyIndustryIncome/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=5">特色产业增收</a></li>
	        <li><a href="${ctx}/county/baseCountyRuralTourism/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=6">乡村旅游</a></li>
	        <li><a href="${ctx}/county/baseCountyEducation/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=7">教育</a></li>
	        <li><a href="${ctx}/county/baseCountyHealthfamilyPlanning/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=8">卫生和计划生育</a></li>
	        <li><a href="${ctx}/county/baseCountyCulture/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=9">文化建设</a></li>
	        <li><a href="${ctx}/county/baseCountyInformation/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=10">贫困村信息化</a></li>
	        <li><a href="${ctx}/county/baseCountySpecialPovertyInfo/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=1">雨露计划</a></li>
	        <li><a href="${ctx}/county/microdinanceProvertyAlleviation/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=2">扶贫小额信贷</a></li>
	        <li class="active">异地扶贫搬迁</li>
	        <li><a href="${ctx}/county/bCountyHelpUnitInfo/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}">帮扶单位及责任人情况</a></li>
	        <li><a href="${ctx}/county/baseCountyHelpInfo/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}">帮扶情况</a></li>
		</ul>
		<div id="tab-1" class="content-detail">
			
	<c:choose>
		<c:when test="${empty baseCountySpecialPovertyInfo.baseCountyInfoId }">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>		
			
	<form:form id="inputForm" modelAttribute="baseCountySpecialPovertyInfo" action="${ctx}/county/offSiteRelocation/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>
		<form:hidden path="type"/>
		<form:hidden path="baseCountyInfoId"/>
			<table>
				<tbody>
				<tr>
					<td class="fir-td"><span>C99 纳入易地扶贫搬迁规划户数（户）</span></td>
					<td class="sec-td bg-white">
						<form:input path="changeRelocationPlanHouse" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>其中：C103a 中央预算内补助投资（万元）</span></td>
					<td class="fou-td bg-white">
						<form:input path="centralBudgetaryInvestments" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>C100 纳入易地扶贫搬迁规划人数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="changeRelocationPlanNum" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span> C103b 中央财政专项资金投入（万元）</span></td>
					<td class="fou-td bg-white">
						<form:input path="centralSpecialInvestments" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>C101 完成易地扶贫搬迁户数（户）</span></td>
					<td class="sec-td bg-white">
						<form:input path="changeRelocationHouse" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>C103c 省级专项资金投入（万元）</span></td>
					<td class="fou-td bg-white">
						<form:input path="provincialSpecialInvestments" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>C102 完成易地扶贫搬迁人数（人） </span></td>　
					<td class="sec-td bg-white">
						<form:input path="changeRelocationNum" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td" ><span>C103d 市县专项资金投入（万元）</span></td>
					<td class="fou-td bg-white">
						<form:input path="countySpecialInvestments" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>C103 易地扶贫搬迁资金投入（万元）</span></td>
					<td class="sec-td bg-white">
						<form:input path="changeRelocationFunding" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
					</td>
					<td class="thr-td" ><span>C103e 其他资金投入（万元）</span></td>
					<td class="fou-td bg-white">
						<form:input path="otherFundInvestments" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
					</td>
				</tr>
				</tbody>
			</table>
			<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
		</form:form>
		</c:otherwise>
		</c:choose>
	</div>
</div>
</body>
</html>