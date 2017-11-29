<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
  <title>干部表管理</title>
  <meta name="decorator" content="default"/>
  <link rel="stylesheet" href="${ctxStatic}/pgfp/css/fpRecord.css"/>
  <script type="text/javascript">
    function page(n,s){
      $("#pageNo").val(n);
      $("#pageSize").val(s);
      $("#searchForm").submit();
      return false;
    }
    $(function(){
    	 $("#countryButton, #countryName").click(function () {
              // 是否限制选择，如果限制，设置为disabled
              if ($("#countryButton").hasClass("disabled")) {
                return true;
              }
              // 正常打开
              top.$.jBox.open("iframe:/pgfp-1.0/a/tag/treeselect?url=" + encodeURIComponent("/record/country/treeData") + "&module=&checked=&extId=&isAll=", "选择村（屯）", 300, 420, {
                ajaxData: {selectIds: $("#countryId").val()},
                buttons: {"确定": "ok", "清除": "clear", "关闭": true},
                submit: function (v, h, f) {
                  if (v == "ok") {
                    var tree = h.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
                    var ids = [], names = [], nodes = [];
                    if ("" == "true") {
                      nodes = tree.getCheckedNodes(true);
                    } else {
                      nodes = tree.getSelectedNodes();
                    }
                    for (var i = 0; i < nodes.length; i++) {//
                      ids.push(nodes[i].id);
                      names.push(nodes[i].name);//
                      break; // 如果为非复选框选择，则返回第一个选择
                    }
                    $("#countryId").val(ids.join(",").replace(/u_/ig, ""));
                    $("#countryName").val(names.join(","));
                  }//
                  else if (v == "clear") {
                    $("#countryId").val("");
                    $("#countryName").val("");
                  }//
                  if (typeof countryTreeselectCallBack == 'function') {
                    countryTreeselectCallBack(v, h, f);
                  }
                },
                loaded: function (h) {
                  $(".jbox-content", top.document).css("overflow-y", "hidden");
                }
              });
            });
    
    });
  </script>
  

</head>
<body>
<div class="wrap">
  <ul class="nav nav-tabs">
    <li><a href="${ctx}/record/basePoorerRegCard/hou?user=${user}">帮扶户列表</a></li>
    <li class="active"><a href="">贫困户列表</a></li>
  </ul>
  <div class="addPepple-wrap">
	<form:form id="searchForm" modelAttribute="basePoorerRegCard" action="${ctx}/record/basePoorerRegCard/bind?user=${user}" method="post" class="breadcrumb form-search">
      <ul class="ul-form">
          <li style="margin:0px;">
            <label class="control-label">村名:</label>
          </li>
          <li style="margin-left:10px;margin-right:10px;">
            <div class="controls">
              <sys:treeselect id="area" name="country.id" value="${basePoorerRegCard.country.id}" labelName="country.name" labelValue="${basePoorerRegCard.country.name}"
                              title="上级行政区划" url="/sys/area/treeData" extId="${country.id}" cssClass="" allowClear="true"/>
            </div>
		</li>
          <!-- 查询按钮 -->
        <li>
          <input class="btn btn-primary" type="submit" value="查询"/>
        </li>
      </ul>
    </form:form>
  </div>
	  <div class="people-list-wrap">
	  	<div class="table-l">
		    <table cellspacing="0" class="inp_content">
		    	<thead>
			      <tr class="firstTr">
			        <td width="20%"><span>户主姓名</span></td>
			        <td width="20%"><span>所在村</span></td>
			        <td width="15%"><span>致贫原因</span></td>
			        <td width="15%"><span>贫困属性</span></td>
			        <td width="15%"><span>联系电话</span></td>
			        <td><span>门牌号</span></td>
			      </tr>
			     </thead>
		      <%--action="${ctx}/record/basePoorerRegCard/saveBind?user=${user}"--%>
				
				    <c:forEach items="${page.list}" var="basePoorerRegCard">
				      <tr>
				        <td>
				        	<input type="checkbox" data-che="f" id="${basePoorerRegCard.id}" >
				        	<input type="hidden" name="houseId" value="${basePoorerRegCard.houseId}"/>
				        	<span>${basePoorerRegCard.houseHolderName}</span>
				        	<input type="hidden" name="ids" value="${basePoorerRegCard.id}"/>
				        </td>
				        
				        <td><span>${basePoorerRegCard.country.name}</span></td>
				        <td><span>${fns:getDictLabel(basePoorerRegCard.primaryPoorReason,"mainPoorReason","")}</span></td>
				        <td><span>${fns:getDictLabel(basePoorerRegCard.poorerType,"poor_households_attributes","")}</span></td>
				        <td><span>${basePoorerRegCard.mobile}</span></td>
				      <td><span>${basePoorerRegCard.houseNumber}</span></td>
				      </tr>
				     </c:forEach>
				  
		    </table>
		    <div class="pagination">
                <ul>
                    <li class="disabled"><a href="javascript:">« 上一页</a></li>
                    <li class="active"><a href="javascript:">1</a></li>
                    <li class="disabled"><a href="javascript:">下一页 »</a></li>
                    <li class="disabled controls"><a href="javascript:">当前 <input type="text" value="1"
                                                                                  onkeypress="var e=window.event||this;var c=e.keyCode||e.which;if(c==13)page(this.value,30,'');"
                                                                                  onclick="this.select();"> / <input type="text"
                                                                                                                     value="30"
                                                                                                                     onkeypress="var e=window.event||this;var c=e.keyCode||e.which;if(c==13)page(1,this.value,'');"
                                                                                                                     onclick="this.select();">
                        条，共 4 条</a></li>
                </ul>
                <div style="clear:both;"></div>
            </div>
	  </div>
	  <div class="computed">
            <button class="addList">添加 >></button><button class="removeList">移除 <<</button>
      </div>
      <div class="table-r">
      		<form:form id="inputForm" modelAttribute="workForceCadre"
      			action="${ctx}/record/basePoorerRegCard/saveBind?user=${user}"  method="post" class="breadcrumb">
	            <table class="cheTable">
	                <thead>
	                <tr class="firstTr">
	                    <td width="25%"><span>户主姓名</span></td>
				        <td width="20%"><span>所在村</span></td>
				        <td width="15%"><span>致贫原因</span></td>
				        <td width="15%"><span>贫困属性</span></td>
				        <td width="15%"><span>联系电话</span></td>
				        <td><span>门牌号</span></td>
	                </tr>
	                <c:forEach items="${existUser}" var="row">
	                	 <tr>
				        <td>
				        	<input type="checkbox" data-che="f" id="${row.id}" >
				        	<input type="hidden" name="houseId" value="${row.houseId}"/>
				        	<span>${row.houseHolderName}</span>
				        	<input type="hidden" name="ids" value="${row.id}"/>
				        </td>
				        <td><span>${row.country.name}</span></td>
				        <td><span>${fns:getDictLabel(row.primaryPoorReason,"mainPoorReason","")}</span></td>
				        <td><span>${fns:getDictLabel(row.poorerType,"poor_households_attributes","")}</span></td>
				        <td><span>${row.mobile}</span></td>
				        <td><span>${row.houseNumber}</span></td>
				      </tr>
	                </c:forEach>
	                </thead>
	            </table>
	            <div class="pagination">${page}<div class="content-save"><input type="submit" value="保 存" class="save-btn btn btn-primary" id="btnSubmit"/></div></div>
            </form:form>
        </div>
       
       
  </div>
</div>
<script>

  var num = 6;
  var curNum = 0;
  var selArr =[];
  // 返回数组索引
  function returnIndex(el,arr){
    for(var i=0,n=arr.length;i<n;i++){
//      console.log('传入的数组是:'+arr)
      if(arr[i]===el){
        return i
//        console.log('i:'+i)
      }
    }
  }
  $('.people-list-wrap tr:not(:eq(0)) td:first-child input').click(function () {
    if($(this).prop('checked')){
      selArr.push($(this).attr('id'))
//      console.log(selArr)
      curNum++;
    }else{
      var curIndex = returnIndex($(this).attr('id'),selArr);
      selArr.splice(curIndex,1);
      curNum--;
//      console.log('当前索引：'+curIndex)
//      console.log(selArr)
    }
    if(curNum > num){
      alert("最多只能选择"+num+"户！")
    }
//    console.log($(this).prop('checked'))
//    console.log('当前选中：'+curNum)
  })
  $('#btnSubmit').click(function (e) {
    if(curNum > num){
      alert("最多只能选择"+num+"户！")
    }
     
     /* $.ajax({
      traditional: true,
      type:'POST',
      url:"${ctx}/record/basePoorerRegCard/saveBind?user=${user}",
      data:{data:selArr},
      success:function(){
    	  
      } 


    })  */
  })
   var inp_contents = $('.inp_content tr:not(:eq(0)) td:first-child input');
    $('.addList').on('click',function () {
      if(inp_contents.is(':checked')){
        $('.inp_content input[type="checkbox"]:checked').parents('tr')
        $('.cheTable').append($('.inp_content input[type="checkbox"]:checked').parents('tr'))
        $('.inp_content input[type="checkbox"]:checked').parents('tr')
      }
    })
    $('.removeList').on('click',function(){
      if($('.cheTable tr:not(:eq(0)) td:first-child input').is(':checked')){
        $('.cheTable input[type="checkbox"]:checked').parents('tr')
        $('.inp_content').prepend($('.cheTable input[type="checkbox"]:checked').parents('tr'))
      }
    })
  
</script>
</body>
</html>
