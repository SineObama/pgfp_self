<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村适龄儿童少年接受义务教育情况统计表管理</title>
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
		<%--<li><a href="${ctx}/co/coChildHaveEducation/">村适龄儿童少年接受义务教育情况统计表列表</a></li>--%>
		<li class="active"><a href="${ctx}/co/coChildHaveEducation/form?coMain.coId=${coMain.coId}&coMain.type=11">村适龄儿童少年接受义务教育情况统计表<shiro:hasPermission name="co:coChildHaveEducation:edit">${not empty coChildHaveEducation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="co:coChildHaveEducation:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>

<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/co/coCountryYear/form?id=${coMain.coId}">村名与年度</a></li>
		<li><a href="${ctx}/co/coCharacterIndustry/form?coMain.coId=${coMain.coId}&coMain.type=1">特色产业情况统计表</a></li>
		<li><a href="${ctx}/co/coPoorHouIndustry/form?coMain.coId=${coMain.coId}&coMain.type=2">村贫困户产业登记表</a></li>
		<li><a href="${ctx}/co/coLaborOut/form?coId=${coMain.coId}&countryId=${countryId}">贫困户劳动力统计表</a></li>
		<li><a href="${ctx}/co/coLaborSituation/form?coId=${coMain.coId}&countryId=${countryId}">贫困户劳动力情况表</a></li>
		<li><a href="${ctx}/co/coHouseSecurity/form?coMain.coId=${coMain.coId}&coMain.type=5">住房保障达标情况统计表</a></li>
		<li><a href="${ctx}/co/coHouseSituation/form?coId=${coMain.coId}&countryId=${countryId}">住房保障未达标户名单情况表</a></li>
		<li><a href="${ctx}/co/coPovertyRelocation/form?coMain.coId=${coMain.coId}&coMain.type=7">易地扶贫搬迁户住房保障情况表</a></li>
		<li><a href="${ctx}/co/coBuyMedicalInsurance/form?coMain.coId=${coMain.coId}&coMain.type=8">居民购买医疗或商业保险情况</a></li>
		<li><a href="${ctx}/co/coInsuranceNameList/form?coId=${coMain.coId}&countryId=${countryId}">未购买医疗或商业保险情况名单</a></li>
		<li><a href="${ctx}/co/coIllTreatment/form?coId=${coMain.coId}&countryId=${countryId}">患病救治和补助报销情况统计</a></li>
		<li class="active"><a>适龄儿童接受义务教育</a></li>
		<li><a href="${ctx}/co/coNoEducation/form?coMain.coId=${coMain.coId}&coMain.type=12">适龄儿童未接受义务教育</a></li>
		<li><a href="${ctx}/co/coPoorStudentPolicy/form?coMain.coId=${coMain.coId}&coMain.type=13">学生享受教育精准扶贫政策</a></li>
		<li><a href="${ctx}/co/coSafeDrink/form?coId=${coMain.coId}&countryId=${countryId}">安全饮水达标情况统计</a></li>
		<li><a href="${ctx}/co/coDrinkSituation/form?coId=${coMain.coId}&countryId=${countryId}">未达到安全饮水户名单</a></li>
		<li><a href="${ctx}/co/coRoadSituation/form?coId=${coMain.coId}&countryId=${countryId}">通硬化路情况表</a></li>
		<li><a href="${ctx}/co/coTwentyRoad/form?coId=${coMain.coId}&countryId=${countryId}">20户以上通路情况表</a></li>
		<li><a href="${ctx}/co/coHaveElectric/form?coMain.coId=${coMain.coId}&coMain.type=18">村有电用达标情况统计表</a></li>
		<li><a href="${ctx}/co/coNoElectric/form?coMain.coId=${coMain.coId}&coMain.type=19">全村未接通生活用电户名单</a></li>
		<li><a href="${ctx}/co/coCultureSituation/form?coId=${coMain.coId}&countryId=${countryId}">篮球场，文化室或戏台情况表</a></li>
		<li><a href="${ctx}/co/coNetwork/form?coId=${coMain.coId}&countryId=${countryId}">通网络宽带情况表</a></li>
		<li><a href="${ctx}/co/coEndowmentInsured/form?coMain.coId=${coMain.coId}&coMain.type=22">城乡居民养老保险参保情况</a></li>
		<li><a href="${ctx}/co/coNoEndowmentInsured/form?coMain.coId=${coMain.coId}&coMain.type=23">城乡居民养老保险未参保名单</a></li>
		<li><a href="${ctx}/co/coAllowances/form?coMain.coId=${coMain.coId}&coMain.type=24">贫困户纳入农村低保情况</a></li>
		<li><a href="${ctx}/co/coTvOnline/form?coId=${coMain.coId}&countryId=${countryId}">农户能看电视或上网情况统计表</a></li>
		<li><a href="${ctx}/co/coDigitalCount/form?coId=${coMain.coId}&countryId=${countryId}">未有数码设备名单</a></li>
		<li><a href="${ctx}/co/coIncidenceOfPoverty/form?coId=${coMain.coId}&countryId=${countryId}">贫困发生率统计表</a></li>
	</ul>
	<div id="tab-1" class="content-detail">
		<c:choose>
		<c:when test="${empty coMain.coId}">
		<script>
			alert("请先填写村名和年度！");
			window.history.back(-1);
		</script>
		</c:when>
		<c:otherwise>
		<form:form id="inputForm" modelAttribute="coMain" action="${ctx}/co/coChildHaveEducation/save" method="post" class="form-horizontal">
			<sys:message content="${message}"/>
			<br>
			<h2 class="table-title"><input style="font-size: 25px;width: 80px" type="text" value="${countryYear.area.name}"/>适龄儿童少年接受义务教育情况统计表</h2>
			<h3 class="table-subtitle">
				<span>填报单位：<input style="font-size: 22px;width: 80px" type="text" value="平桂"/>县（市、区）教育局（盖章）</span>
					<span>填报时间：<input name="fillDate" id="years" type="text"  maxlength="20" class="input-medium Wdate required"
									  value="<fmt:formatDate value="${coMain.fillDate}" pattern="yyyy-MM-dd"/>"
									  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/></span>
			</h3>
			<input type="hidden" name="id" value="${coMain.id}"/>
			<input type="hidden" name="type" value="11"/>
			<input type="hidden" name="coId" value="${coMain.coId}"/>
			<input id="countryId" type="hidden" name="countryId" value="${countryId}"/>
			<table>
				<tbody id="accpitem">
				<tr>
					<td rowspan="2" width=30">序号</td>
					<td rowspan="2" width="70">自然村（屯）</td>
					<td rowspan="2">适龄儿童少年应接受义务教育人数</td>
					<td rowspan="2">适龄儿童少年已接受义务教育人数</td>
					<td>其中</td>
					<td rowspan="2">未接受义务教育人数</td>
					<td>其中</td>
					<td rowspan="2">辍学率（%）</td>
					<td rowspan="2">备注</td>
					<td rowspan="2" style="text-align: center;cursor: pointer;width: 50px;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
				</tr>
				<tr>
					<td width="65px">享受义务教育扶贫政策人数</td>
					<td width="65px">因经济困难辍学人数</td>
				</tr>
				<c:if test="${coMain.educations != null && !coMain.educations.isEmpty()}">
					<c:forEach items="${coMain.educations}" var="education" varStatus="status">
						<tr class="bg-white">
							<td>
								<input type="hidden" name="educations[${status.index}].id" value="${education.id}" class="id"/>
								<input type="text" name="educations[${status.index}].idx" value="${education.idx}" class="idx int"/>
							</td>
							<td>
								<input type="text" name="educations[${status.index}].countryId" value="${education.countryId}" class="countryId"/>
							</td>
							<td>
								<input type="text" name="educations[${status.index}].shouldEducation" value="${education.shouldEducation}" class="shouldEducation int"/>
							</td>
							<td>
								<input type="text" name="educations[${status.index}].haveEducation" value="${education.haveEducation}" class="haveEducation int"/>
							</td>
							<td width="62px">
								<input type="text" name="educations[${status.index}].haveEducationPolicy" value="${education.haveEducationPolicy}" class="haveEducationPolicy int"/>
							</td>
							<td>
								<input type="text" name="educations[${status.index}].noHaveEducation" value="${education.noHaveEducation}" class="noHaveEducation int"/>
							</td>
							<td>
								<input type="text" name="educations[${status.index}].poorNoEducation" value="${education.poorNoEducation}" class="poorNoEducation int"/>
							</td>
							<td>
								<input type="text" name="educations[${status.index}].dropOutRate" value="${education.dropOutRate}" class="dropOutRate decimal"/>
							</td>
							<td width="62px">
								<input type="text" name="educations[${status.index}].remarks" value="${education.remarks}" class="remarks"/>
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
					'<input type="hidden" name="educations[0].id"  class="id"/>'+
					'<input type="text" name="educations[0].idx" class="idx int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="educations[0].countryId" class="countryId"/>' +
					'</td>'+
					'<td>'+
					'<input type="text" name="educations[0].shouldEducation" class="shouldEducation int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="educations[0].haveEducation" class="haveEducation int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="educations[0].haveEducationPolicy" class="haveEducationPolicy int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="educations[0].noHaveEducation" class="noHaveEducation int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="educations[0].poorNoEducation" class="poorNoEducation int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="educations[0].dropOutRate" class="dropOutRate decimal"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="educations[0].remarks" class="remarks"/>'+
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
				$(this).find('.id').attr('name','educations['+i+'].id');
				$(this).find('.idx').attr('name','educations['+i+'].idx');
				$(this).find('.countryId').attr('name','educations['+i+'].countryId');
				$(this).find('.shouldEducation').attr('name','educations['+i+'].shouldEducation');
				$(this).find('.haveEducation').attr('name','educations['+i+'].haveEducation');
				$(this).find('.haveEducationPolicy').attr('name','educations['+i+'].haveEducationPolicy');
				$(this).find('.noHaveEducation').attr('name' , 'educations['+i+'].noHaveEducation');
				$(this).find('.poorNoEducation').attr('name','educations['+i+'].poorNoEducation');
				$(this).find('.dropOutRate').attr('name','educations['+i+'].dropOutRate');
				$(this).find('.remarks').attr('name','educations['+i+'].remarks');
				i++;
			});
		};
	});
</script>

</body>
</html>