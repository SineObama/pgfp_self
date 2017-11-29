<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>基本情况管理</title>
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
		<li class="active"><a href="${ctx}/county/baseCountyInfo/form?id=${baseCountyInfo.id}">基本情况<shiro:hasPermission name="county:baseCountyInfo:edit">${not empty baseCountyInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="county:baseCountyInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<div class="content tabs f-clear">
    <ul class="content-nav">
        <li class="active">基本情况</li>
        <li><a href="${ctx}/county/baseCountyKeyWorkInfo/form?baseCountyInfoId=${baseCountyInfo.id}&type=1">村级道路畅通</a></li>
        <li><a href="${ctx}/county/baseCountyDrinkSafe/form?baseCountyInfoId=${baseCountyInfo.id}&type=2">饮水安全</a></li>
        <li><a href="${ctx}/county/baseCountyPowerSupport/form?baseCountyInfoId=${baseCountyInfo.id}&type=3">农村电力保障</a></li>
        <li><a href="${ctx}/county/baseCountyDangerRoom/form?baseCountyInfoId=${baseCountyInfo.id}&type=4">危房改造</a></li>
        <li><a href="${ctx}/county/baseCountyIndustryIncome/form?baseCountyInfoId=${baseCountyInfo.id}&type=5">特色产业增收</a></li>
        <li><a href="${ctx}/county/baseCountyRuralTourism/form?baseCountyInfoId=${baseCountyInfo.id}&type=6">乡村旅游</a></li>
        <li><a href="${ctx}/county/baseCountyEducation/form?baseCountyInfoId=${baseCountyInfo.id}&type=7">教育</a></li>
        <li><a href="${ctx}/county/baseCountyHealthfamilyPlanning/form?baseCountyInfoId=${baseCountyInfo.id}&type=8">卫生和计划生育</a></li>
        <li><a href="${ctx}/county/baseCountyCulture/form?baseCountyInfoId=${baseCountyInfo.id}&type=9">文化建设</a></li>
        <li><a href="${ctx}/county/baseCountyInformation/form?baseCountyInfoId=${baseCountyInfo.id}&type=10">贫困村信息化</a></li>
        <li><a href="${ctx}/county/baseCountySpecialPovertyInfo/form?baseCountyInfoId=${baseCountyInfo.id}&type=1">雨露计划</a></li>
        <li><a href="${ctx}/county/microdinanceProvertyAlleviation/form?baseCountyInfoId=${baseCountyInfo.id}&type=2">扶贫小额信贷</a></li>
        <li><a href="${ctx}/county/offSiteRelocation/form?baseCountyInfoId=${baseCountyInfo.id}&type=3">异地扶贫搬迁</a></li>
        <li><a href="${ctx}/county/bCountyHelpUnitInfo/form?baseCountyInfoId=${baseCountyInfo.id}">帮扶单位及责任人情况</a></li>
        <li><a href="${ctx}/county/baseCountyHelpInfo/form?baseCountyInfoId=${baseCountyInfo.id}">帮扶情况</a></li>
        
    </ul>
    <div id="tab-1" class="content-detail">
        <!-- <h2>
            贺州市<span>市</span><span>平桂区</span><span>县（市、区）</span><span>大平瑶族乡</span><span>乡（镇）<span>大平村</span><span>行政村</span></span>
            <select name="" id="">
                <option value="2016">2016</option>
                <option value="2017">2017</option>
            </select>
        </h2> -->
	
	
	<form:form id="inputForm" modelAttribute="baseCountyInfo" action="${ctx}/county/baseCountyInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>

		<div class="control-group" style="float: left">

		</div>
		
		<table>
                <tbody>
                <tr>
                	<td colspan="4" style="background-color: #FFFFFF;font-weight: bolder;">
                            区（县）名:
                            <form:input path="area.name" value="平桂区" disabled="true" style="width:19%;background-color:#fff;"/>
                            <form:hidden path="area.id" value="2"/>
                                <%--<sys:treeselect id="area" name="area.id" value="${baseCountyInfo.area.id}" labelName="area.name" labelValue="${baseCountyInfo.area.name}"--%>
                                <%--title="上级行政区划" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true"/>--%>

                        <span style="margin-left: 15%; margin-right:3%">县属性:</span>
                        <form:select path="countyAttribute">
                            <form:option value="" label="-----------"/>
                            <form:options items="${fns:getDictList('county_attribute')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                        <span style="margin-left: 10%; margin-right:3%">归属年度<font color="red">   *</font>:</span>
                        <input name="years" id="years" type="text"  maxlength="20" class="input-medium Wdate required"
                               value="<fmt:formatDate value="${baseCountyInfo.yearDate}" pattern="yyyy"/>"
                               onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" style="width:10%;"/>
                	</td>
                	
                </tr>
                <tr>
                    <td class="fir-td"><span>乡（镇）数（个）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="townAmount" maxlength="8" htmlEscape="false" class="input-xlarge digits"/>
                    </td>


                    <td class="fir-td"><span>行政区域土地面积（平方公里）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="landArea" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>


                </tr>
                <tr>
                    <td class="fir-td"><span>国有林场数（个）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="nationalForestFarmAmount" maxlength="8" htmlEscape="false" class="input-xlarge digits"/>
                    </td>

                    <td class="thr-td"><span>耕地面积（公顷）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="agriculturalAcreage" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>

                </tr>
                <tr>
                    <td class="fir-td"><span>&nbsp;&nbsp;其中：国有贫困林场数（个）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="poorForestFarmAmount" maxlength="8" htmlEscape="false" class="input-xlarge digits"/>
                    </td>
                    <td class="thr-td"><span>基本农田面积（公顷）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="fieldArea" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>行政村数（个）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="incorporatedVillageAmount" maxlength="8" htmlEscape="false" class="input-xlarge digits"/>
                    </td>
                    <td class="thr-td"><span>有效灌溉面积（公顷）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="effectiveIrrigationArea" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>

                </tr>
                
                <tr>
                    <td class="fir-td"><span>&nbsp;&nbsp;其中：贫困村数（个）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="poorVillageAmount" maxlength="8" htmlEscape="false" class="input-xlarge digits"/>
                    </td>
                    <td class="thr-td"><span>林地面积（公顷）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="forestlandArea" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>自然村数（个）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="naturalVillageAmount" maxlength="8" htmlEscape="false" class="input-xlarge digits"/>
                    </td>
                    <td class="thr-td"><span>退耕还林面积（公顷）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="grainForGreenArea" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：已通电自然村（20户以上）数（个）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="conElecVillageAmount" maxlength="8" htmlEscape="false" class="input-xlarge digits"/>
                    </td>
                    <td class="thr-td"><span>林果面积（公顷）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="fruitArea" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>年末总户数（万户）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="totalHouseholds" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>牧草地面积（公顷）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="grasslandArea" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：乡村户数（万户）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="villageHouseholdsAmount" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>水域面积（公顷）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="waterArea" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                
                <tr>
                    <td class="fir-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;符合当地农村居民低保条件（万户）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="accordSubAllowances" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>荒漠化面积（公顷）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="desertLandArea" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;纳入当地农村居民低保户数（万户）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="lowHouseholdAmount" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：石漠化面积（公顷）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="rockyDesertificationArea" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;五保户数（万户）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="fiveGuaranteesHousehold" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>森林覆盖率（%）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="forestCoverageRate" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>年末总人口（万人）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="yearEndTotalPopulation" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>退耕还草面积（公顷）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="farmlandForGrassArea" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：乡村人口（万人）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="villagePopulation" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>地区生产总值GDP（万元）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="gdp" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                
                <tr>
                    <td class="fir-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;少数民族人口（万人）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="minorityPopulation" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;其中：第一产业（万元）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="primaryIndustry" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;低保人口（万人）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="lowHouseholdPopulation" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;第二产业（万元）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="secondaryIndustry" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;五保人口（万人）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="fiveGuaranteesPopulation" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;第三产业（万元）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="tertiaryIndustry" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>&nbsp;&nbsp;&nbsp;&nbsp;妇女人口（万人）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="womenPopulation" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>地区生产总值增长率（%）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="gdpGrowthRate" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>参加城乡居民基本养老保险人数（万人）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="endowmentInsurancePopulation" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>地方公共财政预算收入（万元）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="localPublicFinance" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>贫困户数（万户）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="poorerHouseholdsAmount" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>地方公共财政预算支出（万元）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="localPublicFinanceOut" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>贫困人口（万人）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="poorPopulation" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>地方公共财政扶贫预算支出（万元）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="localPublicFinanceFpOut" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="thr-td"><span></span></td>
                    <td class="fou-td bg-white">
                        <%--<form:input path="residentIncomeGrowthRate" htmlEscape="false" class="input-xlarge decimal"/>--%>
                    </td>
                    <%--<td class="thr-td"><span>标准化乡镇卫生院的乡镇个数</span></td>--%>
                    <%--<td class="fou-td bg-white">--%>
                        <%--<form:input path="hospitalTown" htmlEscape="false" class="input-xlarge int"/>--%>
                    <%--</td>--%>
                    <td class="thr-td"><span>农村居民人均纯收入（元）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="ruralResidentIncome" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="thr-td"><span></span></td>
                    <td class="fou-td bg-white">
                        <%--<form:input path="residentIncomeGrowthRate" htmlEscape="false" class="input-xlarge decimal"/>--%>
                    </td>
                    <td class="thr-td"><span>农村居民人均纯收入增长率（%）</span></td>
                    <td class="fou-td bg-white">
                        <form:input path="residentIncomeGrowthRate" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
	</form:form>
	
	</div>
	</div>
	
</body>
</html>