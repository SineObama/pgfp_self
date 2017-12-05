<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>农村危房改造管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$('#select').click(function(){
				$('#inputForm').attr('action','${ctx}/bf/bfPoorHouseholdsSubsidy/form');
				$('#inputForm').submit();
			});
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
		<li><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/list3">农村危房改造列表</a></li>
		<%--<li class="active"><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/form?id=${bfPoorHouseholdsSubsidy.id}">贫困户惠农补贴<shiro:hasPermission name="bf:bfPoorHouseholdsSubsidy:edit">${not empty bfPoorHouseholdsSubsidy.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bf:bfPoorHouseholdsSubsidy:edit">查看</shiro:lacksPermission></a></li>--%>
		<li class="active"><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/form?type=2&years=${subsidyModel.years}&office.id=${subsidyModel.office.id}">农村危房改造<shiro:hasPermission name="bf:bfPoorHouseholdsSubsidy:edit">${not empty bfPoorHouseholdsSubsidy.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bf:bfPoorHouseholdsSubsidy:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>

	<div class="content tabs f-clear">
	<div id="tab-1" class="content-detail">
		<sys:message content="${message}"/>
	<form:form id="inputForm" modelAttribute="subsidyModel" action="${ctx}/bf/bfPoorHouseholdsSubsidy/save" method="post" class="form-horizontal">
		<%-- <form:hidden path="id"/> --%>
		<input type="hidden" name="type" value="2"/>
		<br/>
		<table style="border: 0px;">
			<tr style="border: 0px #FFFFFF; ">
				<%--<form:hidden path="type"/>--%>
				<td class="sec-td bg-white" colspan="2" style="border: 0px #FFFFFF;">
					<div class="control-group" style="float: left;border-bottom: 0px;">
						<label class="control-label" style="font-size: 12px;font-family: 'Microsoft Yahei',arial;font-weight: lighter;">填报单位:</label>
						<div class="controls">
								<sys:treeselect id="office" name="office.id" value="${subsidyModel.office.id}"
											labelName="office.name" labelValue="${subsidyModel.office.name}"
											title="填报单位" url="/sys/office/treeData" extId="${office.id}" cssClass=""
											allowClear="false" isAll="${isAdminCadre}"/>
						</div>
					</div>
				</td>

				<td class="sec-td bg-white" style="border: 0px #FFFFFF; text-align: right;">归属年度:</td>
				<td class="sec-td bg-white" style="border: 0px #FFFFFF;">
					<input id="years" name="years" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						   value="<fmt:formatDate value="${subsidyModel.yearsDate}" pattern="yyyy"/>"
						   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</td>
				<td class="sec-td bg-white" style="border: 0px #FFFFFF;">
					<input id="select" class="save-btn" style="margin-right:30px !important;" type="submit" value="查询"/>
				</td>
			</tr>
			<tbody id="accpitem">
			<tr>
				<td>户主姓名</td>
				<%--<td>身份证号</td>--%>
				<td>户口本号</td>
				<td>一折通账号</td>
				<td>开户银行</td>
				<td>家庭住址</td>
				<td>补贴项目名称</td>
				<td>补贴总量/补贴面积</td>
				<td>补贴标准</td>
				<td>补贴金额</td>
				<td>兑付时间</td>
				<td>备注</td>
				<td style="text-align: center;cursor: pointer;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
			</tr>
			<c:if test="${subsidyModel.holds != null && !subsidyModel.holds.isEmpty()}">
			<c:forEach items="${subsidyModel.holds}" var="hold" varStatus="status">
			<tr>
				<td class="bg-white">
					<input type="hidden" name="holds[${status.index}].id" value="${hold.id}" class="id"/>
					<input type="hidden" name="holds[${status.index}].type" value="2" class="type"/>
					<form:hidden path="holds[${status.index}].regCard.id" class="regCardId"/>
					<form:input path="holds[${status.index}].regCard.houseHolderName" htmlEscape="false" maxlength="200" class="houseHolderName input-xlarge  "/>
				</td>
				<%--<td>--%>
					<%--<form:input path="holds[${status.index}].member.idNumber" htmlEscape="false" maxlength="200" class="idNumber input-xlarge  " disabled="true"/>--%>
				<%--</td>--%>
				<td>
					<form:input path="holds[${status.index}].regCard.residenceBookletNumber" htmlEscape="false" maxlength="200" class="residenceBookletNumber input-xlarge  " disabled="true"/>
				</td>
				<td>
					<form:input type="text" path="holds[${status.index}].regCard.bankAccount" class="bankAccount" disabled="true"/>
				</td>
				<td>
					<form:input type="text" path="holds[${status.index}].regCard.bankName" class="bankName" disabled="true"/>
				</td>
				<td>
					<form:input type="text" path="holds[${status.index}].regCard.address" class="address" disabled="true"/>
				</td>
				<td class="bg-white">
					<form:hidden path="holds[${status.index}].subType.id" class="subTypeId"/>
					<form:input type="text" path="holds[${status.index}].subType.subsidyType" class="subsidyType"/>
					<%--<form:hidden path="holds[${status.index}].project.id" class="projectId"/>--%>
					<%--<form:input path="holds[${status.index}].project.title" class="projectType"/>--%>
				</td>
				<td class="bg-white">
					<form:input type="text" path="holds[${status.index}].sbMountArea" class="sbMountArea"/>
				</td>
				<td class="bg-white">
					<form:input type="text" path="holds[${status.index}].sbStandard" class="sbStandard"/>
				</td>
				<td class="bg-white">
					<form:input type="text" path="holds[${status.index}].sbAmount" class="sbAmount"/>
				</td>
				<td class="bg-white">
					<input name="holds[${status.index}].honourTime" type="text" readonly="readonly" maxlength="20" class="honourTime input-medium Wdate  required"
							   value="<fmt:formatDate value="${subsidyModel.holds[status.index].honourTime}" pattern="yyyy-MM-dd"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="background-color: #FFF;"/>
				</td>
				<td class="bg-white">
					<form:input type="text" path="holds[${status.index}].remark" class="remark"/>
				</td>
				
				<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>
				
			</tr>
			</c:forEach>
			</c:if>
			
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
		tr.find(".regCardId").val(regCard.id);
		//建档立卡农户姓名
		tr.find(".houseHolderName").val(regCard.houseHolderName);
//		//身份证号
//		tr.find(".idNumber").val(regCard.houseHolder.idNumber);
		//户口本号
		tr.find(".residenceBookletNumber").val(regCard.residenceBookletNumber);
		//户口本号
//		tr.find(".").val(regCard.residenceBookletNumber);
		//一折通账号
		tr.find(".bankAccount").val(regCard.bankAccount);
		//开户银行
		tr.find(".bankName").val(regCard.bankName);
		//家庭住址
		tr.find(".address").val(regCard.address);
	}
	
	function chooseSubsidyType(member){
//		console.debug(member);
		tr.find(".subTypeId").val(member.id);
		tr.find(".subsidyType").val(member.subsidyType);
	}
	
	//弹出户窗口
	$(function () {
		var years= ${subsidyModel.years};
		$("#accpitem").delegate(".houseHolderName",'click',function(){
			tr = $(this).parents("tr");
			var iWidth = 900;
			var iHeight = 500;
			var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
			var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
			var win = window.open("${ctx}/record/basePoorerRegCard/holdsChoose?years="+years, "弹出窗口", "width=" + iWidth +
			", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
			",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
			"status=no,alwaysRaised=yes,depended=yes");
		});
	});

	

	//弹出资助项目窗口
	<%--$(function () {--%>
		<%--$("#accpitem").delegate(".projectTitle",'click',function(){--%>
<%--//					var cardId = $("#id").val();--%>
			<%--tr = $(this).parents("tr");--%>
			<%--var iWidth = 900;--%>
			<%--var iHeight = 500;--%>
			<%--var iTop = (window.screen.availHeight - 30 - iHeight) / 2;--%>
			<%--var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;--%>
			<%--var win = window.open("${ctx}/cms/cmsProject/proChoose", "选择资助项目", "width=" + iWidth +--%>
			<%--", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +--%>
			<%--",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +--%>
			<%--"status=no,alwaysRaised=yes,depended=yes");--%>
		<%--});--%>
	<%--});--%>

	$(function () {
		$("#accpitem").delegate(".subsidyType",'click',function(){
//			var cardId = $("#id").val();
			tr = $(this).parents("tr");
			var iWidth = 900;
			var iHeight = 500;
			var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
			var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
			var win = window.open("${ctx}/bf/bfSubsidyType/bfSubsidyTypeChoose", "选择资助项目", "width=" + iWidth +
			", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
			",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
			"status=no,alwaysRaised=yes,depended=yes");
		});
	});
	
	$(function(){
		
		$(".add-tr-btn").click(function(){
			var _len=$("#accpitem tr").length - 1;
			var trHtml =
				'<tr>' +
				'<td class="bg-white">' +
				'<input type="hidden" name="holds[' + _len + '].id" value="" class="id">' +
				'<input type="hidden" name="holds[' + _len + '].type" value="2" class="type">' +
				'<input type="hidden" name="holds[' + _len + '].regCard.id" class="regCardId" value="">' +
				'<input id="holds'+_len+'.houseHolderName" name="holds[' + _len + '].regCard.houseHolderName" type="text" class="houseHolderName" value="">' +
				'</td>' +
				'<td>' +
				'<input id="holds'+_len+'.residenceBookletNumber" name="holds[' + _len + '].regCard.residenceBookletNumber" type="text" disabled="true" class="residenceBookletNumber" value="">' +
				'</td>' + 
				'<td>' +
				'<input id="holds'+_len+'.bankAccount" name="holds[' + _len + '].regCard.bankAccount" disabled="true" type="text" class="bankAccount" value="">' +
				'</td>' + 
				'<td>' +
				'<input id="holds'+_len+'.bankName" name="holds[' + _len + '].regCard.bankName" disabled="true" type="text" class="bankName" value="">' +
				'</td>' + 
				'<td>' +
				'<input id="holds'+_len+'.address" name="holds[' + _len + '].regCard.address" type="text" disabled="true" class="address" value="">' +
				'</td>' + 
				'<td class="bg-white">' +
				'<input type="hidden" name="holds[' + _len + '].subType.id" class="subTypeId">' +
				'<input id="holds'+_len+'.subType.subsidyType" name="holds[' + _len + '].subType.subsidyType" type="text" class="subsidyType">' +
				'</td>' + 
				'<td class="bg-white">' +
				'<input id="holds'+_len+'.sbMountArea" name="holds[' + _len + '].sbMountArea" type="text" class="sbMountArea" value="">' +
				'</td>' + 
				'<td class="bg-white">' +
				'<input id="holds'+_len+'.sbStandard" name="holds[' + _len + '].sbStandard" type="text" class="sbStandard" value="">' +
				'</td>' + 
				'<td class="bg-white">' +
				'<input id="holds'+_len+'.sbAmount" name="holds[' + _len + '].sbAmount" type="text" class="sbAmount" value="">' +
				'</td>' + 
				'<td class="bg-white">' +
				'<input id="holds'+_len+'.honourTime" name="holds['+_len+'].honourTime" type="text" readonly="readonly" maxlength="20" class="honourTime input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});">'+
				'</td>' + 
				'<td class="bg-white">' +
				'<input id="holds'+_len+'.remark" name="holds[' + _len + '].remark" type="text" class="remark" value="">' +
				'</td>' + 
				'<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>' + 
				'</tr>';
			
			$(this).parents("tbody").append(trHtml);
			$("select").select2();
			rename();
		}); 
		$("#tab-15").delegate(".del-thistd-btn","click",function(){
			$(this).parents("tr").remove();
			rename();
		});
		function rename(){
			var i=-1;
			$('#accpitem tr').each(function(){
				$(this).children('td').children('.id').attr('name','holds['+i+'].id');
				$(this).children('td').children('.type').attr('name','holds['+i+'].type');
				$(this).children('td').children('.regCardId').attr('name','holds['+i+'].regCard.id');
				$(this).children('td').children('.houseHolderName').attr('name','holds['+i+'].regCard.houseHolderName');
				$(this).children('td').children('.idNumber').attr('name','holds['+i+'].member.idNumber');
				$(this).children('td').children('.bankAccount').attr('name','holds['+i+'].regCard.bankAccount');
				$(this).children('td').children('.bankName').attr('name','holds['+i+'].regCard.bankName');
				$(this).children('td').children('.address').attr('name','holds['+i+'].regCard.address');
				$(this).children('td').children('.subTypeId').attr('name','holds['+i+'].subType.id');
				$(this).children('td').children('.subsidyType').attr('name','holds['+i+'].subType.subsidyType');
				$(this).children('td').children('.sbMountArea').attr('name','holds['+i+'].sbMountArea');
				$(this).children('td').children('.sbStandard').attr('name','holds['+i+'].sbStandard');
				$(this).children('td').children('.sbAmount').attr('name','holds['+i+'].sbAmount');
				$(this).children('td').children('.honourTime').attr('name','holds['+i+'].honourTime');
				$(this).children('td').children('.remark').attr('name','holds['+i+'].remark');
				i++;
			});
		};
		
	});
//	function chooseProject(project){
//		tr.find('.projectId').val(project.id);
//		tr.find('.projectTitle').val(project.title);
//	}
</script>

</body>
</html>