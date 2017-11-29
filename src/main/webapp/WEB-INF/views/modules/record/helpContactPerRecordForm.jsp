<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>帮扶记录管理</title>
	<meta name="decorator" content="default"/>
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

			$(".chooseRegCard").click(function(){
				var iWidth = 900;
				var iHeight = 500;
				var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
				var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
				window.open("${ctx}/record/basePoorerRegCard/holdsChoose", "选择贫困户", "width=" + iWidth +
				", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
				",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
				"status=no,alwaysRaised=yes,depended=yes");
			});

		});

		function chooseHolds(regCard){
			window.location.href="${ctx}/record/helpContactPerRecord/form?regCardId="+regCard.id;
//			$("#houseHolderName").val(regCard.houseHolderName);
//			$("#id").val(regCard.id);
		}
	</script>

	<style type="text/css">
		.center{
			width:250px;
			text-align: center !important;
		}
	</style>
</head>
<body>
<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/record/helpContactPerRecord/">帮扶成效记录列表</a></li>
	<li class="active"><a href="${ctx}/record/helpContactPerRecord/form?regCardId=${helpContactPerRecord.regCardId}">帮扶成效记录<shiro:hasPermission name="record:helpContactPerRecord:edit">${not empty helpContactPerRecord.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:helpContactPerRecord:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<div class="content tabs f-clear">
		<%--<ul class="content-nav">--%>
			<%--<li class="active"><a href="${ctx}/record/helpContactPerRecord/form?regCardId=${helpContactPerRecord.regCardId}">帮扶记录</a></li>--%>
		<%--</ul>--%>
	<div id="tab-1" class="content-detail">
		<form:form id="inputForm" modelAttribute="card" action="${ctx}/record/helpContactPerRecord/save" method="post" class="form-horizontal">
			<%--<form:hidden path="id"/>--%>
			<sys:message content="${message}"/>

			<td class="sec-td bg-white" colspan="2" style="border: 0px #FFFFFF;">
				<div class="control-group" style="float: left;border-bottom: 0px;">
					<label class="control-label" style="font-size: 12px;font-family: 'Microsoft Yahei',arial;font-weight: lighter;">户名:</label>
					<div class="controls">
						<%--<sys:treeselect id="id" name="id" value="${card.id}"--%>
										<%--labelName="houseHolderName" labelValue="${card.houseHolderName}"--%>
										<%--title="户名" url="/sys/regCard/treeData" extId="${regCard.id}" cssClass="" allowClear="true"/>--%>
						<form:input path="houseHolderName" class="chooseRegCard"/>
						<form:hidden path="id"/>
							<form:hidden path="houseId"/>
						<form:hidden path="years"/>
					</div>
				</div>
			</td>
			<table>
				<tbody id="accpitem">
				<tr>
					<td class="center">帮扶联系事项</td>
					<td class="center">帮扶联系成效<br/>(数量、金额等)</td>
					<td class="center">取得成效时间</td>
					<td class="center">帮扶联系人所发挥的作用</td>
					<td style="text-align: center;cursor: pointer;width: 132px;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
				</tr>
				<c:if test="${card.records != null && !card.records.isEmpty()}">
				<c:forEach items="${card.records}" var="record" varStatus="status">
				<tr>
					<td class="bg-white">
							<input type="hidden" name="records[${status.index}].id" value="${record.id}" class="id"/>
							<form:input path="records[${status.index}].helpContanctMatters" class="helpContanctMatters input-xlarge required"/>
					</td>
					<td class="bg-white">
							<form:input path="records[${status.index}].helpContactEffectiveness" class="helpContactEffectiveness input-xlarge required"/>
					</td>
					<td class="bg-white">
						<input name="records[${status.index}].effectivenessDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate effectivenessDate"
							   value="<fmt:formatDate value="${record.yearDate}" pattern="yyyy-MM-dd "/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',isShowClear:false});" style="background-color: #FFF;"/>
					</td>
					<td class="bg-white">
						<form:input path="records[${status.index}].playARole" htmlEscape="false" maxlength="500" class="playARole input-xlarge required"/>
					</td>

					<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>
				</tr>
				</c:forEach>
				</c:if>
				</tbody>
			</table>
			<div class="content-save">
				<shiro:hasPermission name="record:helpContactPerRecord:edit">
					<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
				</shiro:hasPermission>
				<%--<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>--%>
			</div>
		</form:form>

	</div>

	<script src="jquery.js"></script>
	<script src="jquery.tabslet.min.js"></script>
	<script>
		$(function () {

			$(".content-nav li").each(function () {
				$(this).click(function () {
					$(".header-rt").text($(this).text());
				});
			});

			$(".add-tr-btn").click(function(){
				var _len=$("#accpitem tr").length;
				var trHtml =
						'<tr>' +
						'<td class="bg-white">' +
						'<input type="hidden" name="records[' + _len + '].id" value="" class="id">' +
						'<input id="records0.helpContanctMatters" name="records[' + _len + '].helpContanctMatters" type="text" class="helpContanctMatters" value="">' +
						'</td>' +
						'<td class="bg-white">' +
						'<input id="records0.helpContactEffectiveness" name="records[' + _len + '].helpContactEffectiveness" type="text" class="helpContactEffectiveness" value="">' +
						'</td>' +
						'<td class="bg-white">' +
						'<input id="records0.effectivenessDate" name="records[' + _len + '].effectivenessDate" type="text" readonly="readonly" maxlength="20" class="effectivenessDate input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});" style="background-color:#FFF;">'+
						'</td>' +
						'<td class="bg-white">' +
						'<input id="records0.playARole" name="records[' + _len + '].playARole" type="text" class="playARole" value="">' +
						'</td>' +
						'<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>' +
						'</tr>';
				$(this).parents("tbody").append(trHtml);
				rename();
			});
//			$("#tab-1").delegate(".del-thistd-btn","click",function(){
//				$(this).parents("tr").remove();
//				rename();
//			});
			$(".del-thistd-btn").click(function(){
				$(this).parents("tr").remove();
				rename();
			});
			function rename(){
				var i=-1;
				$('#accpitem tr').each(function(){
//					console.debug("i = "+i);
					$(this).children('td').children('.id').attr('name','records['+i+'].id');
					$(this).children('td').children('.helpContanctMatters').attr('name','records['+i+'].helpContanctMatters');
					$(this).children('td').children('.helpContactEffectiveness').attr('name','records['+i+'].helpContactEffectiveness');
					$(this).children('td').children('.effectivenessDate').attr('name','records['+i+'].effectivenessDate');
					$(this).children('td').children('.playARole').attr('name','records['+i+'].playARole');
					i++;
				});
			};


		})
	</script>
	</div>
</body>

</html>