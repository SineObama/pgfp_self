<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困家庭学生享受教育精准扶贫政策情况统计表管理</title>
	<meta name="decorator" content="default"/>
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
<style>
	.content-detail table{
		width: 1000px;
	}
	.content-detail td{
		min-width: 0;
		text-align: center;
	}
	/**
	 * common Css
	 */
	.content-detail .table-title{
		font-size: 24px;
		width: 1000px; /* 标题位置 */
		text-align: center;
		color: #317eac;
		white-space: nowrap;
	}
	.content-detail .table-title input{
		display: inline-block;
		border-radius: 0;
		width: 140px;
		border-bottom: 1px solid #ccc;
	}
	.content-detail .table-subtitle{
		width: 1000px; /* 副标题位置 */
		font-size: 0;
		white-space: nowrap;
	}
	.content-detail .table-subtitle>span{
		/*width: 30%;*/
		display: inline-block;
		font-size: 14px;
		color: #555;
	}
	.content-detail .table-subtitle>span:last-child{
		text-align: right;
	}
	.content-detail .table-subtitle>span input{
		border-radius: 0;
		width: 140px;
		border-bottom: 1px solid #ccc;
	}
	.text-bottom{
		margin-top: 10px;
		white-space: nowrap;
	}
	.text-bottom span{
		display: inline-block;
		width: 400px; /* 底部文字位置 */
		font-size: 14px;
	}
	.text-bottom input[type=text]{
		width: 140px;
		border-bottom: 1px solid #ccc;
	}
	#tab-1 #years{
		width: 150px;
	}

</style>

	<ul class="nav nav-tabs">
		<li><a href="${ctx}/co/coCountryYear/">行政村档案清单列表</a></li>
		<%--<li><a href="${ctx}/co/coPoorStudentPolicy/">贫困家庭学生享受教育精准扶贫政策情况统计表列表</a></li>--%>
		<li class="active"><a href="${ctx}/co/coPoorStudentPolicy/form?coMain.coId=${coMain.coId}&coMain.type=13">贫困家庭学生享受教育精准扶贫政策情况统计表<shiro:hasPermission name="co:coPoorStudentPolicy:edit">${not empty coPoorStudentPolicy.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="co:coPoorStudentPolicy:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>

<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/co/coCountryYear/form?id=${coMain.coId}">村名与年度</a></li>
		<li><a href="${ctx}/co/coCharacterIndustry/form?coMain.coId=${coMain.coId}&coMain.type=1">特色产业情况统计表</a></li>
		<li><a href="${ctx}/co/coPoorHouIndustry/form?coMain.coId=${coMain.coId}&coMain.type=2">贫困户产业登记表</a></li>
		<li><a href="${ctx}/co/coLaborOut/form?coId=${coMain.coId}&countryId=${countryId}">贫困户劳动力统计表</a></li>
		<li><a href="${ctx}/co/coLaborSituation/form?coId=${coMain.coId}&countryId=${countryId}">贫困户劳动力情况表</a></li>
		<li><a href="${ctx}/co/coHouseSecurity/form?coMain.coId=${coMain.coId}&coMain.type=5">住房保障达标情况统计表</a></li>
		<li><a href="${ctx}/co/coHouseSituation/form?coId=${coMain.coId}&countryId=${countryId}">住房保障未达标户名单情况表</a></li>
		<li><a href="${ctx}/co/coPovertyRelocation/form?coMain.coId=${coMain.coId}&coMain.type=7">易地扶贫搬迁户住房保障情况表</a></li>
		<li><a href="${ctx}/co/coBuyMedicalInsurance/form?coMain.coId=${coMain.coId}&coMain.type=8">居民购买医疗或商业保险情况</a></li>
		<li><a href="${ctx}/co/coInsuranceNameList/form?coId=${coMain.coId}&countryId=${countryId}">未购买医疗或商业保险情况名单</a></li>
		<li><a href="${ctx}/co/coIllTreatment/form?coId=${coMain.coId}&countryId=${countryId}">患病救治和补助报销情况统计</a></li>
		<li><a href="${ctx}/co/coChildHaveEducation/form?coMain.coId=${coMain.coId}&coMain.type=11">适龄儿童接受义务教育</a></li>
		<li><a href="${ctx}/co/coNoEducation/form?coMain.coId=${coMain.coId}&coMain.type=12">适龄儿童未接受义务教育</a></li>
		<li class="active">学生享受教育精准扶贫政策</li>
		<li><a href="${ctx}/co/coSafeDrink/form?coId=${coMain.coId}&countryId=${countryId}">安全饮水达标情况统计</a></li>
		<li><a href="${ctx}/co/coDrinkSituation/form?coId=${coMain.coId}&countryId=${countryId}">未达到安全饮水户名单</a></li>
		<li><a href="${ctx}/co/coRoadSituation/form?coId=${coMain.coId}&countryId=${countryId}">通硬化路情况表</a></li>
		<li><a href="${ctx}/co/coTwentyRoad/form?coId=${coMain.coId}&countryId=${countryId}">20户以上通路情况表</a></li>
		<li><a href="${ctx}/co/coHaveElectric/form?coMain.coId=${coMain.coId}&coMain.type=18">村有电用达标情况统计表</a></li>
		<li><a href="${ctx}/co/coNoElectric/form?coMain.coId=${coMain.coId}&coMain.type=19">全村未接通生活用电户名单</a></li>
		<li><a href="${ctx}/co/coCultureSituation/form?coId=${coMain.coId}&countryId=${countryId}">篮球场，文化室或戏台情况表</a></li>
		<li><a href="${ctx}/co/coNetwork/form?coId=${coMain.coId}&countryId=${countryId}">通网络宽带情况表</a></li>
		<li><a href="${ctx}/co/coEndowmentInsured/form?coMain.coId=${coMain.coId}&coMain.type=22">城乡居民养老保险参保情况</a></li>
		<li><a href="${ctx}/co/coNoEndowmentInsured/form?coMain.coId=${coMain.coId}&coMain.type=23">城乡居民养老保险未参保名单</a></li>
		<li><a href="${ctx}/co/coAllowances/form?coMain.coId=${coMain.coId}&coMain.type=24">贫困户纳入农村低保情况</a></li>
		<li><a href="${ctx}/co/coTvOnline/form?coId=${coMain.coId}&countryId=${countryId}">农户能看电视或上网情况统计表</a></li>
		<li><a href="${ctx}/co/coDigitalCount/form?coId=${coMain.coId}&countryId=${countryId}">未有数码设备名单</a></li>
		<li><a href="${ctx}/co/coIncidenceOfPoverty/form?coId=${coMain.coId}&countryId=${countryId}">贫困发生率统计表</a></li>
	</ul>
	<div id="tab-1" class="content-detail">
		<c:choose>
		<c:when test="${empty coMain.coId}">
		<script>
			alert("请先填写村名和年度！");
			window.history.back(-1);
		</script>
		</c:when>
		<c:otherwise>

		<form:form id="inputForm" modelAttribute="coMain" action="${ctx}/co/coPoorStudentPolicy/save" method="post" class="form-horizontal">
			<%--<form:hidden path="id"/>--%>
			<sys:message content="${message}"/>
			<br>
			<h2 class="table-title">贫困家庭学生享受教育精准扶贫政策情况统计表</h2>
			<h3 class="table-subtitle">
				<span style="width:40%">填报单位：<input style="font-size: 22px;width: 80px" type="text" name="coPoorStudentPolicy.countryId" value="${coMain.coPoorStudentPolicy.countryId}"/>(教育部门、扶贫部门）</span>
				<span style="width:25%">单位：人，万元</span>
				<span style="width:35%;">填报时间：<input name="fillDate" id="years" type="text"  maxlength="20" class="input-medium Wdate required"
								  value="<fmt:formatDate value="${coMain.fillDate}" pattern="yyyy-MM-dd"/>"
								  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/></span>
			</h3>
			<input type="hidden" name="id" value="${coMain.id}"/>
			<input type="hidden" name="type" value="13"/>
			<input type="hidden" name="coId" value="${coMain.coId}"/>
			<table>
				<tbody id="accpitem">
				<tr>
					<td>就学学段</td>
					<td>学前教育</td>
					<td>义务教育</td>
					<td>普通高中</td>
					<td>中职教育</td>
					<td>高等教育</td>
					<td>合计</td>
					<td>备注</td>
				</tr>
				<tr>
					<td>贫困家庭学生数</td>
					<td class="bg-white">
						<input type="hidden" name="coPoorStudentPolicy.id" value="${coMain.coPoorStudentPolicy.id}"/>
						<input type="text" name="coPoorStudentPolicy.preschoolStus" value="${coMain.coPoorStudentPolicy.preschoolStus}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.compulsoryStus" value="${coMain.coPoorStudentPolicy.compulsoryStus}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.seniorHighStus" value="${coMain.coPoorStudentPolicy.seniorHighStus}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.secondaryVocationalStus" value="${coMain.coPoorStudentPolicy.secondaryVocationalStus}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.higherEducationStus" value="${coMain.coPoorStudentPolicy.higherEducationStus}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.totalStus" value="${coMain.coPoorStudentPolicy.totalStus}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.stusRemark" value="${coMain.coPoorStudentPolicy.stusRemark}"/>
					</td>
				</tr>
				<tr>
					<td>资助人数</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.preschoolHelpNum" value="${coMain.coPoorStudentPolicy.preschoolHelpNum}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.compulsoryHelpNum" value="${coMain.coPoorStudentPolicy.compulsoryHelpNum}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.seniorHighHelpNum" value="${coMain.coPoorStudentPolicy.seniorHighHelpNum}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.secondaryVocationalHelpNum" value="${coMain.coPoorStudentPolicy.secondaryVocationalHelpNum}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.higherEducationHelpNum" value="${coMain.coPoorStudentPolicy.higherEducationHelpNum}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.totalHelpNum" value="${coMain.coPoorStudentPolicy.totalHelpNum}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.helpNumRemark" value="${coMain.coPoorStudentPolicy.helpNumRemark}"/>
					</td>
				</tr>
				<tr>
					<td>资助金额</td>
					<td>--------</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.compulsoryMoney" value="${coMain.coPoorStudentPolicy.compulsoryMoney}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.seniorHighMoney" value="${coMain.coPoorStudentPolicy.seniorHighMoney}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.secondaryVocationalMoney" value="${coMain.coPoorStudentPolicy.secondaryVocationalMoney}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.higherEducationMoney" value="${coMain.coPoorStudentPolicy.higherEducationMoney}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.totalMoney" value="${coMain.coPoorStudentPolicy.totalMoney}"/>
					</td>
					<td class="bg-white">
						<input type="text" name="coPoorStudentPolicy.moneyRemark" value="${coMain.coPoorStudentPolicy.moneyRemark}"/>
					</td>
				</tr>
				</tbody>
			</table>
			<div class="text-bottom">
				<span>审核人：<input type="text" name="auditor" value="${coMain.auditor}"/> </span>
				<span>填表人：<input type="text" name="formHolder" value="${coMain.formHolder}"/></span>
				<span>联系电话：<input type="text" name="mobile" value="${coMain.mobile}"/></span>
			</div>
			<div class="content-save">
				<shiro:hasPermission name="record:basePoorerRegCard:edit">
					<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
				</shiro:hasPermission>
				<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
			</div>
		</form:form>
		</c:otherwise>
		</c:choose>
	</div>
</div>



</body>
</html>