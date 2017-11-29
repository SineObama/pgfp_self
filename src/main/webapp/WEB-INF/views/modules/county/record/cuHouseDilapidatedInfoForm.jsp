<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\countyExport.css"/>
	<style>
		.wh100 {
			width: 100px !important;
		}
	</style>
	<script type="text/javascript">
        var index = 0;
        var renum = 0;
        /*添加删除更新序号*/
        function reflowIndex() {
            var trs = $('tbody tr');
            var trLen = trs.length;
            for (var i = 0; i <= trLen; i++) {
                var tr = trs[i];
                $(tr).find("td:eq(0)").text(i);
            }
        }
        $(function () {
            $("#inputForm .add-tr-btn").on("click", addTr);
            $("#tab-1").delegate(".del-thistd-btn", "click", function () {
                $(this).parents("tr").remove();
                renum = renum + 1;
                reflowIndex();
            });
        });

        /*添加一行*/
        function addTr() {
            index = $("table tbody").find("tr").length;
            var num = index + renum;
            var tr = "<tr>"
						<%--序号--%>
						+ "<td class='bg-white'></td>"
						<%--乡镇--%>
						+ "<td class='bg-white town'>"
							+ "<input type='hidden' name='cuHouseDilapidatedInfos[" + index + "].town.id' class='townId'/>"
							+ "<input class='input_none townName required' style='background-color: #FFFFFF' readonly='true'/>"
						+ "</td>"
						<%--村--%>
						+ "<td class='bg-white country'>"
							+ "<input type='hidden' name='cuHouseDilapidatedInfos[" + index + "].country.id' class='countryId'/>"
							+ "<input class='input_none required countryName' style='background-color: #FFFFFF' readonly='true'/>"
						+ "</td>"
						<%--屯--%>
						+ "<td class='bg-white tun'>"
							+ "<input type='hidden' name='cuHouseDilapidatedInfos[" + index + "].tun.id' class='tunId'/>"
							+ "<input class='input_none required tunName' style='background-color: #FFFFFF' readonly='true'/>"
						+ "</td>"
						<%--户主姓名--%>
						+ "<td class='bg-white'>"
							+ "<input name='cuHouseDilapidatedInfos[" + index + "].householdName' class='input_none required realName' />"
						+ "</td>"
						<%--家庭人口数--%>
						+ "<td class='bg-white'>"
							+ "<input name='cuHouseDilapidatedInfos[" + index + "].familyMember' class='input_none required int' maxlength='4'/>"
						+ "</td>"
						<%--存量危房面积--%>
						+ "<td class='bg-white'>"
							+ "<input name='cuHouseDilapidatedInfos[" + index + "].dilapidatedHousesArea' class='input_none required int'/>"
						+ "</td>"
						<%--解决措施--%>
						+ "<td class='bg-white'>"
							+ "<input name='cuHouseDilapidatedInfos[" + index + "].solution' class='input_none'/>"
						+ "</td>"
						<%--备注--%>
						+ "<td class='bg-white'>"
							+ "<input name='cuHouseDilapidatedInfos[" + index + "].remarks' class='input_none'/>"
						+ "</td>"

						+ "<td class='bg-white' style='text-align: center'>"
							+ "<span class='del-thistd-btn'>删除</span>"
						+ "</td>"
					+ "</tr>"
            $("table tbody").append(tr);
            reflowIndex();
        }

        /*********************************** 区域设置关联块********************************************/
        var who;
        function chooseMember(area,type){
            switch (type){
                case 0:
                    /*县*/
                    var year = $("#inputForm #year").val();
                    var MainId = $("#inputForm #cuMainId").val();
                    $.ajax({
                        url: "${ctx}/record/cuTable/id",
                        type: "post",
                        data: {'areaId': area.id, 'type': '11'},
                        datatype: "json",
                        success: function (data) {
                            if (data.id != null) {
                                window.location.href = "${ctx}/record/cuHouseDilapidatedInfo/form?cuMainId=" + MainId + "&year=" + year + "&type=11&department=" + area.id
                            } else {
                                $("table tbody").html("");
                                $("table thead input").val("");
                                $(".suffix input[type!='hidden']").val("");
                                $("input[id='time']").val("");
                            }
                        }
                    });
                    who.find(".countyId").val(area.id);
                    who.find(".countyName").val(area.name);
                    /*设置标题*/
                    var str = area.name.substring(0, area.name.length - 1);
                    $("#inputForm .h1Town").html(str);
                    break;
                case 1:
                    /*乡镇*/
                    who.find(".townId").val(area.id);
                    who.find(".townName").val(area.name);
                    break;
                case 2:
                    /*行政村 2*/
                    who.find(".countryId").val(area.id);
                    who.find(".countryName").val(area.name);
                    break;
                case 3:
                    /*屯 3*/
                    who.find(".tunId").val(area.id);
                    who.find(".tunName").val(area.name);
                    break;
            }
        }




        /*回调区域选择窗口*/
        $(function () {
            function callWindow(parentId, type) {
                <%--var countryId = '${countryId}';--%>
                var iWidth = 800;
                var iHeight = 400;
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                var win = window.open("${ctx}/record/cuTable/areaChoose?parentId=" + parentId + "&type=" + type, "选择地区", "width=" + iWidth +
                    ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
                    ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
                    "status=no,alwaysRaised=yes,depended=yes");
            };
            /*县 0*/
            $("#inputForm").delegate(".county", 'click', function () {
                who = $(this);
                callWindow("2", "0");
            });
            /*乡镇 1*/
            $("#inputForm").delegate(".town", 'click', function () {
                who = $(this);
                callWindow("2", "1");
            });
            /*行政村 2*/
            $(" #accpitem").delegate(".country", 'click', function () {
                var id = $(this).parents('tr').find(".townId").val();
                who = $(this);
                callWindow(id, "2");
            });
            /*屯 3*/
            $("#accpitem").delegate(".tun", 'click', function () {
                var id = $(this).parents('tr').find(".countryId").val();
                who = $(this);
                callWindow(id, "3");
            });

            /*********************************** 区域设置关联块********************************************/

            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is

                        (":checkbox") || element.is

                        (":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
            /*显示菜单选中*/
            $(".content-nav #DilapidatedInfo").attr("class", "active");
            /*载入页面设置标题镇*/
            var name = $("#inputForm .countyName").val();
            if (name != null && name.length > 0) {
                /*设置标题*/
                var str = name.substring(0, name.length - 1);
                $("#inputForm .h1Town").html(str);
            }
        });

        $(function () {
            $('input:checkbox').each(function () {
                if ($(this).val() === "1") {
                    $(this).attr("checked", true);
                } else {
                    $(this).attr("checked", false);
                }
            });
            $("tbody").delegate("input:checkbox", "click", function () {
                if ($(this).val() === "") {
                    $(this).val("1");
                }
            });
        });

	</script>
</head>
<body>

<ul class="nav nav-tabs">
	<li><a href="${ctx}/record/cuMain/">年度扶贫档案列表</a></li>
	<shiro:hasPermission name="record:cuMain:view">
		<li class="active">
			<a href="">扶贫年度档案添加</a>
		</li>
	</shiro:hasPermission>
</ul>
<div class="content tabs f-clear">
	<jsp:include page="cuItemList.jsp"/>
	<div id="tab-1" class="content-detail">
		<form:form id="inputForm" modelAttribute="cuTable"
				   action="${ctx}/record/cuHouseDilapidatedInfo/save" method="post" class="form-horizontal">
			<sys:message content="${message}"/>
			<form:hidden id="year" path="year"/>
			<form:hidden id="cuMainId" path="cuMainId"/>
			<h1 style="text-align: center"><u><span class="wh100">&nbsp;&nbsp;平桂&nbsp;&nbsp;</span></u>县(市、区）<u>&nbsp;&nbsp;<span
					class="h1Town wh100"></span>&nbsp;&nbsp;</u>乡（镇）贫困户存量危房情况表</h1>
			<br/><br/>
			<p>
				<input type="hidden" name="id" value="${cuTable.id}">
				<span class="county">填报单位：
					<input type="hidden" class="countyId" name="department.id" value="${cuTable.department.id}"/>
					<input name="department.name" readonly class="underline required countyName" style="background-color: #FFFFFF"
						   value="${cuTable.department.name}"/>乡(镇）人民政府（盖章）
				</span>
				<span style="float: right;">填报时间：<input name="time" id="time" type="text" maxlength="20"
														class="input-medium Wdate required"
														value="<fmt:formatDate value="${cuTable.time}" pattern="yyyy-MM-dd"/>"
														onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
														style="width: 120px;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</span>
			</p>
			<div>
				<table>
					<thead>
					<tr>
						<td width="20px">序号</td>
						<td width="60px">乡（镇）</td>
						<td width="80px">行政村</td>
						<td width="80px">自然村（屯）</td>
						<td width="50px">户主姓名</td>
						<td width="40px">家庭人口数</td>
						<td width="40px">存量危房面积</td>
						<td width="150px">解决措施</td>
						<td width="80px">备注</td>
						<td rowspan="3" style="cursor: pointer;" class="add-tr-btn">添加<span
								style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
					</tr>
					</thead>
					<tbody id="accpitem">
					<c:if test="${!empty cuTable.cuHouseDilapidatedInfos}">
						<c:forEach items="${cuTable.cuHouseDilapidatedInfos}" var="house" varStatus="status">
							<c:set var="index" value="${status.index}" scope="page"/>
							<%--id--%>
							<input type="hidden" name="cuHouseDilapidatedInfos[${index}].id"
								   value="${house.id}"/>
							<tr>
								<%--序号--%>
								<td class="bg-white">${index}</td>
									<%--乡镇--%>
								<td class="bg-white town">
									<input type="hidden"
										   name="cuHouseDilapidatedInfos[${index}].town.id"
										   class="townId"
										   value="${house.town.id}"/>
									<input class="input_none townName required"
										   style="background-color: #FFFFFF"
										   value="${house.town.name}"
										   readonly="true"/>
								</td>
									<%--村--%>
								<td class="bg-white country">
									<input type="hidden" name="cuHouseDilapidatedInfos[${index}].country.id"
										   class="countryId "
										   value="${house.country.id}"/>
									<input class="input_none required countryName"
										   style="background-color: #FFFFFF"
										   readonly="true"
										   value="${house.country.name}"/>
								</td>
									<%--屯--%>
								<td class="bg-white tun">
									<input type="hidden" name="cuHouseDilapidatedInfos[${index}].tun.id"
										   class="tunId "
										   value="${house.tun.id}"/>
									<input class="input_none required tunName"
										   style="background-color: #FFFFFF"
										   readonly="true"
										   value="${house.tun.name}"/>
								</td>
									<%--户主姓名--%>
								<td class="bg-white">
									<input name="cuHouseDilapidatedInfos[${index}].householdName"
										   class="input_none required realName"
										   value="${house.householdName}"/>
								</td>
									<%--家庭人口数--%>
								<td class="bg-white">
									<input name="cuHouseDilapidatedInfos[${index}].familyMember"
										   class="input_none required int"
										   maxlength="4"
										   value="${house.familyMember}"/>
								</td>
									<%--存量危房面积--%>
								<td class="bg-white">
									<input name="cuHouseDilapidatedInfos[${index}].dilapidatedHousesArea"
										   class="input_none required decimal"
										   value="${house.dilapidatedHousesArea}"/>
								</td>
									<%--解决措施--%>
								<td class="bg-white">
									<input name="cuHouseDilapidatedInfos[${index}].solution"
										   class="input_none"
										   value="${house.solution}"/>
								</td>
									<%--备注--%>
								<td class="bg-white">
									<input name="cuHouseDilapidatedInfos[${index}].remarks"
										   class="input_none"
										   value="${house.remarks}"/>
								</td>

								<td class="bg-white" style="text-align: center">
									<span class="del-thistd-btn">删除</span>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
				<div class="suffix">
					<p>
						<input type="hidden" name="type" value="${cuTable.type}">
						<span>审核人：<input name="verifier" class="underline required" value="${cuTable.verifier}"/></span>
						<span class="left">填表人：<input name="reportingName" class="underline required"
													  value="${cuTable.reportingName}"/></span>
						<span class="left">联系电话：<input name="phone" class="underline phone" maxlength="11"
													   value="${cuTable.phone}"/></span>
					</p>

				</div>
			</div>
			<div class="form-actions" style="padding-left: 20px!important;">
				<div class="submitStyle">
					<shiro:hasPermission name="record:cuHouseDilapidatedInfo:edit">
						<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
						<input id="btnExport" class="btn btn-primary btnEx" type="button" value="导 出"/>&nbsp;
					</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</form:form>
	</div>
</div>
</body>
</html>
