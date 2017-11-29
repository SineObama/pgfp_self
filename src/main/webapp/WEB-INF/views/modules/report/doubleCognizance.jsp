<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>贫困户脱贫摘帽“双认定”分析表</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
    <script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
    <link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
    <script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
    <script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
    <script type="text/javascript">
       
    </script>
    <style type="text/css">
        .noBlock {
            background-color: #FFFFFF !important;
            border: 0px #FFFFFF !important;
        }

        .tr td {
            text-align: center !important;
            min-width: 80px !important;
        }

        .subTitle {
            border: 1px solid #cccccc;

        }

        .subTitle td {
            text-align: center;
            font-size: 16px;
            font-weight: bolder;
        }

        .record td {
            min-width: 80px !important;
        }

        .delBtn {
            text-align: center !important;
        }
        
        .line-bottom{
        	border-bottom:1px solid black;
        }
        
        .margin-left{
        	margin-left:60px;
        }
        
        .all-border{
        	border:1px solid black;
        	width:40px;
        	height:24px;
        	margin:3px;
        }
        
        .text-center{
        	text-align:center !important;
        }
        
        .font-style-header{
        	font-size: 16px;
    		font-weight: bold;
        }
         .font-light-content{
        	font-size: 14px;
    		font-weight: bold;
        }
		span{
			padding: 0 2px;
		}
    </style>
</head>
<body>
<br/>
<div style="font-size: 20px;color: #4882ab;font-weight: bold;">
  <center>贫困户脱贫摘帽“双认定”分析表</center>
</div>
<div class="content tabs f-clear">
	<center>
	    <div class="content-detail" style="max-width:1200px !important;float:none !important;border-left:none !important;margin-bottom:20px;">
	            <br/>
	            <table class="noBlock" style="width:100% !important;">
	                <tbody id="accpitem" class="accpitem">
	                <tr class="noBlock">
	                    <td colspan="4" class="noBlock">
	                    	<span class="margin-left">${eightHaveOneOver.basePoorerRegCard.address}</span>
	                    	<%--<span class="line-bottom" style="padding:2px 10px;">大平瑶族</span>乡--%>
	                    	<%--<span class="line-bottom" style="padding:2px 10px;">大平</span>村民小组自然村屯--%>
	                    	<%--<span class="line-bottom" style="padding:2px 10px;">大平村平街村屯桂新村民小组自然村</span>屯--%>
	                    		
	                    	<span class="margin-left">户主：</span><span class="line-bottom" style="padding:2px 10px;">${eightHaveOneOver.basePoorerRegCard.houseHolderName}</span>
	                    	<span class="margin-left">人口：</span><span class="line-bottom" style="padding:2px 10px;">${eightHaveOneOver.basePoorerRegCard.memberNumber}</span><span>人</span>
	                    	<span class="margin-left">预计脱贫年度:</span><span class="line-bottom" style="padding:2px 10px;">${eightHaveOneOver.basePoorerRegCard.povertyExpected}</span><span>年</span>
	                    </td>
	                </tr>
	                <tr class="tr">
	                    <td width="30px;" class="font-style-header">序号</td>
	                    <td class="font-style-header">托贫指标</td>
	                    <td class="font-style-header">验收标准</td>
	                    <td width="300px;" class="font-style-header">分析情况</td>
	                </tr>
	                <tr class="record bg-white">
	                    <td class="text-center">1</td>
	                    <td class="text-center font-light-content">
	                    	有收入来源
	                    </td>
	                    <td>
	                    	（1）有劳动能力的家庭，具备下列条件之一的视为达标：
		                    	①人均耕地0.5亩以上（含）,或人均旱地1亩以上（含），或人均经济林地1.5亩以上（含），或人均山林地5亩以上（含），通过耕作或流转获得了稳定的收入；
		                    	②有经营场地（铺面）等，获得稳定的资产收入；
		                    	③养殖有一定规模，获得稳定的收入；
		                    	④家庭成员中有外出务工半年以上或者自主创业,获得稳定的收入；
		                    	⑤有其他稳定的收入。
							<br>
								完全或部分丧失劳动能力、生活自理能力的家庭，享受农村低保政策（获得A类或B类低保金），有最低生活保障，视为有稳定的收入。
		                    <br>
	                    	（2）不愁吃不愁穿。通过生产经营或购买获得主粮、副食、衣物，能满足日常生活需求。
						</td>
						<form:form id="inputForm" modelAttribute="eightHaveOneOver" action="${ctx}/report/eightHaveOneOver/save" method="post" class="form-horizontal">
	                    <td>
							达标<span><form:checkbox path="incomeSta" value="1"/></span>
							【1.收入来源：<span ><form:checkbox path="incomeSta" value="1"/></span>人均水田0.5亩以上（含），或人均旱地1亩以上（含），或人均经济林地1.5亩以上（含），或人均山林地5亩以上（含），通过耕作或流转获得了稳定的收入；
							<span class="all-border">&nbsp;&nbsp;&nbsp;</span>有经营场地（铺面）等，获得稳定的资产收入；
							<span class="all-border">&nbsp;&nbsp;&nbsp;</span>养殖有一定规模，获得稳定的收入；
							<span class="all-border">&nbsp;&nbsp;&nbsp;</span>家庭成员中有外出务工半年以上或者自主创业,获得稳定的收入；
							<span class="all-border">&nbsp;&nbsp;&nbsp;</span>有其他稳定的收入<span class="line-bottom"></span><br>
							家庭成员享受低保政策（获得A类或B类低保金）的人数、姓名<span class="line-bottom">aaa</span>。
							<br>
							未达标<span class="all-border">&nbsp;&nbsp;<c:if test="${eightHaveOneOver.incomeSta == '0'}">√</c:if><c:if test="${eightHaveOneOver.incomeSta == '1'}">&nbsp;&nbsp;</c:if>&nbsp;</span><span>（原因:</span><span class="line-bottom" style="padding:0 2px;display: inline-block;word-break: break-all">cccccccccccccccccccccccccccccccccccc</span>）。
						</td>
	                </tr>
	                
	                <tr class="record bg-white">
	                    <td class="text-center">2</td>
	                    <td class="text-center font-light-content">
	                    	有住房保障
	                    </td>
	                    <td>
	                    	有转混或砖木或土木或者木制结构的住房，房屋主体稳固安全，无倒塌危险，人均住房面积13平方米（含）以上（包括厅房、厨房、卫生间等生活附属房屋面积）；
	                    	新建且已完成工程量50%（含）以上，半年内可以完工的，视为有住房；
	                    	属于易地扶贫搬迁的贫困户，以县（市、区）人民政府确认的搬迁安置房及面积为准。
						</td>
	                    <td>
							达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.houseSta == '1'}">√</c:if><c:if test="${eightHaveOneOver.houseSta == '0'}">&nbsp;&nbsp;</c:if>&nbsp;</span>,
							未达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.houseSta == '0'}">√</c:if><c:if test="${eightHaveOneOver.houseSta == '1'}">&nbsp;&nbsp;</c:if>&nbsp;</span>
							((达标)(未达标)情况:<p class="line-bottom">无</p>）。
						</td>
	                </tr>
	                
	                <tr class="record bg-white">
	                    <td class="text-center">3</td>
	                    <td class="text-center font-light-content">
	                    	有基本医疗保障
	                    </td>
	                    <td>
	                    	家庭成员均参加新型农村合作医疗保险或城镇居民基本医疗保险。
						</td>
	                    <td>
							达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.medicalSta == '1'}">√</c:if><c:if test="${eightHaveOneOver.medicalSta == '0'}">&nbsp;&nbsp;</c:if>&nbsp;</span>,
							未达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.medicalSta == '0'}">√</c:if><c:if test="${eightHaveOneOver.medicalSta == '1'}">&nbsp;&nbsp;</c:if>&nbsp;</span>
							((达标)(未达标)情况:<p class="line-bottom">无</p>）。
						</td>
	                </tr>	                
	                
	                <tr class="record bg-white">
	                    <td class="text-center">4</td>
	                    <td class="text-center font-light-content">
	                    	有义务教育保障
	                    </td>
	                    <td>
	                    	适龄未成年人可以接受义务教育，没有因贫缀学的适龄未成年人（因重度残疾、精神或者重大疾病原因等不能正常上学的除外）。
						</td>
	                    <td>
							达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.eduSta == '1'}">√</c:if><c:if test="${eightHaveOneOver.eduSta == '0'}">&nbsp;&nbsp;</c:if>&nbsp;</span>,
							未达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.eduSta == '0'}">√</c:if><c:if test="${eightHaveOneOver.eduSta == '1'}">&nbsp;&nbsp;</c:if>&nbsp;</span>
							(原因：有<span class="line-bottom">${eightHaveOneOver.eduReason}</span>个因贫辍学适龄未成年人)
						</td>
	                </tr>	                

	                <tr class="record bg-white">
	                    <td class="text-center">5</td>
	                    <td class="text-center font-light-content">
	                    	有路通村屯
	                    </td>
	                    <td>
	                    	20户（含）以上的自然村（屯）通砂石路（含）以上的路，机动车能同行。
						</td>
	                    <td>
							达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.roadSta == '1'}">√</c:if><c:if test="${eightHaveOneOver.roadSta == '0'}">&nbsp;&nbsp;</c:if>&nbsp;</span>,
							未达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.roadSta == '0'}">√</c:if><c:if test="${eightHaveOneOver.roadSta == '1'}">&nbsp;&nbsp;</c:if>&nbsp;</span>
							((达标)(未达标)情况:<p class="line-bottom">无</p>）。
						</td>
	                </tr>	                
	                
	                <tr class="record bg-white">
	                    <td class="text-center">6</td>
	                    <td class="text-center font-light-content">
	                    	有饮用水
	                    </td>
	                    <td>
	                    	通过打井、水柜、水窖、引用山泉水、自来水等方式解决饮水问题。
						</td>
	                    <td>
							达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.drinkSta == '1'}">√</c:if><c:if test="${eightHaveOneOver.drinkSta == '0'}">&nbsp;&nbsp;</c:if>&nbsp;</span>,
							未达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.drinkSta == '0'}">√</c:if><c:if test="${eightHaveOneOver.drinkSta == '1'}">&nbsp;&nbsp;</c:if>&nbsp;</span>
							((达标)(未达标)情况:<p class="line-bottom">无</p>）。
						</td>
	                </tr>
	                
	                <tr class="record bg-white">
	                    <td class="text-center">7</td>
	                    <td class="text-center font-light-content">
	                    	有电用
	                    </td>
	                    <td>
	                    	家中接通生活用电。
						</td>
	                    <td>
							达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.electSta == '1'}">√</c:if><c:if test="${eightHaveOneOver.electSta == '0'}">&nbsp;&nbsp;</c:if>&nbsp;</span>,
							未达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.electSta == '0'}">√</c:if><c:if test="${eightHaveOneOver.electSta == '1'}">&nbsp;&nbsp;</c:if>&nbsp;</span>
							((达标)(未达标)情况:<p class="line-bottom">无</p>）。
						</td>
	                </tr>	                
	                   
	                <tr class="record bg-white">
	                    <td class="text-center">8</td>
	                    <td class="text-center font-light-content">
	                    	有电视看
	                    </td>
	                    <td>
	                    	家中有电视观看，能收看中央或者广西电视频道，了解党和国家的方针政策、新闻信息。
						</td>
	                    <td>
							达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.tvSta == '1'}">√</c:if><c:if test="${eightHaveOneOver.tvSta == '0'}">&nbsp;&nbsp;</c:if>&nbsp;</span>,
							未达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.tvSta == '0'}">√</c:if><c:if test="${eightHaveOneOver.tvSta == '1'}">&nbsp;&nbsp;</c:if>&nbsp;</span>
							((达标)(未达标)情况:<p class="line-bottom">无</p>）。
						</td>
	                </tr>	                   
	                   
	                <tr class="record bg-white">
	                    <td class="text-center">9</td>
	                    <td class="text-center font-light-content">
	                    	年人均纯收入超过国家扶贫标准
	                    </td>
	                    <td>
	                    	家庭当年人均纯收入超过国家现行扶贫标准（2010年2300元不变价）。家庭年人均收入=[经营性收入+工资性收入（劳务收入）+财产性收入+政策性收入（转移性收入）+其他收入
	                    	-生产经营费用支出]/家庭人口数 。
						</td>
	                    <td>
							达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.perIncome == '1'}">√</c:if><c:if test="${eightHaveOneOver.perIncome == '0'}">&nbsp;&nbsp;</c:if>&nbsp;</span>,
							未达标<span class="all-border">&nbsp;<c:if test="${eightHaveOneOver.perIncome == '0'}">√</c:if><c:if test="${eightHaveOneOver.perIncome == '1'}">&nbsp;&nbsp;</c:if>&nbsp;</span>
							(原因：当年家庭年人均收入<span class="line-bottom" style="padding:2px 20px;">${eightHaveOneOver.income}</span>元)
						</td>
	                </tr>	                   
	                
					<tr class="record bg-white">
						<td class="text-center">&nbsp;</td>
						<td colspan="3">
						<br><br>
							<div>
								<span style="margin-left:30px;">户主签名：</span>
								<span style="margin-left:540px;">帮扶联系人签名：</span>
							</div>
							<div style="margin-top:6px;">
								<span>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
								</span>
								<span style="margin-left:500px;">
									&nbsp;&nbsp;年
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
								</span>
							</div>
							<br><br><br>
						</td>
					</tr>
					</form:form>
	                </tbody>
	            </table>
	
	    </div>
	</center>
</div>



<script>

</script>
</body>

</html>