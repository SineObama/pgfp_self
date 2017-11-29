<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户惠农补贴</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
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
	<li ><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/list3">农村危房改造列表</a></li>
	<li class="active">
		<a  href="${ctx}/bf/bfPoorHouseholdsSubsidy/view?id=${hold.id}">
			农村危房改造按年修改
		</a>
	</li>
</ul>
	<div class="content tabs f-clear">
	<div id="tab-15" class="content-detail">
	<form:form id="inputForm" modelAttribute="hold" action="${ctx}/bf/bfPoorHouseholdsSubsidy/saveV" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<br/>
		<table>
			<tbody id="accpitem">
			<tr class="bg-white">
				<td colspan="2">
					录入干部：${hold.createBy.name}
					<span style="float:right;">归属年度：
					  <form:input path="years" disabled="true" style="background-color:#fff;width:100px;"/>
					</span>
				</td>
			</tr>
			<tr>
                <td class="fir-td"><span>建档立卡农户姓名</span></td>
                <td class="sec-td bg-white">
					<input type="hidden" name="hold.id" value="${hold.id}" class="id"/>
					<input type="hidden" name="hold.type" value="2" class="type"/>
					<form:hidden path="regCard.id" class="regCardId"/>
					<form:input path="regCard.houseHolderName" maxlength="200" class="houseHolderName input-xlarge  "/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>身份证号</span></td>
                <td class="sec-td">
                	<form:input path="member.idNumber" maxlength="200" class="idNumber input-xlarge  " disabled="true"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>户口本号</span></td>
                <td class="sec-td">
                	<form:input path="regCard.residenceBookletNumber" maxlength="200" class="residenceBookletNumber input-xlarge  " disabled="true"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>一折通账号</span></td>
                <td class="sec-td">
					<form:input type="text" path="regCard.bankAccount" class="bankAccount" disabled="true"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>开户银行</span></td>
                <td class="sec-td">
					<form:input type="text" path="regCard.bankName" class="bankName" disabled="true"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>家庭住址</span></td>
                <td class="sec-td">
					<form:input type="text" path="regCard.address" class="address" disabled="true"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>补贴政策名称</span></td>
                <td class="sec-td bg-white">
					<%--<form:hidden path="project.id" class="projectId"/>--%>
					<%--<form:input path="project.title" class="projectTitle" htmlEscape="false"/>--%>
					<form:hidden path="subType.id" class="subTypeId"/>
					<form:input type="text" path="subType.subsidyType" class="subsidyType"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>补贴总量/补贴面积</span></td>
                <td class="sec-td bg-white">
					<form:input type="text" path="sbMountArea" class="sbMountArea"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>补贴标准</span></td>
                <td class="sec-td bg-white">
					<form:input type="text" path="sbStandard" class="sbStandard"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>补贴金额</span></td>
                <td class="sec-td bg-white">
					<form:input type="text" path="sbAmount" class="sbAmount"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>兑付时间</span></td>
                <td class="sec-td bg-white">
					<input name="honourTime" type="text" readonly="readonly" maxlength="20" class="honourTime input-medium Wdate  required"
							   value="<fmt:formatDate value="${hold.honourTime}" pattern="yyyy-MM-dd"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="background-color: #FFF;"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>备注</span></td>
                <td class="sec-td bg-white">
					<form:input type="text" path="remark" class="remark"/>
				</td>
            </tr>
			
		</tbody>
	</table>
		<div class="content-save">
			<shiro:hasPermission name="bf:bfPoorHouseholdsSubsidy:edit">
				<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	</div>
	</div>

<script >
	function chooseHolds(regCard){
		//农户id
		$(".regCardId").val(regCard.id);
		//建档立卡农户姓名
		$(".houseHolderName").val(regCard.houseHolderName);
		//身份证号
		$(".idNumber").val(regCard.houseHolder.idNumber);
		//户口本号
		$(".residenceBookletNumber").val(regCard.residenceBookletNumber);
		//一折通账号
		$(".bankAccount").val(regCard.bankAccount);
		//开户银行
		$(".bankName").val(regCard.bankName);
		//家庭住址
		$(".address").val(regCard.address);
	}
	
//	function chooseProject(project){
////		console.debug(member);
//		$(".projectId").val(project.id);
//		$(".projectTitle").val(project.title);
//	}

	function chooseSubsidyType(data){
	console.log(data);
		$(".subTypeId").val(data.id);
		$(".subsidyType").val(data.subsidyType);
	}
	
	//弹出户窗口
	$(function () {
		$("#accpitem").delegate(".houseHolderName",'click',function(){
			var iWidth = 900;
			var iHeight = 500;
			var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
			var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
			var win = window.open("${ctx}/record/basePoorerRegCard/holdsChoose?years=${hold.years}", "弹出窗口", "width=" + iWidth +
			", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
			",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
			"status=no,alwaysRaised=yes,depended=yes");
		});
	});

	//弹出项目选择窗口
	$(function () {
		$("#accpitem").delegate(".subsidyType",'click',function(){
			var iWidth = 900;
			var iHeight = 500;
			var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
			var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
			var win = window.open("${ctx}/bf/bfSubsidyType/bfSubsidyTypeChoose", "选择帮扶政策", "width=" + iWidth +
			", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
			",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
			"status=no,alwaysRaised=yes,depended=yes");
		});
	});
</script>

</body>
</html>