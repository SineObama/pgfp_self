<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>移民搬迁房管理</title>
	<meta name="decorator" content="default"/>
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
		<li><a href="${ctx}/bf/bfPovertyAlleviationBuilding/">移民搬迁楼列表</a></li>
		<li class="active">
			<a href="${ctx}/bf/bfPovertyAlleviationRoom/list?building.id=${bfPovertyAlleviationRoom.building.id}">移民搬迁房列表</a>
		</li>
		<shiro:hasPermission name="bf:bfPovertyAlleviationRoom:edit">
			<li><a href="${ctx}/bf/bfPovertyAlleviationRoom/form?building.id=${bfPovertyAlleviationRoom.building.id}">移民搬迁房添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bfPovertyAlleviationRoom" action="${ctx}/bf/bfPovertyAlleviationRoom/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<form:hidden path="building.id"/>
			<li><label>楼层：</label>
				<form:select path="floor" class="input-medium">
					<form:option value="" label="     "/>
					<form:options items="${fns:getDictList('room_floor')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>单元编号：</label>
				<form:input path="roomCode" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>是否入住：</label>
				<form:radiobuttons path="checkInFlag" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>楼层</th>
				<th>单元编号</th>
				<th>建筑面积</th>
				<th>套内面积</th>
				<th>总价款</th>
				<th>住户</th>
				<th>住户人口</th>
				<th>人均面积</th>
				<th>家庭人均负担</th>
				<th>签订合同日期</th>
				<%--<th>是否交钥匙</th>--%>
				<th>交房日期</th>
				<th>户主入住时间</th>
				<%--<th>是否按揭</th>--%>
				<th>自筹款</th>
				<th>按揭款</th>
				<th>房产证号</th>
				<shiro:hasPermission name="bf:bfPovertyAlleviationRoom:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfPovertyAlleviationRoom">
			<tr>
				<td>
					${fns:getDictLabel(bfPovertyAlleviationRoom.floor, 'room_floor', '')}
				</td>
				<td><a href="${ctx}/bf/bfPovertyAlleviationRoom/form?id=${bfPovertyAlleviationRoom.id}">
					${bfPovertyAlleviationRoom.roomCode}
				</a></td>
				<td>
					${bfPovertyAlleviationRoom.buildArea}
				</td>
				<td>${bfPovertyAlleviationRoom.comprisingArea}</td>
				<td>${bfPovertyAlleviationRoom.totalPrice}</td>
				<td>${bfPovertyAlleviationRoom.regCard.houseHolderName}</td>
				<td>${bfPovertyAlleviationRoom.memberCount}</td>
				<td>${bfPovertyAlleviationRoom.perCapitaArea}</td>
				<td>${bfPovertyAlleviationRoom.perCapitaPrice}</td>
				<td><fmt:formatDate value="${bfPovertyAlleviationRoom.signContratDate}" pattern="yyyy-MM-dd"/> </td>
				<%--<td>${'1'.equals(bfPovertyAlleviationRoom.isHandover)?'是':'否'}</td>--%>
				<td>
					<c:if test="${bfPovertyAlleviationRoom.isHandover =='1'}">
						<fmt:formatDate value="${bfPovertyAlleviationRoom.handoverDate}" pattern="yyyy-MM-dd"/>
					</c:if>
					<c:if test="${bfPovertyAlleviationRoom.isHandover !='1'}">
						未交钥匙
					</c:if>
				  </td>
				<td>
					<c:if test="${bfPovertyAlleviationRoom.checkInFlag != '1'}">
						未入住
					</c:if>
					<c:if test="${bfPovertyAlleviationRoom.checkInFlag == '1'}">
						<fmt:formatDate value="${bfPovertyAlleviationRoom.checkInDate}" pattern="yyyy-MM-dd"/>
					</c:if>
				</td>
				<%--<td>是否按揭</td>--%>
				<td>${bfPovertyAlleviationRoom.selfRaised}</td>
				<td>
					<c:if test="${bfPovertyAlleviationRoom.isMortgage == '1'}">
						${bfPovertyAlleviationRoom.mortgageRaised}
					</c:if>
					<c:if test="${bfPovertyAlleviationRoom.isMortgage != '1'}">
						非按揭
					</c:if>
				</td>
				<td>${bfPovertyAlleviationRoom.proOwnerCerNum}</td>
				<shiro:hasPermission name="bf:bfPovertyAlleviationRoom:edit"><td>
    				<a href="${ctx}/bf/bfPovertyAlleviationRoom/form?id=${bfPovertyAlleviationRoom.id}">修改</a>
					<a href="${ctx}/bf/bfPovertyAlleviationRoom/delete?id=${bfPovertyAlleviationRoom.id}" onclick="return confirmx('确认要删除该扶贫房吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>