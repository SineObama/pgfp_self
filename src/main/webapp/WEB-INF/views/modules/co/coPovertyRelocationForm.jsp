<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村易地扶贫搬迁户住房保障情况表管理</title>
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
		width: 50%;
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
		<%--<li><a href="${ctx}/co/coPovertyRelocation/">村易地扶贫搬迁户住房保障情况表列表</a></li>--%>
		<li class="active"><a href="${ctx}/co/coPovertyRelocation/form?coMain.coId=${coMain.coId}&coMain.type=7">村易地扶贫搬迁户住房保障情况表<shiro:hasPermission name="co:coPovertyRelocation:edit">${not empty coPovertyRelocation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="co:coPovertyRelocation:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>

	<div class="content tabs f-clear">
		<%@ include file="navList.jsp"%>
		<div id="tab-1" class="content-detail">
			<c:choose>
			<c:when test="${empty coMain.coId}">
			<script>
				alert("请先填写村名和年度！");
				window.history.back(-1);
			</script>
			</c:when>
			<c:otherwise>

			<form:form id="inputForm" modelAttribute="coMain" action="${ctx}/co/coPovertyRelocation/save" method="post" class="form-horizontal">
				<sys:message content="${message}"/>
				<br>
				<h2 class="table-title"><input style="font-size: 25px;width: 80px" type="text" value="${countryYear.area.name}"/>易地扶贫搬迁户住房保障情况表</h2>
				<h3 class="table-subtitle">
					<span>填报单位：<input style="font-size: 22px;width: 80px" type="text" value="平桂"/>县（市、区）移民搬迁专责小组（盖章）</span>
					<span>填报时间：<input name="fillDate" id="years" type="text"  maxlength="20" class="input-medium Wdate required"
									  value="<fmt:formatDate value="${coMain.fillDate}" pattern="yyyy-MM-dd"/>"
									  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/></span>
				</h3>
				<input type="hidden" name="id" value="${coMain.id}"/>
				<input type="hidden" name="type" value="7"/>
				<input type="hidden" name="coId" value="${coMain.coId}"/>
				<input id="countryId" type="hidden" name="countryId" value="${countryId}"/>
				<table>
					<tbody id="accpitem">
					<tr>
						<td rowspan="2" width=30">序号</td>
						<td rowspan="2" width="70">自然村（屯）</td>
						<td rowspan="2">户主姓名</td>
						<td rowspan="2">家庭人口数</td>
						<td rowspan="2">安置住房面积（平方米）</td>
						<td rowspan="2">迁入地</td>
						<td colspan="3" width="195px">集中安置户</td>
						<td width="65px">分散安置户</td>
						<td rowspan="2">备注</td>
						<td rowspan="2" style="text-align: center;cursor: pointer;width: 50px;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
					</tr>
					<tr>
						<td width="65px">房屋质量是否达标</td>
						<td width="65px">是否达到入住条件</td>
						<td width="65px">是否交钥匙</td>
						<td width="65px">是否入住</td>
					</tr>
					<c:if test="${coMain.relocations != null && !coMain.relocations.isEmpty()}">
						<c:forEach items="${coMain.relocations}" var="relocation" varStatus="status">
							<tr class="bg-white">
								<td>
									<input type="hidden" name="relocations[${status.index}].id" value="${relocation.id}" class="id"/>
									<input type="text" name="relocations[${status.index}].idx" value="${relocation.idx}" class="idx int"/>
								</td>
								<td>
									<input type="text" name="relocations[${status.index}].countryId" value="${relocation.countryId}" class="countryId"/>
								</td>
								<td>
									<input type="text" name="relocations[${status.index}].householdName" value="${relocation.householdName}" class="householdName"/>
								</td>
								<td>
									<input type="text" name="relocations[${status.index}].memberNum" value="${relocation.memberNum}" class="memberNum int"/>
								</td>
								<td width="62px">
									<input type="text" name="relocations[${status.index}].houseArea" value="${relocation.houseArea}" class="houseArea decimal"/>
								</td>
								<td>
									<input type="text" name="relocations[${status.index}].immigration" value="${relocation.immigration}" class="immigration"/>
								</td>
								<td width="62px">
									<form:radiobuttons class="inp-right" path="relocations[${status.index}].qualityOk"
													   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
								</td>
								<td>
									<form:radiobuttons class="inp-right" path="relocations[${status.index}].checkOk"
													   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
								</td>
								<td>
									<form:radiobuttons class="inp-right" path="relocations[${status.index}].keyOk"
													   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
								</td>
								<td>
									<form:radiobuttons class="inp-right" path="relocations[${status.index}].isCheck"
													   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
								</td>
								<td width="62px">
									<input type="text" name="relocations[${status.index}].remarks" value="${relocation.remarks}" class="remarks"/>
								</td>
								<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>

							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
				<div class="text-bottom">
					<span>审核人：<input type="text" name="auditor" value="${coMain.auditor}"/> </span>
					<span>填表人：<input type="text" name="formHolder" value="${coMain.formHolder}"/></span>
					<span>联系电话：<input type="text" name="mobile" value="${coMain.mobile}"/></span>
				</div>
				<div class="content-save">
					<shiro:hasPermission name="record:basePoorerRegCard:edit">
						<input class="save-btn add-tr-btn" style="margin-right:30px !important; width: 120px;" type="button" value="添加"/>
						<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
					</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
				</div>
			</form:form>
			</c:otherwise>
			</c:choose>
			</div>
		</div>

<script >
	var tr;
	function chooseMember(area){
		tr.find(".countryId").val(area.name);
	}

	//弹出自然村屯选择窗口
	$(function () {
		$("#accpitem").delegate(".countryId",'click',function(){
			var countryId = $("#countryId").val();
			tr = $(this).parents("tr");
			var iWidth = 900;
			var iHeight = 500;
			var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
			var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
			var win = window.open("${ctx}/co/coCountryYear/countryChoose?countryId="+countryId, "选择地区", "width=" + iWidth +
			", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
			",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
			"status=no,alwaysRaised=yes,depended=yes");
		});
	});

	$(function () {

		$(".add-tr-btn").click(function(){
			var trHtml = '<tr class="bg-white">'+
					'<td>'+
					'<input type="hidden" name="relocations[0].id"  class="id"/>'+
					'<input type="text" name="relocations[0].idx" class="idx int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="relocations[0].countryId" class="countryId"/>' +
					'</td>'+
					'<td>'+
					'<input type="text" name="relocations[0].householdName" class="householdName"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="relocations[0].memberNum" class="memberNum int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="relocations[0].houseArea" class="houseArea decimal"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="relocations[0].immigration" class="immigration"/>'+
					'</td>'+

					'<td>'+
					'<span>' +
					'<input id="relocations[0].qualityOk" name="relocations[0].qualityOk" class="qualityOk" type="radio" value="1">' +
					'<label for="relocations[0].qualityOk">是</label>' +
					'</span>' +
					'<span>' +
					'<input id="relocations[0].qualityOk" name="relocations[0].qualityOk" class="qualityOk" type="radio" value="0">' +
					'<label for="relocations[0].qualityOk">否</label>' +
					'</span>'+
					'</td>'+

					'<td>'+
					'<span>' +
					'<input id="relocations[0].checkOk" name="relocations[0].checkOk" class="checkOk" type="radio" value="1">' +
					'<label for="relocations[0].checkOk">是</label>' +
					'</span>' +
					'<span>' +
					'<input id="relocations[0].checkOk" name="relocations[0].checkOk" class="checkOk" type="radio" value="0">' +
					'<label for="relocations[0].checkOk">否</label>' +
					'</span>'+
					'</td>'+

					'<td>'+
					'<span>' +
					'<input id="relocations[0].keyOk" name="relocations[0].keyOk" class="keyOk" type="radio" value="1">' +
					'<label for="relocations[0].keyOk">是</label>' +
					'</span>' +
					'<span>' +
					'<input id="relocations[0].keyOk" name="relocations[0].keyOk" class="keyOk" type="radio" value="0">' +
					'<label for="relocations[0].keyOk">否</label>' +
					'</span>'+
					'</td>'+

					'<td>'+
					'<span>' +
					'<input id="relocations[0].isCheck" name="relocations[0].isCheck" class="isCheck" type="radio" value="1">' +
					'<label for="relocations[0].isCheck">是</label>' +
					'</span>' +
					'<span>' +
					'<input id="relocations[0].isCheck" name="relocations[0].isCheck" class="isCheck" type="radio" value="0">' +
					'<label for="relocations[0].isCheck">否</label>' +
					'</span>'+
					'</td>'+

					'<td>'+
					'<input type="text" name="relocations[0].remarks" class="remarks"/>'+
					'</td>'+
					'<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>'+
					'</tr>';
			$(this).parents("#inputForm").find("tbody").append(trHtml);
			$("select").select2();
			rename();
		});
		$("#tab-1").delegate(".del-thistd-btn","click",function(){
			$(this).parents("tr").remove();
			rename();
		});
		function rename(){
			var i=-2;
			$('#accpitem tr').each(function(){
//				console.debug("i = "+i);
				$(this).find('.id').attr('name','relocations['+i+'].id');
				$(this).find('.idx').attr('name','relocations['+i+'].idx');
				$(this).find('.countryId').attr('name','relocations['+i+'].countryId');
				$(this).find('.householdName').attr('name','relocations['+i+'].householdName');
				$(this).find('.memberNum').attr('name','relocations['+i+'].memberNum');
				$(this).find('.houseArea').attr('name','relocations['+i+'].houseArea');
				$(this).find('.immigration').attr('name' , 'relocations['+i+'].immigration');
				$(this).find('.qualityOk').attr('name','relocations['+i+'].qualityOk');
				$(this).find('.checkOk').attr('name','relocations['+i+'].checkOk');
				$(this).find('.keyOk').attr('name','relocations['+i+'].keyOk');
				$(this).find('.isCheck').attr('name','relocations['+i+'].isCheck');
				$(this).find('.remarks').attr('name','relocations['+i+'].remarks');
				i++;
			});
		};
	});
</script>


</body>
</html>