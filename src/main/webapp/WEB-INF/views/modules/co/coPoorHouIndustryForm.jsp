<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村贫困户产业登记表管理</title>
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
		<%--<li><a href="${ctx}/co/coPoorHouIndustry/">村贫困户产业登记表列表</a></li>--%>
		<li class="active"><a href="${ctx}/co/coPoorHouIndustry/form?coMain.coId=${coMain.coId}&coMain.type=2">村贫困户产业登记表<shiro:hasPermission name="co:coPoorHouIndustry:edit">${not empty coPoorHouIndustry.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="co:coPoorHouIndustry:edit">查看</shiro:lacksPermission></a></li>
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
					<form:form id="inputForm" modelAttribute="coMain" action="${ctx}/co/coPoorHouIndustry/save" method="post" class="form-horizontal">
						<%--<form:hidden path="id"/>--%>
						<sys:message content="${message}"/>
						<br>
						<h2 class="table-title"><input style="font-size: 25px;width: 80px" type="text" value="${countryYear.area.name}"/>贫困户产业登记表</h2>
						<h3 class="table-subtitle">
								<%--<input style="font-size: 22px;width: 80px" type="text" value="平桂"/>--%>
								<div class="control-group" style="float: left">
									<label class="control-label">填报单位：<font color="red">*</font>:</label>
									<div class="controls">
										<sys:treeselect id="area" name="area.id" value="${coMain.area.id}" labelName="area.name" labelValue="${coMain.area.name}"
														title="上级行政区划" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true" />
									</div>
								</div>
								<span>填报时间：<input name="fillDate" id="years" type="text"  maxlength="20" class="input-medium Wdate required"
												  value="<fmt:formatDate value="${coMain.fillDate}" pattern="yyyy-MM-dd"/>"
												  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/></span>
						</h3>
						<input type="hidden" name="id" value="${coMain.id}"/>
						<input type="hidden" name="type" value="2"/>
						<input type="hidden" name="coId" value="${coMain.coId}"/>
						<input id="countryId" type="hidden" name="countryId" value="${countryId}"/>
						<table>
							<tbody id="accpitem">
							<tr>
								<td rowspan="2" width=30">序号</td>
								<td rowspan="2" width="70">自然村（屯）</td>
								<td rowspan="2">户主姓名</td>
								<td rowspan="2" width="60">家庭人口数</td>
								<td colspan="2" width="150" style="text-align: left">
									产业1：<input type="text" name="coIndustry.industry1" value="${coMain.coIndustry.industry1}" style="width: 85px;border-bottom: 1px solid #ccc;border-radius: 0"/>
									<br>
									单位：<input type="text" name="coIndustry.industry1Unit" value="${coMain.coIndustry.industry1Unit}" style="width: 85px;border-bottom: 1px solid #ccc;border-radius: 0"/>(例如：亩，个等）
								</td>
								<td colspan="2" width="150" style="text-align: left">
									产业2：<input type="text" name="coIndustry.industry2" value="${coMain.coIndustry.industry2}" style="width: 85px;border-bottom: 1px solid #ccc;border-radius: 0"/>
									<br>
									单位：<input type="text" name="coIndustry.industry2Unit" value="${coMain.coIndustry.industry2Unit}" style="width: 85px;border-bottom: 1px solid #ccc;border-radius: 0"/>(例如：亩，个等）
								</td>
								<td colspan="2" width="150" style="text-align: left">
									产业3：<input type="text" name="coIndustry.industry3" value="${coMain.coIndustry.industry3}" style="width: 85px;border-bottom: 1px solid #ccc;border-radius: 0"/>
									<br>
									单位：<input type="text" name="coIndustry.industry3Unit" value="${coMain.coIndustry.industry3Unit}" style="width: 85px;border-bottom: 1px solid #ccc;border-radius: 0"/>(例如：亩，个等）
								</td>
								<td rowspan="2" width="70">备注</td>
								<td rowspan="2" style="text-align: center;cursor: pointer;width: 50px;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
							</tr>
							<tr>
								<td>有该产业的打“√”</td>
								<td>产业规模</td>
								<td>有该产业的打“√”</td>
								<td>产业规模</td>
								<td>有该产业的打“√”</td>
								<td>产业规模</td>
							</tr>
							<c:if test="${coMain.coPoorHouIndustries != null && !coMain.coPoorHouIndustries.isEmpty()}">
								<c:forEach items="${coMain.coPoorHouIndustries}" var="industry" varStatus="status">
									<tr class="bg-white">
										<td>
											<input type="hidden" name="coPoorHouIndustries[${status.index}].id" value="${industry.id}" class="id"/>
											<input type="text" name="coPoorHouIndustries[${status.index}].idx" value="${industry.idx}" class="idx int"/>
										</td>
										<td>
											<input type="text" name="coPoorHouIndustries[${status.index}].countryId" value="${industry.countryId}" class="countryId"/>
										</td>
										<td>
											<input type="text" name="coPoorHouIndustries[${status.index}].householdName" value="${industry.householdName}" class="householdName"/>
										</td>
										<td>
											<input type="text" name="coPoorHouIndustries[${status.index}].memberNum" value="${industry.memberNum}" class="memberNum int"/>
										</td>
										<td width="62px">
											<form:radiobuttons class="inp-right" path="coPoorHouIndustries[${status.index}].isIndustry1"
															   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
											<%--<input type="radio" name="coPoorHouIndustries[${status.index}].isIndustry1" value="1"/>--%>
											<%--<input type="radio" name="coPoorHouIndustries[${status.index}].isIndustry1" value="2"/>--%>
											<%--<input type="text" name="coPoorHouIndustries[${status.index}].isIndustry1" value="${industry.isIndustry1}" class="isIndustry1"/>--%>
										</td>
										<td>
											<input type="text" name="coPoorHouIndustries[${status.index}].industry1Scale" value="${industry.industry1Scale}" class="industry1Scale decimal"/>
										</td>
										<td width="62px">
											<form:radiobuttons class="inp-right" path="coPoorHouIndustries[${status.index}].isIndustry2"
															   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
											<%--<input type="text" name="coPoorHouIndustries[${status.index}].isIndustry2" value="${industry.isIndustry2}" class="isIndustry2"/>--%>
										</td>
										<td>
											<input type="text" name="coPoorHouIndustries[${status.index}].industry2Scale" value="${industry.industry2Scale}" class="industry2Scale decimal"/>
										</td>
										<td width="62px">
											<form:radiobuttons class="inp-right" path="coPoorHouIndustries[${status.index}].isIndustry3"
															   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
											<%--<input type="text" name="coPoorHouIndustries[${status.index}].isIndustry3" value="${industry.isIndustry3}" class="isIndustry3"/>--%>
										</td>
										<td>
											<input type="text" name="coPoorHouIndustries[${status.index}].industry3Scale" value="${industry.industry3Scale}" class="industry3Scale decimal"/>
										</td>
										<td>
											<input type="text" name="coPoorHouIndustries[${status.index}].remarks" value="${industry.remarks}" class="remarks"/>
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
						'<input type="hidden" name="coPoorHouIndustries[0].id"  class="id"/>'+
						'<input type="text" name="coPoorHouIndustries[0].idx" class="idx int"/>'+
						'</td>'+
						'<td>'+
						'<input type="text" name="coPoorHouIndustries[0].countryId" class="countryId"/>' +
						'</td>'+
						'<td>'+
						'<input type="text" name="coPoorHouIndustries[0].householdName" class="householdName"/>'+
						'</td>'+
						'<td>'+
						'<input type="text" name="coPoorHouIndustries[0].memberNum" class="memberNum int"/>'+
						'</td>'+

						'<td>'+
						'<span>' +
						'<input id="coPoorHouIndustries[0].isIndustry1" name="coPoorHouIndustries[0].isIndustry1" class="isIndustry1" type="radio" value="1">' +
						'<label for="coPoorHouIndustries[0].isIndustry1">是</label>' +
						'</span>' +
						'<span>' +
						'<input id="coPoorHouIndustries[0].isIndustry1" name="coPoorHouIndustries[0].isIndustry1" class="isIndustry1" type="radio" value="0">' +
						'<label for="coPoorHouIndustries[0].isIndustry1">否</label>' +
						'</span>'+
						'</td>'+

						'<td>'+
						'<input type="text" name="coPoorHouIndustries[0].industry1Scale" class="industry1Scale decimal"/>'+
						'</td>'+

						'<td>'+
						'<span>' +
						'<input id="coPoorHouIndustries[0].isIndustry2" name="coPoorHouIndustries[0].isIndustry2" class="isIndustry2" type="radio" value="1">' +
						'<label for="coPoorHouIndustries[0].isIndustry2">是</label>' +
						'</span>' +
						'<span>' +
						'<input id="coPoorHouIndustries[0].isIndustry2" name="coPoorHouIndustries[0].isIndustry2" class="isIndustry2" type="radio" value="0">' +
						'<label for="coPoorHouIndustries[0].isIndustry2">否</label>' +
						'</span>'+
						'</td>'+

						'<td>'+
						'<input type="text" name="coPoorHouIndustries[0].industry2Scale" class="industry2Scale decimal"/>'+
						'</td>'+

						'<td>'+
						'<span>' +
						'<input id="coPoorHouIndustries[0].isIndustry3" name="coPoorHouIndustries[0].isIndustry3" class="isIndustry3" type="radio" value="1">' +
						'<label for="coPoorHouIndustries[0].isIndustry3">是</label>' +
						'</span>' +
						'<span>' +
						'<input id="coPoorHouIndustries[0].isIndustry3" name="coPoorHouIndustries[0].isIndustry3" class="isIndustry3" type="radio" value="0">' +
						'<label for="coPoorHouIndustries[0].isIndustry3">否</label>' +
						'</span>'+
						'</td>'+

						'<td>'+
						'<input type="text" name="coPoorHouIndustries[0].industry3Scale" class="industry3Scale decimal"/>'+
						'</td>'+
						'<td>'+
						'<input type="text" name="coPoorHouIndustries[0].remarks" class="remarks"/>'+
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
					$(this).find('.id').attr('name','coPoorHouIndustries['+i+'].id');
					$(this).find('.idx').attr('name','coPoorHouIndustries['+i+'].idx');
					$(this).find('.countryId').attr('name','coPoorHouIndustries['+i+'].countryId');
					$(this).find('.householdName').attr('name','coPoorHouIndustries['+i+'].householdName');
					$(this).find('.memberNum').attr('name','coPoorHouIndustries['+i+'].memberNum');
					$(this).find('.isIndustry1').attr('name','coPoorHouIndustries['+i+'].isIndustry1');
					$(this).find('.industry1Scale').attr('name' , 'coPoorHouIndustries['+i+'].industry1Scale');
					$(this).find('.isIndustry2').attr('name','coPoorHouIndustries['+i+'].isIndustry2');
					$(this).find('.industry2Scale').attr('name','coPoorHouIndustries['+i+'].industry2Scale');
					$(this).find('.isIndustry3').attr('name','coPoorHouIndustries['+i+'].isIndustry3');
					$(this).find('.industry3Scale').attr('name','coPoorHouIndustries['+i+'].industry3Scale');
					$(this).find('.remarks').attr('name','coPoorHouIndustries['+i+'].remarks');
					i++;
				});
			};
		});
	</script>
</body>
</html>