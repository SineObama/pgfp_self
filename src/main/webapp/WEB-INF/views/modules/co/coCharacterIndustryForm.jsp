<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村特色产业情况统计表管理</title>
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
		<%--<li><a href="${ctx}/co/coCharacterIndustry/">村特色产业情况统计表列表</a></li>--%>
		<li><a href="${ctx}/co/coCountryYear/">行政村档案清单列表</a></li>
		<li class="active"><a href="${ctx}/co/coCharacterIndustry/form?coMain.coId=${coMain.coId}&coMain.type=${coMain.type}">村特色产业情况统计表<shiro:hasPermission name="co:coCharacterIndustry:edit">${not empty coCharacterIndustry.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="co:coCharacterIndustry:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/co/coCountryYear/form?id=${coMain.coId}">村名与年度</a></li>
		<li class="active">特色产业情况统计表</li>
		<li><a href="${ctx}/co/coPoorHouIndustry/form?coMain.coId=${coMain.coId}&coMain.type=2">贫困户产业登记表</a></li>
		<li><a href="${ctx}/co/coLaborOut/form?coId=${coMain.coId}&countryId=${countryId}">贫困户劳动力统计表</a></li>
		<li><a href="${ctx}/co/coLaborSituation/form?coId=${coMain.coId}&countryId=${countryId}">贫困户劳动力情况表</a></li>
		<li><a href="${ctx}/co/coHouseSecurity/form?coMain.coId=${coMain.coId}&coMain.type=5">住房保障达标情况统计表</a></li>
		<li><a href="${ctx}/co/coHouseSituation/form?coId=${coMain.coId}&countryId=${countryId}">住房保障未达标户名单情况表</a></li>
		<li><a href="${ctx}/co/coPovertyRelocation/form?coMain.coId=${coMain.coId}&coMain.type=7">易地扶贫搬迁户住房保障情况表</a></li>
		<li><a href="${ctx}/co/coBuyMedicalInsurance/form?coMain.coId=${coMain.coId}&coMain.type=8">居民购买医疗或商业保险情况</a></li>
		<li><a href="${ctx}/co/coInsuranceNameList/form?coId=${coMain.coId}&countryId=${countryId}">未购买医疗或商业保险情况名单</a></li>
		<li><a href="${ctx}/co/coIllTreatment/form?coId=${coMain.coId}&countryId=${countryId}">患病救治和补助报销情况统计</a></li>
		<li><a href="${ctx}/co/coChildHaveEducation/form?coMain.coId=${coMain.coId}&coMain.type=11">适龄儿童接受义务教育</a></li>
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
		<%--<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${countryBasic.id}">村级道路情况</a></li>--%>
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
				<form:form id="inputForm" modelAttribute="coMain" action="${ctx}/co/coCharacterIndustry/save" method="post" class="form-horizontal">
					<%--<form:hidden path="id"/>--%>
					<sys:message content="${message}"/>
					<br>
					<h2 class="table-title"><input style="font-size: 25px;width: 80px" type="text" value="${countryYear.area.name}"/>特色产业情况统计表</h2>
					<h3 class="table-subtitle">
						<span>填报单位：<input style="font-size: 22px;width: 80px" type="text" value="平桂"/>县（市、区）产业开发专责小组（盖章）</span>
								<span>填报时间：<input name="fillDate" id="years" type="text"  maxlength="20" class="input-medium Wdate required"
												  value="<fmt:formatDate value="${coMain.fillDate}" pattern="yyyy-MM-dd"/>"
												  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/></span>
					</h3>
					<input type="hidden" name="id" value="${coMain.id}"/>
					<input type="hidden" name="type" value="1"/>
					<input type="hidden" name="coId" value="${coMain.coId}"/>
					<input id="countryId" type="hidden" name="countryId" value="${countryId}"/>
					<table>
						<tbody id="accpitem">
						<tr>
							<td rowspan="3" width=30">序号</td>
							<td rowspan="3" width="70">自然村（屯）</td>
							<td rowspan="3">贫困户数</td>
							<td rowspan="3" width="60">无劳动能力或主要劳动力长期外出务工的贫困户数</td>
							<td rowspan="2" colspan="2" width="60">1-3个特色产业</td>
							<td colspan="6">其中</td>
							<td rowspan="3" width="70">备注</td>
							<td rowspan="3" style="text-align: center;cursor: pointer;width: 50px;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
						</tr>
						<tr>
							<td colspan="2" width="150" style="text-align: left">产业1：<input type="text" name="coIndustry.industry1" value="${coMain.coIndustry.industry1}" style="width: 85px;border-bottom: 1px solid #ccc;border-radius: 0"/></td>
							<td colspan="2" width="150" style="text-align: left">产业2：<input type="text" name="coIndustry.industry2" value="${coMain.coIndustry.industry2}" style="width: 85px;border-bottom: 1px solid #ccc;border-radius: 0"/> </td>
							<td colspan="2" width="150" style="text-align: left">产业3：<input type="text" name="coIndustry.industry3" value="${coMain.coIndustry.industry3}" style="width: 85px;border-bottom: 1px solid #ccc;border-radius: 0"/></td>
						</tr>
						<tr>
							<td>覆盖贫困户数</td>
							<td>覆盖率(%)</td>
							<td>覆盖贫困户数</td>
							<td>覆盖率(%)</td>
							<td>覆盖贫困户数</td>
							<td>覆盖率(%)</td>
							<td>覆盖贫困户数</td>
							<td>覆盖率(%)</td>
						</tr>
						<c:if test="${coMain.industries != null && !coMain.industries.isEmpty()}">
							<c:forEach items="${coMain.industries}" var="industry" varStatus="status">
								<tr class="bg-white">
									<td>
										<input type="hidden" name="industries[${status.index}].id" value="${industry.id}" class="id"/>
										<input type="text" name="industries[${status.index}].idx" value="${industry.idx}" class="idx int"/>
									</td>
									<td>
										<input type="text" name="industries[${status.index}].countryId" value="${industry.countryId}" class="countryId"/>
									</td>
									<td>
										<input type="text" name="industries[${status.index}].poorHous" value="${industry.poorHous}" class="poorHous int"/>
									</td>
									<td>
										<input type="text" name="industries[${status.index}].nolobHous" value="${industry.nolobHous}" class="nolobHous int"/>
									</td>
									<td>
										<input type="text" name="industries[${status.index}].industry13Hous" value="${industry.industry13Hous}" class="industry13Hous int"/>
									</td>
									<td>
										<input type="text" name="industries[${status.index}].industry13Rate" value="${industry.industry13Rate}" class="industry13Rate decimal"/>
									</td>
									<td>
										<input type="text" name="industries[${status.index}].industry1Hous" value="${industry.industry1Hous}" class="industry1Hous int"/>
									</td>
									<td>
										<input type="text" name="industries[${status.index}].industry1Rate" value="${industry.industry1Rate}" class="industry1Rate decimal"/>
									</td>
									<td>
										<input type="text" name="industries[${status.index}].industry2Hous" value="${industry.industry2Hous}" class="industry2Hous int"/>
									</td>
									<td>
										<input type="text" name="industries[${status.index}].industry2Rate" value="${industry.industry2Rate}" class="industry2Rate decimal"/>
									</td>
									<td>
										<input type="text" name="industries[${status.index}].industry3Hous" value="${industry.industry3Hous}" class="industry3Hous int"/>
									</td>
									<td>
										<input type="text" name="industries[${status.index}].industry3Rate" value="${industry.industry3Rate}" class="industry3Rate decimal"/>
									</td>
									<td>
										<input type="text" name="industries[${status.index}].remarks" value="${industry.remarks}" class="remarks"/>
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
					<%--<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>--%>
				</form:form>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<script >
	var tr;
	function chooseMember(area){
//			console.debug(member);
		tr.find(".countryId").val(area.name);
	}

	//弹出自然村屯选择窗口
	$(function () {
		$("#accpitem").delegate(".countryId",'click',function(){
			var countryId = $("#countryId").val();
			<%--var countryId = '${countryId}';--%>
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
//		$(".content-nav li").each(function () {
//			$(this).click(function () {
//				$(".header-rt").text($(this).text())
//			})
//		});

		$(".add-tr-btn").click(function(){
//				console.debug('click add');
//				var _len=$("#accpitem tr").length - 1;
			var trHtml = '<tr class="bg-white">'+
					'<td>'+
					'<input type="hidden" name="industries[0].id"  class="id"/>'+
					'<input type="text" name="industries[0].idx" class="idx int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="industries[0].countryId" class="countryId"/>' +
					'</td>'+
					'<td>'+
					'<input type="text" name="industries[0].poorHous" class="poorHous int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="industries[0].nolobHous" class="nolobHous int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="industries[0].industry13Hous" class="industry13Hous int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="industries[0].industry13Rate" class="industry13Rate decimal"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="industries[0].industry1Hous" class="industry1Hous int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="industries[0].industry1Rate" class="industry1Rate decimal"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="industries[0].industry2Hous" class="industry2Hous int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="industries[0].industry2Rate" class="industry2Rate decimal"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="industries[0].industry3Hous" class="industry3Hous int"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="industries[0].industry3Rate" class="industry3Rate decimal"/>'+
					'</td>'+
					'<td>'+
					'<input type="text" name="industries[0].remarks" class="remarks"/>'+
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
				$(this).find('.id').attr('name','industries['+i+'].id');
				$(this).find('.idx').attr('name','industries['+i+'].idx');
				$(this).find('.countryId').attr('name','industries['+i+'].countryId');
				$(this).find('.poorHous').attr('name','industries['+i+'].poorHous');
				$(this).find('.nolobHous').attr('name','industries['+i+'].nolobHous');
				$(this).find('.industry13Hous').attr('name','industries['+i+'].industry13Hous');
				$(this).find('.industry13Rate').attr('name' , 'industries['+i+'].industry13Rate');
				$(this).find('.industry1Hous').attr('name','industries['+i+'].industry1Hous');
				$(this).find('.industry1Rate').attr('name','industries['+i+'].industry1Rate');
				$(this).find('.industry2Hous').attr('name','industries['+i+'].industry2Hous');
				$(this).find('.industry2Rate').attr('name','industries['+i+'].industry2Rate');
				$(this).find('.industry3Hous').attr('name','industries['+i+'].industry3Hous');
				$(this).find('.industry3Rate').attr('name','industries['+i+'].industry3Rate');
				$(this).find('.remarks').attr('name','industries['+i+'].remarks');
				i++;
			});
		};
	});
</script>

</body>
</html>