<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/27
  Time: 9:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>贫困户收入登记表</title>
	<link rel="stylesheet" href="${ctxStatic}/pgfp/css/fpRecord.css"/>
	<link rel="stylesheet" href="${ctxStatic}/pgfp/css/WdatePicker.css"/>
	<link rel="stylesheet" href="${ctxStatic}/pgfp/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script src="${ctxStatic}/pgfp/js/vue.min.js"></script>
	<script src="${ctxStatic}/jquery/jquery-1.8.3.js"></script>
	<script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
	<script src="${ctxStatic}/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/bf/bfRecordIncome/">贫困户收入登记列表</a></li>
	<li class="active"><a href="${ctx}/bf/bfRecordIncomeDetails/preview?recordIncomeId=${income.id}"> 贫困户收入登记表</a></li>
</ul>
<script type="text/javascript">
	$(document).ready(function() {
		
	});
</script>
<div class="header">
	<a class="header-lt">贫困户收入登记表</a>
</div>
<div class="wrapper" style="max-width: 900px" id="app">
	<div class="preview-wrap">
		<form:form id="inputForm" modelAttribute="details" method="post" class="form-horizontal">
			<sys:message content="${messages}"/>
			
			<table cellspacing="0">
		        <tr>
		            <td colspan="5" rowspan="2">类别</td>
		            <td colspan="12">月份</td>
		            <td rowspan="2">全年合计</td>
		        </tr>
		        <tr>
		            <td>1月</td>
		            <td>2月</td>
		            <td>3月</td>
		            <td>4月</td>
		            <td>5月</td>
		            <td>6月</td>
		            <td>7月</td>
		            <td>8月</td>
		            <td>9月</td>
		            <td>10月</td>
		            <td>11月</td>
		            <td>12月</td>
		        </tr>
		        <tr>
		            <td rowspan="11">一、<br>经营<br>性收<br>入</td>
		            <td rowspan="4" colspan="2" style="width: 130px">（一）种植业收入</td>
		            <td colspan="2" style="width: 78px">粮食类</td>
		            <td>${details["1"].o11Rice }</td>
		            <td>${details["2"].o11Rice }</td>
		            <td>${details["3"].o11Rice }</td>
		            <td>${details["4"].o11Rice }</td>
		            <td>${details["5"].o11Rice }</td>
		            <td>${details["6"].o11Rice }</td>
		            <td>${details["7"].o11Rice }</td>
		            <td>${details["8"].o11Rice }</td>
		            <td>${details["9"].o11Rice }</td>
		            <td>${details["10"].o11Rice }</td>
		            <td>${details["11"].o11Rice }</td>
		            <td>${details["12"].o11Rice }</td>
		            <td>${income.o11RiceTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="2">水果类</td>
		            <td>${details["1"].o11Fruits }</td>
		            <td>${details["2"].o11Fruits }</td>
		            <td>${details["3"].o11Fruits }</td>
		            <td>${details["4"].o11Fruits }</td>
		            <td>${details["5"].o11Fruits }</td>
		            <td>${details["6"].o11Fruits }</td>
		            <td>${details["7"].o11Fruits }</td>
		            <td>${details["8"].o11Fruits }</td>
		            <td>${details["9"].o11Fruits }</td>
		            <td>${details["10"].o11Fruits }</td>
		            <td>${details["11"].o11Fruits }</td>
		            <td>${details["12"].o11Fruits }</td>
		            <td>${income.o11FruitsTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="2">蔬菜类</td>
		            <td>${details["1"].o11Vegetables }</td>
		            <td>${details["2"].o11Vegetables }</td>
		            <td>${details["3"].o11Vegetables }</td>
		            <td>${details["4"].o11Vegetables }</td>
		            <td>${details["5"].o11Vegetables }</td>
		            <td>${details["6"].o11Vegetables }</td>
		            <td>${details["7"].o11Vegetables }</td>
		            <td>${details["8"].o11Vegetables }</td>
		            <td>${details["9"].o11Vegetables }</td>
		            <td>${details["10"].o11Vegetables }</td>
		            <td>${details["11"].o11Vegetables }</td>
		            <td>${details["12"].o11Vegetables }</td>
		            <td>${income.o11VegetablesTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="2">其他</td>
		            <td>${details["1"].o11Other }</td>
		            <td>${details["2"].o11Other }</td>
		            <td>${details["3"].o11Other }</td>
		            <td>${details["4"].o11Other }</td>
		            <td>${details["5"].o11Other }</td>
		            <td>${details["6"].o11Other }</td>
		            <td>${details["7"].o11Other }</td>
		            <td>${details["8"].o11Other }</td>
		            <td>${details["9"].o11Other }</td>
		            <td>${details["10"].o11Other }</td>
		            <td>${details["11"].o11Other }</td>
		            <td>${details["12"].o11Other }</td>
		            <td>${income.o11OtherTotal }</td>
		        </tr>
		        <tr>
		            <td rowspan="2" colspan="2">（二）林业收入</td>
		            <td colspan="2">木材类</td>
		            <td>${details["1"].o12Wood }</td>
		            <td>${details["2"].o12Wood }</td>
		            <td>${details["3"].o12Wood }</td>
		            <td>${details["4"].o12Wood }</td>
		            <td>${details["5"].o12Wood }</td>
		            <td>${details["6"].o12Wood }</td>
		            <td>${details["7"].o12Wood }</td>
		            <td>${details["8"].o12Wood }</td>
		            <td>${details["9"].o12Wood }</td>
		            <td>${details["10"].o12Wood }</td>
		            <td>${details["11"].o12Wood }</td>
		            <td>${details["12"].o12Wood }</td>
		            <td>${income.o12WoodTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="2">其他林产品</td>
		            <td>${details["1"].o12Other }</td>
		            <td>${details["2"].o12Other }</td>
		            <td>${details["3"].o12Other }</td>
		            <td>${details["4"].o12Other }</td>
		            <td>${details["5"].o12Other }</td>
		            <td>${details["6"].o12Other }</td>
		            <td>${details["7"].o12Other }</td>
		            <td>${details["8"].o12Other }</td>
		            <td>${details["9"].o12Other }</td>
		            <td>${details["10"].o12Other }</td>
		            <td>${details["11"].o12Other }</td>
		            <td>${details["12"].o12Other }</td>
		            <td>${income.o12OtherTotal }</td>
		        </tr>
		        <tr>
		            <td rowspan="3" colspan="2">（三）养殖业收入</td>
		            <td colspan="2">水产养殖</td>
		            <td>${details["1"].o13Aquatic }</td>
		            <td>${details["2"].o13Aquatic }</td>
		            <td>${details["3"].o13Aquatic }</td>
		            <td>${details["4"].o13Aquatic }</td>
		            <td>${details["5"].o13Aquatic }</td>
		            <td>${details["6"].o13Aquatic }</td>
		            <td>${details["7"].o13Aquatic }</td>
		            <td>${details["8"].o13Aquatic }</td>
		            <td>${details["9"].o13Aquatic }</td>
		            <td>${details["10"].o13Aquatic }</td>
		            <td>${details["11"].o13Aquatic }</td>
		            <td>${details["12"].o13Aquatic }</td>
		            <td>${income.o13AquaticTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="2">特色养殖</td>
		            <td>${details["1"].o13Characteristic }</td>
		            <td>${details["2"].o13Characteristic }</td>
		            <td>${details["3"].o13Characteristic }</td>
		            <td>${details["4"].o13Characteristic }</td>
		            <td>${details["5"].o13Characteristic }</td>
		            <td>${details["6"].o13Characteristic }</td>
		            <td>${details["7"].o13Characteristic }</td>
		            <td>${details["8"].o13Characteristic }</td>
		            <td>${details["9"].o13Characteristic }</td>
		            <td>${details["10"].o13Characteristic }</td>
		            <td>${details["11"].o13Characteristic }</td>
		            <td>${details["12"].o13Characteristic }</td>
		            <td>${income.o13CharacteristicTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="2">畜牧养殖</td>
		            <td>${details["1"].o13Graziery }</td>
		            <td>${details["2"].o13Graziery }</td>
		            <td>${details["3"].o13Graziery }</td>
		            <td>${details["4"].o13Graziery }</td>
		            <td>${details["5"].o13Graziery }</td>
		            <td>${details["6"].o13Graziery }</td>
		            <td>${details["7"].o13Graziery }</td>
		            <td>${details["8"].o13Graziery }</td>
		            <td>${details["9"].o13Graziery }</td>
		            <td>${details["10"].o13Graziery }</td>
		            <td>${details["11"].o13Graziery }</td>
		            <td>${details["12"].o13Graziery }</td>
		            <td>${income.o13GrazieryTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="2">（四）其他收入</td>
		            <td colspan="2"></td>
		            <td>${details["1"].o14Other }</td>
		            <td>${details["2"].o14Other }</td>
		            <td>${details["3"].o14Other }</td>
		            <td>${details["4"].o14Other }</td>
		            <td>${details["5"].o14Other }</td>
		            <td>${details["6"].o14Other }</td>
		            <td>${details["7"].o14Other }</td>
		            <td>${details["8"].o14Other }</td>
		            <td>${details["9"].o14Other }</td>
		            <td>${details["10"].o14Other }</td>
		            <td>${details["11"].o14Other }</td>
		            <td>${details["12"].o14Other }</td>
		            <td>${income.o14OtherTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">小计</td>
		            <td>${details["1"].o1Subtotal }</td>
		            <td>${details["2"].o1Subtotal }</td>
		            <td>${details["3"].o1Subtotal }</td>
		            <td>${details["4"].o1Subtotal }</td>
		            <td>${details["5"].o1Subtotal }</td>
		            <td>${details["6"].o1Subtotal }</td>
		            <td>${details["7"].o1Subtotal }</td>
		            <td>${details["8"].o1Subtotal }</td>
		            <td>${details["9"].o1Subtotal }</td>
		            <td>${details["10"].o1Subtotal }</td>
		            <td>${details["11"].o1Subtotal }</td>
		            <td>${details["12"].o1Subtotal }</td>
		            <td>${income.o1SubtotalAll }</td>
		        </tr>
		        <tr>
		            <td rowspan="6">二、<br>工资<br>性收<br>入（劳<br>务收<br>入）</td>
		            <td colspan="4">乡镇内务工</td>
		            <td>${details["1"].o2WorkerInTown }</td>
		            <td>${details["2"].o2WorkerInTown }</td>
		            <td>${details["3"].o2WorkerInTown }</td>
		            <td>${details["4"].o2WorkerInTown }</td>
		            <td>${details["5"].o2WorkerInTown }</td>
		            <td>${details["6"].o2WorkerInTown }</td>
		            <td>${details["7"].o2WorkerInTown }</td>
		            <td>${details["8"].o2WorkerInTown }</td>
		            <td>${details["9"].o2WorkerInTown }</td>
		            <td>${details["10"].o2WorkerInTown }</td>
		            <td>${details["11"].o2WorkerInTown }</td>
		            <td>${details["12"].o2WorkerInTown }</td>
		            <td>${income.o2WorkerInTownTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">乡外县内务工</td>
		            <td>${details["1"].o2WorkerInCountyTownship }</td>
		            <td>${details["2"].o2WorkerInCountyTownship }</td>
		            <td>${details["3"].o2WorkerInCountyTownship }</td>
		            <td>${details["4"].o2WorkerInCountyTownship }</td>
		            <td>${details["5"].o2WorkerInCountyTownship }</td>
		            <td>${details["6"].o2WorkerInCountyTownship }</td>
		            <td>${details["7"].o2WorkerInCountyTownship }</td>
		            <td>${details["8"].o2WorkerInCountyTownship }</td>
		            <td>${details["9"].o2WorkerInCountyTownship }</td>
		            <td>${details["10"].o2WorkerInCountyTownship }</td>
		            <td>${details["11"].o2WorkerInCountyTownship }</td>
		            <td>${details["12"].o2WorkerInCountyTownship }</td>
		            <td>${income.o2WorkerInCountyTownshipTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">区内县外务工</td>
		            <td>${details["1"].o2WorkerInCounty }</td>
		            <td>${details["2"].o2WorkerInCounty }</td>
		            <td>${details["3"].o2WorkerInCounty }</td>
		            <td>${details["4"].o2WorkerInCounty }</td>
		            <td>${details["5"].o2WorkerInCounty }</td>
		            <td>${details["6"].o2WorkerInCounty }</td>
		            <td>${details["7"].o2WorkerInCounty }</td>
		            <td>${details["8"].o2WorkerInCounty }</td>
		            <td>${details["9"].o2WorkerInCounty }</td>
		            <td>${details["10"].o2WorkerInCounty }</td>
		            <td>${details["11"].o2WorkerInCounty }</td>
		            <td>${details["12"].o2WorkerInCounty }</td>
		            <td>${income.o2WorkerInCountyTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">区外务工</td>
		            <td>${details["1"].o2WorkerOutCounty }</td>
		            <td>${details["2"].o2WorkerOutCounty }</td>
		            <td>${details["3"].o2WorkerOutCounty }</td>
		            <td>${details["4"].o2WorkerOutCounty }</td>
		            <td>${details["5"].o2WorkerOutCounty }</td>
		            <td>${details["6"].o2WorkerOutCounty }</td>
		            <td>${details["7"].o2WorkerOutCounty }</td>
		            <td>${details["8"].o2WorkerOutCounty }</td>
		            <td>${details["9"].o2WorkerOutCounty }</td>
		            <td>${details["10"].o2WorkerOutCounty }</td>
		            <td>${details["11"].o2WorkerOutCounty }</td>
		            <td>${details["12"].o2WorkerOutCounty }</td>
		            <td>${income.o2WorkerOutCountyTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">其他</td>
		            <td>${details["1"].o2WorkerInOtherArea }</td>
		            <td>${details["2"].o2WorkerInOtherArea }</td>
		            <td>${details["3"].o2WorkerInOtherArea }</td>
		            <td>${details["4"].o2WorkerInOtherArea }</td>
		            <td>${details["5"].o2WorkerInOtherArea }</td>
		            <td>${details["6"].o2WorkerInOtherArea }</td>
		            <td>${details["7"].o2WorkerInOtherArea }</td>
		            <td>${details["8"].o2WorkerInOtherArea }</td>
		            <td>${details["9"].o2WorkerInOtherArea }</td>
		            <td>${details["10"].o2WorkerInOtherArea }</td>
		            <td>${details["11"].o2WorkerInOtherArea }</td>
		            <td>${details["12"].o2WorkerInOtherArea }</td>
		            <td>${income.o2WorkerInOtherAreaTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">小计</td>
		            <td>${details["1"].o2Subtotal }</td>
		            <td>${details["2"].o2Subtotal }</td>
		            <td>${details["3"].o2Subtotal }</td>
		            <td>${details["4"].o2Subtotal }</td>
		            <td>${details["5"].o2Subtotal }</td>
		            <td>${details["6"].o2Subtotal }</td>
		            <td>${details["7"].o2Subtotal }</td>
		            <td>${details["8"].o2Subtotal }</td>
		            <td>${details["9"].o2Subtotal }</td>
		            <td>${details["10"].o2Subtotal }</td>
		            <td>${details["11"].o2Subtotal }</td>
		            <td>${details["12"].o2Subtotal }</td>
		            <td>${income.o2SubtotalAll }</td>
		        </tr>
		        <tr>
		            <td rowspan="4">三、<br>财产<br>性收<br>入</td>
		            <td colspan="4">（一）土地流转收入</td>
		            <td>${details["1"].o31LandTransferIncome }</td>
		            <td>${details["2"].o31LandTransferIncome }</td>
		            <td>${details["3"].o31LandTransferIncome }</td>
		            <td>${details["4"].o31LandTransferIncome }</td>
		            <td>${details["5"].o31LandTransferIncome }</td>
		            <td>${details["6"].o31LandTransferIncome }</td>
		            <td>${details["7"].o31LandTransferIncome }</td>
		            <td>${details["8"].o31LandTransferIncome }</td>
		            <td>${details["9"].o31LandTransferIncome }</td>
		            <td>${details["10"].o31LandTransferIncome }</td>
		            <td>${details["11"].o31LandTransferIncome }</td>
		            <td>${details["12"].o31LandTransferIncome }</td>
		            <td>${income.o31LandTransferIncomeTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">（二）红利收入</td>
		            <td>${details["1"].o32Income }</td>
		            <td>${details["2"].o32Income }</td>
		            <td>${details["3"].o32Income }</td>
		            <td>${details["4"].o32Income }</td>
		            <td>${details["5"].o32Income }</td>
		            <td>${details["6"].o32Income }</td>
		            <td>${details["7"].o32Income }</td>
		            <td>${details["8"].o32Income }</td>
		            <td>${details["9"].o32Income }</td>
		            <td>${details["10"].o32Income }</td>
		            <td>${details["11"].o32Income }</td>
		            <td>${details["12"].o32Income }</td>
		            <td>${income.o32IncomeTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">（三）其他收入</td>
		            <td>${details["1"].o33OtherIncome }</td>
		            <td>${details["2"].o33OtherIncome }</td>
		            <td>${details["3"].o33OtherIncome }</td>
		            <td>${details["4"].o33OtherIncome }</td>
		            <td>${details["5"].o33OtherIncome }</td>
		            <td>${details["6"].o33OtherIncome }</td>
		            <td>${details["7"].o33OtherIncome }</td>
		            <td>${details["8"].o33OtherIncome }</td>
		            <td>${details["9"].o33OtherIncome }</td>
		            <td>${details["10"].o33OtherIncome }</td>
		            <td>${details["11"].o33OtherIncome }</td>
		            <td>${details["12"].o33OtherIncome }</td>
		            <td>${income.o33OtherIncomeTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">小计</td>
		            <td>${details["1"].o3Subtotal }</td>
		            <td>${details["2"].o3Subtotal }</td>
		            <td>${details["3"].o3Subtotal }</td>
		            <td>${details["4"].o3Subtotal }</td>
		            <td>${details["5"].o3Subtotal }</td>
		            <td>${details["6"].o3Subtotal }</td>
		            <td>${details["7"].o3Subtotal }</td>
		            <td>${details["8"].o3Subtotal }</td>
		            <td>${details["9"].o3Subtotal }</td>
		            <td>${details["10"].o3Subtotal }</td>
		            <td>${details["11"].o3Subtotal }</td>
		            <td>${details["12"].o3Subtotal }</td>
		            <td>${income.o3SubtotalAll }</td>
		        </tr>
		        <tr>
		            <td rowspan="10">四、<br>政策<br>性收<br>入（转<br>移性<br>收入）</td>
		            <td colspan="4">（一）扶贫补贴</td>
		            <td>${details["1"].o41PovertySubsidy }</td>
		            <td>${details["2"].o41PovertySubsidy }</td>
		            <td>${details["3"].o41PovertySubsidy }</td>
		            <td>${details["4"].o41PovertySubsidy }</td>
		            <td>${details["5"].o41PovertySubsidy }</td>
		            <td>${details["6"].o41PovertySubsidy }</td>
		            <td>${details["7"].o41PovertySubsidy }</td>
		            <td>${details["8"].o41PovertySubsidy }</td>
		            <td>${details["9"].o41PovertySubsidy }</td>
		            <td>${details["10"].o41PovertySubsidy }</td>
		            <td>${details["11"].o41PovertySubsidy }</td>
		            <td>${details["12"].o41PovertySubsidy }</td>
		            <td>${income.o41PovertySubsidyTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">（二）教育补贴</td>
		            <td>${details["1"].o42AducationSubsidy }</td>
		            <td>${details["2"].o42AducationSubsidy }</td>
		            <td>${details["3"].o42AducationSubsidy }</td>
		            <td>${details["4"].o42AducationSubsidy }</td>
		            <td>${details["5"].o42AducationSubsidy }</td>
		            <td>${details["6"].o42AducationSubsidy }</td>
		            <td>${details["7"].o42AducationSubsidy }</td>
		            <td>${details["8"].o42AducationSubsidy }</td>
		            <td>${details["9"].o42AducationSubsidy }</td>
		            <td>${details["10"].o42AducationSubsidy }</td>
		            <td>${details["11"].o42AducationSubsidy }</td>
		            <td>${details["12"].o42AducationSubsidy }</td>
		            <td>${income.o42AducationSubsidyTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">（三）民政补贴</td>
		            <td>${details["1"].o43CivilSubsidy }</td>
		            <td>${details["2"].o43CivilSubsidy }</td>
		            <td>${details["3"].o43CivilSubsidy }</td>
		            <td>${details["4"].o43CivilSubsidy }</td>
		            <td>${details["5"].o43CivilSubsidy }</td>
		            <td>${details["6"].o43CivilSubsidy }</td>
		            <td>${details["7"].o43CivilSubsidy }</td>
		            <td>${details["8"].o43CivilSubsidy }</td>
		            <td>${details["9"].o43CivilSubsidy }</td>
		            <td>${details["10"].o43CivilSubsidy }</td>
		            <td>${details["11"].o43CivilSubsidy }</td>
		            <td>${details["12"].o43CivilSubsidy }</td>
		            <td>${income.o43CivilSubsidyTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">（四）医疗卫生补贴</td>
		            <td>${details["1"].o44MedicalSubsidy }</td>
		            <td>${details["2"].o44MedicalSubsidy }</td>
		            <td>${details["3"].o44MedicalSubsidy }</td>
		            <td>${details["4"].o44MedicalSubsidy }</td>
		            <td>${details["5"].o44MedicalSubsidy }</td>
		            <td>${details["6"].o44MedicalSubsidy }</td>
		            <td>${details["7"].o44MedicalSubsidy }</td>
		            <td>${details["8"].o44MedicalSubsidy }</td>
		            <td>${details["9"].o44MedicalSubsidy }</td>
		            <td>${details["10"].o44MedicalSubsidy }</td>
		            <td>${details["11"].o44MedicalSubsidy }</td>
		            <td>${details["12"].o44MedicalSubsidy }</td>
		            <td>${income.o44MedicalSubsidyTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">（五）农业补贴</td>
		            <td>${details["1"].o45AgriSubsidy }</td>
		            <td>${details["2"].o45AgriSubsidy }</td>
		            <td>${details["3"].o45AgriSubsidy }</td>
		            <td>${details["4"].o45AgriSubsidy }</td>
		            <td>${details["5"].o45AgriSubsidy }</td>
		            <td>${details["6"].o45AgriSubsidy }</td>
		            <td>${details["7"].o45AgriSubsidy }</td>
		            <td>${details["8"].o45AgriSubsidy }</td>
		            <td>${details["9"].o45AgriSubsidy }</td>
		            <td>${details["10"].o45AgriSubsidy }</td>
		            <td>${details["11"].o45AgriSubsidy }</td>
		            <td>${details["12"].o45AgriSubsidy }</td>
		            <td>${income.o45AgriSubsidyTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">（六）林业补贴</td>
		            <td>${details["1"].o46ForestrySubsidy }</td>
		            <td>${details["2"].o46ForestrySubsidy }</td>
		            <td>${details["3"].o46ForestrySubsidy }</td>
		            <td>${details["4"].o46ForestrySubsidy }</td>
		            <td>${details["5"].o46ForestrySubsidy }</td>
		            <td>${details["6"].o46ForestrySubsidy }</td>
		            <td>${details["7"].o46ForestrySubsidy }</td>
		            <td>${details["8"].o46ForestrySubsidy }</td>
		            <td>${details["9"].o46ForestrySubsidy }</td>
		            <td>${details["10"].o46ForestrySubsidy }</td>
		            <td>${details["11"].o46ForestrySubsidy }</td>
		            <td>${details["12"].o46ForestrySubsidy }</td>
		            <td>${income.o46ForestrySubsidyTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">（七）水库移民补贴</td>
		            <td>${details["1"].o47ResettlementSubsidy }</td>
		            <td>${details["2"].o47ResettlementSubsidy }</td>
		            <td>${details["3"].o47ResettlementSubsidy }</td>
		            <td>${details["4"].o47ResettlementSubsidy }</td>
		            <td>${details["5"].o47ResettlementSubsidy }</td>
		            <td>${details["6"].o47ResettlementSubsidy }</td>
		            <td>${details["7"].o47ResettlementSubsidy }</td>
		            <td>${details["8"].o47ResettlementSubsidy }</td>
		            <td>${details["9"].o47ResettlementSubsidy }</td>
		            <td>${details["10"].o47ResettlementSubsidy }</td>
		            <td>${details["11"].o47ResettlementSubsidy }</td>
		            <td>${details["12"].o47ResettlementSubsidy }</td>
		            <td>${income.o47ResettlementSubsidyTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">（八）残疾人补贴</td>
		            <td>${details["1"].o48DisabilitySubsidy }</td>
		            <td>${details["2"].o48DisabilitySubsidy }</td>
		            <td>${details["3"].o48DisabilitySubsidy }</td>
		            <td>${details["4"].o48DisabilitySubsidy }</td>
		            <td>${details["5"].o48DisabilitySubsidy }</td>
		            <td>${details["6"].o48DisabilitySubsidy }</td>
		            <td>${details["7"].o48DisabilitySubsidy }</td>
		            <td>${details["8"].o48DisabilitySubsidy }</td>
		            <td>${details["9"].o48DisabilitySubsidy }</td>
		            <td>${details["10"].o48DisabilitySubsidy }</td>
		            <td>${details["11"].o48DisabilitySubsidy }</td>
		            <td>${details["12"].o48DisabilitySubsidy }</td>
		            <td>${income.o48DisabilitySubsidyTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">（九）其他补贴</td>
		            <td>${details["1"].o49OtherSubsidy }</td>
		            <td>${details["2"].o49OtherSubsidy }</td>
		            <td>${details["3"].o49OtherSubsidy }</td>
		            <td>${details["4"].o49OtherSubsidy }</td>
		            <td>${details["5"].o49OtherSubsidy }</td>
		            <td>${details["6"].o49OtherSubsidy }</td>
		            <td>${details["7"].o49OtherSubsidy }</td>
		            <td>${details["8"].o49OtherSubsidy }</td>
		            <td>${details["9"].o49OtherSubsidy }</td>
		            <td>${details["10"].o49OtherSubsidy }</td>
		            <td>${details["11"].o49OtherSubsidy }</td>
		            <td>${details["12"].o49OtherSubsidy }</td>
		            <td>${income.o49OtherSubsidyTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">小计</td>
		            <td>${details["1"].o4Subtotal }</td>
		            <td>${details["2"].o4Subtotal }</td>
		            <td>${details["3"].o4Subtotal }</td>
		            <td>${details["4"].o4Subtotal }</td>
		            <td>${details["5"].o4Subtotal }</td>
		            <td>${details["6"].o4Subtotal }</td>
		            <td>${details["7"].o4Subtotal }</td>
		            <td>${details["8"].o4Subtotal }</td>
		            <td>${details["9"].o4Subtotal }</td>
		            <td>${details["10"].o4Subtotal }</td>
		            <td>${details["11"].o4Subtotal }</td>
		            <td>${details["12"].o4Subtotal }</td>
		            <td>${income.o4SubtotalAll }</td>
		        </tr>
		        <tr>
		        	<td rowspan="2">五、其他收入</td>
		            <td colspan="4"></td>
		            <td>${details["1"].o5OtherIncome }</td>
		            <td>${details["2"].o5OtherIncome }</td>
		            <td>${details["3"].o5OtherIncome }</td>
		            <td>${details["4"].o5OtherIncome }</td>
		            <td>${details["5"].o5OtherIncome }</td>
		            <td>${details["6"].o5OtherIncome }</td>
		            <td>${details["7"].o5OtherIncome }</td>
		            <td>${details["8"].o5OtherIncome }</td>
		            <td>${details["9"].o5OtherIncome }</td>
		            <td>${details["10"].o5OtherIncome }</td>
		            <td>${details["11"].o5OtherIncome }</td>
		            <td>${details["12"].o5OtherIncome }</td>
		            <td>${income.o5OtherIncomeTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">小计</td>
		            <td>${details["1"].o5Subtotal }</td>
		            <td>${details["2"].o5Subtotal }</td>
		            <td>${details["3"].o5Subtotal }</td>
		            <td>${details["4"].o5Subtotal }</td>
		            <td>${details["5"].o5Subtotal }</td>
		            <td>${details["6"].o5Subtotal }</td>
		            <td>${details["7"].o5Subtotal }</td>
		            <td>${details["8"].o5Subtotal }</td>
		            <td>${details["9"].o5Subtotal }</td>
		            <td>${details["10"].o5Subtotal }</td>
		            <td>${details["11"].o5Subtotal }</td>
		            <td>${details["12"].o5Subtotal }</td>
		            <td>${income.o5SubtotalAll }</td>
		        </tr>
		        <tr>
		            <td colspan="5">六、家庭总收入（一至五项合计）</td>
		            <td>${details["1"].o6TotalFamilyIncome }</td>
		            <td>${details["2"].o6TotalFamilyIncome }</td>
		            <td>${details["3"].o6TotalFamilyIncome }</td>
		            <td>${details["4"].o6TotalFamilyIncome }</td>
		            <td>${details["5"].o6TotalFamilyIncome }</td>
		            <td>${details["6"].o6TotalFamilyIncome }</td>
		            <td>${details["7"].o6TotalFamilyIncome }</td>
		            <td>${details["8"].o6TotalFamilyIncome }</td>
		            <td>${details["9"].o6TotalFamilyIncome }</td>
		            <td>${details["10"].o6TotalFamilyIncome }</td>
		            <td>${details["11"].o6TotalFamilyIncome }</td>
		            <td>${details["12"].o6TotalFamilyIncome }</td>
		            <td>${income.o6TotalFamilyIncomeTotal }</td>
		        </tr>
		        <tr>
		            <td rowspan="5">七、<br>生产<br>经营<br>费用<br>支出</td>
		            <td colspan="4">（一）种植业</td>
		            <td>${details["1"].o71Planting }</td>
		            <td>${details["2"].o71Planting }</td>
		            <td>${details["3"].o71Planting }</td>
		            <td>${details["4"].o71Planting }</td>
		            <td>${details["5"].o71Planting }</td>
		            <td>${details["6"].o71Planting }</td>
		            <td>${details["7"].o71Planting }</td>
		            <td>${details["8"].o71Planting }</td>
		            <td>${details["9"].o71Planting }</td>
		            <td>${details["10"].o71Planting }</td>
		            <td>${details["11"].o71Planting }</td>
		            <td>${details["12"].o71Planting }</td>
		            <td>${income.o71PlantingTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">（二）林业</td>
		            <td>${details["1"].o72Forestry }</td>
		            <td>${details["2"].o72Forestry }</td>
		            <td>${details["3"].o72Forestry }</td>
		            <td>${details["4"].o72Forestry }</td>
		            <td>${details["5"].o72Forestry }</td>
		            <td>${details["6"].o72Forestry }</td>
		            <td>${details["7"].o72Forestry }</td>
		            <td>${details["8"].o72Forestry }</td>
		            <td>${details["9"].o72Forestry }</td>
		            <td>${details["10"].o72Forestry }</td>
		            <td>${details["11"].o72Forestry }</td>
		            <td>${details["12"].o72Forestry }</td>
		            <td>${income.o72ForestryTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">（三）养殖业</td>
		            <td>${details["1"].o73Breed }</td>
		            <td>${details["2"].o73Breed }</td>
		            <td>${details["3"].o73Breed }</td>
		            <td>${details["4"].o73Breed }</td>
		            <td>${details["5"].o73Breed }</td>
		            <td>${details["6"].o73Breed }</td>
		            <td>${details["7"].o73Breed }</td>
		            <td>${details["8"].o73Breed }</td>
		            <td>${details["9"].o73Breed }</td>
		            <td>${details["10"].o73Breed }</td>
		            <td>${details["11"].o73Breed }</td>
		            <td>${details["12"].o73Breed }</td>
		            <td>${income.o73BreedTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">（四）其他</td>
		            <td>${details["1"].o74Other }</td>
		            <td>${details["2"].o74Other }</td>
		            <td>${details["3"].o74Other }</td>
		            <td>${details["4"].o74Other }</td>
		            <td>${details["5"].o74Other }</td>
		            <td>${details["6"].o74Other }</td>
		            <td>${details["7"].o74Other }</td>
		            <td>${details["8"].o74Other }</td>
		            <td>${details["9"].o74Other }</td>
		            <td>${details["10"].o74Other }</td>
		            <td>${details["11"].o74Other }</td>
		            <td>${details["12"].o74Other }</td>
		            <td>${income.o74OtherTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="4">小计</td>
		            <td>${details["1"].o7Subtotal }</td>
		            <td>${details["2"].o7Subtotal }</td>
		            <td>${details["3"].o7Subtotal }</td>
		            <td>${details["4"].o7Subtotal }</td>
		            <td>${details["5"].o7Subtotal }</td>
		            <td>${details["6"].o7Subtotal }</td>
		            <td>${details["7"].o7Subtotal }</td>
		            <td>${details["8"].o7Subtotal }</td>
		            <td>${details["9"].o7Subtotal }</td>
		            <td>${details["10"].o7Subtotal }</td>
		            <td>${details["11"].o7Subtotal }</td>
		            <td>${details["12"].o7Subtotal }</td>
		            <td>${income.o7SubtotalAll }</td>
		        </tr>
		        <tr>
		            <td colspan="5">八、家庭纯收入（第六项减第七项）</td>
		            <td>${details["1"].o8PureIncome }</td>
		            <td>${details["2"].o8PureIncome }</td>
		            <td>${details["3"].o8PureIncome }</td>
		            <td>${details["4"].o8PureIncome }</td>
		            <td>${details["5"].o8PureIncome }</td>
		            <td>${details["6"].o8PureIncome }</td>
		            <td>${details["7"].o8PureIncome }</td>
		            <td>${details["8"].o8PureIncome }</td>
		            <td>${details["9"].o8PureIncome }</td>
		            <td>${details["10"].o8PureIncome }</td>
		            <td>${details["11"].o8PureIncome }</td>
		            <td>${details["12"].o8PureIncome }</td>
		            <td>${income.o8PureIncomeTotal }</td>
		        </tr>
		        <tr>
		            <td colspan="5">九、年人均纯收入</td>
		            <td colspan="13">${income.o9PerCapitaNetIncome }</td>
		        </tr>
		        <%--<tr>--%>
		            <%--<td rowspan="2" colspan="2" style="height: 100px;">签字确认</td>--%>
		            <%--<td colspan="3"></td>--%>
		            <%--<td><img src="${details['1'].houseHolderSign }" class="img"/></td>--%>
		            <%--<td><img src="${details['2'].houseHolderSign }" class="img"/></td>--%>
		            <%--<td><img src="${details['3'].houseHolderSign }" class="img"/></td>--%>
		            <%--<td><img src="${details['4'].houseHolderSign }" class="img"/></td>--%>
		            <%--<td><img src="${details['5'].houseHolderSign }" class="img"/></td>--%>
		            <%--<td><img src="${details['6'].houseHolderSign }" class="img"/></td>--%>
		            <%--<td><img src="${details['7'].houseHolderSign }" class="img"/></td>--%>
		            <%--<td><img src="${details['8'].houseHolderSign }" class="img"/></td>--%>
		            <%--<td><img src="${details['9'].houseHolderSign }" class="img"/></td>--%>
		            <%--<td><img src="${details['10'].houseHolderSign }" class="img"/></td>--%>
		            <%--<td><img src="${details['11'].houseHolderSign }" class="img"/></td>--%>
		            <%--<td><img src="${details['12'].houseHolderSign }" class="img"/></td>--%>
		            <%--<td></td>--%>
		        <%--</tr>--%>
		        <tr>
		            <td colspan="5">户主（家庭代表）签名</td>
		            <td><img src="${details['1'].cadreSign }" class="img"/></td>
		            <td><img src="${details['2'].cadreSign }" class="img"/></td>
		            <td><img src="${details['3'].cadreSign }" class="img"/></td>
		            <td><img src="${details['4'].cadreSign }" class="img"/></td>
		            <td><img src="${details['5'].cadreSign }" class="img"/></td>
		            <td><img src="${details['6'].cadreSign }" class="img"/></td>
		            <td><img src="${details['7'].cadreSign }" class="img"/></td>
		            <td><img src="${details['8'].cadreSign }" class="img"/></td>
		            <td><img src="${details['9'].cadreSign }" class="img"/></td>
		            <td><img src="${details['10'].cadreSign }" class="img"/></td>
		            <td><img src="${details['11'].cadreSign }" class="img"/></td>
		            <td><img src="${details['12'].cadreSign }" class="img"/></td>
		            <td></td>
		        </tr>
		        <tr>
		            <td colspan="5">贫困户对干部帮扶满意度</td>
		            <td colspan="13">${fns:getDictLabel(income.degreeOfSatisfaction, 'satisfaction', '')}</td>
		        </tr>
		        <tr style="height: 100px;">
		            <td colspan="5">备注</td>
		            <td colspan="13">${income.remarks }</td>
		        </tr>
	    	</table>
			
		</form:form>
		<div class="form-actions">
			<%--<shiro:hasPermission name="bf:bfSubsidyType:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>--%>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</div>
</div>
<style>
	img{
		width:100%;
		height:100%;
		border: none;
	}
</style>
</body>
</html>
