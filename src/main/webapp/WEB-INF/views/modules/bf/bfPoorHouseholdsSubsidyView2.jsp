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
	<li ><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/list2">贫困户惠农补贴列表</a></li>
	<li class="active">
		<a  href="${ctx}/bf/bfPoorHouseholdsSubsidy/view?id=${hold.id}">
			贫困户惠农补贴修改
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
                <td class="fir-td"><span>姓名或组织名称</span></td>
                <td class="sec-td bg-white">
					<input type="hidden" name="hold.id" value="${hold.id}" class="id"/>
					<input type="hidden" name="hold.type" value="1" class="type"/>
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
                <td class="fir-td"><span>银行账号</span></td>
                <td class="sec-td">
					<form:input type="text" path="regCard.bankAccount" class="bankAccount" disabled="true"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>地址</span></td>
                <td class="sec-td">
					<form:input type="text" path="regCard.address" class="address" disabled="true"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>补贴项目</span></td>
                <td class="sec-td bg-white">
					<%--<input type="text" name="" value="农机购置" disabled="true"/>--%>
					<form:hidden path="subType.id" class="subTypeId"/>
					<form:input path="subType.subsidyType" class="subsidyType" htmlEscape="false"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>机具品目</span></td>
                <td class="sec-td bg-white">
					<form:input type="text" path="implementItem" class="implementItem"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>机具型号</span></td>
                <td class="sec-td bg-white">
					<form:input type="text" path="implementModel" class="implementModel"/>
				</td>
            </tr>
            
            <tr>
                <td class="fir-td"><span>数量</span></td>
                <td class="sec-td bg-white">
					<form:input type="text" path="number" class="number"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>总补贴额</span></td>
                <td class="sec-td bg-white">
					<form:input type="text" path="sbAmount" class="sbAmount"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>状态名称</span></td>
                <td class="sec-td bg-white">
					<form:input type="text" path="statusName" class="statusName"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>结算批次</span></td>
                <td class="sec-td bg-white">
					<form:input type="text" path="settlementBatch" class="settlementBatch"/>
				</td>
            </tr>
            <tr>
                <td class="fir-td"><span>乡镇</span></td>
                <td class="sec-td bg-white">
					<form:input type="text" path="township" class="township"/>
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
	var tr;
	function chooseHolds(regCard){
		//农户id
		$(".regCardId").val(regCard.id);
		//姓名或组织名称
		$(".houseHolderName").val(regCard.houseHolderName);
		//身份证号或组织机构代码证号
		$(".idNumber").val(regCard.houseHolder.idNumber);
		//银行账号
		$(".bankAccount").val(regCard.bankAccount);
		//地址
		$(".address").val(regCard.address);
	}
	
	//弹出户窗口
	$(function () {
		$("#accpitem").delegate(".houseHolderName",'click',function(){
			var iWidth = 900;
			var iHeight = 500;
			var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
			var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
			var win = window.open("${ctx}/record/basePoorerRegCard/holdsChoose?years=${hold.years}", "选择户", "width=" + iWidth +
			", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
			",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
			"status=no,alwaysRaised=yes,depended=yes");
		});
	});
	function chooseSubsidyType(data){
		$(".subTypeId").val(data.id);
		$(".subsidyType").val(data.subsidyType);
	}
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