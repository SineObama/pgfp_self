<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>特色产业增收管理</title>
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
		<%-- <li><a href="${ctx}/county/baseCountyIndustryIncome/">饮水安全列表</a></li> --%>
		<li class="active"><a href="${ctx}/county/baseCountyIndustryIncome/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}&type=5">特色产业增收<shiro:hasPermission name="county:baseCountyIndustryIncome:edit">${not empty baseCountyKeyWorkInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="county:baseCountyIndustryIncome:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<div class="content tabs f-clear">
    <ul class="content-nav">
        <li><a href="${ctx}/county/baseCountyInfo/form?id=${baseCountyKeyWorkInfo.baseCountyInfoId}">基本情况</a></li>
        <li><a href="${ctx}/county/baseCountyKeyWorkInfo/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}&type=1">村级道路畅通</a></li>
        <li><a href="${ctx}/county/baseCountyDrinkSafe/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}&type=2">饮水安全</a></li>
        <li><a href="${ctx}/county/baseCountyPowerSupport/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}&type=3">农村电力保障</a></li>
        <li><a href="${ctx}/county/baseCountyDangerRoom/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}&type=4">危房改造</a></li>
        <li class="active"><a>特色产业增收</a></li>
        <li><a href="${ctx}/county/baseCountyRuralTourism/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}&type=6">乡村旅游</a></li>
        <li><a href="${ctx}/county/baseCountyEducation/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}&type=7">教育</a></li>
        <li><a href="${ctx}/county/baseCountyHealthfamilyPlanning/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}&type=8">卫生和计划生育</a></li>
        <li><a href="${ctx}/county/baseCountyCulture/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}&type=9">文化建设</a></li>
        <li><a href="${ctx}/county/baseCountyInformation/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}&type=10">贫困村信息化</a></li>
        <li><a href="${ctx}/county/baseCountySpecialPovertyInfo/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}&type=1">雨露计划</a></li>
        <li><a href="${ctx}/county/microdinanceProvertyAlleviation/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}&type=2">扶贫小额信贷</a></li>
        <li><a href="${ctx}/county/offSiteRelocation/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}&type=3">异地扶贫搬迁</a></li>
        <li><a href="${ctx}/county/bCountyHelpUnitInfo/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}">帮扶单位及责任人情况</a></li>
        <li><a href="${ctx}/county/baseCountyHelpInfo/form?baseCountyInfoId=${baseCountyKeyWorkInfo.baseCountyInfoId}">帮扶情况</a></li>
    </ul>
    <div id="tab-1" class="content-detail">
	<c:choose>
		<c:when test="${empty baseCountyKeyWorkInfo.baseCountyInfoId }">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
			<form:form id="inputForm" modelAttribute="baseCountyKeyWorkInfo" action="${ctx}/county/baseCountyIndustryIncome/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
                <form:hidden path="years"/>
		<sys:message content="${message}"/>	
		
		<form:hidden path="type"/>
		<form:hidden path="baseCountyInfoId"/>	
		
		<table>
                <tbody>
                <tr>
                    <td class="fir-td"><span>农民专业合作组织数（个）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="specialCooperativeAmount" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>互助资金累计还款（万元）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="totalRepayment" maxlength="11" htmlEscape="false" class="input-xlarge  decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>有农民专业合作组织的行政村数（个）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="specialCooperativeVillages" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>其中：贫困户还款（万元）</span></td>
                    <td class="fou-td bg-white">
						<form:input path="poorerRepayment" maxlength="11" htmlEscape="false" class="input-xlarge  decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>有互助资金组织的行政村数（个）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="mutualFundVillages" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>农业、林业部门资金投入（万元）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="agricultureFunding" maxlength="11" htmlEscape="false" class="input-xlarge  decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>参加贫困村互助资金组织户数（户）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="mutualFundHouseholds" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>其中：中央资金投入（万元）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="centralFundingForIndustrial" maxlength="11" htmlEscape="false" class="input-xlarge  decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>互助资金借款户数（户）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="mutualFundBorrowHouseholds" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>省级资金投入（万元）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="provincialFundingForIndustrial" maxlength="11" htmlEscape="false" class="input-xlarge  decimal"/>
                    </td>
                </tr>
                
                <tr>
                    <td class="fir-td"><span>其中：贫困户借款户数（户）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="poorerBorrowHouseholds" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>市县资金投入（万元）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="countyFundingForIndustrial" htmlEscape="false" maxlength="11" class="input-xlarge  decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>互助资金累计借款人次（人次）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="totalBorrowPopulation" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
                    </td>
                    <td class="thr-td"><span>农村青年创业小额贷款（万元）</span></td>
                    <td class="fou-td bg-white">
						<form:input path="youthPettyLoan" htmlEscape="false" maxlength="11" class="input-xlarge  decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>互助资金累计发放借款（万元）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="totalProvideFunding" maxlength="11" htmlEscape="false" class="input-xlarge  decimal"/>
                    </td>
                    <td class="thr-td"><span>妇女小额担保贷款（万元）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="womenGuaranteedLoan" maxlength="11" htmlEscape="false" class="input-xlarge  decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>其中：贫困户借款（万元）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="poorerBorrowMoney" maxlength="11" htmlEscape="false" class="input-xlarge  decimal"/>
                    </td>
                    <td class="thr-td"><span>残疾人康复扶贫贷款（万元）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="disabilityRehabilitationLoan" maxlength="11" htmlEscape="false" class="input-xlarge  decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>有农民专业合作社等新型农业经营主体或有产业基地（园）覆盖的贫困村数（个）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="poorCooperativeVillages" maxlength="8" htmlEscape="false" class="input-xlarge  int"/>
                    </td>
                    <td class="thr-td"><span></span></td>
                    <td class="fou-td bg-white">
                        <%--<form:input path="disabilityRehabilitationLoan" htmlEscape="false" class="input-xlarge  decimal"/>--%>
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