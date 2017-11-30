<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
	<title>养老保险未参保人员名单管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script type="text/javascript">
		$(document).ready(function () {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function (form) {
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function (error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
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
	.content-detail td {
		text-align: center;
		min-width: 92px !important;
	}

	/**
     * common Css
     */
	.content-detail .table-title {
		font-size: 24px;
		width: 1000px; /* 标题位置 */
		text-align: center;
		color: #317eac;
		white-space: nowrap;
	}

	.content-detail .table-title input {
		display: inline-block;
		border-radius: 0;
		width: 140px;
		font-size: 18px;
		border-bottom: 1px solid #ccc;
	}

	.content-detail .table-subtitle {
		width: 1000px; /* 副标题位置 */
		font-size: 0;
		white-space: nowrap;
	}

	.content-detail .table-subtitle > span {
		width: 50%;
		display: inline-block;
		font-size: 14px;
		color: #555;
	}

	.content-detail .table-subtitle > span:last-child {
		text-align: right;
	}

	.content-detail .table-subtitle > span:last-child input {
		width: 145px;
	}

	.content-detail .table-subtitle > span input {
		border-radius: 0;
		width: 100px;
		font-size: 16px;
		border-bottom: 1px solid #ccc;
	}

	.text-bottom {
		margin-top: 10px;
		white-space: nowrap;
	}

	.text-bottom span {
		display: inline-block;
		width: 400px; /* 底部文字位置 */
		font-size: 14px;
	}

	/** -------- **/
	#areaName {
		height: 20px;
		border: 1px solid #ccc;
		text-align: start;
		padding: 4px 6px 4px 6px;
		font-size: 14px;
		border-radius: 4px 0 0 4px;
	}
	.table-subtitle span{
		vertical-align: top;
	}
	#fillDate{
		padding: 4px 6px 4px 6px;
	}
</style>
<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/co/coCountryYear/">行政村档案清单列表</a></li>
	<%--<li><a href="${ctx}/record/workForceOffice/">驻村工作队情况_干部表列表</a></li>--%>
	<li class="active"><a href="">未购买医疗或商业保险情况名单<shiro:hasPermission
			name="co:coInsuranceNameList:edit">${not empty coLaborSituation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
			name="co:coInsuranceNameList:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>

<div class="content tabs f-clear">
	<%@ include file="/WEB-INF/views/include/coNav.jsp"%>
	<div id="tab-15" class="content-detail">
		<c:choose>
			<c:when test="${empty coMain.coId}">
				<script>
					alert("请先填写村名和年度！");
					window.history.back(-1);
				</script>
			</c:when>
			<c:otherwise>
				<form:form id="inputForm" modelAttribute="coMain" action="${ctx}/co/coInsuranceNameList/save" method="post"
						   class="form-horizontal">
					<sys:message content="${message}"/>
					<form:hidden path="id" value="${coMain.id}"/>
					<form:hidden path="coId"/>
					<h2 class="table-title"><input type="text" value="${countryName}" readonly/>居民未购买医疗保险或商业保险情况名单
					</h2>

					<h3 class="table-subtitle">
						<span>填报单位：<input type="text" value="平桂" readonly/>县（市丶区）公共服务专责小组（盖章）</span>
						<span>填报时间：<input name="fillDate" id="fillDate" type="text"  maxlength="20" class="input-medium Wdate required"
										  value="<fmt:formatDate value="${coMain.fillDate}" pattern="yyyy-MM-dd"/>"
										  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/></span>
					</h3>
					<table>
						<tbody id="accpitem">
						<tr>
							<td>序号</td>
							<td style="min-width: 150px!important;">自然村（屯）</td>
							<td>户主姓名</td>
							<td>家庭人口数</td>
							<td style="min-width: 200px!important;">未购买原因</td>
							<td>备注</td>
							<td style="text-align: center;cursor: pointer;width: 132px;" class="add-tr-btn">
								添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
						</tr>
						<c:if test="${coMain.coInsuranceNameLists != null && !coMain.coInsuranceNameLists.isEmpty()}">
						<c:forEach items="${coMain.coInsuranceNameLists}" var="coInsuranceName" varStatus="status">
						<tr>
							<td class="bg-white">
								<input type="hidden" name="coInsuranceNameLists[${status.index}].id"
									   value="${coInsuranceName.id}" class="id"/>
								<input type="hidden" name="coInsuranceNameLists[${status.index}].mainId" class="mainId"
									   value="${coInsuranceName.mainId}"/>
								<form:input path="coInsuranceNameLists[${status.index}].idx" htmlEscape="false"
											maxlength="255" class="idx input-xlarge "/>
							</td>
							<td class="bg-white">
								<form:input path="coInsuranceNameLists[${status.index}].natureId" htmlEscape="false"
											maxlength="64" class="natureId input-xlarge"/>
							</td>
							<td class="bg-white">
								<form:input path="coInsuranceNameLists[${status.index}].housename" htmlEscape="false"
											maxlength="64" class="housename input-xlarge"/>
							</td>
							<td class="bg-white">
								<form:input path="coInsuranceNameLists[${status.index}].familyNumber" htmlEscape="false"
											maxlength="64" class="familyNumber input-xlarge int"/>
							</td>

							<td class="bg-white">
								<form:input path="coInsuranceNameLists[${status.index}].reason" htmlEscape="false"
											maxlength="64" class="reason input-xlarge"/>
							</td>
							<td class="bg-white">
								<form:input path="coInsuranceNameLists[${status.index}].remarks" htmlEscape="false"
											maxlength="64" class="remarks input-xlarge "/>
							</td>

							<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>
							</c:forEach>
							</c:if>
						</tr>
						</tbody>
					</table>
					<div class="text-bottom">
						<span>审核人：</span>
						<span>填表人：</span>
						<span>联系电话：</span>
					</div>
					<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
				</form:form>
			</c:otherwise>
		</c:choose>
	</div>
	<script>
		var tr;
		function chooseMember(area) {
//			console.debug(member);
			tr.find(".natureId").val(area.name);
		}

		//弹出自然村屯选择窗口
		$(function () {
			$("#accpitem").delegate(".natureId", 'click', function () {
//				var cardId = $("#id").val();
				var countryId = '${countryId}';
				tr = $(this).parents("tr");
				var iWidth = 900;
				var iHeight = 500;
				var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
				var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
				var win = window.open("${ctx}/co/coCountryYear/countryChoose?countryId=" + countryId, "选择地区", "width=" + iWidth +
				", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
				",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
				"status=no,alwaysRaised=yes,depended=yes");
			});
		});
		$(function () {
			$(".content-nav li").each(function () {
				$(this).click(function () {
					$(".header-rt").text($(this).text())
				})
			})
			$(".add-tr-btn").click(function () {
				var _len = $("#accpitem tr").length - 1;
				var trHtml = '<tr>' +
						'<td class="bg-white">' +
						'<input type="hidden" name="coInsuranceNameLists[' + _len + '].id"  class="id">' +
						'<input type="hidden" name="coInsuranceNameLists[' + _len + '].mainId" class="mainId">' +
						'<input id="coInsuranceNameLists' + _len + '.idx" name="coInsuranceNameLists[' + _len + '].idx" class="idx input-mini required " type="text"  maxlength="10">' +
						'</td>' +
						'<td class="bg-white">' +
						'<input id="coInsuranceNameLists' + _len + '.natureId" name="coInsuranceNameLists[' + _len + '].natureId" class="natureId" type="text" >' +
						'</td>' +
						'<td class="bg-white">' +
						'<input id="coInsuranceNameLists' + _len + '.housename" name="coInsuranceNameLists[' + _len + '].housename" class="housename" type="text" >' +
						'</td>' +
						'<td class="bg-white">' +
						'<input id="coInsuranceNameLists' + _len + '.familyNumber" name="coInsuranceNameLists[' + _len + '].familyNumber" class="familyNumber int" type="text" >' +
						'</td>' +
						'<td class="bg-white">' +
						'<input id="coInsuranceNameLists' + _len + '.reason" name="coInsuranceNameLists[' + _len + '].reason" class="reason " type="text" >' +
						'</td>' +
						'<td class="bg-white">' +
						'<input id="coInsuranceNameLists' + _len + '.remarks" name="coInsuranceNameLists[' + _len + '].remarks" class="remarks" type="text" >' +
						'</td>' +

						'<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td></tr>';
				$(this).parents("tbody").append(trHtml);
				$("select").select2();
				rename();
			})
			$("#tab-15").delegate(".del-thistd-btn", "click", function () {
				$(this).parents("tr").remove();
				rename();
			});
			function rename() {
				var i = -1;
				$('#accpitem tr').each(function () {
//						console.debug("i = "+i);
					$(this).children('td').children('.id').attr('name', 'coInsuranceNameLists[' + i + '].id');
					$(this).children('td').children('.mainId').attr('name', 'coInsuranceNameLists[' + i + '].mainId');
					$(this).children('td').children('.idx').attr('name', 'coInsuranceNameLists[' + i + '].idx');
					$(this).children('td').children('.natureId').attr('name', 'coInsuranceNameLists[' + i + '].natureId');
					$(this).children('td').children('.housename').attr('name', 'coInsuranceNameLists[' + i + '].housename');
					$(this).children('td').children('.familyNumber').attr('name', 'coInsuranceNameLists[' + i + '].familyNumber');
					$(this).children('td').children('.reason').attr('name', 'coInsuranceNameLists[' + i + '].reason');
					$(this).children('td').children('.remarks').attr('name', 'coInsuranceNameLists[' + i + '].remarks');
					i++;
				});
			};
		});
	</script>
</div>
</body>
</html>