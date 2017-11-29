<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>贫困户建档立卡表管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

        });

        function page(n, s ,v) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#funcParam").val(v);
            $("#searchForm").submit();
            return false;
        }
    </script>

</head>
<body>

<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/urgestudent/urgeDropOutsRecords/houseList">贫困户列表</a></li>
    <%--<shiro:hasPermission name="record:basePoorerRegCard:edit">--%>
        <%--<li><a href="${ctx}/record/basePoorerRegCard/form">贫困户建档立卡表添加</a></li>--%>
    <%--</shiro:hasPermission>--%>
</ul>
<form:form id="searchForm" modelAttribute="card" action="${ctx}/filemanagement/fileManagement/houseList" method="post"
           class="breadcrumb form-search">
    <ul class="ul-form">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <input id="funcParam" name="funcParam" type="hidden" value="${page.funcParam}"/>
        <input id="cardId" name="cardId" type="hidden" value=""/>
        <li>
            <label class="control-label">村名:</label>
            <sys:treeselect id="country" name="country.id" value="${basePoorerRegCard.country.id}"
                            labelName="country.name" labelValue="${basePoorerRegCard.country.name}"
                            title="村（屯）" url="/sys/area/treeData" extId="${country.id}" cssClass=""
                            allowClear="true"/>
        </li>
        <li>
            <label class="control-label">户主姓名:</label>
            <form:input path="houseHolderName"/>
        </li>

        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<c:if test="${yearList != null}">
    <ul class="nav nav-tabs nav-year">
        <c:forEach items="${yearList}" var="year">
            <c:if test="${card.years == year}">
                <li class="active"><a href="${ctx}/urgestudent/urgeDropOutsRecords/houseList?years=${year}">${year}</a></li>
            </c:if>
            <c:if test="${card.years != year}">
                <li><a href="${ctx}/urgestudent/urgeDropOutsRecords/houseList?years=${year}">${year}</a></li>
            </c:if>
        </c:forEach>
    </ul>
</c:if>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>家庭住址</th>
        <th>户主姓名</th>
        <th>归属年度</th>
        <shiro:hasPermission name="filemanagement:fileManagement:view">
            <th>操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="card" varStatus="status">
        <tr>
            <td>
                    <%--<input type="hidden" name="id" class="id" value=""/>--%>
                <input type="hidden" value="${card.id}" class="regCardId" id="${card.id}"/>
                    ${card.address}
                <input type="hidden" class="houseId" value="${card.houseId}"/>
            </td>
            <td>
                    ${card.houseHolderName}
            </td>
            <td>
                ${card.years}
            </td>
            <td>
                &nbsp;&nbsp;<a href="${ctx}/urgestudent/urgeDropOutsRecords/form?id=${card.id}">查看劝返记录</a>&nbsp;&nbsp;
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
<style>
    li label {
        margin-left: 0px !important;
    }
</style>
</body>
</html>