<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>自然村建档立卡产业状况管理</title>
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
		<%-- <li><a href="${ctx}/record/natureBaseIndustryIncome/">产业状况列表</a></li> --%>
		<li class="active"><a href="${ctx}/record/natureBaseIndustryIncome/form?id=${industryIncome.id}">产业状况<shiro:hasPermission name="record:natureBaseCountryBasic:edit">${not empty industryIncome.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:natureBaseCountryBasic:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<div class="content tabs f-clear">
	    <ul class="content-nav">
	        <li><a href="${ctx}/record/natureBaseCountryBasic/form?id=${industryIncome.countryBasicId}">基本情况</a></li>
	        <li><a href="${ctx}/record/natureBaseDevIncome/form?countryBasicId=${industryIncome.countryBasicId}">收入状况</a></li>
	        <li class="active">产业状况</li>
	        <li><a href="${ctx}/record/infrastructureSituation/form?countryBasicId=${industryIncome.countryBasicId}">基础设施状况</a></li>
	        <li><a href="${ctx}/record/demandAndSituation/formD?countryBasicId=${industryIncome.countryBasicId}">帮扶需求及帮扶情况</a></li>
        	<li><a href="${ctx}/record/tableInfo/formD?countryBasicId=${industryIncome.countryBasicId}">填表信息</a></li>
	        
	    </ul>
	    <div id="tab-2" class="content-detail">
	<c:choose>
		<c:when test="${empty industryIncome.countryBasicId }">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
	<form:form id="inputForm" modelAttribute="industryIncome" action="${ctx}/record/natureBaseIndustryIncome/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>	
		<form:hidden path="countryBasicId"/>	
		<table>
              <tbody>
                <tr>
                    <td>种植类</td>
                    <td class="bg-white">
						<form:input path="b83Planted" htmlEscape="false" maxlength="64" class="input-xlarge"/>
                    </td>
                    <td>特色产业人均收入（元）</td>
                    <td class="bg-white">
                    	<form:input path="b84Income"  maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
                    </td>
                </tr>
                <tr>
                    <td>中药材类</td>
                    <td class="bg-white">
                    	<form:input path="b83Herbal" htmlEscape="false" maxlength="64" class="input-xlarge"/>
                    </td>
                    <td>特色产业农民专业合作社（个）</td>
                    <td class="bg-white">
						<form:input path="b85ProCooper" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
                </tr>
                <tr>
                    <td>养殖类</td>
                    <td class="bg-white">
                    	<form:input path="b83Breed" htmlEscape="false" maxlength="64" class="input-xlarge"/>
                    </td>
                    <td>参加特色产业农民专业合作社贫困户数（户）</td>
                    <td class="bg-white">
                    	<form:input path="b86ProHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td>水果类</td>
                    <td class="bg-white">
                    	<form:input path="b83Fruit" htmlEscape="false" maxlength="64" class="input-xlarge"/>
                    </td>
                    <td>开展乡村旅游户数（户）</td>
                    <td class="bg-white">
                    	<form:input path="b87TouHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td>坚果类</td>
                    <td class="bg-white">
                    	<form:input path="b83Nut" htmlEscape="false" maxlength="64" class="input-xlarge"/>
                    </td>
                    <td>乡村旅游从业人数（人）</td>
                    <td class="bg-white">
                    	<form:input path="b88TouPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td>其他类</td>
                    <td class="bg-white">
                    	<form:input path="b83Other" htmlEscape="false" maxlength="64" class="input-xlarge"/>
                    </td>
                    <td>经营农家乐的户数（户）</td>
                    <td class="bg-white">
                    	<form:input path="b89Agritain" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
                    </td>
                </tr>
                <tr>
                    <td>经营农家乐户年均收入（元）</td>
                    <td class="bg-white">
                    	<form:input path="b90AveIncome" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
                    </td>
                    <td></td>
                    <td class="bg-white"></td>
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