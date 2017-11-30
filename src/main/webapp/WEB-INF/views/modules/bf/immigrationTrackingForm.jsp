<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>移民后期跟踪记录</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
	<!-- 引入 ECharts 文件 -->
	<script src="${ctxStatic}\echarts\echarts.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
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
	<li><a href="${ctx}/bf/ImmigrationTracking/">移民后期跟踪记录</a></li>
	<li class="active"><a href="${ctx}/bf/ImmigrationTracking/form?roomId=${tracking.roomId}">信息概览<shiro:hasPermission name="record:baseMemberTrainingStatus:edit">${not empty baseMemberTrainingStatus.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:baseMemberTrainingStatus:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<div class="header">
	<a href="" class="header-lt">移民后期跟踪</a>
	<a href="" class="header-rt">${tracking.houseHolderName}</a>
</div>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li class="active">信息概览</li>
		<li><a href="${ctx}/bf/ImmigrationTracking/training?roomId=${tracking.roomId}">移民后期受训情况</a></li>
		<li><a href="${ctx}/bf/ImmigrationTracking/work?roomId=${tracking.roomId}">移民后期就业情况</a></li>
	</ul>
	<div id="tab-1" class="content-detail">

		<sys:message content="${message}"/>
			<br/>
			<table>
				<tbody id="accpitem">
				<tr>
					<td class="titleTd">
						户主姓名
					</td>
					<td class="contentTd">
						${tracking.houseHolderName}
					</td>
					<td class="titleTd">
						小区楼栋单元
					</td>
					<td>
						${tracking.communityName}&nbsp;小区（社区）
							&nbsp;${tracking.buildingCode}&nbsp;楼栋&nbsp;
							${tracking.roomCode}&nbsp;&nbsp;单元
					</td>
				</tr>
				<tr>
					<td class="titleTd">
						建筑面积
					</td>
					<td>
						${tracking.buildArea}
					</td>
					<td class="titleTd">
						套内面积
					</td>
					<td>
						${tracking.comprisingArea}
					</td>
				</tr>
				<tr>
					<td class="titleTd">
						平均面积
					</td>
					<td>
						${tracking.perCapitaArea}
					</td>
					<td class="titleTd">
						总价款
					</td>
					<td>
						${tracking.totalPrice}
					</td>
				</tr>
				<tr>
					<td class="titleTd">
						是否交房
					</td>
					<td>
						<c:choose>
							<c:when test="${tracking.isCheckOut eq '1'}">是</c:when>
							<c:otherwise>否</c:otherwise>
						</c:choose>
					</td>
					<td class="titleTd">
						交房时间
					</td>
					<td>
						<fmt:formatDate value="${tracking.checkOutDate}" pattern="yyyy年MM月dd日"/>
					</td>
				</tr>
				</tbody>
			</table>
		<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
		<div id="EChartsMain" style="width: 800px;height:200px;margin-top: 30px;">

		</div>
			<div class="content-save">
				<%--<shiro:hasPermission name="record:basePoorerRegCard:edit">--%>
					<%--&lt;%&ndash;<input class="save-btn add-tr-btn" style="margin-right:30px !important; width: 120px;" type="button" value="添加"/>&ndash;%&gt;--%>
					<%--&lt;%&ndash;<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>&ndash;%&gt;--%>
				<%--</shiro:hasPermission>--%>
				<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
			</div>


	</div>
</div>
<style>
	.titleTd{
		font-weight: bold;
	}
</style>
<script >
	// 基于准备好的dom，初始化echarts实例
	var myChart = echarts.init(document.getElementById('EChartsMain'));

	// 指定图表的配置项和数据
	var option = {
		title: {
			text: '贫困户年收入'
		},
		tooltip: {},
		legend: {
			data:['收入']
		},
		xAxis: {
			data: [${years}]
		},
		yAxis: {},
		series: [{
			name: '收入',
			type: 'bar',
			data: [${incomeList}]
		}]
	};

	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);
</script>

</body>
</html>