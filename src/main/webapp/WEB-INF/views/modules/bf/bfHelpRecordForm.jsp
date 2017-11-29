<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>帮扶记录管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<%-- <script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script> --%>
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
	<style>
		.noBlock {
			background-color: #FFFFFF !important;
			border: 0px #FFFFFF !important;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/bf/bfHelpRecord/">帮扶记录列表</a></li>
		<li class="active"><a href="${ctx}/bf/bfHelpRecord/form?id=${record.id}">帮扶记录<shiro:hasPermission name="bf:bfHelpRecord:edit">${not empty bfHelpRecord.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bf:bfHelpRecord:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<div class="content tabs f-clear">
	<div id="tab-15" class="content-detail">
	<form:form id="inputForm" modelAttribute="record" action="${ctx}/bf/bfHelpRecord/save" method="post" class="form-horizontal">
		<%-- <form:hidden path="id"/> --%>
		<sys:message content="${message}"/>		
		<table class="noBlock">
			<tbody id="accpitem">
			<input type="hidden" value="${record.id}" name="id"/>
			<tr>
				<td class="strongFont">户主姓名</td>
				<td>${record.houseHolderName}</td>
				<td class="strongFont">下乡时间</td>
				<td><fmt:formatDate value="${record.helpDate}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr><td colspan="4" class="strongFont">帮扶内容</td></tr>
			<tr><td colspan="4" class="bg-white">
				<textarea name="content" id="content" style="width: 780px; border: none; min-height: 80px;">${record.content}</textarea>
			</td></tr>
			<tr>
				<td colspan="4" class="strongFont">帮扶照片</td>
			</tr>
			<tr>
				<td colspan="4">
					<c:forEach items="${record.images}" var="imgPath">
						<img src="${imgPath}" style="height:190px;"/>
					</c:forEach>
				</td>
			</tr>
			<tr class="strongFont">
				<td colspan="4">户主签名</td>
			</tr>
			<tr>
				<td colspan="4">
					<img src="${record.regCardSignPath}"/>
				</td>
			</tr>
			<tr><td colspan="4" class="strongFont">帮扶干部签名</td></tr>
			<tr>
				<td colspan="4">
					<img src="${record.cadreSignPath}"/>
				</td>
			</tr>
			<%--<tr class="noBlock">--%>
				<%--<td colspan="" class="houseHolderName noBlock">--%>
						<%--&lt;%&ndash;<span id="houseHolderName">户主姓名：${plan.card.houseHolderName}</span>&ndash;%&gt;--%>
					<%--户主姓名：<form:input path="regCard.houseHolderName" style="width:60px;" class="chooseRegCard"/>--%>
					<%--<form:hidden path="regCard.id"/>--%>
					<%--<form:hidden path="regCard.houseId"/>--%>
				<%--</td>--%>
				<%--<td class="address noBlock">家庭地址：${recordModel.regCard.address}</td>--%>
				<%--<td class="year noBlock ">年度：<form:input path="regCard.years" disabled="true" style="background-color:#FFF ;width:50px;"/></td>--%>
			<%--</tr>--%>

			<%--<tr>--%>
				<%--<td>入户时间</td>--%>
				<%--<td style="width:500px;">帮扶联系内容</td>--%>
				<%--<td style="text-align: center;cursor: pointer;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>--%>
			<%--</tr>--%>
			<%--<c:if test="${recordModel.records != null && !recordModel.records.isEmpty()}">--%>
			<%--<c:forEach items="${recordModel.records}" var="record" varStatus="status">--%>
			<%--<tr>--%>
				<%--<td class="bg-white">--%>
					<%--<input type="hidden" name="records[${status.index}].id" value="${record.id}" class="id"/>--%>
					<%--<input id="helpDate" name="records[${status.index}].helpDate" type="text" readonly="readonly" maxlength="20" class="helpDate input-medium Wdate required"--%>
						   <%--value="<fmt:formatDate value="${recordModel.records[status.index].helpDate}" pattern="yyyy-MM-dd"/>"--%>
						   <%--onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="background-color: #fff;"/>--%>
				<%--</td>--%>
				<%--<td class="bg-white">--%>
					<%--<form:hidden path="records[${status.index}].isLocal" class="isLocal"/>--%>
					<%--<form:input type="text" path="records[${status.index}].content" class="content"/>--%>
				<%--</td>--%>
				<%--<td id="tab-15" class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>--%>
				<%----%>
				<%--</tr>--%>
				<%--</c:forEach>--%>
				<%--</c:if>--%>
			<%----%>
			</tbody>
		</table>
		<div class="content-save">
			<shiro:hasPermission name="bf:bfHelpRecord:edit">
				<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
		</div>

	</form:form>
	</div>
	</div>
<script>

	function chooseHolds(regCard){
		window.location.href="${ctx}/bf/bfHelpRecord/form?regCardId="+regCard.id;
	}


	$(function(){

		$(".chooseRegCard").click(function(){
//			console.debug("adfasfd");
			var iWidth = 900;
			var iHeight = 500;
			var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
			var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
			window.open("${ctx}/record/basePoorerRegCard/holdsChoose", "选择贫困户", "width=" + iWidth +
			", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
			",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
			"status=no,alwaysRaised=yes,depended=yes");
		});


		$(".content-nav li").each(function () {
			$(this).click(function () {
				$(".header-rt").text($(this).text());
			});
		});

		$(".add-tr-btn").click(function(){
//			console.debug('click add');
			var _len=$("#accpitem tr").length - 1;
			var trHtml =
				'<tr>' +
				'<td class="bg-white">' + 
				'<input type="hidden" name="records[' + _len + '].id" value="" class="id">' +
				'<input id="helpDate" style="background-color: #fff;" name="records['+_len+'].helpDate" type="text" readonly="readonly" maxlength="20" class="helpDate input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});">'+
				'</td>' + 
				'<td class="bg-white">' +
				'<input name="records[0].isLocal" type="hidden" class="isLocal" value="0"/>' +
				'<input id="records0.content" name="records[' + _len + '].content" type="text" class="content" value="">' + 
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
			var i=-2;
			$('#accpitem tr').each(function(){
//			console.debug("i = "+i);
				$(this).children('td').children('.helpDate').attr('name','records['+i+'].helpDate');
				$(this).children('td').children('.content').attr('name','records['+i+'].content');
				$(this).children('td').children('.isLocal').attr('name','records['+i+'].isLocal');
				$(this).find('.id').attr('name','records['+i+'].id');
				i++;
			});
		};
	});
</script>
	<style>
		.strongFont{
			font-weight: bold;
		}
	</style>
</body>
</html>