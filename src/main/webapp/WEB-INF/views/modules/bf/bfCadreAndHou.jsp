<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
  <title>干部表管理</title>
  <meta name="decorator" content="default"/>
  <style>
    .addBfHou{
      box-shadow: 0 2px 3px #ccc;
      padding: 4px 12px;
      background: #6196bb;
      color: #fff;
      border-radius: 3px;
      font-size: 14px;
      display: inline-block;
      height: 20px;
    }
    .addBfHou:hover{
      color: #fff;
    }
    .ul-form li{
      list-style: none;
    }
  </style>
  <script type="text/javascript">
    $(document).ready(function() {

    });
    function page(n,s){
      $("#pageNo").val(n);
      $("#pageSize").val(s);
      $("#searchForm").submit();
      return false;
    }
  </script>
</head>
<body>
<ul class="nav nav-tabs">
  <li><a href="${ctx}/record/workForceCadre/">帮扶干部管理</a></li>
  <li class="active"><a href="${ctx}/record/basePoorerRegCard/hou?user=${user.id}">帮扶户列表</a></li>
</ul>
  <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
  <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
  <ul class="ul-form">
    <li class="btns"> <a class="addBfHou" href="${ctx}/record/basePoorerRegCard/bind?user=${user}"><span>+</span>添加帮扶对象</a></li>
  </ul>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
  <thead>
  <tr>
    <th>户主姓名</th>
    <th>家庭住址</th>
    <th>联系方式</th>
    <th>户口本号</th>
    <th>是否脱贫</th>
    <th>贫困户属性</th>
    <shiro:hasPermission name="record:countryBasic:edit"><th>操作</th></shiro:hasPermission>
  </tr>
  </thead>
  <tbody>
  <c:forEach items="${bps}" var="bp">
    <tr>
      <td><%--<a href="${ctx}/bf/bfCadreInfo/form?id=${bfCadreInfo.id}">--%>
          ${bp.houseHolderName}
      <%--</a>--%></td>
      <td>
          ${bp.address}
      </td>
      <td>
          ${bp.mobile}
      </td>
      <td>
          ${bp.residenceBookletNumber}
      </td>
      <td>
		<c:choose>
			<c:when test="${bp.povertyFlag==1}">是</c:when>
			<c:when test="${bp.povertyFlag==0}">否</c:when>
		</c:choose>
      </td>
      <td>
		<c:choose>
			<c:when test="${bp.poorerType == 01}">一般贫困户</c:when>
			<c:when test="${bp.poorerType == 02}">低保贫困户</c:when>
			<c:when test="${bp.poorerType == 03}">五保贫困户</c:when>
		</c:choose>
      </td>
      <shiro:hasPermission name="record:countryBasic:edit"><td>
        <a href="${ctx}/bf/bfRecordIncomeDetails/form?regCardId=${bp.id}">收入登记</a>
        <%--<a href="${ctx}/bf/bfRecordIncome/list?regCardId=${bp.id}">查看详情</a>--%>
        <a href="${ctx}/bf/bfCadreInfo/delete?id=${bfCadreInfo.id}" onclick="return confirmx('确认要删除该干部表吗？', this.href)">删除</a>
      </td></shiro:hasPermission>
    </tr>
  </c:forEach>
  </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>