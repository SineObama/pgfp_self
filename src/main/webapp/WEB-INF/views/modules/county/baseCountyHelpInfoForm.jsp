<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困县帮扶情况管理</title>
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
		<%-- <li><a href="${ctx}/county/baseCountyHelpInfo/">贫困县帮扶情况列表</a></li> --%>
		<li class="active"><a href="${ctx}/county/baseCountyHelpInfo/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}">贫困县帮扶情况<shiro:hasPermission name="county:baseCountyHelpInfo:edit">${not empty baseCountyHelpInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="county:baseCountyHelpInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<div class="content tabs f-clear">
    <ul class="content-nav">
        <li><a href="${ctx}/county/baseCountyInfo/form?id=${baseCountyHelpInfo.baseCountyInfoId}">基本情况</a></li>
        <li><a href="${ctx}/county/baseCountyKeyWorkInfo/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}&type=1">村级道路畅通</a></li>
        <li><a href="${ctx}/county/baseCountyDrinkSafe/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}&type=2">饮水安全</a></li>
        <li><a href="${ctx}/county/baseCountyPowerSupport/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}&type=3">农村电力保障</a></li>
        <li><a href="${ctx}/county/baseCountyDangerRoom/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}&type=4">危房改造</a></li>
        <li><a href="${ctx}/county/baseCountyIndustryIncome/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}&type=5">特色产业增收</a></li>
        <li><a href="${ctx}/county/baseCountyRuralTourism/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}&type=6">乡村旅游</a></li>
        <li><a href="${ctx}/county/baseCountyEducation/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}&type=7">教育</a></li>
        <li><a href="${ctx}/county/baseCountyHealthfamilyPlanning/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}&type=8">卫生和计划生育</a></li>
        <li><a href="${ctx}/county/baseCountyCulture/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}&type=9">文化建设</a></li>
        <li><a href="${ctx}/county/baseCountyInformation/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}&type=10">贫困村信息化</a></li>
        <li><a href="${ctx}/county/baseCountySpecialPovertyInfo/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}&type=1">雨露计划</a></li>
        <li><a href="${ctx}/county/microdinanceProvertyAlleviation/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}&type=2">扶贫小额信贷</a></li>
        <li><a href="${ctx}/county/offSiteRelocation/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}&type=3">异地扶贫搬迁</a></li>
        <li><a href="${ctx}/county/bCountyHelpUnitInfo/form?baseCountyInfoId=${baseCountyHelpInfo.baseCountyInfoId}">帮扶单位及责任人情况</a></li>
        <li class="active"><a>帮扶情况</a></li>
    </ul>
    <div id="tab-1" class="content-detail">
	
	<c:choose>
		<c:when test="${empty baseCountyHelpInfo.baseCountyInfoId }">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
	
	<form:form id="inputForm" modelAttribute="baseCountyHelpInfo" action="${ctx}/county/baseCountyHelpInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
        <form:hidden path="years"/>
		<sys:message content="${message}"/>	
		<form:hidden path="baseCountyInfoId"/>	
		
		<table>
                <tbody>
                <tr>
                    <td class="fir-td"><span>选派驻村工作队数（个）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="assignVillageTaskForce" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>返贫人口（人）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="repovertyPopulation" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>选派驻村干部人数（人）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="assignVillageCadres" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>投入到县扶贫资金总额（万元）</span></td>
                    <td class="fou-td bg-white">
						<form:input path="countyPovertyFunds" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>其中：省属部门干部人数（人）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="provincialCadres" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>中央财政扶贫资金投入到县总额（万元）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="centralGovPovertyFunds" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>市属部门干部人数（人）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="cityCadres" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>发展资金和扶贫贷款财政贴息资金（万元）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="loanDiscountInterest" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>县属部门干部人数（人）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="countyCadres" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>以工代赈资金（万元）</span></td>
                    <td class="fou-td bg-white">
						<form:input path="workReliefFund" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>乡属干部人数（人）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="villageCadres" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>少数民族发展资金（万元）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="minoritiesDevelopFund" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>其他人员人数（人）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="oterPersonnel" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>省级财政扶贫资金（万元）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="provincialPovertyFunds" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>脱贫村数（个）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="overcomePovertyVillage" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>市县级财政扶贫资金（万元）</span></td>
                    <td class="fou-td bg-white">
						<form:input path="cityPovertyFunds" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>脱贫户数（户）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="overcomePovertyHouseholds" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>行业扶贫资金（万元）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="industryPovertyFunds" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>脱贫人口（人）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="overcomePovertyPopulation" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>社会帮扶资金（万元）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="socialSupportFunds" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>返贫户数（户）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="repovertyHouseholds" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span></span></td>
                    <td class="fou-td bg-white"></td>
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