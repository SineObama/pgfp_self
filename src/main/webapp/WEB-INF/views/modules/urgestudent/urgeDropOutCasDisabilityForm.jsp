<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>因失能免学、缓学、休学的学生情况记录管理</title>
	<meta name="decorator" content="default"/>
    <script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
    <script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
    <script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
    <script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
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
    <style>
        .tab-1_nav{
            font-size: 0;
            margin-bottom: 0px;
        }
        .icon-plus-sign-alt{
            margin-left: 3px;
        }
        .tab-1_nav li{
            position: relative;
            display: inline-block;
            font-size: 14px;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-top-width: 0;
            /* background-color: #e5e5e5; */
            border-radius: 0 0 4px 4px;
            transition: 1s;
        }
        .tab-1_nav li:not(.addTable)::before{
            content: ""; display: block; width: 0; position: absolute; top: 0; left: 0; height: 2px; background: #6196bb;transition:
                .3s;
        }
        .tab-1_nav li:not(.addTable):hover::before{
            width: 100%;
        }
        .tab-1_nav li.active:after{
            content: "";
            display: block;
            width: 100%;
            position: absolute;
            top: 0;
            left: 0;
            border-top: 2px solid #6196bb;
        }
        .tab-1_nav .addTable{
            /* margin-right: 15px; */
        }
    </style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/urgestudent/urgeDropOutsRecords/houseList">贫困户列表</a></li>
		<li class="active"><a href="${ctx}/urgestudent/urgeDropOutCasDisability/form?id=${card.id}">因失能免学、缓学、休学的学生情况记录
			<shiro:hasPermission name="urgestudent:urgeDropOutCasDisability:edit">${not empty urgeDropOutCasDisability.id?'修改':'添加'}</shiro:hasPermission>
			<shiro:lacksPermission name="urgestudent:urgeDropOutCasDisability:edit">查看</shiro:lacksPermission>
		</a></li>
	</ul><br/>
    <ul class="content-nav">
        <li ><a href="${ctx}/urgestudent/urgeDropOutsRecords/form?id=${card.id}">贫困学生劝返情况记录</a></li>
        <%--<li><a href="${ctx}">辍学劝返工作情况说明书</a></li>--%>
        <li style="height:38px; line-height: 19px;" class="active">因失能、缓学、休学<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贫困户学生情况记录表</li>
    </ul>
    <div id="tab-1" class="content-detail">
        <div class="content-head">
            <ul class="tab-1_nav">
                <li class="addTable">
                    点击添加<i class="icon-plus-sign-alt"></i></li>
                <c:if test="${card.disabilities != null && !card.disabilities.isEmpty()}">
                    <c:forEach items="${card.disabilities}" var="u" varStatus="index">
                        <li id="${u.id}" class="tab-student tab-1_nav">${u.student.name}</li>
                    </c:forEach>
                </c:if>
            </ul>
        </div>
	<form:form id="inputForm" modelAttribute="disability" action="${ctx}/urgestudent/urgeDropOutCasDisability/save" method="post" class="form-horizontal">
		<input type="hidden" name="id" class="id"/>
        <input type="hidden" name="cardId" class="cardId" id="regCardId" value="${card.id}"/>
        <input type="hidden" name="houseId" class="houseId" value="${card.houseId}"/>
        <input type="hidden" name="years" class="years" value="${card.years}"/>
		<sys:message content="${message}"/>
        <br/>
        <table id="urge" style="display: none;">
            <tbody>
            <tr class="bg-white">
                <td colspan="7" style="text-align: right; padding-right: 10px;"  id="deleteUrge">
                    <a>删除本页签</a>
                </td>
            </tr>
            <tr>
                <td colspan="7">一、基本信息</td>
            </tr>
            <tr class="stuInfo">
                <td>学生姓名</td>
                <td class="bg-white">
                    <input type="hidden" name="student.id" class="studentId"/>
                    <input type="text" name="student.name" class="studentName"/>
                </td>
                <td>性别</td>
                <td>
                    <input type="text" disabled name="student.sex" class="studentSex"/>
                </td>
                <td>身份证号码</td>
                <td colspan="2"><input type="text" disabled name="student.idNumber" class="studentIdNumber"/></td>
            </tr>
            <tr>
                <td>就读学校及年级</td>
                <td colspan="4" class="bg-white"><input type="text" name="schoolGrade" class="schoolGrade"/></td>
                <td>辍学年月</td>
                <td class="bg-white">
                    <input id="dropOutDate" name="dropOutDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required dropOutDate"
                           onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});"
                           style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
                </td>
            </tr>
            <tr class="guarInfo">
                <td>家长（或监护人）姓名</td>
                <td colspan="2" class="bg-white">
                    <input type="hidden" name="guardian.id" class="guardianId"/>
                    <input type="text" name="guardian.name" class="guardianName">
                </td>
                <td>电话</td>
                <td colspan="3" class="bg-white">
                    <input type="text" name="guardianPhone" class="guardianPhone"/>
                </td>
            </tr>
            <tr>
                <td>家庭住址</td>
                <td colspan="3" class="bg-white"><input type="text" name="address" class="address"/> </td>
                <td>户籍所在地</td>
                <td colspan="2" class="bg-white"><input type="text" name="householdRegister" class="householdRegister"></td>
            </tr>
            <tr>
                <td>帮扶联系人姓名</td>
                <td colspan="2" class="bg-white">
                    <input type="text" name="cadreName" class="cadreName"/>
                </td>
                <td>手机号码</td>
                <td colspan="3" class="bg-white">
                    <input type="text" name="cadrePhone" class="cadrePhone"/>
                </td>
            </tr>
            <tr>
                <td>班主任姓名</td>
                <td colspan="2" class="bg-white">
                    <input type="text" name="teacherName" class="teacherName"/>
                </td>
                <td>手机号码</td>
                <td colspan="3" class="bg-white">
                    <input type="text" name="teacherPhone" class="teacherPhone"/>
                </td>
            </tr>
            <tr>
                <td>二、失能原因</td>
                <td colspan="6" class="bg-white">
                    <input type="radio" name="disabilityType" class="disabilityType" value="A" checked/> 重大疾病&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="disabilityType" class="disabilityType" value="B"/>重度残疾&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="disabilityType" class="disabilityType" value="C"/>精神疾病&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="7">三、证明材料（证明材料目录直接输入，材料可以通过图片形式上传）</td>
            </tr>
            <tr>
                <td colspan="7" class="bg-white" style="height: 554px;">
                    <form:textarea id="content" htmlEscape="true" path="materialContent" rows="4" maxlength="200" class="input-xxlarge materialContent" />
                    <sys:ckeditor replace="content" uploadPath="/urge/disability" />
                </td>
            </tr>
            <tr>
                <td colspan="7">

                    <div class="content-save" id="content-save">
                        <shiro:hasPermission name="urgestudent:urgeDropOutsRecords:edit">
                        <input id="btnSubmit" class="save-btn" style="margin-right:30px !important;"
                               type="submit" value="保 存"/>
                        </shiro:hasPermission>
                        <input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <br/><br/><br/>
        </div>
	</form:form>
    </div>
<script>
    var card = ${fns:toJson(card)};
    var lastId = "";

    init("");

    //TODO 初始的时候调用
    function init(id){
        if(id == "1"){//如果是新增的页签，则清除掉所有内容。
            clearValue();
            return;
        }
        if(card != null && card.disabilities != null){
        $("#urge").css('display' , 'block');
        $("#content-save").css('display' , 'block');
            var dis = card.disabilities;
            if(dis.length > 0 ){
                //设置当前是那一条数据
                var d = dis[0];
                if(id != null && id != ''){
                    for(var i = 0 , size = dis.length ; i<size ; i++ ){
                        if(id == dis[i].id){
                            d = dis[i];
                            break;
                        }
                    }
                }
                lastId = d.id;
                setDisability(d);//设置内容
                //设置当前（或第一条）的选中状态
                $(".tab-student").each(function(){
                    var id = $(this).attr("id");
                    if(id == d.id){
                        $(this).addClass("active");
                    }
                })

            }
        }
    }


    //TODO 点击页签头的时候
    $(".tab-1_nav").delegate("li:not(.addTable)","click",function(){
        var id = $(this).attr("id");
        if(lastId == ""){
            if(confirm("确定不用保存信息吗？\n不需要保存请点击确定按钮，需要先保存请点击取消后进行保存！")){
                $(".tab-1_nav li:not(.addTable)").each(function(){
                    var liId = $(this).attr("id");
                    if(liId == '1'){
                        $(this).remove();
                    }
                })
                clearValue();
                init(id);
                $(".tab-1_nav li").removeClass("active");
                $(this).addClass("active")
            }
        } else {
            clearValue();
            init(id);
            $(".tab-1_nav li").removeClass("active");
            $(this).addClass("active")
        }
    })

    //TODO 添加一条主表记录
    $(".addTable").on("click",function(){
        $(".tab-1_nav li").removeClass("active");
        $(".addTable").parent(".tab-1_nav").append('<li onclick="clearValue()" id="1" class="active">请输入信息</li>');
        clearValue();
        lastId = "";
        $("#urge").css('display' , 'block');
        $("#content-save").css('display' , 'block');
    })

    $("#deleteUrge").delegate("a" , "click" , function(){
        if(confirm("确定删除本页签吗？")){
            var dId = $(".id").val();
            if(dId == null || dId == ''){
                $(".tab-1_nav li:not(.addTable)").each(function(){
                    var liId = $(this).attr("id");
                    if(liId == '1'){
                        $(this).remove();
                    }
                })
                init("");
            } else {
                window.location.href= ctx + "/urgestudent/urgeDropOutCasDisability/delete?id=" + dId;
            }

        }
    })

    //TODO 清空数据页面显示的数据
    function clearValue(){
        $(".id").val("");
        $(".studentId").val("");
        $(".studentName").val("");
        $(".studentSex").val("");
        $(".studentIdNumber").val("");
        $(".schoolGrade").val("");
        $(".dropOutDate").val("");
        $(".guardianId").val("");
        $(".guardianName").val("");
        $(".guardianPhone").val("");
        $(".address").val("");
        $(".householdRegister").val("");
        $(".cadreName").val("");
        $(".cadrePhone").val("");
        $(".teacherName").val("");
        $(".teacherPhone").val("");
        CKEDITOR.instances.content.setData("");
    }

    //TODO 设置数据页面内容显示
    function setDisability(d){
        $(".id").val(d.id);
        $(".studentId").val(d.student.id);
        $(".studentName").val(d.student.name);
        $(".studentSex").val(d.student.sex == "01" ? "男" : "女");
        $(".studentIdNumber").val(d.student.idNumber);
        $(".schoolGrade").val(d.schoolGrade);
        $(".dropOutDate").val("" == d.dropOutDate ? "" :d.dropOutDate.slice(0,7));
        $(".guardianId").val(d.guardian.id);
        $(".guardianName").val(d.guardian.name);
        $(".guardianPhone").val(d.guardianPhone);
        $(".address").val(d.address);
        $(".householdRegister").val(d.householdRegister);
        $(".cadreName").val(d.cadreName);
        $(".cadrePhone").val(d.cadrePhone);
        $(".teacherName").val(d.teacherName);
        $(".teacherPhone").val(d.teacherPhone);
        CKEDITOR.instances.content.setData(d.materialContent);
    }

    //弹出学生窗口
    $(function () {
        $("#urge").delegate(".studentName",'click',function(){
            var cardId = $("#regCardId").val();
            tr = $(this).parents("tr");
            var iWidth = 900;
            var iHeight = 500;
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
            var win = window.open("${ctx}/record/basePoorerFamilyMember/familyMemberChoose?poorerRegCardId="+cardId+"&selectMode=2", "选择学生", "width=" + iWidth +
                ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
                ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
                "status=no,alwaysRaised=yes,depended=yes");
        });
    });

    //弹出选择家长窗口
    $(function () {
        $("#urge").delegate(".guardianName",'click',function(){
            var cardId = $("#regCardId").val();
            tr = $(this).parents("tr");
            var iWidth = 900;
            var iHeight = 500;
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
            var win = window.open("${ctx}/record/basePoorerFamilyMember/familyMemberChoose?poorerRegCardId="+cardId+"", "选择家长", "width=" + iWidth +
                ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
                ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
                "status=no,alwaysRaised=yes,depended=yes");
        });
    });
    var tr;
    //弹出窗口回调
    function chooseMember(member){
        var className = tr[0].className;
        if("stuInfo" == className){//如果点击的是学生
            tr.find(".studentIdNumber").val(member.idNumber);
            tr.find(".studentName").val(member.name);
            tr.find(".studentSex").val("01" == member.sex ? "男" : "女");
            tr.find(".studentId").val(member.id);
        } else if("guarInfo" == className) {//如果点击的是家长
            tr.find(".guardianId").val(member.id);
            tr.find(".guardianName").val(member.name);
            tr.find(".guardianPhone").val(member.phone);
        }
    }
</script>
</body>
</html>