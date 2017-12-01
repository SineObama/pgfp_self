<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村居民购买医疗保险或商业保险情况统计表管理</title>
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
		<%--<li><a href="${ctx}/co/coBuyMedicalInsurance/">村居民购买医疗保险或商业保险情况统计表列表</a></li>--%>
		<li class="active"><a href="${ctx}/co/coBuyMedicalInsurance/form?coMain.coId=${coMain.coId}&coMain.type=8">村居民购买医疗保险或商业保险情况统计表<shiro:hasPermission name="co:coBuyMedicalInsurance:edit">${not empty coBuyMedicalInsurance.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="co:coBuyMedicalInsurance:edit">查看</shiro:lacksPermission></a></li>
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

		<form:form id="inputForm" modelAttribute="coMain" action="${ctx}/co/coBuyMedicalInsurance/save" method="post" class="form-horizontal">
			<%--<form:hidden path="id"/>--%>
			<sys:message content="${message}"/>
			<br>
			<h2 class="table-title"><input style="font-size: 25px;width: 80px" type="text" value="${countryYear.area.name}"/>居民购买医疗或商业保险情况统计表</h2>
			<h3 class="table-subtitle">
				<span>填报单位：<input style="font-size: 22px;width: 80px" type="text" value="平桂"/>县（市、区）公共服务专责小组（盖章）</span>
					<span>填报时间：<input name="fillDate" id="years" type="text"  maxlength="20" class="input-medium Wdate required"
									  value="<fmt:formatDate value="${coMain.fillDate}" pattern="yyyy-MM-dd"/>"
									  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/></span>
			</h3>
			<input type="hidden" name="id" value="${coMain.id}"/>
			<input type="hidden" name="type" value="8"/>
			<input type="hidden" name="coId" value="${coMain.coId}"/>
			<input id="countryId" type="hidden" name="countryId" value="${countryId}"/>
			<table>
				<tbody id="accpitem">
				<tr>
					<td rowspan="3" width=30">序号</td>
					<td rowspan="3" width="70">自然村（屯）</td>
					<td rowspan="3">农户数</td>
					<td rowspan="2" colspan="2">参加城乡居民基本医疗保险（含大病保险）或商业保险</td>
					<td colspan="4">其中</td>
					<td rowspan="3">备注</td>
					<td rowspan="3" style="text-align: center;cursor: pointer;width: 50px;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
				</tr>
				<tr>
					<td width="65px" colspan="2">购买医疗保险（含大病保险）</td>
					<td width="65px" colspan="2">购买商业保险</td>
				</tr>
				<tr>
					<td>户数</td>
					<td>购买率(%)</td>
					<td>户数</td>
					<td>购买率(%)</td>
					<td>户数</td>
					<td>购买率(%)</td>
				</tr>
				<c:if test="${coMain.insurances != null && !coMain.insurances.isEmpty()}">
					<c:forEach items="${coMain.insurances}" var="insurance" varStatus="status">
						<tr class="bg-white">
							<td>
								<input type="hidden" name="insurances[${status.index}].id" value="${insurance.id}" class="id"/>
								<input type="text" name="insurances[${status.index}].idx" value="${insurance.idx}" class="idx int"/>
							</td>
							<td>
								<input type="text" name="insurances[${status.index}].countryId" value="${insurance.countryId}" class="countryId"/>
							</td>
							<td>
								<input type="text" name="insurances[${status.index}].hous" value="${insurance.hous}" class="hous int"/>
							</td>
							<td>
								<input type="text" name="insurances[${status.index}].haveInsuranceHous" value="${insurance.haveInsuranceHous}" class="haveInsuranceHous int"/>
							</td>
							<td width="62px">
								<input type="text" name="insurances[${status.index}].haveInsuranceRate" value="${insurance.haveInsuranceRate}" class="haveInsuranceRate decimal"/>
							</td>
							<td>
								<input type="text" name="insurances[${status.index}].medicalInsuranceHous" value="${insurance.medicalInsuranceHous}" class="medicalInsuranceHous int"/>
							</td>
							<td>
								<input type="text" name="insurances[${status.index}].medicalInsuranceRate" value="${insurance.medicalInsuranceRate}" class="medicalInsuranceRate decimal"/>
							</td>
							<td>
								<input type="text" name="insurances[${status.index}].commercialInsuranceHous" value="${insurance.commercialInsuranceHous}" class="commercialInsuranceHous int"/>
							</td>
							<td>
								<input type="text" name="insurances[${status.index}].commercialInsuranceRate" value="${insurance.commercialInsuranceRate}" class="commercialInsuranceRate decimal"/>
							</td>
							<td width="62px">
								<input type="text" name="insurances[${status.index}].remarks" value="${insurance.remarks}" class="remarks"/>
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
					'<input type="hidden" name="insurances[0].id"  class="id"/>'+
					'<input type="text" name="insurances[0].idx" class="idx int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="insurances[0].countryId" class="countryId"/>' +
					'</td>'+
					'<td>'+
					'<input type="text" name="insurances[0].hous" class="hous int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="insurances[0].haveInsuranceHous" class="haveInsuranceHous int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="insurances[0].haveInsuranceRate" class="haveInsuranceRate decimal"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="insurances[0].medicalInsuranceHous" class="medicalInsuranceHous int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="insurances[0].medicalInsuranceRate" class="medicalInsuranceRate decimal"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="insurances[0].commercialInsuranceHous" class="commercialInsuranceHous int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="insurances[0].commercialInsuranceRate" class="commercialInsuranceRate decimal"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="insurances[0].remarks" class="remarks"/>'+
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
			var i=-3;
			$('#accpitem tr').each(function(){
//				console.debug("i = "+i);
				$(this).find('.id').attr('name','insurances['+i+'].id');
				$(this).find('.idx').attr('name','insurances['+i+'].idx');
				$(this).find('.countryId').attr('name','insurances['+i+'].countryId');
				$(this).find('.hous').attr('name','insurances['+i+'].hous');
				$(this).find('.haveInsuranceHous').attr('name','insurances['+i+'].haveInsuranceHous');
				$(this).find('.haveInsuranceRate').attr('name','insurances['+i+'].haveInsuranceRate');
				$(this).find('.medicalInsuranceHous').attr('name' , 'insurances['+i+'].medicalInsuranceHous');
				$(this).find('.medicalInsuranceRate').attr('name','insurances['+i+'].medicalInsuranceRate');
				$(this).find('.commercialInsuranceHous').attr('name','insurances['+i+'].commercialInsuranceHous');
				$(this).find('.commercialInsuranceRate').attr('name','insurances['+i+'].commercialInsuranceRate');
				$(this).find('.remarks').attr('name','insurances['+i+'].remarks');
				i++;
			});
		};
	});
</script>

</body>
</html>