<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>扶贫小额信贷管理</title>
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
		<%-- <li><a href="${ctx}/county/microdinanceProvertyAlleviation/">扶贫小额信贷列表</a></li> --%>
		<li class="active"><a href="${ctx}/county/microdinanceProvertyAlleviation/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=2">扶贫小额信贷<shiro:hasPermission name="county:microdinanceProvertyAlleviation:edit">${not empty microdinanceProvertyAlleviation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="microfinanceProvertyAlleviation:edit">查看</shiro:lacksPermission></a></li>
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
	        <li class="active">扶贫小额信贷</li>
	        <li><a href="${ctx}/county/offSiteRelocation/form?baseCountyInfoId=${baseCountySpecialPovertyInfo.baseCountyInfoId}&type=3">异地扶贫搬迁</a></li>
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
			
	<form:form id="inputForm" modelAttribute="baseCountySpecialPovertyInfo" action="${ctx}/county/microdinanceProvertyAlleviation/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>
		<form:hidden path="type"/>
		<form:hidden path="baseCountyInfoId"/>
		<table>
			<tbody>
			<tr>
				<td class="fir-td"><span>C92 扶贫小额信贷覆盖贫困村数（个）</span></td>
				<td class="sec-td bg-white">
					<form:input path="microfinanceCoverVillages" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>C94e 其他（万元）</span></td>
				<td class="fou-td bg-white">
					<form:input path="otherLoanAmount" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>C93 扶贫小额信贷贷款户数（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="microfinanceLoanHouseholds" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>C95 支付扶贫小额信贷贴息资金（万元）</span></td>
				<td class="fou-td bg-white">
					<form:input path="microfinanceInterestSubsidy" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>C94 扶贫小额信贷发放总额（万元）</span></td>
				<td class="sec-td bg-white">
					<form:input path="microfinanceLoanAmount" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
				</td>
				<td class="thr-td"><span>其中：C95a地方贴息资金（万元）</span></td>
				<td class="fou-td bg-white">
					<form:input path="localInterestSubsidy" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>其中：C94a发展种植业、林果业（万元）</span></td>　
				<td class="sec-td bg-white">
					<form:input path="developPlantationAmount" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
				</td>
				<td class="thr-td" ><span>C96 扶贫小额信贷当年到期贷款额（万元）</span></td>
				<td class="fou-td bg-white">
					<form:input path="microfinanceMaturingLoans" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>C94b发展养殖业（万元）</span></td>
				<td class="sec-td bg-white">
					<form:input path="developAquacultureAmount" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
				</td>
				<td class="thr-td" ><span>C97 扶贫小额信贷当年到期贷款回收额（万元）</span></td>
				<td class="fou-td bg-white">
					<form:input path="maturingLoansRecovery" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>C94c发展加工业（万元）</span></td>
				<td class="sec-td bg-white">
					<form:input path="developIndustryAmount" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
				</td>
				<td class="thr-td" ><span>C98 扶贫小额信贷年末贷款余额（万元）</span></td>
				<td class="fou-td bg-white">
					<form:input path="microfinanceLoanBalance" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>C94d发展服务业、运输业（万元）</span></td>
				<td class="sec-td bg-white">
					<form:input path="serviceIndustryLoanAmount" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
				</td>
				<td class="thr-td" ><span></span></td>
				<td class="fou-td bg-white">
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