<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>扶贫楼管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
    <script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
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


        //弹出项目选择窗口
        $(function () {
            $("#inputForm").delegate(".projectTitle", 'click', function () {
                var iWidth = 900;
                var iHeight = 500;
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                var win = window.open("${ctx}/cms/cmsProject/proChoose", "选择项目", "width=" + iWidth +
                ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
                ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
                "status=no,alwaysRaised=yes,depended=yes");
            });
        });

        function chooseProject(project) {
//		console.debug(member);
            $(".projectId").val(project.id);
            $(".projectTitle").val(project.title);
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/bf/bfPovertyAlleviationBuilding/">扶贫楼列表</a></li>
    <li class="active"><a
            href="${ctx}/bf/bfPovertyAlleviationBuilding/form?id=${bfPovertyAlleviationBuilding.id}">扶贫楼<shiro:hasPermission
            name="bf:bfPovertyAlleviationBuilding:edit">${not empty bfPovertyAlleviationBuilding.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="bf:bfPovertyAlleviationBuilding:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>

<div class="content tabs f-clear">
    <div id="tab-15" class="content-detail">
        <form:form id="inputForm" modelAttribute="bfPovertyAlleviationBuilding"
                   action="${ctx}/bf/bfPovertyAlleviationBuilding/save" method="post" class="form-horizontal">
            <form:hidden path="id"/>
            <sys:message content="${message}"/>
            <table>
                <tbody id="accpitem">
                <tr>
                    <td>
                        <span>楼栋编码</span>
                    </td>
                    <td class="bg-white">
                        <form:input path="buildingCode" htmlEscape="false" maxlength="64" class="input-xlarge "/>
                    </td>
                    <td>
                        <span>楼栋名称</span>
                    </td>
                    <td class="bg-white">
                        <form:input path="buildingName" htmlEscape="false" maxlength="64" class="input-xlarge "/>
                    </td>
                </tr>
                <tr>
                    <td>
                        小区名称
                    </td>
                    <td class="bg-white">
                            <form:input path="communityName" htmlEscape="false" maxlength="64" cssClass="input-xlarge"/>
                    </td>
                    <td>
                        用途
                    </td>
                    <td class="bg-white">
                        <form:select path="useFor" class="input-medium">
                            <form:option value="" label="     "/>
                            <form:options items="${fns:getDictList('building_use_for')}"
                                          itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <td>
                        竣工时间
                    </td>
                    <td class="bg-white">
                            <input name="finishDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
                            value="<fmt:formatDate value="${bfPovertyAlleviationBuilding.finishDate}" pattern="yyyy-MM-dd"/>"
                            onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="background-color: #FFF;"/>
                    </td>
                    <td>
                        建筑结构
                    </td>
                    <td class="bg-white">
                        <form:select path="buildingStructure" class="input-medium">
                            <form:option value="" label="    "/>
                            <form:options items="${fns:getDictList('building_structure')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                        <%--<form:input path="buildingStructure" htmlEscape="false" maxlength="2" class="input-xlarge "/>--%>
                    </td>
                </tr>
                <tr>
                    <td>
                        占地面积
                    </td>
                    <td class="bg-white">
                        <form:input path="areaCovered" htmlEscape="false" maxlength="64" class="input-xlarge "/>
                    </td>
                    <td>
                        高度
                    </td>
                    <td class="bg-white">
                        <%--<form:input path="buildingHeight" htmlEscape="false" maxlength="64" class="input-xlarge "/>--%>
                            <form:select path="buildingHeight" class="input-xlarge ">
                                <form:option value="" label="     "/>
                                <form:options items="${fns:getDictList('room_floor')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                            </form:select>
                    </td>
                </tr>
                <tr>
                    <td>
                        地址
                    </td>
                    <td class="bg-white" colspan="3">
                        <form:input path="address" htmlEscape="false" maxlength="128" class="input-xlarge "/>
                    </td>
                </tr>
                <tr>
                    <td>
                        其他说明
                    </td>
                    <td class="bg-white" colspan="3">
                        <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="500" style="width:100%;me"/>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="form-actions">
            <shiro:hasPermission name="bf:bfPovertyAlleviationBuilding:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
            <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>