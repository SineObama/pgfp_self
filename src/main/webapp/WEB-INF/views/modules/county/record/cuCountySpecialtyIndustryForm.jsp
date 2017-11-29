<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\countyExport.css"/>
	<script type="text/javascript">
        var index = 0;
        var renum = 0;
        /*添加删除更新序号*/
        function reflowIndex() {
            var trs = $('tbody tr');
            var trLen = trs.length;
            for (var i = 0; i <= trLen; i++) {
                var tr = trs[i];
                $(tr).find("td:eq(0)").text(i);
            }
        }
        /*删除一行数据处理*/
        $(function () {
            $("#inputForm .add-tr-btn").on("click", addTr);
            $("#tab-1").delegate(".del-thistd-btn", "click", function () {
                $(this).parents("tr").remove();
                renum++;
                /*刷新序号*/
                reflowIndex();
            });
        });
        /*添加一行tr*/
        function addTr() {
            index = $("table tbody").find("tr").length;
            var num = index + renum;
            var tr ="<tr>" + "<td class='bg-white'>" + num + "</td>"
                + "<td class='bg-white town'><input  type='hidden' name='cuCountySpecialtyIndustries[" + index + "].town.id' class='townId'/>"
	            + "<input class='input_none townName required' style='background-color: #FFFFFF' readonly='true'/></td>"
                + " <td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].houseNumber' class='input_none'/></td>"
                + "<td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].incapacity' class='input_none'/></td>"
                + " <td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].specialtyIndustryHouse' class='input_none'/></td>"
                + "<td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].specialtyIndustryRate' class='input_none'/></td>"
                + "<td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].industryOneHouse' class='input_none'/></td>"
                + "<td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].industryOneRate' class='input_none''/></td>"
                + "<td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].industryTwoHouse' class='input_none'/></td>"
                + "<td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].industryTwoRate' class='input_none'/></td>"
                + "<td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].industryThreeHouse' class='input_none'/></td>"
                + "<td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].industryThreeRate' class='input_none'/></td>"
                + "<td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].industryFourHouse' class='input_none'/></td>"
                + "<td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].industryFourRate' class='input_none'/></td>"
                + "<td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].industryFiveHouse' class='input_none'/></td>"
                + "<td class='bg-white'><input name='cuCountySpecialtyIndustries[" + index + "].industryFiveRate' class='input_none'/></td>"
                + "<td class='bg-white' style='text-align: center'><span class='del-thistd-btn'>删除</span></td>"
                + "</tr>"
            $("table tbody").append(tr);
			/*刷新序号*/
            reflowIndex();
        }
          $(document).ready(function () {
                    $("#inputForm").validate({
                        submitHandler: function (form) {
                            loading('正在提交，请稍等...');
                            form.submit();
                        },
                        errorContainer: "#messageBox",
                        errorPlacement: function (error, element) {
                            $("#messageBox").text("输入有误，请先更正。");
                            if (element.is

                                (":checkbox") || element.is

                                (":radio") || element.parent().is(".input-append")) {
                                error.appendTo(element.parent().parent());
                            } else {
                                error.insertAfter(element);
                            }
                        }
                    });
			  /*菜单置为选中状态*/
                $(function () {
                    $(".content-nav #specialty").attr("class", "active");
                });
            })


/*********************************** 区域设置关联块********************************************/
        var who;
        function chooseMember(area,type){
            if(type == 0){
                who.find(".countyId").val(area.id);
                who.find(".countyName").val(area.name);
            }
            if(type == 1){
                who.find(".townId").val(area.id);
                who.find(".townName").val(area.name);
            }

        }
        $(function () {
            function callWindow(parentId ,type) {
                <%--var countryId = '${countryId}';--%>
                var iWidth = 800;
                var iHeight = 400;
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                var win = window.open("${ctx}/record/cuTable/areaChoose?parentId=" + parentId+"&type="+type, "选择地区", "width=" + iWidth +
                    ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
                    ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
                    "status=no,alwaysRaised=yes,depended=yes");
            };
            /*平桂 0*/
            $("#inputForm").delegate(".county",'click',function () {
                who = $(this);
                callWindow("1","0");
            });
            /*乡镇 1*/
            $(" #accpitem").delegate(".town",'click',function () {
                var id = $("#inputForm .countyId").val();
                who = $(this);
                callWindow(id,"1");
            });
        });
/*********************************** 区域设置关联块********************************************/

	</script>
</head>
<body>

<ul class="nav nav-tabs">
	<li><a href="${ctx}/record/cuMain/">年度扶贫档案列表</a></li>
	<shiro:hasPermission name="record:cuMain:view">
		<li class="active">
			<a href="">扶贫年度档案添加</a>
		</li>
	</shiro:hasPermission>
</ul>
<div class="content tabs f-clear">
	<jsp:include page="cuItemList.jsp"/>
	<div id="tab-1" class="content-detail">
		<form:form id="inputForm" modelAttribute="cuTable"
		           action="${ctx}/record/cuCountySpecialtyIndustry/save" method="post" class="form-horizontal">
			<sys:message content="${message}"/>
			<form:hidden id="year" path="year"/>
			<form:hidden id="cuMainId" path="cuMainId"/>
			<h1 style="text-align: center"><u> 平桂 </u>县(市、区）特色产业情况统计表</h1>
			<br/><br/>
			<p>
				<input type="hidden" name="id" value="${cuTable.id}">
				<span class="county">填报单位：
					<input type="hidden" class="countyId" name="department.id" value="${cuTable.department.id}"/>
					<input name="department.name" class="underline required countyName" value="${cuTable.department.name}"/>县(市、区）产业开发专责小组（盖章）
				</span>
				<span style="float: right;">填报时间：<input name="time" id="time" type="text" maxlength="20"
				                                        class="input-medium Wdate required"
				                                        value="<fmt:formatDate value="${cuTable.time}" pattern="yyyy-MM-dd"/>"
				                                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
				                                        style="width: 120px;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</span>
			</p>
			<div>
				<table>
					<thead>
					<tr>
						<td rowspan="3" style="width:35px">序号</td>
						<td rowspan="3">乡（镇）</td>
						<td rowspan="3">贫困户数</td>
						<td rowspan="3">无劳动能力或主要劳动力长期外出务工的贫困户数</td>
						<td rowspan="2" colspan="2">2-5个特色产业</td>
						<td colspan="10">其中</td>
						<td rowspan="3" style="cursor: pointer;" class="add-tr-btn">添加<span
								style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
					</tr>
					<tr>

						<td colspan="2">产业：
							<input name="cuSpecialtyIndustry.id" type="hidden"
							       value="${cuTable.cuSpecialtyIndustry.id}"/>
							<input name="cuSpecialtyIndustry.tableId" type="hidden"
							       value="${cuTable.cuSpecialtyIndustry.tableId}"/>
							<input name="cuSpecialtyIndustry.industryNameOne"
							       class="underline underline_width"
							       maxlength="20"
							       value="${cuTable.cuSpecialtyIndustry['industryNameOne']}"/>
						</td>
						<td colspan="2">产业：
							<input name="cuSpecialtyIndustry.industryNameTwo"
							       class="underline underline_width"
							       maxlength="20"
							       value="${cuTable.cuSpecialtyIndustry['industryNameTwo']}"/>
						</td>
						<td colspan="2">产业：
							<input name="cuSpecialtyIndustry.industryNameThree"
							       class="underline underline_width"
							       maxlength="20"
							       value="${cuTable.cuSpecialtyIndustry['industryNameThree']}"/>
						</td>
						<td colspan="2">产业：
							<input name="cuSpecialtyIndustry.industryNameFour"
							       class="underline underline_width"
							       maxlength="20"
							       value="${cuTable.cuSpecialtyIndustry['industryNameFour']}"/>
						</td>
						<td colspan="2">产业：
							<input name="cuSpecialtyIndustry.industryNameFive"
							       class="underline underline_width"
							       maxlength="20"
							       value="${cuTable.cuSpecialtyIndustry['industryNameFive']}"/>
						</td>


					</tr>
					<tr>
						<td>覆盖贫困户数</td>
						<td>覆盖率</td>
						<td>覆盖贫困户数</td>
						<td>覆盖率</td>
						<td>覆盖贫困户数</td>
						<td>覆盖率</td>
						<td>覆盖贫困户数</td>
						<td>覆盖率</td>
						<td>覆盖贫困户数</td>
						<td>覆盖率</td>
						<td>覆盖贫困户数</td>
						<td>覆盖率</td>
					</tr>
					</thead>
					<tbody id="accpitem">
					<c:if test="${!empty cuTable.cuCountySpecialtyIndustries}">
						<c:forEach items="${cuTable.cuCountySpecialtyIndustries}" var="county" varStatus="status">
							<c:set var="index" value="${status.index}"/>
							<input type="hidden" name="cuCountySpecialtyIndustries[${index}].id" value="${county.id}"/>
							<tr>
								<td class="bg-white">${index}</td>
								<td class="bg-white town"><input type="hidden" name="cuCountySpecialtyIndustries[${index}].town.id"
								                            class="townId"
								                            value="${county.town.id}"/>
									<input class="input_none townName" style="background-color: #FFFFFF" value="${county.town.name}" readonly="true"/>
								</td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].houseNumber"
										class="input_none int"
										value="${county.houseNumber}"/></td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].incapacity"
										class="input_none int"
										value="${county.incapacity}"/></td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].specialtyIndustryHouse"
										class="input_none int"
										value="${county.specialtyIndustryHouse}"/></td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].specialtyIndustryRate"
										class="input_none decimal"
										value="${county.specialtyIndustryRate}"/></td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].industryOneHouse"
										class="input_none int"
										value="${county.industryOneHouse}"/></td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].industryOneRate"
										class="input_none decimal"
										value="${county.industryOneRate}"/></td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].industryTwoHouse"
										class="input_none int"
										value="${county.industryTwoHouse}"/></td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].industryTwoRate"
										class="input_none decimal"
										value="${county.industryTwoRate}"/></td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].industryThreeHouse"
										class="input_none int"
										value="${county.industryThreeHouse}"/></td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].industryThreeRate"
										class="input_none decimal"
										value="${county.industryThreeRate}"/></td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].industryFourHouse"
										class="input_none int"
										value="${county.industryFourHouse}"/></td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].industryFourRate"
										class="input_none decimal"
										value="${county.industryFourRate}"/></td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].industryFiveHouse"
										class="input_none int"
										value="${county.industryFiveHouse}"/></td>
								<td class="bg-white"><input
										name="cuCountySpecialtyIndustries[${index}].industryFiveRate"
										class="input_none decimal"
										value="${county.industryFiveRate}"/></td>
								<td class="bg-white" style="text-align: center">
									<span class="del-thistd-btn">删除</span></td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
				<div class="suffix">
					<p>
						<input type="hidden" name="type" value="${cuTable.type}">
						<span>审核人：<input name="verifier" class="underline required" value="${cuTable.verifier}"/></span>
						<span class="left">填表人：<input name="reportingName" class="underline required" value="${cuTable.reportingName}"/></span>
						<span class="left">联系电话：<input name="phone" class="underline phone" maxlength="11" value="${cuTable.phone}"/></span>
					</p>

				</div>
			</div>
			<div class="form-actions" style="padding-left: 20px!important;">
				<div class="submitStyle">
					<shiro:hasPermission name="record:cuCountySpecialtyIndustry:edit">
						<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
						<input id="btnExport" class="btn btn-primary btnEx" type="button" value="导 出"/>&nbsp;
					</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</form:form>
	</div>
</div>

</body>
</html>
