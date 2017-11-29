<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>基础设施状况管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
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
		<li><a href="${ctx}/record/natureBaseCountryBasic/">自然村建档立卡基本情况列表</a></li>
		<%-- <li><a href="${ctx}/record/infrastructureSituation/">基础设施状况列表</a></li> --%>
		<li class="active"><a href="${ctx}/record/infrastructureSituation/form?countryBasicId=${infrastructureSituation.countryBasicId}">基础设施状况<shiro:hasPermission name="record:infrastructureSituation:edit">${not empty infrastructureSituation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:infrastructureSituation:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<div class="content tabs f-clear">
    <ul class="content-nav">
        <li><a href="${ctx}/record/natureBaseCountryBasic/form?id=${infrastructureSituation.countryBasicId}">基本情况</a></li>
        <li><a href="${ctx}/record/natureBaseDevIncome/form?countryBasicId=${infrastructureSituation.countryBasicId}">收入状况</a></li>
        <li><a href="${ctx}/record/natureBaseIndustryIncome/form?countryBasicId=${infrastructureSituation.countryBasicId}">产业状况</a></li>
        <li class="active"><a>基础设施状况</a></li>
        <li><a href="${ctx}/record/demandAndSituation/formD?countryBasicId=${infrastructureSituation.countryBasicId}">帮扶需求及帮扶情况</a></li>
        <li><a href="${ctx}/record/tableInfo/formD?countryBasicId=${infrastructureSituation.countryBasicId}">填表信息</a></li>
        
    </ul>
    <div id="tab-1" class="content-detail">
	
	<c:choose>
		<c:when test="${empty infrastructureSituation.countryBasicId }">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
	
	<form:form id="inputForm" modelAttribute="infrastructureSituation" action="${ctx}/record/infrastructureSituation/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>	
		<form:hidden path="countryBasicId"/>	
		<table>
                <tbody>
                <tr>
                    <td class="fir-td"><span>自然村（屯）到主干道未通沥青（水泥）路（公里）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="c28WithoutAsphaltRoad" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>饮水困难人数（人）</span></td>
                    <td class="fou-td bg-white">
						<form:input path="c31DrinkHardPerson" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>自然村（屯）内未硬化道路里程（公里）</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="c29UncuredRoad" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                    <td class="thr-td"><span>取水往返时间超过30分钟的人数（人）</span></td>
                    <td class="fou-td bg-white">
						<form:input path="moreThan30minPerson" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>饮水困难户数（户）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="c30DrinkHardHoursehold" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>全年缺水三个月以上的人数（人）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="moreThan3monPerson" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>取水往返时间超过30分钟的户数（户）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="moreThan30minHoursehold" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span>未通电户数（户）</span></td>
                    <td class="fou-td bg-white">
                    	<form:input path="c32NonEnergizedHoursehold" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>全年缺水三个月以上的户数（户）</span></td>
                    <td class="sec-td bg-white">
                    	<form:input path="moreThan3monHoursehold" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                    <td class="thr-td"><span></span></td>
                    <td class="fou-td bg-white"></td>
                </tr>
                </tbody>
            </table>
            <div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
	</form:form>
	</c:otherwise>
	</c:choose>
	</div>
	</div>
</body>
</html>