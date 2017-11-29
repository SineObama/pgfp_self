<%@ taglib prefix="html" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="http" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>网上办事业务</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

		$(document).ready(function() {

            if($("#link").val()){
                $('#linkBody').show();
                $('#url').attr("checked", true);
            }
			$('input[name=templateType]').on('click',function(){
				var ty=$(this).val()
				$('.template_ty').hide();
				$('#'+ty).show();
			});
			$("#title").focus();
			function check_checkboxes() {

				var $bsStuffs = $(".bsStuffs");
				if ($bsStuffs.length > 0) {
					var is_true = true;
					for (var i = 0; i < $bsStuffs.length; i = i + 2) {
						//console.log(i);
						if ($bsStuffs.eq(i) && !$bsStuffs.eq(i).attr('checked') && !$bsStuffs.eq(i + 1).attr('checked')) {
							if (is_true) {
								alert("请选择办理材料明细方式");
							}
							$bsStuffs.eq(i + 1).parent().append('<label for="" class="error">必填信息</label>');
							is_true = false;
						}
						if (!$bsStuffs.eq(i + 2)) {
							break;
						}
					}
					$bsStuffs.off("click").on("click", (function () {
						if ($(this).attr('checked')) {
							$(this).parent().parent().find(".error").remove();
						}
					}));
					return is_true;
				}
				return true;
			}
		});

	</script>
	<style>
		.a_upload {
			padding: 4px 10px;
			height: 20px;
			line-height: 20px;
			position: relative;
			cursor: pointer;
			color: #888;
			background: #fafafa;
			border: 1px solid #ddd;
			border-radius: 4px;
			overflow: hidden;
			display: inline-block;
			*display: inline;
			*zoom: 1
		}

		.a_upload input {
			position: absolute;
			font-size: 100px;
			right: 0;
			top: 0;
			opacity: 0;
			filter: alpha(opacity=0);
			cursor: pointer
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/bs/bsBasicinfo/">网上办事业务列表</a></li>
		<li class="active"><a href="${ctx}/bs/bsBasicinfo/form?id=${bsBasicinfo.id}">文章<shiro:hasPermission name="cms:article:edit">${not empty article.id?'修改':'添加'}
		</shiro:hasPermission><shiro:lacksPermission name="cms:article:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bsBasicinfo" action="${ctx}/bs/bsBasicinfo/save" method="post" class="form-horizontal" enctype="multipart/form-data" >
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">标题:</label>
			<div class="controls">
				<input id="title" name="title" class="input-xxlarge measure-input required" value="${bsBasicinfo.title}" maxlength="200" type="text">
			</div>
		</div>


		<div class="control-group">
			<label class="control-label">责任部门:</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${bsBasicinfo.office.id}" labelName="office.name" labelValue="${bsBasicinfo.office.name}"
								title="部门" url="/sys/office/treeData?type=2" cssClass="required" notAllowSelectParent="true"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">扶贫办事类型:</label>
			<div class="controls">
				<html:radiobuttons path="bsType" items="${fns:getDictList('bsType')}" itemValue="value" itemlabel="label"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">办事指南基本信息:</label>
			<%--<html:hidden path="id"></html:hidden>--%>
			<div class="controls">
				<table class="table table-bordered">
					<tbody>
					<tr>
						<td>
							<div class="form-group">
								<label for="qlType"><font color="red">*</font>权利事项类型：</label>
								<form:select path="qlType" class="input-large">
									<form:options items="${fns:getDictList('qlType')}" itemLabel="label"
												  itemValue="value" htmlEscape="false"/>
									<%--<form:options items="${fns:getDictList('right_item_type')}" itemLabel="label"
												  itemValue="value" htmlEscape="false"/>--%>
								</form:select>
							</div>
						</td>
						<td>
							<div class="form-group">
								<label for="qlTime"><font color="red">*</font>法定期限：</label>
								<form:input path="qlTime" htmlEscape="false" class="input-xlarge"
											placeholder="提示：如填写“10个工作日”" maxlength="100" size="30"></form:input>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-group">
								<label for="qlType"><font color="red">*</font>权利来源：</label>
								<form:select path="qlFrom" class="input-large">
									<form:options items="${fns:getDictList('qlFrom')}" itemLabel="label"
												  itemValue="value" htmlEscape="false"/>
									<%--<form:options items="${fns:getDictList('right_from')}" itemLabel="label"
												  itemValue="value" htmlEscape="false"/>--%>
								</form:select>
							</div>
						</td>
						<td>
							<div class="form-group">
								<label for="cnTime"><font color="red">*</font>承诺期限：</label>
								<form:input path="cnTime" htmlEscape="false" class="input-xlarge required"
											placeholder="提示：如填写“10个工作日”" maxlength="100" size="30"></form:input>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-group">
								<label for="jgName"><font color="red">*</font>实施机关：</label>
								<form:input path="jgName" htmlEscape="false" placeholder="提示：填写本单位名称"
											class="input-xlarge required" maxlength="100" size="30"></form:input>
							</div>
						</td>
						<td>
							<div class="form-group">
								<label for="zxTel"><font color="red">*</font>咨询电话：</label>
								<form:input path="zxTel" htmlEscape="false" class="input-xlarge required"
											maxlength="100" size="30"></form:input>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-group">
								<label for="ksName">责任科(股)室：</label>
								<form:input path="ksName" htmlEscape="false" placeholder="提示：请填写本科（股）室名称"
											class="input-xlarge" maxlength="100" size="30"></form:input>
							</div>
						</td>
						<td>
							<div class="form-group">
								<label for="tsTel">监督投诉电话：</label>
								<form:input path="tsTel" htmlEscape="false" class="input-xlarge" maxlength="100"
											size="30"></form:input>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-group">
								<label for="bsTarget"><font color="red">*</font>办事对象：</label>
								<form:select path="bsTarget" class="input-large">
									<%--<form:options items="${fns:getDictList('bsobject_type')}" itemLabel="label"
												  itemValue="value" htmlEscape="false"/>--%>
									<form:options items="${fns:getDictList('bsTarget')}" itemLabel="label"
												  itemValue="value" htmlEscape="false"/>
								</form:select>
							</div>
						</td>
						<td>
							<div class="form-group">
								<label for="bsType"><font color="red">*</font>办件类型：</label>
								<form:select path="bjType" class="input-large">
									<%--<form:options items="${fns:getDictList('bj_type')}" itemLabel="label" itemValue="value"
												  htmlEscape="false"/>--%>
									<form:options items="${fns:getDictList('bjType')}" itemLabel="label" itemValue="value"
												  htmlEscape="false"/>
								</form:select>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="1">
							<div class="form-group">
								<label for="addrTime"><font color="red">*</font>到办事窗口的最小次数：</label>
								<form:input path="bsMinNb" placeholder="提示：填写整数"
											class="input-xlarge required digits" maxlength="10"></form:input>
							</div>
						</td>
						<td colspan="1">
							<div class="form-group">
								<label for="addrTime"><font color="red">*</font>办理地点、时间：</label>
								<form:input path="addrTime" htmlEscape="false"
											placeholder="提示：如填写“**政务大厅**窗口   上午8：30-11：30；下午14：00-17：00（法定节假日除外）”"
											class="input-xxlarge" maxlength="100"></form:input>
							</div>
						</td>
					</tr>
					</tbody>
				</table>
			</div>

			<div class="control-group">
				<label class="control-label">受理条件:</label>

				<div class="controls">
					<table class="table table-bordered">
						<thead>
						<tr>
							<td colspan="3">
								<button type="button" class="btn btn-default" id="addAccp">增加受理条件</button>
							</td>
						</tr>
						<tr>
							<th>权重</th>
							<th>项目名称</th>
							<th>是否必选</th>

							<th></th>
						</tr>
						</thead>
						<tbody id="accpitem">
						<c:if test="${!empty bsBasicinfo.acceptanceList}">
							<c:forEach items="${bsBasicinfo.acceptanceList}" var="ac" varStatus="status">
								<tr>
									<td>
										<html:input path="acceptanceList[${status.index}].weight" placeholder="提示：数字小排在前面"
													cssClass="input-mini required digits weight"
													maxlength="10"></html:input>
									</td>
									<td>
										<input type="hidden" name="acceptanceList[${status.index}].id" value="${ac.id}">
										<input type="hidden" name="acceptanceList[${status.index}].baseId"
											   value="${ac.baseId}">
										<html:input path="acceptanceList[${status.index}].title" htmlEscape="false"
													cssClass="input-xlarge atitle required" maxlength="200"/>
									</td>
									<td>
										<label class="radio">
											<html:radiobutton path="acceptanceList[${status.index}].checkedFlag"
															  cssClass="required" value="0"/>否
										</label>
										<label class="radio">
											<html:radiobutton path="acceptanceList[${status.index}].checkedFlag"
															  cssClass="required" value="1"/>是
										</label>
									</td>
									<td>
										<button type="button" class="btn btn-default backAdd">删除</button>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						</tbody>
					</table>
					<script>
						$(function () {
							$('#addAccp').on('click', function () {
								var _len = $("#accpitem tr").length;
								var tr = '<tr>' +
										'<td>' +
										'<input name="acceptanceList[' + _len + '].weight" type="text" class="input-mini required digits weight" maxlength="200" size="30"/>' +
										'</td>' +
										'<td>' +
										'<input name="acceptanceList[' + _len + '].title" type="text" class="input-xlarge atitle required" maxlength="200" size="30"/>' +
										'</td>' +
										'<td>' +
										'<label class="radio"><input type="radio" name="acceptanceList[' + _len + '].checkedFlag"' +
										'value="0" checked>否</label>' +
										'<label class="radio"><input type="radio" name="acceptanceList[' + _len + '].checkedFlag"' +
										'value="1">是</label>' +
										'</td>' +
										'<td>' +
										'<button type="button" class="btn btn-default backAdd">删除</button>' +
										'</td>' +
										'</tr>';
								$('#accpitem').append(tr);
								rename();
							});
							$('.backAdd').live('click', function () {
								var cobj = $(this);
								if ($(this).parent('td').parent('tr').find('input[type=hidden]').html() != null) {
									var id = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
									$.get("${ctx}/bs/bsBasicinfo/deleteAcceptance?id=" + id, null, function (msg) {
										if (msg == 'success') {
											$(cobj).parent('td').parent('tr').remove();
										}
									});
								} else {
									$(cobj).parent('td').parent('tr').remove();
								}
								rename();
							});
						});
						function rename() {
							var i = 0;
							$('#accpitem tr').each(function () {
								$(this).children('td').children('.atitle').attr('name', 'acceptanceList[' + i + '].title');
								$(this).children('td').children('.weight').attr('name', 'acceptanceList[' + i + '].weight');
								$(this).children('td').children('label').find('input[type=radio]').attr('name', 'acceptanceList[' + i + '].checkedFlag');
								i++;
							});
						}
					</script>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">办理材料明细:</label>

				<div class="controls">
					<table class="table table-bordered">
						<thead>
						<tr>
							<td colspan="6">
								<button type="button" class="btn btn-default" id="addStuff">增加材料明细</button>
							</td>
						</tr>
						<tr>
							<th>排序</th>
							<th>材料名称</th>
							<th>材料形式</th>
							<th>详细要求</th>
							<th>必要性及描述</th>
							<th>材料表单</th>
							<th>材料提交方式</th>
							<th></th>
						</tr>
						</thead>
						<tbody id="stuffitem">
						<c:if test="${!empty bsBasicinfo.stuffList}">
							<c:forEach items="${bsBasicinfo.stuffList}" var="stuff" varStatus="status">
								<tr>
									<td>
										<html:input path="stuffList[${status.index}].weight"
													cssClass="input-mini required digits" maxlength="200"></html:input>
									</td>
									<td>
										<input type="hidden" name="stuffList[${status.index}].baseId"
											   value="${stuff.baseId}" class="c1">
										<html:hidden path="stuffList[${status.index}].id"></html:hidden>
										<html:input path="stuffList[${status.index}].name" htmlEscape="false"
													cssClass="s_name required" maxlength="200"></html:input>
									</td>
									<td>
										<html:input path="stuffList[${status.index}].type" htmlEscape="false"
													cssClass="s_type required" maxlength="100"></html:input>
									</td>
									<td>
										<html:input path="stuffList[${status.index}].content" htmlEscape="false"
													cssClass="s_content" maxlength="500"></html:input>
									</td>
									<td>
										<%--<<<<<<< .mine--%>
										<%--<html:input path="bsStuffs[${status.index}].necessityDesc" cssClass="s_desc required" maxlength="500"></html:input>--%>
										<%--<html:radiobuttons path="bsStuffs[${status.index}].necessityDesc" cssClass="s_desc" items="${fns:getDictList('is_necessary')}" itemValue="value"/>--%>
										<html:select path="stuffList[${status.index}].necessityDesc"
													 cssClass="s_desc required" items="${fns:getDictList('is_necessary')}"
													 itemValue="value"/>

										<%--=======--%>
										<%--<html:select path="bsStuffs[${status.index}].necessityDesc" cssClass="s_desc required">--%>
										<%--<html:option value="">选择非必要性及描述</html:option>--%>
										<%--<html:option value="必要">必要</html:option>--%>
										<%--<html:option value="非必要">非必要</html:option>--%>
										<%--</html:select>--%>
										<%--<html:input path="bsStuffs[${status.index}].necessityDesc" cssClass="s_desc required" maxlength="500"></html:input>--%>
									</td>
									<td>
										<a class="a_upload a_upload_b">上传表单
											<input type="file" name="appFile" id="bsStuffsFile_${status.index}"/>
										</a>
										<c:forEach var="file" items="${stuff.stuffFiles}">
											<div class="response_elements stufitem">
												${file.stuffName}
												&nbsp;&nbsp;<a
													href="${ctx}/bs/bsBasicinfo/deleteStuffFile?filePathName=${file.pathName}&fid=${file.id}"
													class="t16 delstufile">删除</a>
											</div>
										</c:forEach>
									</td>
									<td>
										<label class="checkbox inline">
											<input type="checkbox" name="stuffList[${status.index}].submitTypeArr[0]"
												   class="stype0" value="0" <c:if
												test="${!empty stuff.submitTypeArr and fn:indexOf(fn:join(stuff.submitTypeArr,','),'0')>-1}">checked</c:if>/>窗口提交
										</label>
										<label class="checkbox inline">
											<input type="checkbox" name="stuffList[${status.index}].submitTypeArr[1]"
												   class="stype1" value="1" <c:if
												test="${!empty stuff.submitTypeArr and fn:indexOf(fn:join(stuff.submitTypeArr,','),'1')>-1}">checked</c:if>/>线上提交
										</label>
									</td>
									<td>
										<input type="hidden" name="stuffIdbackAdd_2" value="${stuff.id}"/>
										<button type="button" class="btn btn-default backAdd_2">删除</button>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						</tbody>
					</table>
				</div>
				<script>
					$(function () {
						function getFileName(o) {
							var pos = o.lastIndexOf("\\");
							return o.substring(pos + 1);
						}

						$(document).on('click', '.tab_close', function () {
							if (confirm('确定离开页面!离开页面将导致数据丢失')) {
								return false;
							} else {

							}
						});
						document.body.onbeforeunload = function (event) {
							var c = event || window.event;
							if (/webkit/.test(navigator.userAgent.toLowerCase())) {
								return "离开页面将导致数据丢失！";
							}
							else {
								c.returnValue = "离开页面将导致数据丢失！";
							}
						}
						$("body").on("change", ".a_upload_b input", function () {
							var wrap = $(this).parent('.a_upload').parent('td');
							var sid = $(this).attr('id');
							var _index = $(this).parent('a').parent('td').parent('tr').index();
							var _val = $(this).val();
							$.ajaxFileUpload
							(
									{
										url: '${ctx}/bs/bsBasicinfo/uploadStuffFile',
										secureuri: false,
										type: "POST",
										fileElementId: sid,
										dataType: 'text',
										success: function (data, status) {
//													//console.debug(data);
											var _div = '<div class="response_elements stufitem">' +
													'<input type="hidden" name="stuffList[' + _index + '].stuffFiles[' + _index + '].pathName" class="stufile" value="' + data + '"/>' +
													'<input type="hidden" name="stuffList[' + _index + '].stuffFiles[' + _index + '].stuffName" class="ostufile" value="' + getFileName(_val) + '"/>' + getFileName(_val) +
													'&nbsp;&nbsp;<a href="${ctx}/bs/bsBasicinfo/deleteStuffFile?filePathName=' + data + '&stuffId=${stuff.id}" class="t16 delstufile">删除</a>'
											'</div>';
											$(wrap).append(_div);
											$('label[for=checked' + sid + ']').remove();
											if (typeof (data.error) != 'undefined') {
												if (data.error != '') {
													alert(data.error);
												} else {
													alert(data.msg);
												}
											}
										},
										error: function (data, status, e) {
											alert(e);
										}
									}
							)
						});
						//删除表单附件
						$('body').on('click', '.delstufile', function () {
							var delBtn = $(this);
							var _href = $(this).attr('href');
							//console.debug(_href)
							$.get(_href, null, function (data) {
								if (data == 'success') {
									$(delBtn).parent('.stufitem').remove();
								}
							});
							return false;
						});
						/*
						 $('#addStuff').on('click',function(){
						 var _len=$("#stuffitem tr").length;
						 var tr='<tr>'+
						 '<td>'+
						 '<input type="text" name="bsStuffs['+_len+'].name" class="s_name required" maxlength="200"/>'+
						 '</td>'+
						 '<td>'+
						 '<input type="text" name="bsStuffs['+_len+'].type" class="s_type required" maxlength="100"/>'+
						 '</td>'+
						 '<td>'+
						 '<input type="text" name="bsStuffs['+_len+'].content" class="s_content" maxlength="500"/>'+
						 '</td>'+
						 '<td>'+
						 '<input type="text" name="bsStuffs['+_len+'].necessityDesc" class="s_desc required" maxlength="500"/>'+
						 '</td>'+
						 '<td>'+
						 '<a class="a_upload a_upload_b">上传表单'+
						 '<input type="file" name="appFile" id="bsStuffsFile_'+_len+'"/>'+
						 '</a>'+
						 '</td>'+
						 '<td><label class="checkbox inline">'+
						 '<input type="checkbox" name="bsStuffs['+_len+'].submitTypeArr[0]" class="stype0" value="0"/>窗口提交</label>'+
						 '<label class="checkbox inline"><input type="checkbox" name="bsStuffs['+_len+'].submitTypeArr[1]" class="stype1" value="1"/>在线提交</label>'+
						 '</td>'+
						 '<td>'+
						 '<input type="hidden" name="stuffIdbackAdd_2"/>'+
						 '<button type="button" class="btn btn-default backAdd_2">删除</button>'+
						 '</td>'+
						 '</tr>';
						 $('#stuffitem').append(tr);
						 rename_2();
						 });*/

						$('#addStuff').live('click', function () {
							var _len = $("#stuffitem tr").length;
							var tr = '<tr>' +
									'<td>' +
									'<input type="text" name="stuffList[' + _len + '].weight" class="input-mini required digits" maxlength="200"/>' +
									'</td>' +
									'<td>' +
									'<input type="text" name="stuffList[' + _len + '].name" class="s_name required" maxlength="200"/>' +
									'</td>' +
									'<td>' +
									'<input type="text" name="stuffList[' + _len + '].type" class="s_type required" maxlength="100"/>' +
									'</td>' +
									'<td>' +
									'<input type="text" name="stuffList[' + _len + '].content" class="s_content" maxlength="500"/>' +
									'</td>' +
									'<td>' +
//											'<input type="text" name="bsStuffs['+_len+'].necessityDesc" class="s_desc required" maxlength="500"/>'+
//											'<form >'+
//											'<input type="radio" checked="checked" name="bsStuffs['+_len+'].necessityDesc" value="1" />必须'+
//											'<input type="radio"  name="bsStuffs['+_len+'].necessityDesc" value="2" />非必须'+
//											'</form>'+
									'<select name="bsStuffs[' + _len + '].necessityDesc" class="s_desc required" style="width:80px">' +
									'<option value="1" class="s_desc" >必要</option>' +
									'<option value="2" class="s_desc">非必要</option>' +
									'</select>' +
									'</td>' +
									'<td>' +
									'<a class="a_upload a_upload_b">上传表单' +
									'<input type="file" name="appFile" id="bsStuffsFile_' + _len + '"/>' +
									'</a>' +
									'</td>' +
									'<td><label class="checkbox inline">' +
									'<input type="checkbox" name="stuffList[' + _len + ']" class="stype0 bsStuffs bsStuffs_' + _len + '" value="0"/>窗口提交</label>' +
									'<label class="checkbox inline"><input type="checkbox" name="stuffList[' + _len + ']" class="stype1 bsStuffs  bsStuffs_' + _len + '"  value="1"/>在线提交</label>' +
									'</td>' +
									'<td>' +
									'<input type="hidden" name="stuffIdbackAdd_2"/>' +
									'<button type="button" class="btn btn-default backAdd_2">删除</button>' +
									'</td>' +
									'</tr>';
							$('#stuffitem').append(tr);
							rename_2();
						});


						$('.backAdd_2').live('click', function () {
							var ctx = $(this);
//									//删除表单附件
							var delstufile = $(ctx).parent('td').parent('tr').find('.delstufile');
							//获取明细id
							var stuffId = $(ctx).parent('td').find('input[name=stuffIdbackAdd_2]').val();
//									out.prinln("======== "+stuffId+"  =========");
//									//通过js删除附件
							if ($(delstufile).length > 0) {
								$(delstufile).each(function () {
									var delBtn = $(this);
									var _href = $(this).attr('href');
									$.get(_href, null, function (data) {
										if (data == 'success') {
											$(delBtn).parent('.stufitem').remove();
										}
									});
								});
							}
							//删除明细
							if (stuffId != null && stuffId.length > 0) {
								$.get("${ctx}/bs/bsBasicinfo/deleteStuff?stuffId=" + stuffId, null, function (msg) {
									if (msg == 'success') {
										$(ctx).parent('td').parent('tr').remove();
									}
								});
							} else {
								$(ctx).parent('td').parent('tr').remove();
							}
//									$(this).parent('td').parent('tr').remove();
							rename_2();
						});

						$('#addfile').live('click', function () {
							var tr = '<tr>' +
									'<td><input type="file" name=""></td>' + z
							'<td><input type="text" name="name"></td>' +
							'<td><button type="button" class="btn btn-default backAdd_4">删除</button></td>' +
							'</tr>';
							$('#fileitem').append(tr);
						});
						$('.backAdd_4').live('click', function () {
							$(this).parent('td').parent('tr').remove();
						});
					});
					function rename_2() {
						var i = 0;
						$('#stuffitem tr').each(function () {
							//alert('');
							$(this).children('td').children('.input-mini').attr('name', 'stuffList[' + i + '].weight');
							$(this).children('td').children('.s_name').attr('name', 'stuffList[' + i + '].name');
							$(this).children('td').children('.s_type').attr('name', 'stuffList[' + i + '].type');
							$(this).children('td').children('.s_content').attr('name', 'stuffList[' + i + '].content');
							$(this).children('td').children('.stufitem').children('.stufile').attr('name', 'nNamebsStuffs[' + i + '].file');
							$(this).children('td').children('.stufitem').children('.ostufile').attr('name', 'oNamebsStuffs[' + i + '].file');
							$(this).children('td').children('a').children('input[type=file]').attr('id', 'bsStuffsFile_' + i + '');
							$(this).children('td').children('.s_desc').attr('name', 'stuffList[' + i + '].necessityDesc');
							$(this).children('td').children('label').children('.stype0').attr('name', 'stuffList[' + i + '].submitTypeArr[0]');
							$(this).children('td').children('label').children('.stype1').attr('name', 'stuffList[' + i + '].submitTypeArr[1]');

							//appFile
							$(this).children('td').children('input[name=appFile]').attr('id', 'bsStuffsFile_' + i);
							//stufile:bsStuffs[' + _index + '].stuffFiles[' + _index + '].pathName
							$(this).children('td').children('.stufile').attr('name', 'stuffList[' + i + '].stuffFiles[' + i + '].pathName');
							$(this).children('td').children('.ostufile').attr('name', 'stuffList[' + i + '].stuffFiles[' + i + '].stuffName');
							i++;
						});
					}
				</script>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收费明细:</label>

			<div class="controls">
				<table class="table table-bordered">
					<thead>
					<tr>
						<td colspan="5">
							<button type="button" class="btn btn-default" id="addCharge">增加收费项目</button>
						</td>
					</tr>
					<tr>
						<th>明细标题</th>
						<th>收费</th>
						<th>法律依据</th>
						<th></th>
					</tr>
					</thead>
					<tbody id="chargeitem">
					<c:if test="${!empty bsBasicinfo.chargeList}">
						<c:forEach items="${bsBasicinfo.chargeList}" var="charge" varStatus="status">
							<tr>
								<td>
									<input type="hidden" name="chargeList[${status.index}].id" value="${charge.id}">
									<input type="hidden" name="chargeList[${status.index}].baseId"
										   value="${charge.baseId}">
									<html:input path="chargeList[${status.index}].title" htmlEscape="false"
												cssClass="input-xlarge c_title required" maxlength="200"/>
								</td>
								<td>
									<html:input path="chargeList[${status.index}].charge" htmlEscape="false"
												cssClass="input-xlarge c_charge required" maxlength="100"/>
								</td>
								<td>
									<html:input path="chargeList[${status.index}].cDescribe" htmlEscape="false"
												cssClass="input-xlarge c_describe required" maxlength="100"/>
								</td>
								<td>
									<button type="button" class="btn btn-default backAdd_3">删除</button>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
			</div>
			<script>
				$(function () {
					$('#addCharge').on('click', function () {
						var _len = $("#chargeitem tr").length + 1;
						var tr = '<tr>' +
								'<td>' +
								'<input type="text" name="chargeList[' + _len + '].title" class="input-xlarge c_title required" maxlength="200">' +
								'</td>' +
								'<td>' +
								'<input type="text" name="chargeList[' + _len + '].charge" class="input-xlarge c_charge required" maxlength="100">' +
								'</td>' +
								'<td>' +
								'<input type="text" name="chargeList[' + _len + '].cDescribe" class="input-xlarge c_describe required" maxlength="500">' +
								'</td>' +
								'<td>' +
								'<button type="button" class="btn btn-default backAdd_3">删除</button>' +
								'</td>' +
								'</tr>';
						$('#chargeitem').append(tr);
						rename_3();
					});
					$('.backAdd_3').live('click', function () {
						var cobj = $(this);
						if ($(cobj).parent('td').parent('tr').find('input[type=hidden]').html() !== null) {
							var id = $(this).parent('td').parent('tr').find('input[type=hidden]').val();
							$.get("${ctx}/bs/bsBasicinfo/deleteCharge?id=" + id, null, function (msg) {
								if (msg == 'success') {
									$(cobj).parent('td').parent('tr').remove();
								}
							});
						} else {
							$(cobj).parent('td').parent('tr').remove();
						}
						rename_3();
					});
				});
				function rename_3() {
					var i = 0;
					$('#chargeitem tr').each(function () {
						$(this).children('td').children('.c_title').attr('name', 'chargeList[' + i + '].title');
						$(this).children('td').children('.c_charge').attr('name', 'chargeList[' + i + '].charge');
						$(this).children('td').children('.c_describe').attr('name', 'chargeList[' + i + '].cDescribe');
						i++;
					});
				}
			</script>
		</div>


		<div class="control-group">
			<label class="control-label">办理流程:</label>

			<div class="controls">
				<html:hidden path="flow.id"></html:hidden>
				<form:textarea id="flow" htmlEscape="false" path="flow.content" rows="4" class="input-xlarge"/>
				<sys:ckeditor replace="flow" uploadPath="/bs/flow"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">法律依据:</label>

			<div class="controls">
				<html:hidden path="law.id"></html:hidden>
				<form:textarea id="law" htmlEscape="false" path="law.content" rows="4" maxlength="200"
							   class="input-xlarge"/>
				<sys:ckeditor replace="law" uploadPath="/bs/law"/>
			</div>
		</div>

		<shiro:hasPermission name="cms:article:audit">
			<div class="control-group">
				<label class="control-label">发布状态:</label>
				<div class="controls">
					<form:radiobuttons path="delFlag" items="${fns:getDictList('cms_del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
					<span class="help-inline"></span>
				</div>
			</div>
		</shiro:hasPermission>
		<div class="form-actions">
			<shiro:hasPermission name="cms:article:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保存"/>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>

	<script type="text/javascript" src="${ctxStatic}/js/ajaxfileupload.js"></script>
</body>
</html>