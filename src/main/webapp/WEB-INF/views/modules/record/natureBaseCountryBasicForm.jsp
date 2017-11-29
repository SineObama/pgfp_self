<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>自然村建档立卡基本情况管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
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
		<li><a href="${ctx}/record/natureBaseCountryBasic/">自然村建档立卡基本情况列表</a></li>
		<li class="active"><a href="${ctx}/record/natureBaseCountryBasic/form?id=${countryBasic.id}">自然村建档立卡基本情况<shiro:hasPermission name="record:natureBaseCountryBasic:edit">${not empty countryBasic.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:natureBaseCountryBasic:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
<div class="content tabs f-clear">
    <ul class="content-nav">
        <li class="active">基本情况</li>
        <li><a href="${ctx}/record/natureBaseDevIncome/form?countryBasicId=${countryBasic.id}">收入状况</a></li>
        <li><a href="${ctx}/record/natureBaseIndustryIncome/form?countryBasicId=${countryBasic.id}">产业状况</a></li>
        <li><a href="${ctx}/record/infrastructureSituation/form?countryBasicId=${countryBasic.id}">基础设施状况</a></li>
        <li><a href="${ctx}/record/demandAndSituation/formD?countryBasicId=${countryBasic.id}">帮扶需求及帮扶情况</a></li>
        <li><a href="${ctx}/record/tableInfo/formD?countryBasicId=${countryBasic.id}">填表信息</a></li>

    </ul>
    <div id="tab-1" class="content-detail">
		
		<form:form id="inputForm" modelAttribute="countryBasic" action="${ctx}/record/natureBaseCountryBasic/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<form:hidden path="type" value="2"/>
		
		<div class="control-group" style="float: left">
			<label class="control-label">村名:</label>
			<div class="controls">
				<sys:treeselect id="area" name="area.id" value="${countryBasic.area.id}" labelName="area.name" labelValue="${countryBasic.area.name}"
								title="上级行政区划" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group" style="float: left">
			<label class="control-label">归属年度  <font color="red">*</font>:</label>
			<div class="controls">
				<input name="years" id="years" type="text"  maxlength="20" class="input-medium Wdate required"
					   value="<fmt:formatDate value="${countryBasic.yearsDate}" pattern="yyyy"/>"
					   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
			</div>
		</div>
		
        <!--<form action="">-->
            <table style="border: 0px #FFFFFF;">
                <tbody>
                <%-- <tr style="border: 0px #FFFFFF; ">
                    <td class="sec-td bg-white" colspan="2" style="border: 0px #FFFFFF;">
                        <div class="control-group" style="float: left;border-bottom: 0px;">
                            <label class="control-label" style="font-size: 12px;font-family: 'Microsoft Yahei',arial;font-weight: lighter;">村名:</label>
                            <div class="controls">
                                <sys:treeselect id="country" name="country.id" value="${countryBasic.country.id}"
                                                labelName="country.name" labelValue="${countryBasic.country.name}"
                                                title="村（屯）" url="/record/country/treeData" extId="${country.id}" cssClass="" allowClear="true"/>
                            </div>
                        </div>
                    </td>
                    <td class="sec-td bg-white" style="border: 0px #FFFFFF; text-align: right;">归属年度:</td>
                    <td class="sec-td bg-white" style="border: 0px #FFFFFF;">
                        <input id="years" name="years" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
                               value="<fmt:formatDate value="${countryBasic.yearsDate}" pattern="yyyy"/>"
                               onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
                    </td>
                </tr> --%>
                <tr>
                    <td class="fir-td"><span>自然村(屯)负责人</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="leader" htmlEscape="false" maxlength="20" class="input-xlarge realName"/>
                    </td>
                    <td class="thr-td"><span>联系电话</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="mobile" htmlEscape="false" maxlength="20" class="input-xlarge phoneChange"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>总户数(户)</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="b3TotalHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>乡(镇)外县内务工(人)</span></td>
                    <td class="fou-td bg-white">
						<form:input path="townOut" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>贫困户数(户)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b31PoorHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>县外省内务工(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="countyOut" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>一般贫困户(户)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b31ComPoor" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>省外务工(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="provinceOut" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>有劳动能力的扶贫低保户(户)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b312LabHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>文化程度:文盲或半文盲(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="b8Illiteracy" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>无劳动能力的低保户(户)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b312NolabHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>小学(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="primarysch" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr class="tuopin-btn">
                    <td class="fir-td"><span>五保户数(户)</span></td>
                    <!--<td class="sec-td"><input type="radio" name="tuopin-time" value="2016" checked><span>2016</span><input type="radio" name="tuopin-time" value="2017"><span>2017</span></td>-->
                    <td class="sec-td bg-white">
                        <form:input path="b33FiveHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>初中(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="junior" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr class="tez-btn">
                    <td class="fir-td"><span>总人口数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b4TotalPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>高中(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="high" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>贫困人口数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b41PoorPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>中职中专(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="secondary" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>一般贫困人口数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b411ComPoorPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>高职高专(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="vocational" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>有劳动能力的扶贫低保人口数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b412LabPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>大学及以上(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="university" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>无劳动能力的低保人口数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b413NolabPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>在校生情况:学前教育(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="b9Preschool" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>低保人口数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b42LowPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>在校生:小学(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="primarying" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>五保人口数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b43FivePer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>在校生:初中(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="junioring" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>少数民族人口数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b45Minority" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>在校生:高中(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="highing" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>妇女人口数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b46Woman" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>在校生:中职中专(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="secondarying" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>残疾人口数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b44Disabled" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>在校生:高职高专(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="vocationaling" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>长期患病(一年以上不能参加劳动)人口数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="chronicIllness" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>在校生:大学及以上(人)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="universitying" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>留守儿童数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b47Children" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>耕地面积(亩)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="b10Cultivate" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>空巢老人数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b48Oldman" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>水田面积(亩)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="b101Field" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>劳动力人数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b5TotalWorker" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>缺水灌溉面积(亩)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="needWater" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>16-39岁劳动力人数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="worker1" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>旱地面积(亩)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="b102Dryland" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>40-49岁劳动力人数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="worker2" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>林地面积(亩)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="b11Woodland" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>50-60岁劳动力人数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="worker3" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>退耕还林面积(亩)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="reforest" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>女性劳动力人数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b6WorkWom" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>林果面积(亩)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="treefruit" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>外出务工人数(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b7WorkOut" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>荒山荒坡面积(亩)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="b12Undeveloped" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>外出务工半年以上(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="workOut4" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>养殖水面面积(亩)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="b13Breed" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>外出务工半年以上一年以内(含半年)(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="workOut5" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>大牲畜(马、牛、驴、骡等)存栏数(头)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="b14Livestock" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>外出务工1年以上(含1年)(人)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="workOut6" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>生猪存栏数(头)</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="b15Pig" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>其他牲畜存栏数(头)</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="b16Other" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span></span></td>
                    <td class="fou-td bg-white"></td>
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
   
</body>
</html>