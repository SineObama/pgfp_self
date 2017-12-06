<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>县异地搬迁户住房保障情况表管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\countyExport.css"/>

	<script type="text/javascript">
        $(document).ready(function () {

            /*checkbox回显*/
            $('input:checkbox').each(function () {
                if ($(this).val() == 1) {
                    $(this).attr('checked', true);
                } else {
                    $(this).attr('checked', false);
                }
            });
            /**********************************  设置checkbox单选  ***********************************************/


          //绑定点击的checkbox
            $("#accpitem").delegate('input:checkbox', 'click', function () {
                var check = $(this);  //记录点击checkbox位置
                var state = check.attr("checked");  //点击后的checkbox状态（点击后取反）
                var array = check.parents('tr').find("input:checkbox");  //获取点击位置所在的tr里的所有checkbox
                var className = check.attr("class");  //保存className

                //修改点击的checkbox状态，同时赋值
                if (state == "checked") {
                    check.attr('checked', true);
                    check.val("1");
                } else {
                    check.attr('checked', false);
                    check.val("");
                }

                if(state == "checked"){
                    if(className.indexOf("disperseIn")!= -1 ){
                        check.parents('tr').find(".centralizeHouseQuality").val("");
                        check.parents('tr').find(".centralizeHouseQuality").attr('checked', false);
                        check.parents('tr').find(".centralizeIn").val("");
                        check.parents('tr').find(".centralizeIn").attr('checked', false);
                        check.parents('tr').find(".centralizeKey").val("");
                        check.parents('tr').find(".centralizeKey").attr('checked', false);
                    }else{
                        check.parents('tr').find(".disperseIn").val("");
                        check.parents('tr').find(".disperseIn").attr('checked', false);
                    }
				}
			});




            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });

            $('.btnEx').click(function () {
                top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v) {
                    var cuTable = null;
                    if (v == "ok") {
                        window.location.href = "${ctx}/record/cuCountyRelocation/export?type=${cuTable.type}&cuMainId=${cuTable.cuMainId}";
                    }
                });
            });

            $(function () {
                $(".content-nav #relocation").attr("class", "active");
            });
        });
	</script>
</head>
<body>
<div class="main">
	<input type="hidden" id="main_year" value="${cuMain['year']}">
	<input type="hidden" id="main_id" value="${cuMain['id']}">
</div>
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
				   action="${ctx}/record/cuCountyRelocation/save" method="post"
				   class="form-horizontal">
			<sys:message content="${message}"/>
			<input type="hidden" name="id" value="${cuTable.id}"/>
			<input type="hidden" name="cuMainId" value="${cuTable.cuMainId}"/>
			<input type="hidden" name="year" value="${cuTable.year}"/>
			<input type="hidden" name="type" value="${cuTable.type}"/>
			<h1 id="h1" style="text-align: center">
				平桂县异地搬迁户住房保障情况表
			</h1>
			<br/><br/>
			<p style="margin-bottom: 5px!important;">
                <span id="span-1" class="department" style="float: left">
                    <input type="hidden" readonly="true" class="departmentId" name="department.id"
						   value="2"/>
             填报单位：<input class="underline departmentName required" readonly="true" name="department.name"
						 value="平桂"
						 style="width: 80px" maxlength="20"/>县（市、区）移民搬迁专责小组（盖章）
                </span>
				<span style="float: right">填报时间：<input name="time" id="time" type="text" maxlength="20"
													   class="input-medium Wdate required"
													   value="<fmt:formatDate value="${cuTable.time}" pattern="yyyy-MM-dd"/>"
													   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
													   style="width: 120px;background-color: #FFFFFF;border:1px solid #ccc;"/>
        </span>
			</p>
			<br/>
			<div>
				<table>
					<thead>
					<tr>
						<td rowspan="2">序号</td>
						<td rowspan="2">乡（镇）</td>
						<td rowspan="2">行政村</td>
						<td rowspan="2">自然村（屯）</td>
						<td rowspan="2">户主姓名</td>
						<td rowspan="2">家庭人口数(人)</td>
						<td rowspan="2">安置住房面积（㎡）</td>
						<td rowspan="2">迁入地</td>
						<td colspan="3">集中安置户</td>
						<td>分散安置户</td>
						<td rowspan="2">备注</td>
						<td style="text-align: center;cursor: pointer;width: 60px;" class="add-tr-btn" rowspan="3">
							添加<span
								style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
					</tr>
					<tr>
						<td>房屋质量是否达标</td>
						<td>是否达到入住条件</td>
						<td>是否交钥匙</td>
						<td>是否入住</td>
					</tr>
					</thead>
					<tbody id="accpitem">
					<c:if test="${!empty cuTable.cuCountyRelocations}">
						<c:forEach items="${cuTable.cuCountyRelocations}" var="relocation" varStatus="status">
							<c:set var="indexN" value="${status.index+1}" scope="page"/>
							<input type="hidden" class="id" name="cuCountyRelocations[${status.index}].id"
								   value="${relocation.id}"/>
							<tr>
								<td class="bg-white">${indexN}</td>
								<td class="bg-white required town">
									<input type="hidden" class="townId"
										   name="cuCountyRelocations[${status.index}].town.id"
										   value="${relocation.town.id}"/>
									<input class="td-input townName required"
										   name="cuCountyRelocations[${status.index}].town.name"
										   readonly="true" value="${relocation.town.name}"/>
								</td>
								<td class="bg-white village">
									<input type="hidden" class="villageId"
										   name="cuCountyRelocations[${status.index}].village.id"
										   value="${relocation.village.id}"/>
									<input class="td-input villageName required"
										   name="cuCountyRelocations[${status.index}].village.name"
										   readonly="true" value="${relocation.village.name}"/>
								</td>
								<td class="bg-white tun">
									<input type="hidden" class="tunId"
										   name="cuCountyRelocations[${status.index}].tun.id"
										   value="${relocation.tun.id}"/>
									<input class="td-input tunName required"
										   name="cuCountyRelocations[${status.index}].tun.name"
										   readonly="true" value="${relocation.tun.name}"/>
								</td>
								<td class="bg-white">
									<input class="householdName realName td-input required"
										   name="cuCountyRelocations[${status.index}].householdName"
										   value="${relocation.householdName}" maxlength="30"/>
								</td>
								<td class="bg-white">
									<input class="familyMember int td-input required"
										   name="cuCountyRelocations[${status.index}].familyMember"
										   value="${relocation.familyMember}" maxlength="8"/>
								</td>
								<td class="bg-white">
									<input class="housingArea td-input decimal required"
										   name="cuCountyRelocations[${status.index}].housingArea"
										   value="${relocation.housingArea}" maxlength="11"/>
								</td>
								<td class="bg-white">
									<input class="adress td-input int required"
										   name="cuCountyRelocations[${status.index}].adress"
										   value="${relocation.adress}" maxlength="100"/>
								</td>
								<td class="bg-white">
									<input type="checkbox" class="centralizeHouseQuality"
										   name="cuCountyRelocations[${status.index}].centralizeHouseQuality"
										   value="${relocation.centralizeHouseQuality}"/>
								</td>
								<td class="bg-white">
									<input type="checkbox" class="centralizeIn"
										   name="cuCountyRelocations[${status.index}].centralizeIn"
										   value="${relocation.centralizeIn}"/>
								</td>
								<td class="bg-white">
									<input type="checkbox" class="centralizeKey"
										   name="cuCountyRelocations[${status.index}].centralizeKey"
										   value="${relocation.centralizeKey}"/>
								</td>
								<td class="bg-white">
									<input type="checkbox" class="disperseIn"
										   name="cuCountyRelocations[${status.index}].disperseIn"
										   value="${relocation.disperseIn}"/>
								</td>
								<td class="bg-white">
									<input class="remarks td-input"
										   name="cuCountyRelocations[${status.index}].remarks"
										   value="${relocation.remarks}"/>
								</td>
								<td class="bg-white" style="text-align: center">
									<span class="del-thistd-btn">删除</span>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
				<span style="float: left;">
                 审核人：<input class="underline realName" name="verifier" value="${cuTable.verifier}" style="width: 100px"
							maxlength="20"/>&nbsp;&nbsp;&nbsp;
                 填表人：<input class="underline realName required" name="reportingName" value="${cuTable.reportingName}"
							style="width: 100px" maxlength="20"/>&nbsp;&nbsp;&nbsp;
                 联系电话：<input class="underline phone required" name="phone" value="${cuTable.phone}" style="width: 100px"
							 maxlength="11"/>
                </span>

			</div>

			<div class="form-actions actions">
				<div class="submitStyle">
					<shiro:hasPermission name="record:cuCountyRelocation:edit">
						<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
						<input id="btnExport" class="btn btn-primary btnEx" type="button" value="导 出"/>&nbsp;
					</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</form:form>
	</div>
</div>
<script>

    var choose;
    function chooseMember(area, type) {
        if (type == 1) {
            choose.find(".townId").val(area.id);
            choose.find(".townName").val(area.name);
            choose.parents('tr').find(".villageId").val("");
            choose.parents('tr').find(".villageName").val("");
            choose.parents('tr').find(".tunId").val("");
            choose.parents('tr').find(".tunName").val("");
        } else if (type == 2) {
            choose.find(".villageId").val(area.id);
            choose.find(".villageName").val(area.name);
            choose.parents('tr').find(".tunId").val("");
            choose.parents('tr').find(".tunName").val("");
        }else if (type == 3) {
            choose.find(".tunId").val(area.id);
            choose.find(".tunName").val(area.name);
        }
    }

    $(function () {
        function openWindow(parentId, type) {
            var iWidth = 800;
            var iHeight = 400;
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
            var win = window.open("${ctx}/record/cuTable/areaChoose?parentId=" + parentId + "&type=" + type, "选择地区", "width=" + iWidth +
                ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
                ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
                "status=no,alwaysRaised=yes,depended=yes");
        };
        /*type(1：镇级)*/
        $("#accpitem").delegate(".town", 'click', function () {
            choose = $(this);
            var parentId = $("#span-1").find(".departmentId").val();
            openWindow(parentId, "1");
        });
        /*type(2:村级)*/
        $("#accpitem").delegate(".village", 'click', function () {
            choose = $(this);
            var parentId = choose.parents().find(".townId").val();
            if(parentId == ""){
                alert("请先选择镇！");
                return false;
			}
            openWindow(parentId, "2");
        });
        /*type(3:屯级)*/
        $("#accpitem").delegate(".tun", 'click', function () {
            choose = $(this);
            var parentId = choose.parents().find(".villageId").val();
            if(parentId == ""){
                alert("请先选择村！");
                return false;
            }
            openWindow(parentId, "3");
        });
    });
</script>

<script>

    var index = 0;
    var renum = 0;

    /*添加删除一行tr方法*/
    function reflowIndex() {
        var trs = $('tbody tr');
        var trLen = trs.length;
        for (var i = 0; i <= trLen; i++) {
            var tr = trs[i];
            $(tr).find("td:eq(0)").text(i + 1);
        }
    };

    $(function () {
        $(".add-tr-btn").click(function () {
            index = $("table tbody").find("tr").length;
            var num = index + renum;
            var tr = '<tr>' +
                '<input type="hidden" class="id"  name="cuCountyRelocations[' + num + '].id"/>' +
                '<td class="bg-white">' +
                '</td>' +
                '<td class="bg-white town">' +
                '<input type="hidden" class="townId" name="cuCountyRelocations[' + num + '].town.id"/>' +
                '<input class="td-input townName required" readonly="true" name="cuCountyRelocations[' + num + '].town.name"/>' +
                '</td>' +
                ' <td class="bg-white village">' +
                '<input type="hidden" class="villageId" name="cuCountyRelocations[' + num + '].village.id"/>' +
                '<input class="td-input villageName required" readonly="true" name="cuCountyRelocations[' + num + '].village.name"/>' +
                '</td>' +
                '<td class="bg-white tun">' +
                '<input type="hidden" class="tunId" name="cuCountyRelocations[' + num + '].tun.id"/>' +
                '<input class="td-input tunName required" readonly="true" name="cuCountyRelocations[' + num + '].tun.name"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input householdName realName required" maxlength="30" name="cuCountyRelocations[' + num + '].householdName"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input familyMember int required" maxlength="8" name="cuCountyRelocations[' + num + '].familyMember"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input housingArea decimal required" maxlength="11" name="cuCountyRelocations[' + num + '].housingArea"/> ' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input adress required" maxlength="100" name="cuCountyRelocations[' + num + '].adress"/> ' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input type="checkbox" class="centralizeHouseQuality" name="cuCountyRelocations[' + num + '].centralizeHouseQuality"/> ' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input type="checkbox" class="centralizeIn" name="cuCountyRelocations[' + num + '].centralizeIn"/> ' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input type="checkbox" class="centralizeKey" name="cuCountyRelocations[' + num + '].centralizeKey"/> ' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input type="checkbox" class="disperseIn" name="cuCountyRelocations[' + num + '].disperseIn"/> ' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input remarks" name="cuCountyRelocations[' + num + '].remarks" maxlength="500"/>' +
                '</td>' +
                '<td class="bg-white" style="text-align: center">' +
                '<span class="del-thistd-btn">删除</span>' +
                '</td>' +
                '</tr>';
            $("table tbody").append(tr);
            reflowIndex();
        });

        $("#tab-1").delegate(".del-thistd-btn", "click", function () {
            $(this).parents("tr").remove();
            renum++;
            reflowIndex();
        });
    });
</script>
</body>
</html>