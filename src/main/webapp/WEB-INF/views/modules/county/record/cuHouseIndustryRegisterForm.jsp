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
                + "<td class='bg-white'></td>"
                <%--行政村--%>
                + "<td class='bg-white country'>"
                + "<input type='hidden' name='cuHouseIndustryRegisters[" + num + "].country.id'class='countryId'/>"
                + "<input class='input_none required countryName' style='background-color: #FFFFFF' readonly/>"
                + "</td>"
                <%--屯--%>
                + "<td class='bg-white tun'>"
                + "<input type='hidden' name='cuHouseIndustryRegisters[" + num + "].tun.id'class='tunId'/>"
                + "<input class='input_none tunName' style='background-color: #FFFFFF' readonly/>"
                + "</td>"
                <%--户主姓名--%>
                + "<td class='bg-white'>"
                + "<input name='cuHouseIndustryRegisters[" + num + "].householdName'class='input_none required realName' maxlength='20'/>"
                + "</td>"
                <%--家庭人口数--%>
                + "<td class='bg-white'>"
                + "<input name='cuHouseIndustryRegisters[" + num + "].houseAmount'class='input_none int required'/>"
                + "</td>"
                <%--有该产业的打“√”--%>
                + "<td class='bg-white'>"
                + "<input type='checkbox'name='cuHouseIndustryRegisters[" + num + "].haveIndustryOne'class='input_none' value='1'/>"
                + "</td>"
                <%--产业规模--%>
                + "<td class='bg-white'>"
                + "<input name='cuHouseIndustryRegisters[" + num + "].industryScaleOne'class='input_none int' />"
                + "</td>"
                <%--有该产业的打“√”--%>
                + "<td class='bg-white'>"
                + "<input type='checkbox'name='cuHouseIndustryRegisters[" + num + "].haveIndustryTwo'class='input_none' value='1'/>"
                + "</td>"
                <%--产业规模--%>
                + "<td class='bg-white'>"
                + "<input name='cuHouseIndustryRegisters[" + num + "].industryScaleTwo'class='input_none int' />"
                + "</td>"
                <%--有该产业的打“√”--%>
                + "<td class='bg-white'>"
                + "<input type='checkbox'name='cuHouseIndustryRegisters[" + num + "].haveIndustryThree'class='input_none' value='1'/>"
                + "</td>"
                <%--产业规模--%>
                + "<td class='bg-white'>"
                + "<input name='cuHouseIndustryRegisters[" + num + "].industryScaleThree'class='input_none int' />"
                + "</td>"
                <%--有该产业的打“√”--%>
                + "<td class='bg-white'>"
                + "<input type='checkbox'name='cuHouseIndustryRegisters[" + num + "].haveIndustryFour'class='input_none' value='1'/>"
                + "</td>"
                <%--产业规模--%>
                + "<td class='bg-white'>"
                + "<input name='cuHouseIndustryRegisters[" + num + "].industryScaleFour'class='input_none int' />"
                + "</td>"
                <%--有该产业的打“√”--%>
                + "<td class='bg-white'>"
                + "<input type='checkbox'name='cuHouseIndustryRegisters[" + num + "].haveIndustryFive'class='input_none' value='1'/>"
                + "</td>"
                <%--产业规模--%>
                + "<td class='bg-white'>"
                + "<input name='cuHouseIndustryRegisters[" + num + "].industryScaleFive'class='input_none int' />"
                + "</td>"
                + "<td class='bg-white' style='text-align: center'>"
                + "<span class='del-thistd-btn'>删除</span>"
                + "</td>"
                + "</tr>";
            $("table tbody").append(tr);
            reflowIndex();
        }

        /*********************************** 区域设置关联块********************************************/
        var who;
        function chooseMember(area, type) {
            /*乡镇*/
            if (type == 1) {
                var year = $("#inputForm #year").val();
                var MainId = $("#inputForm #cuMainId").val();
                $.ajax({
                    url: "${ctx}/record/cuTable/id",
                    type: "post",
                    data: {'areaId': area.id, 'type': '2'},
                    datatype: "json",
                    success: function (data) {
                        if (data.id != null) {
                            window.location.href = "${ctx}/record/cuHouseIndustryRegister/form?cuMainId=" + MainId + "&year=" + year + "&type=2&department=" + area.id
                        } else {
                            $("table tbody").html("");
                            $("table thead input").val("");
                            $(".suffix input[type!='hidden']").val("");
                            $("input[id='time']").val("");
                        }
                    }
                });

                who.find(".townId").val(area.id);
                who.find(".townName").val(area.name);

                /*设置标题*/
                var str = area.name.substring(0, area.name.length - 1);
                $("#inputForm .h1Town").html(str);
            }
            /*行政村*/
            if (type == 2) {
                who.find(".countryId").val(area.id);
                who.find(".countryName").val(area.name);
            }
            /*屯*/
            if (type == 3) {
                who.find(".tunId").val(area.id);
                who.find(".tunName").val(area.name);
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
            /*乡镇 1*/
            $("#inputForm").delegate(".county", 'click', function () {
                who = $(this);
                callWindow("2", "1");
            });
            /*行政村 2*/
            $(" #accpitem").delegate(".country", 'click', function () {
                var id = $("#inputForm .townId").val();
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
            $(".content-nav #industry").attr("class", "active");
            /*载入页面设置标题镇*/
            var name = $("#inputForm .center_left .townName").val();
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
                   action="${ctx}/record/cuHouseIndustryRegister/save" method="post" class="form-horizontal">
            <sys:message content="${message}"/>
            <form:hidden id="year" path="year"/>
            <form:hidden id="cuMainId" path="cuMainId"/>
            <h1 style="text-align: center"><u><span class="wh100">&nbsp;&nbsp;平桂&nbsp;&nbsp;</span></u>县(市、区）<u>&nbsp;&nbsp;<span
                    class="h1Town wh100"></span>&nbsp;&nbsp;</u>乡（镇）贫困户产业登记表</h1>
            <br/><br/>
            <p>
                <input type="hidden" name="id" value="${cuTable.id}">
                <span class="county">填报单位：
					<input type="hidden" class="townId" name="department.id" value="${cuTable.department.id}"/>
					<input name="department.name" readonly class="underline required townName" style="background-color: #FFFFFF"
                           value="${cuTable.department.name}"/>乡（镇）人民政府（盖章）
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
                        <td rowspan="2" style="width:35px">序号</td>
                        <td rowspan="2">行政村</td>
                        <td rowspan="2">自然村（屯）</td>
                        <td rowspan="2">户主姓名</td>
                        <td rowspan="2">家庭人口数</td>
                        <td colspan="2">产业：
                            <input name="cuSpecialtyIndustry.id" type="hidden"
                                   value="${cuTable.cuSpecialtyIndustry.id}"/>
                            <input name="cuSpecialtyIndustry.tableId" type="hidden"
                                   value="${cuTable.cuSpecialtyIndustry.tableId}"/>
                            <input name="cuSpecialtyIndustry.industryNameOne"
                                   class="underline underline_width"
                                   maxlength="20"
                                   value="${cuTable.cuSpecialtyIndustry['industryNameOne']}"/>
                        </td>
                        <td colspan="2">产业：
                            <input name="cuSpecialtyIndustry.industryNameTwo"
                                   class="underline underline_width"
                                   maxlength="20"
                                   value="${cuTable.cuSpecialtyIndustry['industryNameTwo']}"/>
                        </td>
                        <td colspan="2">产业：
                            <input name="cuSpecialtyIndustry.industryNameThree"
                                   class="underline underline_width"
                                   maxlength="20"
                                   value="${cuTable.cuSpecialtyIndustry['industryNameThree']}"/>
                        </td>
                        <td colspan="2">产业：
                            <input name="cuSpecialtyIndustry.industryNameFour"
                                   class="underline underline_width"
                                   maxlength="20"
                                   value="${cuTable.cuSpecialtyIndustry['industryNameFour']}"/>
                        </td>
                        <td colspan="2">产业：
                            <input name="cuSpecialtyIndustry.industryNameFive"
                                   class="underline underline_width"
                                   maxlength="20"
                                   value="${cuTable.cuSpecialtyIndustry['industryNameFive']}"/>
                        </td>
                        <td rowspan="3" style="cursor: pointer;" class="add-tr-btn">添加<span
                                style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
                    </tr>
                    <tr>
                        <td>有该产业的打√</td>
                        <td>产业规模</td>
                        <td>有该产业的打√</td>
                        <td>产业规模</td>
                        <td>有该产业的打√</td>
                        <td>产业规模</td>
                        <td>有该产业的打√</td>
                        <td>产业规模</td>
                        <td>有该产业的打√</td>
                        <td>产业规模</td>
                    </tr>
                    </thead>
                    <tbody id="accpitem">
                    <c:if test="${!empty cuTable.cuHouseIndustryRegisters}">
                        <c:forEach items="${cuTable.cuHouseIndustryRegisters}" var="house" varStatus="status">
                            <c:set var="index" value="${status.index}" scope="page"/>
                            <%--id--%>
                            <input type="hidden" name="cuHouseIndustryRegisters[${index}].id"
                                   value="${house.id}"/>
                            <tr>
                                <td class="bg-white">${index}</td>
                                    <%--行政村--%>
                                <td class="bg-white country">
                                    <input type="hidden" name="cuHouseIndustryRegisters[${index}].country.id"
                                           class="countryId" value="${house.country.id}"/>
                                    <input class="input_none required countryName" style="background-color: #FFFFFF"
                                           readonly="true"
                                           value="${house.country.name}"/>
                                </td>
                                    <%--屯--%>
                                <td class="bg-white tun">
                                    <input type="hidden" name="cuHouseIndustryRegisters[${index}].tun.id"
                                           class="tunId" value="${house.tun.id}"/>
                                    <input class="input_none tunName" style="background-color: #FFFFFF" readonly="true"
                                           value="${house.tun.name}"/>
                                </td>
                                    <%--户主姓名--%>
                                <td class="bg-white">
                                    <input name="cuHouseIndustryRegisters[${index}].householdName"
                                           class="input_none required realName" maxlength="20"
                                           value="${house.householdName}"/>
                                </td>
                                    <%--家庭人口数--%>
                                <td class="bg-white">
                                    <input name="cuHouseIndustryRegisters[${index}].houseAmount"
                                           class="input_none int required"
                                           value="${house.houseAmount}"/>
                                </td>
                                    <%--有该产业的打“√”--%>
                                <td class="bg-white">
                                    <input type="checkbox"
                                           name="cuHouseIndustryRegisters[${index}].haveIndustryOne"
                                           class="input_none"
                                           value="${house.haveIndustryOne}"/>
                                </td>
                                    <%--产业规模--%>
                                <td class="bg-white">
                                    <input name="cuHouseIndustryRegisters[${index}].industryScaleOne"
                                           class="input_none int"
                                           value="${house.industryScaleOne}"/>
                                </td>
                                    <%--有该产业的打“√”--%>
                                <td class="bg-white">
                                    <input type="checkbox"
                                           name="cuHouseIndustryRegisters[${index}].haveIndustryTwo"
                                           class="input_none"
                                           value="${house.haveIndustryTwo}"/>

                                </td>
                                    <%--产业规模--%>
                                <td class="bg-white">
                                    <input name="cuHouseIndustryRegisters[${index}].industryScaleTwo"
                                           class="input_none int"
                                           value="${house.industryScaleTwo}"/>
                                </td>
                                    <%--有该产业的打“√”--%>
                                <td class="bg-white">
                                    <input type="checkbox"
                                           name="cuHouseIndustryRegisters[${index}].haveIndustryThree"
                                           class="input_none"
                                           value="${house.haveIndustryThree}"/>
                                </td>
                                    <%--产业规模--%>
                                <td class="bg-white">
                                    <input name="cuHouseIndustryRegisters[${index}].industryScaleThree"
                                           class="input_none int"
                                           value="${house.industryScaleThree}"/>
                                </td>
                                    <%--有该产业的打“√”--%>
                                <td class="bg-white">
                                    <input type="checkbox"
                                           name="cuHouseIndustryRegisters[${index}].haveIndustryFour"
                                           class="input_none"
                                           value="${house.haveIndustryFour}"/>
                                </td>
                                    <%--产业规模--%>
                                <td class="bg-white">
                                    <input name="cuHouseIndustryRegisters[${index}].industryScaleFour"
                                           class="input_none int"
                                           value="${house.industryScaleFour}"/>
                                </td>
                                    <%--有该产业的打“√”--%>
                                <td class="bg-white">
                                    <input type="checkbox"
                                           name="cuHouseIndustryRegisters[${index}].haveIndustryFive"
                                           class="input_none"
                                           value="${house.haveIndustryFive}"/>
                                </td>
                                    <%--产业规模--%>
                                <td class="bg-white">
                                    <input name="cuHouseIndustryRegisters[${index}].industryScaleFive"
                                           class="input_none int"
                                           value="${house.industryScaleFive}"/>
                                </td>
                                <td class="bg-white" style="text-align: center">
                                    <span class="del-thistd-btn">删除</span></td>
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
                    <shiro:hasPermission name="record:cuHouseIndustryRegister:edit">
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
