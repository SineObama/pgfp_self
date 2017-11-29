<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>贫困户密码管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
    <script type="text/javascript">
        <%--console.debug(${fns:toJson(lists)});--%>
        <%--console.debug(${lists});--%>
        $(document).ready(function () {

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
    <li class="active"><a href="${ctx}/sys/poorerUser/">贫困户密码列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="poorerUser" action="${ctx}/sys/poorerUser/" method="post"
           class="breadcrumb form-search">
    <ul class="ul-form">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <li>
            <label class="control-label">户主姓名:</label>
            <form:input path="regcard.houseHolderName"/>
        </li>
        <li>
            <label class="control-label">户主身份证:</label>
            <form:input path="idNumber"/>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>户主姓名</th>
        <th>联系电话</th>
        <th>密码</th>
        <th>家庭住址</th>
        <th>是否脱贫</th>
        <shiro:hasPermission name="poorerUser:edit">
            <th>操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="poorerUser" varStatus="status">
        <tr>
            <td>${poorerUser.regcard.houseHolderName}</td>
            <td>${poorerUser.regcard.mobile}</td>
            <td>${poorerUser.pwd}</td>
            <td>${poorerUser.regcard.address}</td>
            <td>
                <c:if test="${poorerUser.regcard.povertyFlag eq '0'}">否</c:if>
                <c:if test="${poorerUser.regcard.povertyFlag eq '1'}">是</c:if>
            </td>
            <shiro:hasPermission name="poorerUser:edit">
                <td>
                    <a href="${ctx}/sys/poorerUser/delete?id=${basePoorerRegCard.id}&years=${basePoorerRegCard.years}"
                       onclick="return confirmx('确认要该贫困户密码吗？', this.href)">删除</a>&nbsp;&nbsp;
                </td>
            </shiro:hasPermission>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
<%-- 模态框（Modal） --%>
<div class="modal fade"  style="display: none;width:400px;" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="myModalLabel">添加户年度信息</h4>
            </div>
            <form:form action="${ctx}/record/basePoorerRegCard/saveNewYear" id="editSave" modelAttribute="basePoorerRegCard" method="post" >
                <input type="hidden" id="oldId" name="id"/>
                <div style="margin-top: 13px;text-align: center;">
                    新增年度：<input name="years" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
                       value="<fmt:formatDate value="${basePoorerRegCard.yearDate}" pattern="yyyy"/>"
                       onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit"  class="btn btn-primary">增加</button>
                </div>
            </form:form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<script>
    $(".addNewRecord").click(function(){
        var id = $(this).parents("tr").find(".id").val();
        $("#oldId").val(id);
    });
</script>
<style>
    li label{
        margin-left: 0px !important;
    }
</style>
</body>
</html>