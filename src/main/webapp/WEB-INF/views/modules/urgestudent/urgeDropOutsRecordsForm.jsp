<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>辍学学生劝返记录主表管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
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
		<li><a href="${ctx}/urgestudent/urgeDropOutsRecords/houseList">辍学学生劝返记录主表列表</a></li>
		<li class="active"><a href="${ctx}/urgestudent/urgeDropOutsRecords/form?id=${card.id}">辍学学生劝返记录主表<shiro:hasPermission name="urgestudent:urgeDropOutsRecords:edit">${not empty urgeDropOutsRecords.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="urgestudent:urgeDropOutsRecords:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<div class="header">
		<a href="" class="header-lt">贫困学生劝返</a>
		<a href="" class="header-rt">贫困学生劝返情况记录</a>
	</div>
	<div class="content tabs f-clear">
		<ul class="content-nav">
			<li class="active"><a>贫困学生劝返情况记录</a></li>
			<li><a href="${ctx}">辍学劝返工作情况说明书</a></li>
			<li style="height:38px;"><a href="${ctx}">因失能、缓学、休学<br/>贫困户学生情况记录表</a></li>
		</ul>
		<div id="tab-1" class="content-detail">
			<div class="content-head">
				<ul class="tab-1_nav">
					<li class="addTable">
						点击添加<i class="icon-plus-sign-alt"></i></li>
					<c:if test="${card.urges != null && !card.urges.isEmpty()}">
						<c:forEach items="${card.urges}" var="u" varStatus="index">
							<li id="${u.id}" class="tab-student tab-1_nav">${u.student.name}</li>
						</c:forEach>
					</c:if>
				</ul>
			</div>
			<form:form id="inputForm" modelAttribute="urge" action="${ctx}/urgestudent/urgeDropOutsRecords/save" method="post" class="form-horizontal">
				<%--<form:hidden path="id"/>--%>
				<form:hidden path="houseId"/>
				<sys:message content="${message}"/>
				<br/>
				<table style="border: 0px #FFFFFF; display:none;" id="urge">
					<tbody>
					<tr class="bg-white">
						<td colspan="7" style="text-align: right; padding-right: 10px;"  id="deleteUrge">
							<a>删除本页签</a>
						</td>
					</tr>

					<tr>
						<td class="sec-td" colspan="7">
							<strong>一、信息管理</strong>
						</td>
					</tr>
					<tr class="stuInfo">
						<td class="sec-td">学生姓名<span><font color="red">&nbsp;&nbsp;*</font></span></td>
						<td class="sec-td bg-white">
							<input type="hidden" name="id" class="id"/>
							<input type="hidden" name="deleteContentsId" class="deleteContentsId"/>
							<input type="hidden" name="houseId" class="houseId" value="${card.houseId}"/>
							<input type="hidden" name="regCardId" class="regCardId" id="regCardId" value="${card.id}"/>
							<input type="hidden" name="years" class="years" value="${card.years}"/>
							<input type="hidden" name="student.id" class="studentId"/>
							<input type="text" class="studentName required" name="student.name"/>
						</td>
						<td style="min-width:30px !important;">性别</td>
						<td style="min-width:30px !important;">
							<input type="text" class="studentSex" name="student.sex" disabled/>
						</td>
						<td>身份证号码</td>
						<td colspan="2">
							<input type="text" class="studentIdNumber" name="student.idNumber" disabled/>
						</td>
					</tr>
					<tr>
						<td class="sec-td">就读学校及年级</td>
						<td class="sec-td bg-white" colspan="4">
							<input type="text" class="schoolGrade" name="schoolGrade"/>
						</td>
						<td>辍学年月</td>
						<td class="sec-td bg-white"  colspan="">
							<input id="dropOutDate" name="dropOutDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required dropOutDate"
								   onclick="WdatePicker({dateFmt:'yyyy-MM',isShowClear:false});"
								   style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
						</td>
					</tr>
					<tr class="guarInfo">
						<td class="sec-td">家长(或监护人)姓名<span><font color="red">&nbsp;&nbsp;*</font></span></td>
						<td class="sec-td bg-white" colspan="2">
							<input type="hidden" name="guardian.id" class="guardianId"/>
							<input type="text" class="guardianName required" name="guardian.name"/>
						</td>
						<td>电话号码</td>
						<td class="sec-td bg-white"  colspan="3">
							<input type="text" class="guardianPhone phone" name="guardianPhone"/>
						</td>
					</tr>
					<tr>
						<td class="sec-td">家庭住址<span><font color="red">&nbsp;&nbsp;*</font></span></td>
						<td class="sec-td bg-white" colspan="3">
							<input type="text" class="address" name="address"/>
						</td>
						<td>户籍所在地</td>
						<td class="sec-td bg-white"  colspan="2">
							<input type="text" class="householdRegister" name="householdRegister"/>
						</td>
					</tr>
					<tr>
						<td class="sec-td" colspan="7">
							<strong>二、辍学原因</strong>
						</td>
					</tr>
					<tr>
						<td class="sec-td bg-white" colspan="7">
							<input type="text" class="dropOutReason" name="dropOutReason"/>
						</td>
					</tr>
					<tr>
						<td class="sec-td" colspan="7">
							<strong>三、已采取的帮扶措施</strong>
						</td>
					</tr>
					<tr>
						<td class="sec-td bg-white" colspan="7">
							<input type="text" class="supportingMeasures" name="supportingMeasures"/>
						</td>
					</tr>
					</tbody>
				</table>
				<table style="border: 0px #FFFFFF; display:none;" id="contents">
					<tbody>
						<tr>
							<td class="sec-td" colspan="6">
								<strong>四、劝返记录</strong>
							</td>
						</tr>
						<tr>
							<td class="sec-td">
								劝返次数
							</td>
							<td>
								劝返人员姓名
							</td>
							<td>
								劝返人员电话
							</td>
							<td>
								劝返时间
							</td>
							<td style="min-width:167px !important;">
								劝返就读情况记录
							</td>
							<td style="text-align: center;cursor: pointer;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
						</tr>
					</tbody>
				</table>

				<div class="content-save" id="content-save" style="display: none">
					<shiro:hasPermission name="urgestudent:urgeDropOutsRecords:edit">
						<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;"
							   type="submit" value="保 存"/>
					</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
				</div>
			</form:form>
		</div>
	</div>
	<script>
		var card = ${fns:toJson(card)};
		var deleteRecordContent = "";
		var lastId = "1";

        $(".tab-1_nav").delegate("li:not(.addTable)","click",function(){
            var id = $(this).attr("id");

            if(lastId == ""){
                if(confirm("确定不用保存信息吗？\n不需要保存请点击确定按钮，需要先保存请点击取消后进行保存！")){
                    $(".tab-1_nav li:not(.addTable)").each(function(){
                        var liId = $(this).attr("id");
                        if(liId == null || liId == ''){
                            $(this).remove();
						}
					})

                    init(id);
                    $(".tab-1_nav li").removeClass("active");
                    $(this).addClass("active")
                }
            } else {
                init(id);
                $(".tab-1_nav li").removeClass("active");
                $(this).addClass("active")
            }
		})

		$("#deleteUrge").delegate("a" , "click" , function(){
			if(confirm("确定删除本页签吗？")){
			    var urgeId = $(".id").val();
//			    console.log(urgeId);
                window.location.href= ctx + "/urgestudent/urgeDropOutsRecords/delete?id=" + urgeId;
			}
		})

		//TODO 初始的时候调用，主要是获取劝返次数的数据
		function init(id){
            $("#contents").css('display' , 'block');
            $("#urge").css('display' , 'block');
            $("#content-save").css('display' , 'block');
		    if(card != null && card.urges != null){
		        var urges = card.urges;
		        if(urges.length > 0 ){
		            //设置当前是那一条数据
		            var urge = urges[0];
		            if(id != null && id != ''){
		                for(var i = 0 , size = urges.length ; i<size ; i++ ){
		                    if(id == urges[i].id){
		                        urge = urges[i];
		                        break;
							}
						}
					}

                    lastId = urge.id;
                    setUrge(urge);//设置内容
					//获取内容
					$.ajax({
                        type: 'POST',
                        url: ctx+"/urgestudent/urgeDropOutsRecords/getContents",
                        data: {"urgeId" : urge.id},
                        dataType: "JSON",
                        success: function(msg){
                            if(msg.responseText == 'success'){
//                                alert("获取成功!");
								var contents = msg.data;
								setContents(contents);//设置内容
                            } else {
                                alert(msg.responseText);
                            }
                        },
                        error:function(msg){
                            alert("error:"+JSON.stringify(msg));
                        }
					});

					//设置当前（或第一条）的选中状态
					$(".tab-student").each(function(){
					    var id = $(this).attr("id");
					    if(id == urge.id){
					        $(this).addClass("active");
						}
					})

				}
			}
		}

		//TODO 这里做一个把劝返记录的主表的数据给放到对应的文本框中
		function setUrge(u){
		    if(u != null) {
                $(".id").val(u.id);
                $(".studentName").val(u.student.name);
                $(".studentId").val(u.student.id);
                $(".studentSex").val(u.student.sex == '01' ? "男" : "女");
                $(".studentIdNumber").val(u.student.idNumber);
                $(".schoolGrade").val(u.schoolGrade);
                $(".dropOutDate").val("" == u.dropOutDate ? "" :u.dropOutDate.slice(0,7));
                $(".guardianName").val(u.guardian.name);
                $(".guardianId").val(u.guardian.id);
                $(".guardianPhone").val(u.guardianPhone);
                $(".address").val(u.address);
                $(".householdRegister").val(u.householdRegister);
                $(".dropOutReason").val(u.dropOutReason);
                $(".supportingMeasures").val(u.supportingMeasures);
            }
		}

		//TODO 这里是把劝返次数记录都给放到对应的地方
		function setContents(cs){
            var index = 0 ;
            $(".content").each(function(){
                if(index >= 1){
                    $(this).remove();//删除数据行
                }
                index ++;
            });

			//TODO 再重新写入行
			if(cs != null){
			    var HTML ;
			    for(var i = 0 , size = cs.length ; i < size ; i++){
			        var TR = "<TR CLASS=\"content\">" +
							"<TD  class=\"sec-td bg-white\">" + "<input type='hidden' name='content["+i+"].id' value='"+cs[i].id+"' class='contentId'/>" +
							"<input type='text' name='content["+i+"].recordIdx' value='"+cs[i].recordIdx +"' class='recordIdx'/>" +
							"</TD>"+
							"<TD  class=\"sec-td bg-white\">" +
							"<input type='text' name='content["+i+"].urgeeCadreName' value='"+cs[i].urgeeCadreName+"' class='urgeeCadreName'/>" +
							"</TD>"+
							"<TD  class=\"sec-td bg-white\">" +
							"<input type='text' name='content["+i+"].urgeeCadrePhone' value='"+cs[i].urgeeCadrePhone+"' class='urgeeCadrePhone phone'/>" +
							"</TD>"+
							"<td class=\"sec-td bg-white\">"+
							"<input name='content["+i+"].urgeeDate' type='text'" +
							"class='urgeeDate input-medium Wdate required'"+ "value='"+cs[i].dateString +"'"+
							"onclick='WdatePicker({dateFmt:\"yyyy-MM\",isShowClear:false});'"+
							"style='width: 120px;height:90%;background-color: #FFFFFF;border:0px none #FFFFFF;'/>"+
							"</td>"+
                            "<td class=\"sec-td bg-white\">"+
                            "<input type='text' name='content["+i+"].recordContent' value='"+cs[i].recordContent+"' class='recordContent'/>" +
                            "</TD>"+
                            "<td class='bg-white' style='text-align: center'><span class='del-thistd-btn'>删除</span></td>"+
							"</TR>";
			        HTML = HTML + TR;
				}
				$("#contents").find("tbody").append(HTML);
			}

		}

        $(document).ready(function() {
            //$("#name").focus();
			//TODO 提交数据
            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    $('.deleteContentsId').val(deleteRecordContent);//设置要删除的id列表
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

            //TODO 添加一行子记录
            $(".add-tr-btn").click(function() {
                var TR = "<TR CLASS=\"content\">" +
                    "<TD  class=\"sec-td bg-white\">" + "<input type='hidden' name='content[0].id' class='contentId'/>" +
                    "<input type='text' name='content[0].recordIdx' class='recordIdx'/>" +
                    "</TD>" +
                    "<TD  class=\"sec-td bg-white\">" +
                    "<input type='text' name='content[0].urgeeCadreName' class='urgeeCadreName'/>" +
                    "</TD>" +
                    "<TD  class=\"sec-td bg-white\">" +
                    "<input type='text' name='content[0].urgeeCadrePhone' class='urgeeCadrePhone phone'/>" +
                    "</TD>"+
                    "<td class=\"sec-td bg-white\">" +
                    "<input name='content[0].urgeeDate' type='text'" +
                    "class='urgeeDate input-medium Wdate required'"+
                    "onclick='WdatePicker({dateFmt:\"yyyy-MM\",isShowClear:false});'"+
                    "style='width: 120px;height:90%;background-color: #FFFFFF;border:0px none #FFFFFF;'/>"+
                    "</td>"+
                    "<td class=\"sec-td bg-white\">"+
                    "<input type='text' name='content[0].recordContent' class='recordContent'/>" +
                    "</TD>"+
                    "<td class='bg-white' style='text-align: center'><span class='del-thistd-btn'>删除</span></td>"+
                    "</TR>";
                $(this).parents("#contents").find("tbody").append(TR);
//                $("select").select2();
                rename();
            });

            //TODO 删除一行子记录
            $("#contents").delegate(".del-thistd-btn","click",function(){
                var id = $(this).parents("tr").find(".contentId").val();
                if(id != null && id != ''){
                    deleteRecordContent = deleteRecordContent + id +",";//如果是拼接被删除的id列表
				}
                $(this).parents("tr").remove();
                rename();
            });
            //TODO 改每一个子记录的name属性
            function rename(){
                var i=-2;
                $('#contents tr').each(function() {
                    $(this).children('td').children('.contentId').attr('name','content['+ i +'].id');
                    $(this).children('td').children('.recordIdx').attr('name','content['+ i +'].recordIdx');
                    $(this).children('td').children('.urgeeCadreName').attr('name','content['+ i +'].urgeeCadreName');
                    $(this).children('td').children('.urgeeCadrePhone').attr('name','content['+ i +'].urgeeCadrePhone');
                    $(this).children('td').children('.urgeeDate').attr('name','content['+ i +'].urgeeDate');
                    $(this).children('td').children('.recordContent').attr('name','content['+ i +'].recordContent');
                    i ++ ;
                });
			}

			//TODO 添加一条主表记录
            $(".addTable").on("click",function(){
                $(".tab-1_nav li").removeClass("active");
                $(".addTable").parent(".tab-1_nav").append('<li onclick="clearValue()" class="active">请输入信息</li>');

                clearValue();
				$("#contents").css('display' , 'block');
                $("#urge").css('display' , 'block');
                $("#content-save").css('display' , 'block');
            })
//            $(".tab-1_nav").delegate("li:not(.addTable)","click",function(){
//                $(".tab-1_nav li").removeClass("active");
//                $(this).addClass("active")
//            })
        });

		//TODO 点击添加时，清空所有的数据
		function clearValue(){
		    lastId = '';
		    $('.studentName').val("");
		    $('.studentId').val("");
		    $('.id').val("");
		    $('.deleteContentsId').val("");
		    $('.studentSex').val("");
			$('.studentIdNumber').val("");
			$('.schoolGrade').val("");
			$('.dropOutDate').val("");
			$('.guardianId').val("");
			$('.guardianName').val("");
			$('.guardianPhone').val("");
			$('.address').val(card.address);
			$('.householdRegister').val("");
			$('.dropOutReason').val("");
			$('.supportingMeasures').val("");

            var index = 0 ;
            $(".content").each(function(){
                if(index >= 1){
					$(this).remove();//删除数据行
                }
                index ++;
            });
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
                tr.find(".studentSex").val(member.sex);
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