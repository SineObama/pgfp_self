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
            amout = $("table tbody").find("tr").length;
            var index = amout + renum;
            var tr = "<tr>"
				<%--序号--%>
				+ "<td class='bg-white'></td>"
                <%--乡镇--%>
                + "<td class='bg-white town'>"
                + "<input type='hidden' name='cuCountyTwentyRoadSituations[" + index + "].town.id' class='townId'/>"
                + "<input class='input_none townName required' style='background-color: #FFFFFF' readonly='true'/>"
                + "</td>"
            	<%--村--%>
                + "<td class='bg-white country'>"
                + "<input type='hidden' name='cuCountyTwentyRoadSituations[" + index + "].country.id' class='countryId'/>"
                + "<input class='input_none required countryName' style='background-color: #FFFFFF' readonly='true'/>"
                + "</td>"
                <%--屯--%>
                + "<td class='bg-white tun'>"
                + "<input type='hidden' name='cuCountyTwentyRoadSituations[" + index + "].tun.id' class='tunId'/>"
                + "<input class='input_none required tunName' style='background-color: #FFFFFF' readonly='true'/>"
                + "</td>"
                <%--是否通砂石路以上的路--%>
                + "<td class='bg-white'>"
                + "<input type='checkbox' name='cuCountyTwentyRoadSituations[" + index + "].gravelRoadAbove' class='input_none int'/>"
                + "</td>"
                <%--砂石路（1）或硬化路（2）--%>
                + "<td>"
                + "<input name='cuCountyTwentyRoadSituations[" + index + "].gravelOrHardeningRoad' disabled='disabled' class='gravelOrHardeningRoad input_none isEdit'/>"
                + "</td>"
                <%--路面宽（米）--%>
                + "<td>"
                + "<input name='cuCountyTwentyRoadSituations[" + index + "].roadWidth' disabled='disabled' class='input_none decimal isEdit'/>"
                + "</td>"
                <%--里程（公路）--%>
                + "<td>"
                + "<input name='cuCountyTwentyRoadSituations[" + index + "].mileage'  disabled='disabled' class='input_none decimal isEdit'/>"
                + "</td>"
                <%--建成通车时间--%>
                + "<td>"
					+ "<input name='cuCountyTwentyRoadSituations[" + index + "].completionTime'  disabled='disabled' type='text' "
						+ "class='input_none isEdit' onclick=\"WdatePicker({dateFmt:'yyyy-MM',isShowClear:true});\"/>"
                + "</td>"
                <%--自然保护区路段地点--%>
                + "<td>"
                + "<input name='cuCountyTwentyRoadSituations[" + index + "].site'  disabled='disabled' class='input_none isEdit'/>"
                + "</td>"
                <%--自然保护区路段长度--%>
                + "<td>"
                + "<input name='cuCountyTwentyRoadSituations[" + index + "].length'  disabled='disabled'  class='input_none decimal isEdit'/>"
                <%--备注--%>
                + "<td class='bg-white'>"
                + "<input name='cuCountyTwentyRoadSituations[" + index + "].remarks' class='input_none'/>"
                + "</td>"
                + "<td class='bg-white' style='text-align: center'>"
                + "<span class='del-thistd-btn'>删除</span>"
                + "</td>"
				+ "</tr>";
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

			$("tbody").delegate("input:checkbox", 'click', function () {
                isEdit($(this));
            });

            /*菜单置为选中状态*/
            $(".content-nav #RoadSituation").attr("class", "active");
        })

        function isEdit(v) {
            if(v.attr("checked") == "checked"){
                v.val("1");
                v.parents('tr').find(".isEdit").each(function () {
                    $(this).attr("disabled",false);
                    $(this).parent('td').attr('class',"bg-white");
                });
            }else{
                v.parents('tr').find(".isEdit").each(function () {
                    $(this).attr("disabled",true);
                    $(this).val("");
                    $(this).parent('td').attr('class',"");
                });
            }
        };
        /*********************************** 区域设置关联块********************************************/
        var who;

        function chooseMember(area, type) {
            switch (type) {
                case 0:
                    /*县*/
                    who.find(".countyId").val(area.id);
                    who.find(".countyName").val(area.name);
                    break;
                case 1:
                    /*乡镇*/
                    who.find(".townId").val(area.id);
                    who.find(".townName").val(area.name);
                    break;
                case 2:
                    /*行政村 2*/
                    who.find(".countryId").val(area.id);
                    who.find(".countryName").val(area.name);
                    break;
                case 3:
                    /*屯 3*/
                    who.find(".tunId").val(area.id);
                    who.find(".tunName").val(area.name);
                    break;
            }
        }

        $(function () {
            function callWindow(parentId, type) {
                <%--var countryId = '${countryId}';--%>
                var iWidth = 800;
                var iHeight = 400;
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                var win = window.open("${ctx}/record/cuTable/areaChoose?parentId=" + parentId + "&type=" + type, "选择地区", "width=" + iWidth +
                    ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
                    ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
                    "status=no,alwaysRaised=yes,depended=yes");
            };
            /*平桂 0*/
            $("#inputForm").delegate(".county", 'click', function () {
                who = $(this);
                callWindow("1", "0");
            });
            /*乡镇 1*/
            $(" #accpitem").delegate(".town", 'click', function () {
                var id = $("#inputForm .countyId").val();
                who = $(this);
                callWindow(id, "1");
            });
            /*行政村 2*/
            $(" #accpitem").delegate(".country", 'click', function () {
                var id = $(this).parents('tr').find(".townId").val();
                who = $(this);
                callWindow(id, "2");
            });
            /*屯 3*/
            $("#accpitem").delegate(".tun", 'click', function () {
                var id = $(this).parents('tr').find(".countryId").val();
                who = $(this);
                callWindow(id, "3");
            });
            $('input:checkbox').each(function () {
                if ($(this).val() === "1") {
                    $(this).attr("checked", true);
                    isEdit($(this));
                } else {
                    $(this).attr("checked", false);
                }
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
				   action="${ctx}/record/cuCountyTwentyRoadSituation/save" method="post" class="form-horizontal">
			<sys:message content="${message}"/>
			<form:hidden id="year" path="year"/>
			<form:hidden id="cuMainId" path="cuMainId"/>
			<h1 style="text-align: center"><u> 平桂 </u>县(市、区）20户以上自然村屯通路情况表</h1>
			<br/><br/>
			<p>
				<input type="hidden" name="id" value="${cuTable.id}">
				<span class="county">填报单位：
					<input type="hidden" class="countyId" name="department.id" value="${cuTable.department.id}"/>
					<input name="department.name" class="underline required countyName"
						   value="${cuTable.department.name}"/>县(市、区）交通运输局（盖章）
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
						<td width="20px" rowspan="2">序号</td>
						<td width="60px" rowspan="2">乡(镇)</td>
						<td width="60px" rowspan="2">行政村</td>
						<td width="60px" rowspan="2">自然村</td>
						<td width="60px" rowspan="2">是否通砂石路以上的路</td>
						<td width="55px" colspan="4">通砂石路以上的路</td>
						<td width="260px" colspan="2">自然保护区路段</td>
						<td width="120px" rowspan="2">备注</td>
						<td tyle="cursor: pointer;" class="add-tr-btn" width="40px"  rowspan="2">添加<span
								style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
					</tr>
					<tr>
						<td>砂石路或硬化路</td>
						<td>路面宽<br>(米)</td>
						<td>里程<br>(公里)</td>
						<td style="width: 100px!important;">通车<br>时间</td>
						<td>地点</td>
						<td>长度</td>
					</tr>
					</thead>
					<tbody id="accpitem">
					<c:if test="${!empty cuTable.cuCountyTwentyRoadSituations}">
						<c:forEach items="${cuTable.cuCountyTwentyRoadSituations}" var="road" varStatus="status">
							<c:set var="index" value="${status.index}"/>
							<input type="hidden" name="cuCountyTwentyRoadSituations[${index}].id" value="${road.id}"/>
							<tr>
									<%--序号--%>
								<td class='bg-white'>${index}</td>
									<%--乡镇--%>
								<td class='bg-white town'>
									<input type='hidden' name='cuCountyTwentyRoadSituations[${index}].town.id' class='townId'
										   value='${road.town.id}'/>
									<input class='input_none townName required' style='background-color: #FFFFFF' readonly='true'
										   value='${road.town.name}'/>
								</td>
									<%--村--%>
								<td class='bg-white country'>
									<input type='hidden' name='cuCountyTwentyRoadSituations[${index}].country.id' class='countryId '
										   value='${road.country.id}'/>
									<input class='input_none required countryName' style='background-color: #FFFFFF' readonly='true'
										   value='${road.country.name}'/>
								</td>
									<%--屯--%>
								<td class='bg-white tun'>
									<input type='hidden' name='cuCountyTwentyRoadSituations[${index}].tun.id' class='tunId '
										   value='${road.country.id}'/>
									<input class='input_none required tunName' style='background-color: #FFFFFF' readonly='true'
										   value='${road.tun.name}'/>
								</td>
									<%--是否通砂石路以上的路--%>
								<td class='bg-white'>
									<input type="checkbox" name='cuCountyTwentyRoadSituations[${index}].gravelRoadAbove'
										   value='${road.gravelRoadAbove}'/>
								</td>
									<%--砂石路或硬化路--%>
								<td class='bg-white'>
									<input name='cuCountyTwentyRoadSituations[${index}].gravelOrHardeningRoad' class='input_none isEdit'
										   value='${road.gravelOrHardeningRoad}'/>
								</td>
									<%--路面宽（米）--%>
								<td class='bg-white'>
									<input name='cuCountyTwentyRoadSituations[${index}].roadWidth' class='input_none decimal isEdit'
										   value='${road.roadWidth}'/>
								</td>
									<%--里程（公路）--%>
								<td class='bg-white '>
									<input name='cuCountyTwentyRoadSituations[${index}].mileage' class='input_none decimal isEdit'
										   value='${road.mileage}'/>
								</td>
									<%--建成通车时间--%>
								<td class='bg-white'>
									<%--<input name='cuCountyTwentyRoadSituations[${index}].completionTime' class='input_none int'
										   value='${road.completionTime}'/>--%>

										<input  name='cuCountyTwentyRoadSituations[${index}].completionTime' type="text"
											   class="input_none isEdit" value='<fmt:formatDate value="${road.completionTime}" pattern="yyyy-MM"/>'
											   onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:true});"/>
								</td>
									<%--自然保护区路段地点--%>
								<td class='bg-white'>
									<input name='cuCountyTwentyRoadSituations[${index}].site' class='input_none isEdit'
										   value='${road.site}'/>
								</td>
									<%--自然保护区路段长度--%>
								<td class='bg-white'>
									<input name='cuCountyTwentyRoadSituations[${index}].length' class='input_none decimal isEdit'
										   value='${road.length}'/>
									<%--备注--%>
								<td class='bg-white'>
									<input name='cuCountyTwentyRoadSituations[${index}].remarks' class='input_none'
										   value='${road.remarks}'/>
								</td>
								<td class='bg-white' style='text-align: center'>
									<span class='del-thistd-btn'>删除</span>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
				<div class="suffix">
					<p>
						<input type="hidden" name="type" value="${cuTable.type}">
						<span>审核人：<input name="verifier" class="underline required" value="${cuTable.verifier}"/></span>
						<span class="left">填表人：<input name="reportingName" class="underline required"
													  value="${cuTable.reportingName}"/></span>
						<span class="left">联系电话：<input name="phone" class="underline phone" maxlength="11"
													   value="${cuTable.phone}"/></span>
					</p>

				</div>
			</div>
			<div class="form-actions" style="padding-left: 20px!important;">
				<div class="submitStyle">
					<shiro:hasPermission name="record:cuCountyTwentyRoadSituation:edit">
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

