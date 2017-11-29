<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>移民后期跟踪记录</title>
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
    <li class="active"><a href="${ctx}/bf/ImmigrationTracking/">移民后期跟踪记录</a></li>
</ul>
<form:form id="searchForm" modelAttribute="tracking" action="${ctx}/bf/ImmigrationTracking/" method="post"
           class="breadcrumb form-search">
    <ul class="ul-form">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

        <li>
            <label class="control-label">户主姓名:</label>
            <input name="houseHolderName" value="${tracking.houseHolderName}"/>
        </li>

        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>小区名</th>
        <th>楼栋</th>
        <th>单元</th>
        <th>户主姓名</th>
        <th>建筑面积</th>
        <th>人均面积</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="track" varStatus="status">
        <tr>
            <td>${track.communityName}</td>
            <td>
                ${track.buildingCode}
            </td>
            <td>
                ${track.roomCode}
            </td>
            <td>
                ${track.houseHolderName}
            </td>
            <td>
                ${track.buildArea}
            </td>
            <td>
                ${track.perCapitaArea}
            </td>
            <td>
                <a href="${ctx}/bf/ImmigrationTracking/form?roomId=${track.roomId}">查看详细</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
<style>
    li label{
        margin-left: 0px !important;
    }
</style>
</body>
</html>