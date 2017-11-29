<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>驻村工作队情况_干部表管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
    <script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
    <script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
    <script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
    <%--<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>--%>
    <link rel="stylesheet" href="${ctxStatic}/pgfp/css/cadre.css"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnExport").click(function () {
                top.$.jBox.confirm("确认要导出用户数据吗？", "系统提示", function (v, h, f) {
                    if (v == "ok") {
                        $("#searchForm").attr("action", "${ctx}/record/workForceCadre/export");
                        $("#searchForm").submit();
                    }
                }, {buttonsFocus: 1});
                top.$('.jbox-body .jbox-icon').css('top', '55px');
            });
            $("#btnImport").click(function () {
                $.jBox($("#importBox").html(), {
                    title: "导入--数据", buttons: {"关闭": true},
                    bottomText: "导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"
                });
            });
        });

        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/record/workForceCadre/">帮扶干部管理</a></li>
    <shiro:hasPermission name="record:workForceCadre:add">
        <li><a href="" class="addCadre" data-toggle="modal" data-target="#myModal" id="addCadre">帮扶干部添加</a></li>
    </shiro:hasPermission>
</ul>
<div id="importBox" class="hide">
	<form id="importForm" action="${ctx}/record/workForceCadre/import" method="post" enctype="multipart/form-data"
	      class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
		<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
		<input id="years" name="years" type="text" readonly="readonly" maxlength="20"
		       class="input-medium Wdate required"
		       onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"
		       style="width: 120px;background-color: #FFFFFF;"/>
		<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
	</form>
</div>
<form:form id="searchForm" modelAttribute="workForceCadre" action="${ctx}/record/workForceCadre/" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>姓名：</label>
            <form:input path="b921Name" style="border-width:1px" htmlEscape="false" maxlength="200"
                        class="input-medium"/>
        </li>
        <li class="btns">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
            <input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
            <input id="btnImport" class="btn btn-primary" type="button" value="导入"/>
        </li>

        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>姓名</th>
        <th>单位</th>
        <th>职务</th>
        <th>联系电话</th>
        <th>开始时间</th>
        <th>结束时间</th>
        <shiro:hasPermission name="record:countryBasic:edit">
            <th>操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="workForceCadre">
        <tr>
            <td>
                    ${workForceCadre.b921Name}
            </td>
            <td>
                    ${workForceCadre.office.name}
            </td>
            <td>
                    ${workForceCadre.b923Position}
            </td>
            <td>
                    ${workForceCadre.b925Phone}
            </td>
            <td>
                <fmt:formatDate value="${workForceCadre.beginResidentDate}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
                <fmt:formatDate value="${workForceCadre.endResidentDate}" pattern="yyyy-MM-dd"/>
            </td>
            <td>
                <shiro:hasPermission name="record:workForceCadre:edit">
                    <%--<a href="${ctx}/record/basePoorerRegCard/edit?id=${workForceCadre.id}" class="bj" id="${workForceCare.id}">编辑</a>--%>
                    <a class="bj" id="${workForceCadre.id}" data-toggle="modal" data-target="#myModal">编辑</a>&nbsp;&nbsp;
                    <a href="${ctx}/record/workForceCadre/delete?id=${workForceCadre.id}"
                       onclick="return confirmx('确认要删除该干部吗？', this.href)">删除</a>&nbsp;&nbsp;
                </shiro:hasPermission>
                <shiro:hasPermission name="record:countryBasic:edit">
                    <c:if test="${workForceCadre.user != null && workForceCadre.user.id ne ''}">
                        <a href="${ctx}/record/basePoorerRegCard/hou?user=${workForceCadre.user}"
                           >查看帮扶详情</a>&nbsp;&nbsp;
                    </c:if>
                        <c:if test="${workForceCadre.user == null || workForceCadre.user.id == null || workForceCadre.user.id eq ''}">
                        <a href="${ctx}/sys/user/form?id=${workForceCadre.user.id}&workForceCadre.id=${workForceCadre.id}">关联账号</a>
                    </c:if>
                </shiro:hasPermission>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
<script>
    function checkSrc(user) {
        if(user != null){
            return true;
        }
        alert("请先关联帐号");
        return false;
//        var s = v.href;
//        //alert(s.substring(63));
//        var ss = s.substring(63);
//        if (ss == null || ss == "") {
//            alert("请先关联账号");
//            return false;
//        }
//
//        return true;
    }


    $(document).ready(function () {
        $(".bj").click(function () {
            var id = $(this).attr("id");
            $.ajax({
                type: "POST",
                url: "${ctx}/record/workForceCadre/edit?id=" + id,
                date: "JSON",
                success: function (cadre) {
                    $("#id").val(cadre.id);
                    $("#name").children("#b921Name").val(cadre.b921Name);//姓名
                    $("#b925Phone").val(cadre.b925Phone);//电话
                    $("#idNumber").val(cadre.idNumber);//证件号码
                    radioChecked("sex", cadre.sex);//性别
                    radioChecked("isLeader", cadre.isLeader);//是否队长
                    radioChecked("isFirstSecretary", cadre.isFirstSecretary);//是否第一书记
                    radioChecked("cadreType", cadre.cadreType);//是否第一书记
                    $("#b923Position").val(cadre.b923Position);//职务
                    $("#political").val(cadre.political);//政治面貌
                    $("#officeId").val(cadre.office.id);//单位
                    $("#officeName").val(cadre.office.name);
                    var beginDate = new Date(cadre.beginResidentDate);//
                    $("#beginResidentDate").val(dateFormat(beginDate));//开始扶贫时间
//						$("#beginResidentDate").attr("date",beginDate);
                    $("#endResidentDate").val(dateFormat(new Date(cadre.endResidentDate)));//结束扶贫时间
//						$("#endResidentDate").attr("date",new Date(cadre.endResidentDate));
                    $("select").select2();
                }
            });
        });
    });
    $("#addCadre").click(function () {
        $("#id").val(null);
        $("#name").children("#b921Name").val(null);//姓名
        $("#b925Phone").val(null);//电话
        $("#idNumber").val(null);//证件号码
        $("#b923Position").val(null);//职务
        $("#political").val(null);//政治面貌
        $("#officeId").val(null);//单位
        $("#officeName").val(null);
        $("#beginResidentDate").val(dateFormat(new Date));//开始扶贫时间
        $("#endResidentDate").val(dateFormat(new Date()));//结束扶贫时间
        $("input[type=radio]").each(function () {
            $(this).attr("checked", false);
        });
        $("select").select2();
    });
    function dateFormat(date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        m = m < 10 ? '0' + m : m;
        var d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        return y + '-' + m + '-' + d;
    }
    ;
    //根据传入的单选name属性和需要set的值
    function radioChecked(name, value) {
        var type = "input[name='" + name + "']";
        var radios = $(type);
        for (i = 0; i < radios.length; i++) {
            if (radios[i].value == value) {
                radios.eq(i).attr("checked", true);
            }
        }
    }

</script>

<!-- 模态框（Modal） -->
<div class="modal fade" style="display: none;" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="myModalLabel">添加单位干部信息</h4>
            </div>
            <form:form action="${ctx}/record/workForceCadre/save" id="editSave" modelAttribute="cadre" method="post">
                <div class="modal-body">
                    <table class="table table-bordered">
                        <tbody>
                        <tr>
                            <td width="90">姓名</td>
                            <td class="" id="name">
                                <form:hidden path="id"/>
                                <form:input path="b921Name" cssClass="inp-right required" cssStyle="width:150px;"/>
                            </td>
                            <td>手机号码</td>
                            <td><form:input path="b925Phone" cssStyle="width:150px;"
                                            class="phoneChange inp-right required"/></td>

                        </tr>
                        <tr>
                            <td>证件号码</td>
                            <td><form:input path="idNumber" class="required"/></td>
                            <td>性别</td>
                            <td>
                                <form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemValue="value"
                                                   itemLabel="label"/>
                            </td>
                        </tr>
                        <tr>
                            <td width="90">单位姓名</td>
                            <td>
                                <sys:treeselect id="office" name="office.id" value="${cadre.office.id}"
                                                labelName="office.name" labelValue="${cadre.office.name}"
                                                title="单位" url="/sys/office/treeData?type=2" cssClass="required"
                                                cssStyle="width:150px;"/>

                            </td>
                            <td>政治面貌</td>
                            <td>
                                <form:select path="political" items="${fns:getDictList('political_outlook')}"
                                             itemValue="value" itemLabel="label"></form:select>
                            </td>


                        </tr>
                        <tr>

                            <td>职务</td>
                            <td>
                                <form:input path="b923Position" cssStyle="width:150px;"/>
                            </td>
                            <td>
                                干部类型
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${isSupervise}">
                                        <form:radiobutton path="cadreType" value="1" label="普通干部"/>
                                        <form:radiobutton path="cadreType" value="2" label="督办干部"/>
                                    </c:when>
                                    <c:otherwise>
                                        <form:radiobutton path="cadreType" value="1" label="普通干部" disabled="true"/>
                                        <form:radiobutton path="cadreType" value="2" label="督办干部" disabled="true"/>
                                    </c:otherwise>
                                </c:choose>

                            </td>
                        </tr>
                        <tr>
                            <td>是否队长</td>
                            <td><form:radiobuttons path="isLeader" items="${fns:getDictList('yes_no')}"
                                                   itemLabel="label" itemValue="value"></form:radiobuttons></td>
                            <td>是否第一书记</td>
                            <td><form:radiobuttons path="isFirstSecretary" items="${fns:getDictList('yes_no')}"
                                                   itemLabel="label" itemValue="value"></form:radiobuttons></td>
                        </tr>
                        <tr>
                            <td>开始时间</td>
                            <td>
                                <input id="beginResidentDate" name="beginResidentDate" type="text" readonly="readonly"
                                       maxlength="20" class="input-medium Wdate required"
                                       value="<fmt:formatDate value="${radre.beginResidentDate}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                       style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
                            </td>
                            <td>结束时间</td>
                            <td>
                                <input id="endResidentDate" name="endResidentDate" type="text" readonly="readonly"
                                       maxlength="20" class="input-medium Wdate required"
                                       value="<fmt:formatDate value="${radre.endResidentDate}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                       style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>

                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">提交更改</button>
                </div>
            </form:form>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
</body>
</html>