<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业行业</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/recruit/css/trade.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="${ctxStatic}/recruit/js/trade.js"></script>
	<script type="text/javascript" src="${ctxStatic}/recruit/js/data.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#trade-right").on("click",'.tlb',function () {
				top.mainFrame.companyIndustryAddOrDel($(this).html());
		    });
			//alert(recruit_hy_data.length);
			buildHyHtml();
			//var j = '01';
			//alert(recruit_hy_data_detail[j]);
		});
		
		function buildHyHtml(){
			var hyHtml = "";
			var hyDetailHtml = "";
	        for(var i=0;i<recruit_hy_data.length;i++){
	        	var data = recruit_hy_data[i];
	        	if(i==0){
	        		hyHtml += "<li class='tl current'>"+data.c+"</li>";
	        	}else{
	        		hyHtml += "<li class='tl'>"+data.c+"</li>";
	        	}
	        	
	        	var hyDetailUlHtml = "";
	        	if(i==0){
	        		hyDetailUlHtml += "<ul class='show'>";
	        	}else{
	        		hyDetailUlHtml += "<ul>";
	        	}
	        	var category = data.category;
	        	for(var j=0;j<category.length;j++){
	        		var categoryId = category[j];
	        		var categoryName = recruit_hy_data_detail[categoryId];
	        		hyDetailUlHtml += "<li class='tlb'>"+categoryName+"</li>";
	        	}
	        	hyDetailUlHtml += "</ul>";
	        	hyDetailHtml += hyDetailUlHtml;
	        }
	        $("#trad-left-ul").empty();
        	$("#trad-left-ul").append(hyHtml);
        	$("#trade-right").empty();
        	$("#trade-right").append(hyDetailHtml);
		}
	</script>
</head>
<body>
	<div>
		<div id="trade-minddle">
        	<div id="trade-left">
            	<ul id="trad-left-ul">
                	<!-- <li class='current'>计算机/互联网/通信/电子</li>
                   	<li>销售</li>
                	<li>计算机/互联网/通信/电子</li>
                    <li>计算机/互联网/通信/电子</li>
                	<li>计算机/互联网/通信/电子</li>
                	<li>计算机/互联网/通信/电子</li>
              		<li>计算机/互联网/通信/电子</li>  -->                 
                </ul>
			</div>
			<div id="trade-right">
	        	<!-- <ul class='show'>
	             	<li>计算机软件</li>
	            	<li>计算机硬件</li>
	            	<li>计算机服务</li>
	            	<li>通信/电信/网络设备</li>
	            	<li>通信/电信/网络设备</li>
	            	<li>通信/电信/网络设备</li>
				</ul>
	 			<ul class=''>
					<li>其他销售</li>
					<li>零售</li>
					<li>批发</li>
					<li>饮食</li>
				</ul> -->
			</div>
    	</div>
	</div>
</body>
</html>