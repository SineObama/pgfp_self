<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困人员信息查询</title>
	<meta name="decorator" content="default"/>
	<style>
	.form-search .ul-form .control-label{
	width: 70px;}
	.form-search .input-medium #age{
	width:40px;
	}
	#to{
	    width: 20px;
    	margin-left: 0px;
   	 	margin-right: 10px
	}
	.select2-chosen{
		width:80px;
	}
</style>
	
	<script type="text/javascript">
		$(document).ready(function(){

			$('#push').click(function(){
				var pushMessage = $('#pushMessage').val();
				confirmx('确认要推送给所有干部吗？', function(){
					$('#search').attr("action","${ctx}/query/pushMessage");
					var pushMessageValue = '<input type="hidden" name="pushMessage" value="'+pushMessage+'"/>'
					$('#search').append(pushMessageValue);
					$('#search').submit();
				})
			});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#search").submit();
        	return false;
        }
	</script>
</head>
<body>

	<ul class="nav nav-tabs">
		<li class="active"><a href="">人员信息列表</a></li>
	</ul>

	 <form:form id="search" modelAttribute="pi" action="${ctx}/query/PovertyInfo" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">	
           	 <li>
            <label class="control-label">村名:</label>
            <sys:treeselect id="country" name="countryId" value="${pi.countryId}"
                            labelName="countryName" labelValue="${pi.countryName}"
                            title="村（屯）" url="/sys/area/treeData" allowClear="true"/>
       		 </li>
			<li>
           		 <label class="control-label">年龄:</label>
           		 <form:input type="text" path="ageF" style="width:50px;" value="${pi.ageF}"/>
           		 <label id="to">至</label>
           		 <form:input type="text" path="ageL" style="width:50px;" value="${pi.ageL}"/>
           	</li> 
           	<li>
           		<label class="control-label">是否在校生:</label>
           		<form:select path="studentStatus">
           			<form:option value=''>无</form:option>
           			<form:options items="${fns:getDictList('students_situation')}"
							itemLabel="label" itemValue="value"/>
           		</form:select>
           	</li>
           	<li>
           		<label class="control-label">是否务工:</label>
           		<form:select path="workingConditions">
           			<form:option value=''>无</form:option>
					<form:options items="${fns:getDictList('migrant_workers')}" itemLabel="label" itemValue="value"/>
           		</form:select>
           	</li>
           	<li>
           		<label class="control-label">贫困户属性:</label>
           		<form:select path="poorerType">
           			<form:option value=''>无</form:option>
					<form:options items="${fns:getDictList('poor_households_attributes')}" itemLabel="label" itemValue="value"/>
           		</form:select>
           	</li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			</li>
			<shiro:hasPermission name="query:pushMessage">
				<li class="btns">
					<input id="btnPush" class="btn btn-primary" type="button" data-toggle="modal" data-target="#myModal"s value="推送"/>
				</li>
			</shiro:hasPermission>

			<li class="clearfix"></li>
		</ul>
	</form:form>
	

	<sys:message content="${message}"/> 
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>姓名</th>
				<th>性别</th>
				<th>出生日期</th>
				<th>年龄</th>
				<th>身份证</th>
				<th>文化程度</th>
				<th>健康状况</th>
				<th>电话号码</th>
				<th>劳动能力</th>
				<th>在校生状况</th>
				<th>务工状况</th>
				<th>户主姓名</th>
				<th>家庭住址</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="row">
			<tr>
				<td>${row.name}</td>
				<td>
					<c:choose>
						<c:when test="${row.sex == '01'}">男</c:when>
						<c:when test="${row.sex == '02'}">女</c:when>
						<c:otherwise>其它</c:otherwise>
					</c:choose>
				</td>
				<td>${row.birthDate}</td>
				<td>${row.age}</td>
				<td>${row.identId}</td>
				<td>
					${fns:getDictLabel(row.educationalLevel, 'degree_of_education', '')}
				</td>
				<td>
						${fns:getDictLabel(row.healthCondition, 'health', '')}
				</td>
				<td>${row.phone}</td>
				<td>
						${fns:getDictLabel(row.laborCapacity, 'labor_skill', '')}
				</td>
				<td>
						${fns:getDictLabel(row.studentStatus, 'students_situation', '')}
				</td>
				<td>
						${fns:getDictLabel(row.workingConditions, 'migrant_workers', '')}
				</td>
				<td>${row.houseHolderName}</td>
				<td>${row.address}</td>
			</tr>
		</c:forEach>
			
		</tbody>
	</table>
	
	<div class="pagination">${page}</div>




	<!-- 模态框（Modal） -->
	<div class="modal fade" style="display: none;" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		 aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title text-center" id="myModalLabel">推送通知消息</h4>
				</div>
				<div style="margin-left: 20px;">
					<textarea id="pushMessage" rows="6" style="width:515px;"></textarea>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" id="push" class="btn btn-primary">提交更改</button>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
</body>
</html>