<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>网上办事预约管理</title>
    <meta name="decorator" content="default"/>
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
<ul class="nav nav-tabs">
    <li><a href="${ctx}/bs/bsAppionment/">网上办事预约列表</a></li>
    <li class="active"><a href="${ctx}/bs/bsAppionment/form?id=${bsAppionment.id}">网上办事预约<shiro:hasPermission
            name="bs:bsAppionment:edit">${not empty bsAppionment.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="bs:bsAppionment:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="bsAppionment" action="${ctx}/bs/bsAppionment/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>

    <div class="control-group">
        <label class="control-label">申报事项：</label>

        <div class="controls">
            <a href="${ctx}/bs/bsBasicinfo/form?id=${basicinfo.id}" target="_blank">
                ${basicinfo.title}
            </a>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">办事部门：</label>

        <div class="controls">
            ${basicinfo.office.name}
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">申报时间：</label>

        <div class="controls">
            <fmt:formatDate value="${bsAppionment.appointmentTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">申报人信息：</label>

        <div class="controls">
            <table class="table table-bordered">
                <tr>
                    <td>
                        <label>查询编码：</label>
                    </td>
                    <td>
                        ${bsAppionment.lookCode}
                    </td>
                    <td>
                        <label>查询密码：</label>
                    </td>
                    <td>
                        ${bsAppionment.lookPwd}
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>申报人：</label>
                    </td>
                    <td>
                        ${bsAppionment.applyName}
                    </td>
                    <td>
                        <label>身份证：</label>
                    </td>
                    <td>
                        ${bsAppionment.idCard}
                    </td>
                </tr>
                <tr>
                    <%--<td>--%>
                    <%--<label>法定代表人：</label>--%>
                    <%--</td>--%>
                    <%--<td>--%>
                    <%--${bsAppionment.legalMan}--%>
                    <%--</td>--%>
                    <td>
                        <label>联系人姓名：</label>
                    </td>
                    <td>
                        ${bsAppionment.linkName}
                    </td>
                    <td>
                        <label>联系人身份证：</label>
                    </td>
                    <td>
                        ${bsAppionment.linkIdCard}
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>联系人手机：</label>
                    </td>
                    <td>
                        ${bsAppionment.linkPhone}
                    </td>
                    <td>
                        <label>联系人电话：</label>
                    </td>
                    <td>
                        ${bsAppionment.linkTel}
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>邮编：</label>

                    </td>
                    <td>
                        ${bsAppionment.postCode}
                    </td>
                    <td>
                        <label>通讯地址：</label>
                    </td>
                    <td colspan="3">
                        ${bsAppionment.address}
                    </td>
                </tr>
                <%--<tr>--%>
                <%--</tr>--%>
            </table>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">提交材料:</label>

        <div class="controls">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th width="20"></th>
                    <th>材料名称</th>
                    <th>材料形式</th>
                    <th>详细要求</th>
                    <th>必要性描述</th>
                    <th>提交材料</th>
                    <th>材料提交方式</th>
                </tr>
                </thead>
                <tbody id="stuffitem">
                <c:if test="${!empty basicinfo.stuffList}">
                    <c:forEach items="${basicinfo.stuffList}" var="stuff" varStatus="status">
                        <tr>
                            <td>
                                ${basicinfo.stuffList[status.index].weight}
                            </td>
                            <td>
                                ${basicinfo.stuffList[status.index].name}
                            </td>
                            <td>
                                ${basicinfo.stuffList[status.index].type}
                            </td>
                            <td>
                                ${basicinfo.stuffList[status.index].content}
                            </td>
                            <td>
                                ${basicinfo.stuffList[status.index].necessityDesc}
                            </td>
                            <td>
                                <c:if test="${!empty bsAppionment.files}">
                                    <c:forEach items="${bsAppionment.files}" var="afile">
                                        <c:if test="${afile.stuffId eq basicinfo.stuffList[status.index].id}">
                                            <div class="response_elements">
                                                <a href="${smartPg}${afile.filePath}/${afile.pathName}"
                                                   title="${afile.name}" target="_blank">
                                                    ${afile.name}
                                                </a>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${!empty stuff.submitTypeArr and fn:indexOf(fn:join(stuff.submitTypeArr,','),'0')>-1}">
                                    窗口提交&nbsp;&nbsp;&nbsp;&nbsp;
                                </c:if>
                                <c:if test="${!empty stuff.submitTypeArr and fn:indexOf(fn:join(stuff.submitTypeArr,','),'1')>-1}">
                                    线上提交
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>b
                </tbody>
            </table>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">处理：</label>

        <div class="controls">
            <form:radiobuttons path="status" items="${fns:getDictList('auditing_status')}" itemLabel="label"
                               itemValue="value" htmlEscape="false"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">审批信息：</label>

        <div class="controls">
            <form:textarea path="auditingOption" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
        </div>
    </div>

    <div class="form-actions">
        <shiro:hasPermission name="bs:bsAppionment:edit"><input id="btnSubmit" class="btn btn-primary" type="submit"
                                                                value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>