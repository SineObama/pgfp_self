<%--suppress ALL --%>
<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
    <script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
    <link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
    <link rel="stylesheet" href="${ctxStatic}\pgfp\css\countyExport.css"/>
    <script type="text/javascript">
        $(document).ready(function () {
                /*checkbox回显*/
                $('input:checkbox').each(function () {
                    if ($(this).val() == 1) {
                        $(this).attr('checked', true);
                    } else {
                        $(this).attr('checked', false);
                    }
                    isEdit($(this));
                });

                function isEdit(v) {
                    if(v.parents('tr').find(".incapabilityHouse").attr("checked")  == "checked"){
                        v.parents('tr').find(".isEdit").each(function () {
                            $(this).attr("disabled", true);
                            $(this).parent('td').removeAttr("class");
                            $(this).val("")
                        });
                    }else{
                        v.parents('tr').find(".isEdit").each(function () {
                            $(this).attr("disabled", false);
                            $(this).parent('td').attr('class', "bg-white");
                        });
                    }
                };

                /**********************************  设置checkbox单选  ***********************************************/


                //绑定点击的checkbox
                $("#accpitem").delegate('input:checkbox', 'click', function () {
                    var check = $(this);  //记录点击checkbox位置
                    var state = check.attr("checked");  //点击后的checkbox状态（点击后取反）
                    var array = check.parents('tr').find("input:checkbox");  //获取点击位置所在的tr里的所有checkbox
                    var className = check.attr("class");//保存className

                    //判断是否是第一次点击
                    /*第一次点击时有一个checkbox状态先会取反，这时两个checkbox状态不相同*/
                    if (array[0].checked == array[1].checked) {
                        //循环list
                        for (var i = 0; i < array.length; i++) {
                            //每一个checkbox都取反
                            array[i].checked = !array[i].checked;
                            //根据取反后的状态赋值（true:1;false:""）
                            if (array[i].checked) {
                                array[i].value = "1"
                            } else {
                                array[i].value = "";
                            }
                        }
                    }
                    //修改点击的checkbox状态，同时赋值
                    if (state == "checked") {
                        check.attr('checked', true);
                        check.val("1");
                        //如果点的的checkbox的className包含“incapabilityHouse”，
                        // 清空className为labourNumber、labourAdress的数据
                        // if(className.indexOf("incapabilityHouse")!= -1){
                        //     check.parents('tr').find(".labourNumber").val("");
                        //     check.parents('tr').find(".labourAdress").val("");
                        // }
                    } else {
                        check.attr('checked', false);
                        check.val("");
                    }
                     isEdit(check);
                });


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

                $('.btnEx').click(function () {
                    top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
                        if (v == "ok") {
                            window.location.href = "${ctx}/county/record/cuHouseIncapabilityOrWorkout/export?type=${cuTable.type}&cuMainId=${cuTable.cuMainId}&department.id=${cuTable.department.id}";
                        }
                    });
                });

                $(function () {
                    $(".content-nav #labour2").attr("class", "active");
                });
            }
        )
    </script>
</head>
<body>
<div class="main">
    <input type="hidden" id="main_year" value="${cuMain['year']}">
    <input type="hidden" id="main_id" value="${cuMain['id']}">
</div>
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
                   action="${ctx}/county/record/cuHouseIncapabilityOrWorkout/save" method="post"
                   class="form-horizontal">
            <sys:message content="${message}"/>
            <input type="hidden" name="id" value="${cuTable.id}"/>
            <input type="hidden" name="cuMainId" value="${cuTable.cuMainId}"/>
            <input type="hidden" name="year" value="${cuTable.year}"/>
            <input type="hidden" name="type" value="${cuTable.type}"/>
            <h1 id="h1" style="text-align: center">
                平桂区${cuTable.department.name}
                (乡、镇)无劳动能力或主要劳动力<br/>长期外出务工贫困户情况表
            </h1>
            <br/><br/>
            <p style="margin-bottom: 5px!important;">
                <span id="span-1" class="department" style="float: left">
                    <input type="hidden" readonly="true" class="departmentId" name="department.id"
                           value="${cuTable.department.id}"/>
             填报单位：<input class="underline departmentName required" readonly="true" name="department.name"
                         value="${cuTable.department.name}"
                         style="width: 80px" maxlength="20"/>乡镇人民政府（盖章）
                </span>
                <span style="float: right">填报时间：<input name="time" id="time" type="text" maxlength="20"
                                                       class="input-medium Wdate required"
                                                       value="<fmt:formatDate value="${cuTable.time}" pattern="yyyy-MM-dd"/>"
                                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                                       style="width: 120px;background-color: #FFFFFF;border:1px solid #ccc;"/>
        </span>
            </p>
            <br/>
            <div>
                <table>
                    <thead>
                    <tr>
                        <td rowspan="3">序号</td>
                        <td rowspan="3">村屯</td>
                        <td rowspan="2" colspan="2">无劳动能力或主要劳动力长期外出务工的户</td>
                        <td colspan="4">其中</td>
                        <td rowspan="3">备注</td>
                        <td style="text-align: center;cursor: pointer;width: 60px;" class="add-tr-btn" rowspan="3">
                            添加<span
                                style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
                    </tr>
                    <tr>
                        <td colspan="1">无劳动能力贫困户</td>
                        <td colspan="3">主要劳动力长期外出务工贫困户</td>
                    </tr>
                    <tr>
                        <td>户主</td>
                        <td>家庭人数</td>
                        <td>属于此类型的打勾</td>
                        <td>属于此类型的打勾</td>
                        <td>务工人数</td>
                        <td>务工地</td>
                    </tr>
                    </thead>
                    <tbody id="accpitem">
                    <c:if test="${!empty cuTable.cuHouseIncapabilityOrWorkouts}">
                        <c:forEach items="${cuTable.cuHouseIncapabilityOrWorkouts}" var="house" varStatus="status">
                            <c:set var="indexN" value="${status.index+1}" scope="page"/>
                            <input type="hidden" class="id" name="cuHouseIncapabilityOrWorkouts[${status.index}].id"
                                   value="${house.id}"/>
                            <tr class="tr-1">
                                <td class="bg-white">${indexN}</td>
                                <td class="bg-white required tun">
                                    <input type="hidden" class="tunId"
                                           name="cuHouseIncapabilityOrWorkouts[${status.index}].tun.id"
                                           value="${house.tun.id}"/>
                                    <input class="td-input tunName required"
                                           name="cuHouseIncapabilityOrWorkouts[${status.index}].tun.name"
                                           readonly="true" value="${house.tun.name}"/>
                                </td>
                                <td class="bg-white">
                                    <input class="incapabilityOrWorkoutName td-input realName required"
                                           name="cuHouseIncapabilityOrWorkouts[${status.index}].incapabilityOrWorkoutName"
                                           value="${house.incapabilityOrWorkoutName}" maxlength="30"/>
                                </td>
                                <td class="bg-white">
                                    <input class="incapabilityOrWorkoutNumber td-input int required"
                                           name="cuHouseIncapabilityOrWorkouts[${status.index}].incapabilityOrWorkoutNumber"
                                           value="${house.incapabilityOrWorkoutNumber}" maxlength="3"/>
                                </td>
                                <td class="bg-white">
                                    <input type="checkbox" class="incapabilityHouse"
                                           name="cuHouseIncapabilityOrWorkouts[${status.index}].incapabilityHouse"
                                           value="${house.incapabilityHouse}"/>
                                </td>
                                <td class="bg-white">
                                    <input type="checkbox" class="workoutHouse"
                                           name="cuHouseIncapabilityOrWorkouts[${status.index}].workoutHouse"
                                           value="${house.workoutHouse}"/>
                                </td>
                                <td class="bg-white">
                                    <input class="labourNumber td-input int isEdit"
                                           name="cuHouseIncapabilityOrWorkouts[${status.index}].labourNumber"
                                           value="${house.labourNumber}" maxlength="3"/>
                                </td>
                                <td class="bg-white">
                                    <input class="labourAdress td-input isEdit"
                                           name="cuHouseIncapabilityOrWorkouts[${status.index}].labourAdress"
                                           value="${house.labourAdress}" maxlength="500"/>
                                </td>
                                <td class="bg-white">
                                    <input class="remarks td-input"
                                           name="cuHouseIncapabilityOrWorkouts[${status.index}].remarks"
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
                <span style="float: left;">
                 审核人：<input class="underline realName" name="verifier" value="${cuTable.verifier}" style="width: 100px"
                            maxlength="20"/>&nbsp;&nbsp;&nbsp;
                 填表人：<input class="underline realName required" name="reportingName" value="${cuTable.reportingName}"
                            style="width: 100px" maxlength="20"/>&nbsp;&nbsp;&nbsp;
                 联系电话：<input class="underline phone required" name="phone" value="${cuTable.phone}" style="width: 100px"
                             maxlength="11"/>
                </span>
            </div>

            <div class="form-actions actions">
                <div class="submitStyle">
                    <shiro:hasPermission name="record:cuHouseIncapabilityOrWorkout:edit">
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
                        <input id="btnExport" class="btn btn-primary btnEx" type="button" value="导 出"/>&nbsp;
                    </shiro:hasPermission>
                    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
                </div>
            </div>
        </form:form>
    </div>
</div>
<script>

    var choose;

    function chooseMember(area, type) {
        if (type == 1) {
            window.location.href = '${ctx}/county/record/cuHouseIncapabilityOrWorkout/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=4&department.id=' + area.id + '&department.name=' + area.name;
        } else if (type == 66) {
            choose.find(".tunId").val(area.id);
            choose.find(".tunName").val(area.name);
        }
    }

    $(function () {
        function call(parentId, type) {
            var iWidth = 800;
            var iHeight = 400;
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
            var win = window.open("${ctx}/record/cuTable/areaChoose?parentId=" + parentId + "&type=" + type, "选择地区", "width=" + iWidth +
                ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
                ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
                "status=no,alwaysRaised=yes,depended=yes");
        };
        /*type(1：镇级)*/
        $("#inputForm").delegate(".department", 'click', function () {
            choose = $(this);
            call("2", "1");
        });
        /*type(66:根据镇id查屯)*/
        $("#accpitem").delegate(".tun", 'click', function () {
            choose = $(this);
            var parentId = $("#span-1").find(".departmentId").val();
            if (parentId == "") {
                alert("请先选择镇！");
                return false;
            }
            call(parentId, "66");
        });
    });
</script>

<script>

    var index = 0;
    var renum = 0;

    /*添加删除一行tr方法*/
    function reflowIndex() {
        var trs = $('tbody tr');
        var trLen = trs.length;
        for (var i = 0; i <= trLen; i++) {
            var tr = trs[i];
            $(tr).find("td:eq(0)").text(i + 1);
        }
    };

    $(function () {
        $(".add-tr-btn").click(function () {
            index = $("table tbody").find("tr").length;
            var num = index + renum;
            var tr = '<tr>' +
                '<input type="hidden" class="id"  name="cuHouseIncapabilityOrWorkouts[' + num + '].id"/>' +
                '<td class="bg-white">' +
                '</td>' +
                '<td class="bg-white tun">' +
                '<input type="hidden" class="tunId" name="cuHouseIncapabilityOrWorkouts[' + num + '].tun.id"/>' +
                '<input class="td-input tunName required" readonly="true" name="cuHouseIncapabilityOrWorkouts[' + num + '].tun.name"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input incapabilityOrWorkoutName realName required" maxlength="30" name="cuHouseIncapabilityOrWorkouts[' + num + '].incapabilityOrWorkoutName"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input int incapabilityOrWorkoutNumber required" maxlength="3" name="cuHouseIncapabilityOrWorkouts[' + num + '].incapabilityOrWorkoutNumber"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input type="checkbox" class="incapabilityHouse" name="cuHouseIncapabilityOrWorkouts[' + num + '].incapabilityHouse" value="1"/> ' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input type="checkbox" name="cuHouseIncapabilityOrWorkouts[' + num + '].workoutHouse" value="1"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input labourNumber int isEdit" maxlength="8" name="cuHouseIncapabilityOrWorkouts[' + num + '].labourNumber"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input labourAdress isEdit" maxlength="500" name="cuHouseIncapabilityOrWorkouts[' + num + '].labourAdress"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input remarks" name="cuHouseIncapabilityOrWorkouts[' + num + '].remarks" maxlength="500"/>' +
                '</td>' +
                '<td class="bg-white" style="text-align: center">' +
                '<span class="del-thistd-btn">删除</span>' +
                '</td>' +
                '</tr>';
            $("table tbody").append(tr);
            reflowIndex();
        });

        $("#tab-1").delegate(".del-thistd-btn", "click", function () {
            $(this).parents("tr").remove();
            renum++;
            reflowIndex();
        });
    });
</script>
</body>
</html>
