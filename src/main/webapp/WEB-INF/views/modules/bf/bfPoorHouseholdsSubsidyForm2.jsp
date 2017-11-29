<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户惠农补贴管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#select').click(function(){
				$('#inputForm').attr('action','${ctx}/bf/bfPoorHouseholdsSubsidy/form');
				$('#inputForm').submit();
			});
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
		<li><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/list2">贫困户惠农补贴列表</a></li>
		<%--<li class="active"><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/form?id=${bfPoorHouseholdsSubsidy.id}">贫困户惠农补贴<shiro:hasPermission name="bf:bfPoorHouseholdsSubsidy:edit">${not empty bfPoorHouseholdsSubsidy.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bf:bfPoorHouseholdsSubsidy:edit">查看</shiro:lacksPermission></a></li>--%>
		<li class="active"><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/form?type=1&years=${subsidyModel.years}&office.id=${subsidyModel.office.id}">贫困户惠农补贴<shiro:hasPermission name="bf:bfPoorHouseholdsSubsidy:edit">${not empty bfPoorHouseholdsSubsidy.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bf:bfPoorHouseholdsSubsidy:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<div class="content tabs f-clear">
	<div id="tab-1" class="content-detail">
	
	<form:form id="inputForm" modelAttribute="subsidyModel" action="${ctx}/bf/bfPoorHouseholdsSubsidy/save" method="post" class="form-horizontal">
		<%-- <form:hidden path="id"/> --%>
		<input type="hidden" name="type" value="1"/>
		<sys:message content="${message}"/>
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
				<td style="width:100px;">序号</td>
				<td>姓名或组织名称</td>
				<%--<td>身份证号或组织机构代码证号</td>--%>
				<td>银行账号</td>
				<td>地址</td>
				<td>补贴项目</td>
				<td>机具品目</td>
				<td>机具型号</td>
				<td>生产企业名称</td>
				<td>经销商名称</td>
				<td>数量</td>
				<td>总补贴额</td>
				<td>最终销售总价</td>
				<td>状态名称</td>
				<td>结算批次</td>
				<td>乡镇</td>
				<td style="text-align: center;cursor: pointer;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
			</tr>
			<c:if test="${subsidyModel.holds != null && !subsidyModel.holds.isEmpty()}">
			<c:forEach items="${subsidyModel.holds}" var="hold" varStatus="status">
			<tr>
				<td class="bg-white" style="width:100%;margin-right:0;">
					<form:input path="holds[${status.index}].idx" class="idx" style="width:100px;"/>
				</td>
				<td class="bg-white">
					<input type="hidden" name="holds[${status.index}].id" value="${hold.id}" class="id"/>
					<input type="hidden" name="holds[${status.index}].type" value="1" class="type"/>
					<form:hidden path="holds[${status.index}].regCard.id" class="regCardId"/>
					<form:input path="holds[${status.index}].regCard.houseHolderName" htmlEscape="false" maxlength="200" class="houseHolderName"/>
				</td class="bg-white">
				<%--<td>--%>
					<%--<form:input path="holds[${status.index}].member.idNumber" htmlEscape="false" maxlength="200" class="idNumber input-xlarge  "/>--%>
				<%--</td>--%>
				<td>
					<form:input type="text" path="holds[${status.index}].regCard.bankAccount" disabled="true" class="bankAccount"/>
				</td>
				<td>
					<form:input type="text" path="holds[${status.index}].regCard.address" disabled="true" class="address"/>
				</td>
				<td class=" bg-white">
					<form:hidden path="holds[${status.index}].subType.id" class="subTypeId"/>
					<form:input type="text" path="holds[${status.index}].subType.subsidyType" class="subsidyType"/>
					<%--<form:hidden path="holds[${status.index}].project.id" class="projectId"/>--%>
					<%--<form:input path="holds[${status.index}].project.title" class="projectTitle" htmlEscape="false"/>--%>
				</td>
				<td class="bg-white">
					<form:input type="text" path="holds[${status.index}].implementItem" class="implementItem"/>
				</td>
				<td class="bg-white">
					<form:input type="text" path="holds[${status.index}].implementModel" class="implementModel"/>
				</td>
				<td class="bg-white" style="background-color: white!important;">
					<form:input type="text" path="holds[${status.index}].companyName" class="companyName"/>
				</td>
				<td class="bg-white" style="background-color: white!important;">
				    <form:input type="text" path="holds[${status.index}].dealerName" class="dealerName"/>
			    </td>
				<td class="bg-white">
					<form:input type="text" path="holds[${status.index}].number" class="number"/>
				</td>
				<td class="bg-white">
				    <form:input type="text" path="holds[${status.index}].sbAmount" class="sbAmount"/>
			    </td>
				<td class="bg-white" style="background-color: white!important;">
					<form:input type="text" path="holds[${status.index}].finalSalesTotal" class="finalSalesTotal"/>
				</td>
				<td class="bg-white">
					<form:input type="text" path="holds[${status.index}].statusName" class="statusName"/>
				</td>
				<td class="bg-white">
					<form:input type="text" path="holds[${status.index}].settlementBatch" class="settlementBatch"/>
				</td>
				<td class="bg-white">
					<form:input type="text" path="holds[${status.index}].township" class="township"/>
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
		//姓名或组织名称
		tr.find(".houseHolderName").val(regCard.houseHolderName);
		//身份证号
//		tr.find(".idNumber").val(regCard.houseHolder.idNumber);
		//一折通账号
		tr.find(".bankAccount").val(regCard.bankAccount);
		//家庭住址
		tr.find(".address").val(regCard.address);
	}
	
	//弹出户窗口
	$(function () {
		var years = ${subsidyModel.years}
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

	
	$(function(){
		
		$(".add-tr-btn").click(function(){
			var _len=$("#accpitem tr").length - 1;
			var trHtml =
				'<tr>' +
				'<td class="bg-white">' +
				'<input id="holds'+_len+'.idx" name="holds[' + _len + '].idx" type="text" class="idx" value="">' +
				'</td>' +
				'<td class="bg-white">' +
				'<input type="hidden" name="holds[' + _len + '].id" value="" class="id">' +
				'<input type="hidden" name="holds[' + _len + '].type" value="1" class="type">' +
				'<input type="hidden" name="holds[' + _len + '].regCard.id" class="regCardId" value="">' +
				'<input id="holds'+_len+'.houseHolderName" name="holds[' + _len + '].regCard.houseHolderName" type="text" class="houseHolderName" value="">' +
				'</td>' +
				'<td>' +
				'<input id="holds'+_len+'.bankAccount" name="holds[' + _len + '].regCard.bankAccount" disabled="true" type="text" class="bankAccount" value="">' +
				'</td>' +
				'<td>' +
				'<input id="holds'+_len+'.address" name="holds[' + _len + '].regCard.address" disabled="true" type="text" class="address" value="">' +
				'</td>' +
				'<td class="bg-white">' +
//				'<input type="hidden" name="holds[' + _len + '].project.id" class="projectId">' +
//				'<input id="holds'+_len+'.project" name="holds[' + _len + '].project.title" type="text" class="projectTitle">' +
				'<input type="hidden" name="holds[' + _len + '].subType.id" class="subTypeId">' +
				'<input id="holds'+_len+'.subType.subsidyType" name="holds[' + _len + '].subType.subsidyType" type="text" class="subsidyType">' +
				'</td>' +
				'<td class="bg-white">' +
				'<input id="holds'+_len+'.implementItem" name="holds[' + _len + '].implementItem" type="text" class="implementItem" value="">' +
				'</td>' + 
				'<td class="bg-white">' +
				'<input id="holds'+_len+'.implementModel" name="holds[' + _len + '].implementModel" type="text" class="implementModel" value="">' +
				'</td>' +
				'<td class="bg-white" style="background-color: white!important;">' +
				'<input id="holds'+_len+'.companyName" name="holds[' + _len + '].companyName" type="text" class="companyName" value="">' +
				'</td>' +
				'<td class="bg-white" style="background-color: white!important;">' +
				'<input id="holds'+_len+'.dealerName" name="holds[' + _len + '].dealerName" type="text" class="dealerName" value="">' +
				'</td>' +
				'<td class="bg-white">' +
				'<input id="holds'+_len+'.number" name="holds[' + _len + '].number" type="text" class="number" value="">' +
				'</td>' + 
				'<td class="bg-white">' +
				'<input id="holds'+_len+'.sbAmount" name="holds[' + _len + '].sbAmount" type="text" class="sbAmount" value="">' +
				'</td>' +
				'<td class="bg-white" style="background-color: white!important;">' +
				'<input id="holds'+_len+'.finalSalesTotal" name="holds[' + _len + '].finalSalesTotal" type="text" class="finalSalesTotal" value="">' +
				'</td>' +
				'<td class="bg-white">' +
				'<input id="holds'+_len+'.statusName" name="holds[' + _len + '].statusName" type="text" class="statusName" value="">' +
				'</td>' + 
				'<td class="bg-white">' +
				'<input id="holds'+_len+'.settlementBatch" name="holds[' + _len + '].settlementBatch" type="text" class="settlementBatch" value="">' +
				'</td>' + 
				'<td class="bg-white">' +
				'<input id="holds'+_len+'.township" name="holds[' + _len + '].township" type="text" class="township" value="">' +
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
				/* $(this).children('td').children('.id').attr('name','holds['+i+'].id'); */
				$(this).children('td').children('.type').attr('name','holds['+i+'].type');
				$(this).children('td').children('.idx').attr('name','holds['+i+'].idx');
				$(this).children('td').children('.regCardId').attr('name','holds['+i+'].regCard.id');
				$(this).children('td').children('.houseHolderName').attr('name','holds['+i+'].regCard.houseHolderName');
				$(this).children('td').children('.idNumber').attr('name','holds['+i+'].member.idNumber');
				$(this).children('td').children('.bankAccount').attr('name','holds['+i+'].regCard.bankAccount');
				$(this).children('td').children('.address').attr('name','holds['+i+'].regCard.address');
				$(this).children('td').children('.implementItem').attr('name','holds['+i+'].implementItem');
				$(this).children('td').children('.implementModel').attr('name','holds['+i+'].implementModel');
				$(this).children('td').children('.companyName').attr('name','holds['+i+'].companyName');
				$(this).children('td').children('.dealerName').attr('name','holds['+i+'].dealerName');
				$(this).children('td').children('.number').attr('name','holds['+i+'].number');
				$(this).children('td').children('.sbAmount').attr('name','holds['+i+'].sbAmount');
				$(this).children('td').children('.finalSalesTotal').attr('name','holds['+i+'].finalSalesTotal');
				$(this).children('td').children('.statusName').attr('name','holds['+i+'].statusName');
				$(this).children('td').children('.settlementBatch').attr('name','holds['+i+'].settlementBatch');
				$(this).children('td').children('.township').attr('name','holds['+i+'].township');
//				$(this).children('td').children('.projectId').attr('name','holds['+i+'].project.id');
//				$(this).children('td').children('.projectTitle').attr('name','holds['+i+'].project.title');
				$(this).children('td').children('.subTypeId').attr('name','holds['+i+'].subType.id');
				$(this).children('td').children('.subsidyType').attr('name','holds['+i+'].subType.subsidyType');
				i++;
			});
		};
		
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
	<%--function chooseProject(project){--%>
		<%--tr.find('.projectId').val(project.id);--%>
		<%--tr.find('.projectTitle').val(project.title);--%>
	<%--}--%>

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

	function chooseSubsidyType(member){
//		console.debug(member);
		tr.find(".subTypeId").val(member.id);
		tr.find(".subsidyType").val(member.subsidyType);
	}
</script>

</body>
</html>