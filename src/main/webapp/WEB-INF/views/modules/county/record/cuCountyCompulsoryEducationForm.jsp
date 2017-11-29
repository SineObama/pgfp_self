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

        /*删除一行数据处理*/
        $(function () {
            $("#inputForm .add-tr-btn").on("click", addTr);
            $("#tab-1").delegate(".del-thistd-btn", "click", function () {
                $(this).parents("tr").remove();
                renum++;
                /*刷新序号*/
                reflowIndex();
            });
        });

        /*添加一行tr*/
        function addTr() {
            amout = $("table tbody").find("tr").length;
            var index = amout + renum;
            var tr = "<tr>"
                <%--序号--%>
                + "<td class='bg-white'></td>"
                <%--乡镇--%>
                + "<td class='bg-white town'>"
                + "<input type='hidden' name='cuCountyCompulsoryEducations[" + index + "].town.id' class='townId'/>"
                + "<input class='input_none townName required' style='background-color: #FFFFFF' readonly='true'/>"
                + "</td>"
                <%--村--%>
                + "<td class='bg-white country'>"
                + "<input type='hidden' name='cuCountyCompulsoryEducations[" + index + "].country.id' class='countryId'/>"
                + "<input class='input_none required countryName' style='background-color: #FFFFFF' readonly='true'/>"
                + "</td>"
                <%--适龄儿童少年应接受义务教育人数--%>
                + "<td class='bg-white'>"
                + "<input name='cuCountyCompulsoryEducations[" + index + "].shouldComEducationNum' class='input_none int' maxlength='12'/>"
                + "</td>"
                <%--适龄儿童少年已接受义务教育人数--%>
                + "<td class='bg-white'>"
                + "<input name='cuCountyCompulsoryEducations[" + index + "].comEducationNum' class='input_none int' maxlength='12'/>"
                + "</td>"
                <%--享受义务教育扶贫政策人数--%>
                + "<td class='bg-white'>"
                + "<input name='cuCountyCompulsoryEducations[" + index + "].comEducationPolicyNum' class='input_none int' maxlength='12'/>"
                + "</td>"
                <%--未接受义务教育人数--%>
                + "<td class='bg-white'>"
                + "<input name='cuCountyCompulsoryEducations[" + index + "].noCoEducationNum' class='input_none int' maxlength='12'/>"
                + "</td>"
                <%--因经济原因辍学人数--%>
                + "<td class='bg-white'>"
                + "<input name='cuCountyCompulsoryEducations[" + index + "].dropOut' class='input_none int' maxlength='12'/>"
                + "</td>"
                <%--辍学率--%>
                + "<td class='bg-white'>"
                + "<input name='cuCountyCompulsoryEducations[" + index + "].dropOutRate' class='input_none decimal' maxlength='12'/>"
                + "</td>"
                <%--备注--%>
                + "<td class='bg-white'>"
                + "<input name='cuCountyCompulsoryEducations[" + index + "].remarks' class='input_none'/>"
                + "</td>"
                + "<td class='bg-white' style='text-align: center'>"
                + "<span class='del-thistd-btn'>删除</span>"
                + "</td>"
                + "</tr>";
            $("table tbody").append(tr);
            /*刷新序号*/
            reflowIndex();
        }

        $(document).ready(function () {
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
            /*菜单置为选中状态*/
            $(".content-nav #CompulsoryEducation").attr("class", "active");
        })


        /*********************************** 区域设置关联块********************************************/
        var who;

        function chooseMember(area, type) {
            switch (type) {
                case 0:
                    /*县*/
                    who.find(".countyId").val(area.id);
                    who.find(".countyName").val(area.name);
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
            /*平桂 0*/
            $("#inputForm").delegate(".county", 'click', function () {
                who = $(this);
                callWindow("1", "0");
            });
            /*乡镇 1*/
            $(" #accpitem").delegate(".town", 'click', function () {
                var id = $("#inputForm .countyId").val();
                who = $(this);
                callWindow(id, "1");
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
        });
        /*********************************** 区域设置关联块********************************************/

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
                   action="${ctx}/record/cuCountyCompulsoryEducation/save" method="post" class="form-horizontal">
            <sys:message content="${message}"/>
            <form:hidden id="year" path="year"/>
            <form:hidden id="cuMainId" path="cuMainId"/>
            <h1 style="text-align: center"><u> 平桂 </u>县(市、区）贫困人口患病救治和补助报销情况统计表</h1>
            <br/><br/>
            <p>
                <input type="hidden" name="id" value="${cuTable.id}">
                <span class="county">填报单位：
					<input type="hidden" class="countyId" name="department.id" value="${cuTable.department.id}"/>
					<input name="department.name" class="underline required countyName"
                           value="${cuTable.department.name}"/>县(市、区）公共服务专责小组（盖章）
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
                        <td width="20px" rowspan="2">序号</td>
                        <td width="70px" rowspan="2">乡（镇）</td>
                        <td width="80px" rowspan="2">行政村</td>
                        <td rowspan="2">适龄儿童少年应接受义务教育人数</td>
                        <td rowspan="2">适龄儿童少年已接受义务教育人数</td>
                        <td>其中</td>
                        <td rowspan="2">未接受义务教育人数</td>
                        <td>其中</td>
                        <td rowspan="2">辍学率</td>
                        <td width="140px" rowspan="2">备注</td>
                        <td tyle="cursor: pointer;" class="add-tr-btn" width="40px"  rowspan="2">添加<span
                                style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
                    </tr>
                    <tr>
                        <td width="20px">享受义务教育扶贫政策人数</td>
                        <td width="20px">因经济困难原因辍学数</td>
                    </tr>
                    </thead>
                    <tbody id="accpitem">
                    <c:if test="${!empty cuTable.cuCountyCompulsoryEducations}">
                        <c:forEach items="${cuTable.cuCountyCompulsoryEducations}" var="house" varStatus="status">
                            <c:set var="index" value="${status.index}"/>
                            <input type="hidden" name="cuCountyCompulsoryEducations[${index}].id" value="${house.id}"/>
                            <tr>
                                    <%--序号--%>
                                <td class="bg-white">${index}</td>
                                    <%--乡镇--%>
                                <td class="bg-white town">
                                    <input type="hidden"
                                           name="cuCountyCompulsoryEducations[${index}].town.id"
                                           class="townId"
                                           value="${house.town.id}"/>
                                    <input class="input_none townName required"
                                           style="background-color: #FFFFFF"
                                           value="${house.town.name}"
                                           readonly="true"/>
                                </td>
                                    <%--村--%>
                                <td class="bg-white country">
                                    <input type="hidden" name="cuCountyCompulsoryEducations[${index}].country.id"
                                           class="countryId "
                                           value="${house.country.id}"/>
                                    <input class="input_none required countryName"
                                           style="background-color: #FFFFFF"
                                           readonly="true"
                                           value="${house.country.name}"/>
                                </td>
                                    <%--适龄儿童少年应接受义务教育人数--%>
                                <td class="bg-white">
                                    <input name="cuCountyCompulsoryEducations[${index}].shouldComEducationNum"
                                           class="input_none int"
                                           maxlength="12"
                                           value="${house.shouldComEducationNum}"/>
                                </td>
                                    <%--适龄儿童少年已接受义务教育人数--%>
                                <td class="bg-white">
                                    <input name="cuCountyCompulsoryEducations[${index}].comEducationNum"
                                           class="input_none int"
                                           maxlength="12"
                                           value="${house.comEducationNum}"/>
                                </td>
                                    <%--享受义务教育扶贫政策人数--%>
                                <td class="bg-white">
                                    <input name="cuCountyCompulsoryEducations[${index}].comEducationPolicyNum"
                                           class="input_none int"
                                           maxlength="12"
                                           value="${house.comEducationPolicyNum}"/>
                                </td>
                                    <%--未接受义务教育人数--%>
                                <td class="bg-white">
                                    <input name="cuCountyCompulsoryEducations[${index}].noCoEducationNum"
                                           class="input_none int"
                                           maxlength="12"
                                           value="${house.noCoEducationNum}"/>
                                </td>
                                    <%--因经济原因辍学人数--%>
                                <td class="bg-white">
                                    <input name="cuCountyCompulsoryEducations[${index}].dropOut"
                                           class="input_none int"
                                           maxlength="12"
                                           value="${house.dropOut}"/>
                                </td>
                                    <%--辍学率--%>
                                <td class="bg-white">
                                    <input name="cuCountyCompulsoryEducations[${index}].dropOutRate"
                                           class="input_none decimal"
                                           maxlength="12"
                                           value="${house.dropOutRate}"/>
                                </td>
                                    <%--备注--%>
                                <td class="bg-white">
                                    <input name="cuCountyCompulsoryEducations[${index}].remarks"
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
                    <shiro:hasPermission name="record:cuCountyFarmerCooperation:edit">
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

