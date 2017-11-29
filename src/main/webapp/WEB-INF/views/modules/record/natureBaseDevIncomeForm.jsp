<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>自然村建档立卡收入状况管理</title>
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
		<%-- <li><a href="${ctx}/record/natureBaseDevIncome/">收入状况列表</a></li> --%>
		<li class="active"><a href="${ctx}/record/natureBaseDevIncome/form?id=${devIncome.id}">收入状况<shiro:hasPermission name="record:natureBaseCountryBasic:edit">${not empty devIncome.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:natureBaseCountryBasic:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<div class="content tabs f-clear">
    <ul class="content-nav">
        <li><a href="${ctx}/record/natureBaseCountryBasic/form?id=${devIncome.countryBasicId}">基本情况</a></li>
        <li class="active">收入状况</li>
        <li><a href="${ctx}/record/natureBaseIndustryIncome/form?countryBasicId=${devIncome.countryBasicId}">产业状况</a></li>
        <li><a href="${ctx}/record/infrastructureSituation/form?countryBasicId=${devIncome.countryBasicId}">基础设施状况</a></li>
        <li><a href="${ctx}/record/demandAndSituation/formD?countryBasicId=${devIncome.countryBasicId}">帮扶需求及帮扶情况</a></li>
        <li><a href="${ctx}/record/tableInfo/formD?countryBasicId=${devIncome.countryBasicId}">填表信息</a></li>
        
    </ul>
    <div id="tab-2" class="content-detail">
	
	<c:choose>
		<c:when test="${empty devIncome.countryBasicId }">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
	<form:form id="inputForm" modelAttribute="devIncome" action="${ctx}/record/natureBaseDevIncome/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>		
		<form:hidden path="countryBasicId"/>
		<table>
            <tbody>
             <tr>
                 <td>村民主要收入来源</td>
                 <td class="bg-white">
                 	<form:checkboxes path="b17SouIncomeList" items="${fns:getDictList('income_sou')}" itemValue="value" itemlabel="label" htmlEscape="false"/>
                 </td>
                 <td>自然村(屯)集体财产</td>
                 <td class="bg-white">
                 	<form:checkboxes path="b19AllPropertyList" items="${fns:getDictList('income_sou')}" itemValue="value" itemlabel="label" htmlEscape="false"/>
                 	<%-- <form:input path="b19AllProperty" htmlEscape="false" maxlength="11" class="input-xlarge"/> --%>
                 </td>
             </tr>
             <tr>
                 <td>自然村(屯)集体经济收入(万元)</td>
                 <td class="bg-white">
                 	<form:input path="b20AllIncomel" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                 </td>
                 <td>农民年人均纯收入(元)</td>
                 <td class="bg-white">
                 	<form:input path="b18AveIncome" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                 </td>
             </tr>
             <tr>
                 <td>人均纯收入2800元以上(含2800元)(户)</td>
                 <td class="bg-white">
                 	<form:input path="b181Income" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                 </td>
                 <td>人均纯收入2000-2800元(含2000元)(户)</td>
                 <td class="bg-white">
                 	<form:input path="b182Income" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                 </td>
             </tr>
             <tr>
                 <td>人均纯收入1000-2000元(含1000元)(户)</td>
                 <td class="bg-white">
                 	<form:input path="b183Income" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                 </td>
                 <td>人均纯收入1000元以下(户)</td>
                 <td class="bg-white">
                 	<form:input path="b184Income" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                 </td>
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