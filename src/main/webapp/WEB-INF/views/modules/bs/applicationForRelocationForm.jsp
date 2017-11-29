<%@ taglib prefix="fnt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
	<title>移民搬迁申请表管理</title>
	<meta name="decorator" content="default"/>
	<%--<script type="text/javascript">
        $(document).ready(function () {
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
	</script>--%>
	<style>
		.control-group .input {
			border-width: 0 0 1px 0;
			text-align: center;
			border-bottom-color: #000000;
		}

		.text, .input {
			font-size: 17px;
		}

		h1 {
			text-align: center;
		}

		.text {
			line-height: 45px;
		}

		.control-group {
			margin-left: 60px;
			width: 870px;

		}

		.control-group .white {
			padding: 12px 8px 12px 8px;
			text-align: center;
			font-size: 15px;
		}

		/*.control-group input[type="text"]:focus{*/
		/*border-color: #fff;*/
		/*outline: none;*/
		/*box-shadow: none;*/
		/*}*/
		input[readonly] {
			background-color: #fff;
		}

		.fb {
			font-weight: bold;
		}

		p {
			margin: 0px;
		}

		td.fb {
			background-color: #f5f5f5;
		}
		.return{
			display: inline-block;
			padding: 4px 12px;
			border: 1px solid rgb(179,179,179);
			font-size: 14px;
			line-height: 20px;
			color: #333;
			text-align: center;
			text-shadow: 0 1px 1px rgba(255, 255, 255, 0.75);
			border-radius: 4px;
			text-decoration: none;
			vertical-align: top;
			margin-left: 20px;
		}
		.return:hover{
			color: #333;
			text-decoration: none;
		}
		.accept {
			margin-left: 500px;
			color: #333;
			background: #4b7ee6;
		}

		.accept:hover {
			color: #fff;
			background: #4b7ee6;
		}

		.back {
			color: #333;
			background: #ff3c2f;
		}

		.back:hover {
			color: #fff;
			background: #ff3c2f;
		}
		.btn.back[readonly]{
			color: #333;
		}
		.btn.back[readonly]:hover{
			color: #333;
			background-color: rgb(243,243,243);
		}
	</style>
</head>
<body style="width: 860px">
<script>
    $(function(){
        $("input").attr("readonly", "true");
        check();
    });

    function check(v) {
        var value= ${applicationForRelocation.checkState};
        if(v){
            value = v;
        }
        //判断状态
        if (value == '0') {
            $(".checkState").text("未处理");
        } else if (value == '1') {
            $(".checkState").text("已受理");
            alter(".back",false);
            alter(".accept",true);
        } else if (value == '2') {
            $(".checkState").text("已驳回");
            alter(".back",true);
            alter(".accept",false);
        }
    };
    function alter(str,b){
        $(str).attr("disabled",b);
    }

</script>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/bs/applicationForRelocation/">移民搬迁申请表列表</a></li>
	<li class="active"><a
			href="${ctx}/bs/applicationForRelocation/form?id=${applicationForRelocation.id}">移民搬迁申请表详情</a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="applicationForRelocation" class="form-horizontal">
	<form:hidden class="id" path="id"/>
	<div class="control-group">
		<br/><br/><br/>
		<h1>广西壮族自治区易地扶贫搬迁申请书</h1>
		<br/><br/>
		<p class="text">
			<form:input path="country1" class="input" style="width: 180px;" type="none"/>乡（镇）人民政府：</p>
		<p class="text" style="text-indent:4em;">
			<span>本人</span>
			<form:input path="name" class="input" style="width: 130px;" type="none"/>
			<span>，身份证号</span>
			<form:input path="idNumber" style="width:290px;" maxlength="18" class="input" type="none"/>
			<span>，性别</span>
			<form:input path="sex" class="input" style="width: 70px;" type="none"/>
			<span>，年龄</span>
			<form:input path="age" class="input" style="width: 70px;" type="none"/>
			<span>岁，家住</span>
			<form:input path="city" class="input" style="width: 120px;" type="none"/>
			<span>市</span>
			<form:input path="area" class="input" style="width: 120px;" type="none"/>
			<span>县（市、区）</span>
			<form:input path="country2" class="input" style="width: 120px;" type="none"/>
			<span>乡（镇）</span>
			<form:input path="village" class="input" style="width: 120px;" type="none"/>
			<span>村</span>
			<form:input path="tun" class="input" style="width: 120px;" type="none"/>
			<span>屯，现有家庭人口</span>
			<form:input path="memberNumber" class="input" style="width: 80px;" type="none"/>
			<span>人，其中：劳动力</span>
			<form:input path="labourNumber" class="input" style="width: 80px;" type="none"/>
			<span>人，残疾</span>
			<form:input path="disableNumber" class="input" style="width: 80px;" type="none"/>
			<span>人，重大疾病</span>
			<form:input path="majorDiseases" class="input" style="width: 80px;" type="none"/>
			<span>人，新一轮精准识别得分</span>
			<form:input path="score" class="input" style="width: 80px;" type="none"/>
			<span>分,属于</span>
			<c:choose>
				<c:when test="${applicationForRelocation.poorType == '1'}">
					<c:set var="poor" value="①建档立卡贫困户" scope="page"/>
				</c:when>
				<c:otherwise>
					<c:set var="poor" value="②同步搬迁的其他农户" scope="page"/>
				</c:otherwise>
			</c:choose>
			<input id="poorType" name="poorType" class="input" style="width: 180px;" type="none" value="${poor}"/>
			<span>。由于我村（组、屯）地处偏远，</span>
			<span>生存环境恶劣，发展条件受到严重制约，为尽快脱贫致富，本人及全家成员自愿</span>
			<span>申请易地扶贫搬迁到<b>
				<%--平桂老乡家园--%>
				<form:input path="place" class="input" style="width: 120px;" type="none"/>
				</b>安置点进行集中安置，并遵守易地扶贫搬迁有关</span>
			<span>政策规定，愿意通过易地扶贫搬迁和自己辛勤劳动实现脱贫致富。</span>
		</p>
		<p class="text" style="text-indent:4em;">请予批准！</p><br/><br/><br/><br/>
			<%--<p class="text" style="text-indent:22em;">--%>
			<%--申请人（签字、手印）：<input id="signature" name="signature" class="input" style="width: 180px;"/>--%>
			<%--</p>--%>
		<p class="text" style="text-indent:28em;">
			联系电话：<form:input path="phone" name="phone" class="input" style="width: 180px;" type="none"/>
		</p>

		<p class="text" style="text-indent:32em;">
			<fmt:formatDate value="${applicationForRelocation.applyDate}" pattern="yyyy  年  MM  月 dd 日"/>
		</p>
	</div>
	<br/>
	<div class="control-group">
		<br/><br/><br/>
		<h1>广西壮族自治区易地扶贫搬迁审批表</h1>
		<br/><br/>
		<p class="text">
			<span class="fb">编  号：</span>
				${applicationForRelocation.approvalForRelocation.serialNumber}
			<span style="float: right">
				<span align="right" class="fb">申请日期：</span>
				<fmt:formatDate value="${applicationForRelocation.approvalForRelocation.applyDate}"
				                pattern="yyyy  年  MM  月 dd 日"/>
			</span>

		</p>
		<table border="1px" style="width:100%" cellspacing="10">
			<tr>
				<td class="white fb" colspan="2">
					申请人（户主）
				</td>
				<td class="white" colspan="2">
						${applicationForRelocation.approvalForRelocation.name}
				</td>
				<td class="white fb">
					性别
				</td>
				<td class="white">
						${applicationForRelocation.approvalForRelocation.sex}
				</td>
				<td class="white fb" colspan="2">
					身份证号码
				</td>
				<td class="white" colspan="3">
						${applicationForRelocation.approvalForRelocation.idNumber}
				</td>
			</tr>
			<tr>
				<td class="white fb">
					民族
				</td>
				<td class="white">
						${applicationForRelocation.approvalForRelocation.nation}
				</td>
				<td class="white fb" colspan="2" style="padding: 10px;">
					文化程度
				</td>
				<td class="white">
						${applicationForRelocation.approvalForRelocation.education}
				</td>
				<td class="white fb">
					家庭住址
				</td>
				<td class="white" colspan="2">
						${applicationForRelocation.approvalForRelocation.address}
				</td>
				<td class="white fb">
					联系电话
				</td>
				<td class="white" colspan="2">
						${applicationForRelocation.approvalForRelocation.phone}
				</td>
			</tr>
			<tr>
				<td class="white fb" colspan="2">
					核定搬迁人口
				</td>
				<td class="white" colspan="2">
						${applicationForRelocation.approvalForRelocation.moveNumber}<span class="fb">人</span>
				</td>
				<td class="white fb">
					类型
				</td>
				<td class="white" colspan="6">
					新一轮精准识别得分 ${applicationForRelocation.approvalForRelocation.score}
					<c:set var="poorType" value="${applicationForRelocation.approvalForRelocation.poorType}"/>
					分，属于 ${poorType == "1"?"①建档立卡贫困户":poorType == "2"?"②需要同步搬迁的其他农户":""}
				</td>
			</tr>
			<tr>
				<td class="white" colspan="11">
					<span class="fb">家庭人口情况：</span>总人口数 ${applicationForRelocation.approvalForRelocation.totalNumber}
					人，其中：劳动力 ${applicationForRelocation.approvalForRelocation.laborNumber}
					人，残疾 ${applicationForRelocation.approvalForRelocation.disableNumber}
					人，重大疾病 ${applicationForRelocation.approvalForRelocation.majorDiseases}
					人（详见下表）
				</td>
			</tr>

			<tr>
				<td class="white fb" style="width: 70px;">家庭成员姓名</td>
				<td class="white fb" style="width: 55px;">与户主关系</td>
				<td class="white fb" style="width: 40px;">性别</td>
				<td class="white fb" style="width: 40px;">民族</td>
				<td class="white fb" style="width: 200px;" colspan="2">身份证号码</td>
				<td class="white fb" style="width: 40px;">文化程度</td>
				<td class="white fb" style="width: 80px;">是否建档立卡人口</td>
				<td class="white fb" style="width: 70px;">健康状况</td>
				<td class="white fb" style="width: 40px;" colspan="2">有何技能</td>
			</tr>
			<c:forEach items="${applicationForRelocation.approvalFamilyMember}" var="menber">
				<tr>
					<td class="white" height="20px">${menber.name}</td>
					<td class="white">${menber.relationship}</td>
					<td class="white">${menber.sex}</td>
					<td class="white">${menber.nation}</td>
					<td class="white" colspan="2">${menber.idNumber}</td>
					<td class="white">${menber.education}</td>
					<td class="white">${menber.isFiling}</td>
					<td class="white">${menber.isHealth}</td>
					<td class="white">${menber.skill}</td>
				</tr>
			</c:forEach>
			<tr>
				<td class="white" height="20px"></td>
				<td class="white"></td>
				<td class="white"></td>
				<td class="white"></td>
				<td class="white" colspan="2"></td>
				<td class="white"></td>
				<td class="white"></td>
				<td class="white"></td>
				<td class="white"></td>
			</tr>
			<tr>
				<td class="white" colspan="11">
					<c:set var="isHealth" value="${applicationForRelocation.approvalForRelocation.isHealth}"/>
					健康状况选项：
					<c:choose>
						<c:when test="${isHealth == '①'}">①健康</c:when>
						<c:when test="${isHealth == '②'}">②残疾</c:when>
						<c:when test="${isHealth == '③'}">③重大疾病</c:when>
						<c:otherwise>其它</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td class="white fb" colspan="2">
					现有土地情况
				</td>
				<td class="white" colspan="9" style="text-align: left">
					耕地（水田、旱地、自留地等）
					<%--<fnt:formatNumber var="cultivateLand" value="${applicationForRelocation.approvalForRelocation.cultivateLand}" pattern="#0.##">
						${cultivateLand}--%>
					<fnt:formatNumber pattern="#0.##" value="${applicationForRelocation.approvalForRelocation.cultivateLand}"/>
					亩，林地
					<fnt:formatNumber pattern="#0.##" value="${applicationForRelocation.approvalForRelocation.woodland}"/>
					亩。
				</td>
			</tr>
			<tr>
				<td class="white fb" colspan="2">
					现有住房情况
				</td>
				<td class="white" colspan="9" style="text-align: left">
					住房面积：
					<fnt:formatNumber value="${applicationForRelocation.approvalForRelocation.houseArea}" pattern="#0.##"/>
					㎡，宅基地面积：
					<fnt:formatNumber value="${applicationForRelocation.approvalForRelocation.baseArea}" pattern="#0.##"/>
					㎡。住房结构：
					<c:set var="houseStructure"
					       value="${applicationForRelocation.approvalForRelocation.houseStructure}"/>
					<c:choose>
						<c:when test="${houseStructure != null}">
							${houseStructure}
						</c:when>
						<c:otherwise>无房</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td class="white fb" colspan="2">
					人口就业情况
				</td>
				<td class="white" colspan="9" style="text-align: left">
					<c:set var="peopleEmploy" value="${applicationForRelocation.approvalForRelocation.peopleEmploy}"/>
					<c:choose>
						<c:when test="${peopleEmploy != null}">
							${peopleEmploy}
						</c:when>
						<c:otherwise>其它</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td class="white fb" colspan="2">
					计划搬迁情况
				</td>
				<td class="white" colspan="9" style="text-align: left">
					搬迁年份
					<c:set var="year" value="${applicationForRelocation.approvalForRelocation.year}"/>
					<c:choose>
						<c:when test="${peopleEmploy != null}">
							<fnt:formatDate value="${year}" pattern="YYYY"/>
						</c:when>
						<c:otherwise>________</c:otherwise>
					</c:choose>
					年，安置地点：
					<c:set var="place" value="${applicationForRelocation.approvalForRelocation.place}"/>
					<c:choose>
						<c:when test="${place != null}">
							${place}
						</c:when>
						<c:otherwise>________</c:otherwise>
					</c:choose>
					，住房建筑面积约
					<c:set var="buildArea" value="${applicationForRelocation.approvalForRelocation.buildArea}"/>
					<c:choose>
						<c:when test="${buildArea != null}">
							${buildArea}
						</c:when>
						<c:otherwise>0</c:otherwise>
					</c:choose>
					平方米。<br/>
					安置方式：
					<c:set var="method" value="${applicationForRelocation.approvalForRelocation.method}"/>
					<c:choose>
						<c:when test="${method != null}">
							${method}
						</c:when>
						<c:otherwise>________</c:otherwise>
					</c:choose>

				</td>
			</tr>
			<tr>
				<td class="white fb" colspan="11" style="font-size: 20px;padding: 14px;">
					审&nbsp; &nbsp; 批 &nbsp;&nbsp; 意&nbsp;&nbsp; 见
				</td>
			</tr>
			<tr>
				<td class="white fb" colspan="5">
					迁出地所在村（居）委会意见
				</td>
				<td class="white fb" colspan="6">
					迁出地所在乡（镇）政府意见
				</td>
			</tr>
			<tr>
				<td class="white" colspan="5" style="text-align:left">
					<div style="margin: 15px 0px 160px 30px">
						<span>该农户自愿搬迁。</span>
					</div>
					<span style="margin-left:180px">(盖章)<br><br></span>
					<span style="margin-left:80px">经办人：</span>
					<span style="margin-left:80px">负责人：</span>
					<br/>
					<br/>
					<span style="margin-left: 215px">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日</span>
					<br/><br/>
				</td>
				<td class="white" colspan="6" style="text-align:left">
					<div style="margin: 0px 30px 45px 30px">
						<p style="text-indent:2em;line-height:35px;">
							农户自愿搬迁到
							<input class="input" style="width:100px"/>
							区
							<input class="input" style="width:155px"/>
							街道，
							<input class="input" style="width:140px"/>
							进行
							<input class="input" style="width:140px"/>
							安置。
						</p>
						<p style="text-indent:2em;line-height:35px;">
							经核定，该户搬迁人口
							<input class="input" style="width:100px"/>
							人，安置房建筑面积约
							<input class="input" style="width:100px"/>
							平方米，按我县差异化住房补助标准，获得住房补助合计
							<input class="input" style="width:120px"/>
							元。
						</p>
					</div>
					<span style="margin-left:315px">(盖章)<br><br></span>
					<span style="margin-left:210px">经办人：</span>
					<span style="margin-left:80px">负责人：</span>
					<br/>
					<br/>
					<span style="margin-left: 345px">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日</span>
					<br/>
				</td>
			</tr>
			<tr>
				<td class="white fb" colspan="5">
					县（区）级扶贫部门意见
				</td>
				<td class="white fb" colspan="6">
					县（区）级建设部门意见
				</td>
			</tr>
			<tr>
				<td class="white" colspan="5" style="text-align:left">
					<div style="margin: 15px 0px 160px 30px">
						<p><span style="font-size: 24px">□ </span><span>该户属</span><input class="input"
						                                                                 style="width:80px"/><span>年建档立卡贫困户</span>
						</p>
						<p><span style="font-size: 24px">□ </span>该户属同步搬迁的其他农户</p>
					</div>
					<span style="margin-left:180px">(盖章)<br><br></span>
					<span style="margin-left:80px">经办人：</span>
					<span style="margin-left:80px">负责人：</span>
					<br/>
					<br/>
					<span style="margin-left: 215px">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日</span>
					<br/><br/>
				</td>
				<td class="white" colspan="6" style="text-align:left">
					<div style="margin: 0px 30px 200px 30px">
						<p>该农户未享受过危房改造政策 </p>
					</div>
					<span style="margin-left:315px">(盖章)<br><br></span>
					<span style="margin-left:210px">经办人：</span>
					<span style="margin-left:80px">负责人：</span>
					<br/>
					<br/>
					<span style="margin-left: 345px">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日</span>
					<br/>
				</td>
			</tr>
			<tr>
				<td class="white fb" colspan="11">
					县（区）级移民专责小组审批意见
				</td>
			</tr>
			<tr>

				<td class="white" colspan="11" style="text-align:left">
					<div style="margin: 0px 30px 100px 30px">
						<p style="text-indent:2em;line-height:35px;">
							同意列为
							<input class="input" style="width:100px"/>
							年易地扶贫搬迁对象，安排到
							<input class="input" style="width:180px"/>
							进行
							<input class="input" style="width:140px"/>
							安置。
						</p>
					</div>
					<span style="margin-left:630px">(盖章)<br><br></span>
					<span style="margin-left:525px">经办人：</span>
					<span style="margin-left:80px">负责人：</span>
					<br/>
					<br/>
					<span style="margin-left: 660px">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日</span>
					<br/><br/>
				</td>
			</tr>
		</table>
		<div class="white" colspan="11" style="text-align:left">
			<p style="line-height: 25px;text-indent: -2em;margin-left: 20px"><span class="fb">注：</span>1.申请书及审批表内容不能随意改动，双面打印一式七份（分别由农户、村委、镇政府、扶贫办、建设局、移民搬迁专责小组、平顺公司各存一份）；
				<br>2.移民搬迁安置住房面积人均不能超25平方米。<br>
				<span class="fb">应有附件：</span>1.申请人家庭全体成员在现住房前合照的相片；
				2.家庭人口户口簿复印件；
				3.乡（镇）人民政府出具的新一轮精准识别得分证明。
			</p>
		</div>
	</div>
	<div class="control-group">
		<br/><br/><br/><br/>
		<h1>广西壮族自治区易地扶贫搬迁及旧房拆除协议</h1>
		<br/><br/>
		<p class="text">
			甲 方:<form:input path="demolitionAgreement.country1" class="input" style="width:200px"
			                type="none"/>乡（镇）人民政府<br>
			乙 方:<form:input path="demolitionAgreement.name" class="input" style="width:200px" type="none"/>（搬迁户户主）<br>
			身份证号:<form:input path="demolitionAgreement.idNumber" class="input" style="width:300px" type="none"/>
			联系电话:<form:input path="demolitionAgreement.phone" class="input" style="width:200px" type="none"/>
		</p>
		<br/>
		<div class="text">
			<p style="text-indent: 2em">
				根据国家发展和改革委员会、国务院扶贫开发领导小组办公室、财政部、国土资源部、中国人民银行
				《关于印发“十三五”时期易地扶贫搬迁工作方案的通知》（发改地区〔2015〕2769号）精神，本着
				自愿、平等、公开原则，经甲乙双方共同协商，就甲、乙双方搬迁安置、旧房拆除等方面达成如下协议：
			</p>
			<p style="text-indent: 2em">
				一、乙方现居住在
				<form:input path="demolitionAgreement.area1" class="input" style="width:130px" type="none"/>县（市、区）
				<form:input path="demolitionAgreement.country2" class="input" style="width:170px" type="none"/>乡（镇）
				<form:input path="demolitionAgreement.village1" class="input" style="width:170px" type="none"/>村
				<form:input path="demolitionAgreement.group1" class="input" style="width:130px" type="none"/>组，住房建筑总面积
				<form:input path="demolitionAgreement.houseArea" class="input" style="width:110px" type="none"/>平方米，宅基地面积
				<form:input path="demolitionAgreement.baseArea" class="input" style="width:110px" type="none"/>平方米；核定搬迁人口
				<form:input path="demolitionAgreement.movePerson" class="input" style="width:110px" type="none"/>人；新一轮精准识别
				<form:input path="demolitionAgreement.score" class="input" style="width:110px" type="none"/>分。
			</p>
			<p style="text-indent: 2em">
				二、乙方符合国家易地扶贫搬迁政策，经全体家庭成员一致同意，自愿申请搬迁到
				<form:input path="demolitionAgreement.city" class="input" style="width:160px" type="none"/>市
				<form:input path="demolitionAgreement.area2" class="input" style="width:130px" type="none"/>县（市、区）
				<form:input path="demolitionAgreement.country3" class="input" style="width:160px" type="none"/>乡（镇）
				<form:input path="demolitionAgreement.village2" class="input" style="width:160px" type="none"/>村（社区），安置地点为
				<form:input path="demolitionAgreement.movePlace" class="input" style="width:160px" type="none"/>，安置房建筑面积约为
				<form:input path="demolitionAgreement.moveArea" class="input" style="width:110px" type="none"/>平方米。
			</p>
			<p style="text-indent: 2em">
				三、乙方安置房采取购买商品房方式。
			</p>
			<p class="text" style="text-indent: 2em">
				四、乙方搬迁安置住房补助资金计
				<form:input path="demolitionAgreement.subsidyMoney" class="input" style="width:100px" type="none"/>元（人均补助标准
				按当地县级政府规定执行，币种为人民币，下同）。乙方按照甲方制定的分房（购房、建房）方案，在甲方规定的时间内搬迁入住。
			</p>
			<p style="text-indent: 2em">
				五、乙方同意在搬迁入住安置新房后两年左右自行拆除旧房或同意相关部门组织拆除原旧房及附属设施实施并复垦，甲方应结合乙方旧房质量、旧宅基地占
				地面积、复垦价值等情况，按照拆除旧房后给予乙方 20000 元奖励。
			</p>
			<p style="text-indent: 2em">
				六、乙方须按甲方制定的搬迁户建房自筹资金方案，交纳自筹资金。本协议签订后，乙方须按甲方要求在规定期限内向甲方指定账户交纳建房自筹资金
				<form:input path="demolitionAgreement.raiseMoney" class="input" style="width:100px" type="none"/>
				元；乙方逾期不交的，甲方有权取消乙方易地扶贫搬迁资格。
			</p>
			<p style="text-indent: 2em">
				七、安置住房补助资金和旧房（含附属设施）拆除奖励资金按安置方式及政策规定使用和结算。
			</p>
			<p style="text-indent: 2em">
				八、甲方在乙方办理安置住房确权办证、户籍登记、社会保险、就业培训、子女就学等方面提供服务和支持。乙方须积极配合甲方做好易地
				扶贫搬迁安置各项工作，并服从甲方的社会管理。乙方取得不动产权10年内不得转让。
			</p>
			<p style="text-indent: 2em">
				九、其他约定：
				<form:input path="demolitionAgreement.other" class="input" style="width:670px;text-align:left"
				            type="textarea"/>
				。
			</p>
			<p style="text-indent: 2em">
				十、本协议一经签订，视为双方自愿认可，甲、乙双方必须严格遵守执行。双方如有未尽事宜，可另行补充协议，具有同等效力。
			</p>
			<p style="text-indent: 2em">
				十一、本协议壹式伍份，甲、乙双方各执壹份，县级发展改革局、扶贫办、国土资源局备案各壹份。本协议自双方签字、盖章之日起生效。
			</p>
			<div style="margin: 50px 0px 50px 30px">
				<p><span>甲方（公章）：</span><span style="margin-left: 200px">乙方（签字、手印）:</span></p>
				<p>法定代表人或委托代理人（签字）：</p>
				<p>协议签订时间：<span style="margin-left: 70px">年</span><span style="margin-left: 40px">月</span>
					<span style="margin-left: 40px">日</span></p>
			</div>
		</div>
	</div>
	<div class="control-group" style="margin:10px 60px;height: 60px;padding: 0px">
		<span class="text fb">审核状态:</span><span class="text checkState fb" style="color: red;margin-left: 15px"></span>
	</div>
	<div class="control-group" style="margin:10px 60px;">
		<span class="text fb">审批意见:</span>
		<textarea id="remarks" name="remarks" style="min-width:350px;margin-bottom:5px;">${applicationForRelocation.remarks}</textarea>
	</div>
	<div class="control-group" style="margin:20px 60px;height: 60px;padding: 0px">
		<input class="btn accept" type="button" data-tar="1" style="margin-left: 300px" value="同意">
		<input class="btn back" type="button" data-tar="2" style="margin-left: 20px;color:#333;" value="驳回">
		<a class="return" href="${ctx}/bs/applicationForRelocation/">返回</a>
		<%--<input class="btn" type="button" style="margin-left: 20px" onclick="history.go(-1)" value="返回">--%>
	</div>
</form:form>
<script>
    $(".accept,.back").on("click",function () {
        var sta = $(this).data("tar");
        var id = $("input[class='id']").val();
		var remarks = $("textarea[id='remarks']").val();
        $.ajax({
            url: '${basePath}/a/bs/applicationForRelocation/check',
            type: 'post',
            dataType: 'json',
            data:{
                id:id,
                sta: sta,
				remarks:remarks
            },
            success: function (res) {
                if(res.sta === '1'){
                    check(1);
                }else if(res.sta == '2'){
                    check(2);
                }
            },
            error: function (error) {
                console.log(error);
            }
        });
    })
</script>
</body>
</html>