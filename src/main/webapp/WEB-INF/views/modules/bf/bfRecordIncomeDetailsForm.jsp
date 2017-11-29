<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/3/27
  Time: 9:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>收入登记</title>
	<link rel="stylesheet" href="${ctxStatic}/pgfp/css/fpRecord.css"/>
	<link rel="stylesheet" href="${ctxStatic}/pgfp/css/WdatePicker.css"/>
	<link rel="stylesheet" href="${ctxStatic}/pgfp/css/bootstrap.min.css"/>
	<script src="${ctxStatic}/pgfp/js/vue.min.js"></script>
	<script src="${ctxStatic}/jquery/jquery-1.8.3.js"></script>
	<script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
	<script src="${ctxStatic}/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function() {
		//$("#name").focus();e
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
<div class="wrapper" style="max-width: 900px" id="app">
	<div class="header">
		<h1>贫困户收入登记表</h1>
	<form:form id="inputForm" modelAttribute="bfRecordIncomeDetails" action="${ctx}/bf/bfRecordIncomeDetails/save" method="post" class="form-horizontal">
		<sys:message content="${messages}"/>
		<form:hidden class="id" path="id"/>
		<form:hidden class="regCardId" path="bfRecordIncome.regCardId"/>
		<form:hidden class="hidPath" path="recordIncomeId"/>
		
		<div>
			<span style="float: left;">单位（元）</span>

			<li style="text-align: center;list-style: none">
				<div class="controls" style="margin-left: 0">

				<%--<input style="width: 60px" name="bfRecordIncome.years" id="bfRecordIncome.years" type="text"  maxlength="20" class="selYear input-medium Wdate required"--%>
					   <%--value="<fmt:formatDate value="${bfRecordIncomeDetails.yearDate}" pattern="yyyy"/>"--%>
					   <%--onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/><label style="display: inline-block">年</label>--%>
					<input type="text" style="width: 60px;" name="year" value="${bfRecordIncomeDetails.bfRecordIncome.years}" disabled/>
					<input type="hidden" id="disyear" name="bfRecordIncome.years" value="${bfRecordIncomeDetails.bfRecordIncome.years}"/>
					<label style="display: inline-block">年</label>
					<form:select path="month" id="month" style="width: 60px">
						<%--<form:option value="">--</form:option>--%>
						<form:option value="1">1</form:option>
						<form:option value="2">2</form:option>
						<form:option value="3">3</form:option>
						<form:option value="4">4</form:option>
						<form:option value="5">5</form:option>
						<form:option value="6">6</form:option>
						<form:option value="7">7</form:option>
						<form:option value="8">8</form:option>
						<form:option value="9">9</form:option>
						<form:option value="10">10</form:option>
						<form:option value="11">11</form:option>
						<form:option value="12">12</form:option>
					</form:select>
					<label style="display: inline-block">月</label>
					<input id="messageQuery" class="btn btn-default" type="button" value="点击查询" style="background: #6196bb;color: #fff;text-shadow: none;margin-left: 50px;"/>
					</div>
			</li>
		</div>
		<div class="receipts-table">
			家庭总收入:<span id="totalFamilyIncome"></span><br>
			家庭纯收入:<span id="pureIncome"></span><br>
			<table cellspacing="0" style="margin-bottom: 40px;">
				<tr>
					<td colspan="4" style="text-align: center"><span>一、经营性收入</span></td>
				</tr>
				<tr>
					<td colspan="4" style="text-align: left"><span>1、种植业收入</span></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>粮食类</span></td>
					<td><form:input id="o11Rice" path="o11Rice" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span>水果类</span></td>
					<td><form:input id="o11Fruits" path="o11Fruits" htmlEscape="false" class="input-xlarge decimal"/></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>蔬菜类</span></td>
					<td><form:input id="o11Vegetables" path="o11Vegetables" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span>其他</span></td>
					<td><form:input id="o11Other" path="o11Other" htmlEscape="false" class="input-xlarge decimal"/></td>
				</tr>
				<tr>
					<td colspan="4" style="text-align: left"><span>2、林业收入</span></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>木材类</span></td>
					<td><form:input id="o12Wood" path="o12Wood" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span>其他</span></td>
					<td><form:input id="o12Other" path="o12Other" htmlEscape="false" class="input-xlarge decimal"/></td>
				</tr>
				<tr>
					<td colspan="4" style="text-align: left"><span>3、养殖业收入</span></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>水产养殖</span></td>
					<td><form:input id="o13Aquatic" path="o13Aquatic" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span>特色养殖</span></td>
					<td><form:input id="o13Characteristic" path="o13Characteristic" htmlEscape="false" class="input-xlarge decimal"/></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>畜牧养殖</span></td>
					<td><form:input id="o13Graziery" path="o13Graziery" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span></span></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="4" style="text-align: left"><span>4、其他收入</span></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>其他收入</span></td>
					<td><form:input id="o14Other" path="o14Other" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span></span></td>
					<td></td>
				</tr>
				
				<tr>
					<td colspan="4" style="text-align: center"><span>二、工资性收入（劳务收入）</span></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>乡镇内务工</span></td>
					<td><form:input id="workerInTown" path="workerInTown" htmlEscape="false" class="input-xlarge int"/><label for="">人</label><form:input path="o2WorkerInTown" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span>乡外县内务工</span></td>
					<td><form:input id="workerInCountyTownship" path="workerInCountyTownship" htmlEscape="false" class="input-xlarge int"/><label for="">人</label><form:input path="o2WorkerInCountyTownship" htmlEscape="false" class="input-xlarge decimal"/></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>区内县外务工</span></td>
					<td><form:input id="workerInCounty" path="workerInCounty" htmlEscape="false" class="input-xlarge int"/><label for="">人</label><form:input path="o2WorkerInCounty" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span>区外务工</span></td>
					<td><form:input id="workerOutCounty" path="workerOutCounty" htmlEscape="false" class="input-xlarge int"/><label for="">人</label><form:input path="o2WorkerOutCounty" htmlEscape="false" class="input-xlarge decimal"/></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>其他</span></td>
					<td><form:input id="workerInOtherArea" path="workerInOtherArea" htmlEscape="false" class="input-xlarge int"/><label for="">人</label><form:input path="o2WorkerInOtherArea" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span></span></td>
					<td></td>
				</tr>
				
				<tr>
					<td colspan="4" style="text-align: center"><span>三、财产性收入</span></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>土地流转收入</span></td>
					<td><form:input id="o31LandTransferIncome" path="o31LandTransferIncome" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span>红利收入</span></td>
					<td><form:input id="o32Income" path="o32Income" htmlEscape="false" class="input-xlarge decimal"/></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>其他收入</span></td>
					<td><form:input id="o33OtherIncome" path="o33OtherIncome" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span></span></td>
					<td></td>
				</tr>
				
				<tr>
					<td colspan="4" style="text-align: center"><span>四、政策性收入（转移性收入）</span></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>扶贫补贴</span></td>
					<td><form:input id="o41PovertySubsidy" path="o41PovertySubsidy" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span>教育培训补贴</span></td>
					<td><form:input id="o42AducationSubsidy" path="o42AducationSubsidy" htmlEscape="false" class="input-xlarge decimal"/></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>民政补贴（养老金、高龄补贴等）</span></td>
					<td><form:input id="o43CivilSubsidy" path="o43CivilSubsidy" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span>医疗卫生补贴</span></td>
					<td><form:input id="o44MedicalSubsidy" path="o44MedicalSubsidy" htmlEscape="false" class="input-xlarge decimal"/></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>农业补贴</span></td>
					<td><form:input id="o45AgriSubsidy" path="o45AgriSubsidy" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span>林业补贴</span></td>
					<td><form:input id="o46ForestrySubsidy" path="o46ForestrySubsidy" htmlEscape="false" class="input-xlarge decimal"/></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>水库移民补贴</span></td>
					<td><form:input id="o47ResettlementSubsidy" path="o47ResettlementSubsidy" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span>残疾人补贴</span></td>
					<td><form:input id="o48DisabilitySubsidy" path="o48DisabilitySubsidy" htmlEscape="false" class="input-xlarge decimal"/></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>其他补贴</span></td>
					<td><form:input id="o49OtherSubsidy" path="o49OtherSubsidy" htmlEscape="false" class="input-xlarge decimal"/></td>
					<td class="bg-f5"><span></span></td>
					<td></td>
				</tr>
				
				<tr>
					<td colspan="4" style="text-align: center"><span>五、其他收入</span></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>类别</span></td>
					<td><form:input id="o5Type" path="o5Type" htmlEscape="false" class="input-xlarge"/></td>
					<td class="bg-f5"><span>收入</span></td>
					<td><form:input id="o5OtherIncome" path="o5OtherIncome" htmlEscape="false" class="input-xlarge decimal"/></td>
				</tr>
				
				<tr>
					<td colspan="4" style="text-align: center"><span>六、家庭总收入（一至五项合计）</span></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>合计</span></td>
					<td><span id="o6TotalFamilyIncome"></span></td>
					<td class="bg-f5"><span></span></td>
					<td></td>
				</tr>
				
				<tr>
					<td colspan="4" style="text-align: center"><span>七、生产经营费用支出</span></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>种植业</span></td>
					<td><form:input id="o71Planting" path="o71Planting" htmlEscape="false" class="input-xlarge "/></td>
					<td class="bg-f5"><span>林业</span></td>
					<td><form:input id="o72Forestry" path="o72Forestry" htmlEscape="false" class="input-xlarge "/></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>养殖业</span></td>
					<td><form:input id="o73Breed" path="o73Breed" htmlEscape="false" class="input-xlarge "/></td>
					<td class="bg-f5"><span>其他</span></td>
					<td><form:input id="o74Other" path="o74Other" htmlEscape="false" class="input-xlarge "/></td>
				</tr>
				
				<tr>
					<td colspan="4" style="text-align: center"><span>八、家庭纯收入（第六项减第七项）</span></td>
				</tr>
				<tr>
					<td class="bg-f5"><span>小计</span></td>
					<td><span id="o8PureIncome"></span></td>
					<td class="bg-f5"><span></span></td>
					<td></td>
				</tr>
			</table>
		</div>
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" style="float: right;margin-bottom: 40px;">
	</form:form>
	</div>
</div>
<script>
	function pf(num) {
		return parseFloat(num)
	}
	
	
	$(document).ready(function(){
		
		//点击查询
		$("#messageQuery").click(function(){
			//alert("1");
			var regCardId = $('.regCardId').val();
//			var years = $dp.cal.date.y;
			var years = $("#disyear").val();
			var month = $("#month").val();
			
			$.ajax({
				url:'${ctx}/bf/bfRecordIncomeDetails/getMessage',
				data:{regCardId:regCardId,years:years,month:month},
				dataType:'json',
				type:'post',
				success:function(data){
					console.log(data)
					if(data != null) {
						console.trace()
						if(confirm("数据库中已有该月信息，是否使用该数据？")){
							//window.location.href = "${ctx}/record/countryBasic/toHref?id="+countryBasicId;
							$('#o11Rice').val(data['o11Rice']);
							$('#o11Fruits').val(data['o11Fruits']);
							$('#o11Vegetables').val(data['o11Vegetables']);
							$('#o11Other').val(data['o11Other']);
							$('#o12Wood').val(data['o12Wood']);
							$('#o12Other').val(data['o12Other']);
							$('#o13Aquatic').val(data['o13Aquatic']);
							$('#o13Characteristic').val(data['o13Characteristic']);
							$('#o13Graziery').val(data['o13Graziery']);
							$('#o14Other').val(data['o14Other']);
							$('#workerInTown').val(data['workerInTown']);
							$('#o2WorkerInTown').val(data['o2WorkerInTown']);
							$('#workerInCountyTownship').val(data['workerInCountyTownship']);
							$('#o2WorkerInCountyTownship').val(data['o2WorkerInCountyTownship']);
							$('#workerInCounty').val(data['workerInCounty']);
							$('#o2WorkerInCounty').val(data['o2WorkerInCounty']);
							$('#workerOutCounty').val(data['workerOutCounty']);
							$('#o2WorkerOutCounty').val(data['o2WorkerOutCounty']);
							$('#workerInOtherArea').val(data['workerInOtherArea']);
							$('#o2WorkerInOtherArea').val(data['o2WorkerInOtherArea']);
							$('#o31LandTransferIncome').val(data['o31LandTransferIncome']);
							$('#o32Income').val(data['o32Income']);
							$('#o33OtherIncome').val(data['o33OtherIncome']);
							$('#o41PovertySubsidy').val(data['o41PovertySubsidy']);
							$('#o42AducationSubsidy').val(data['o42AducationSubsidy']);
							$('#o43CivilSubsidy').val(data['o43CivilSubsidy']);
							$('#o44MedicalSubsidy').val(data['o44MedicalSubsidy']);
							$('#o45AgriSubsidy').val(data['o45AgriSubsidy']);
							$('#o46ForestrySubsidy').val(data['o46ForestrySubsidy']);
							$('#o47ResettlementSubsidy').val(data['o47ResettlementSubsidy']);
							$('#o48DisabilitySubsidy').val(data['o48DisabilitySubsidy']);
							$('#o49OtherSubsidy').val(data['o49OtherSubsidy']);
							$('#o5Type').val(data['o5Type']);
							$('#o5OtherIncome').val(data['o5OtherIncome']);
							$('#o6TotalFamilyIncome').text(data['o6TotalFamilyIncome']);
							$('#o71Planting').val(data['o71Planting']);
							$('#o72Forestry').val(data['o72Forestry']);
							$('#o73Breed').val(data['o73Breed']);
							$('#o74Other').val(data['o74Other']);
							$('#o8PureIncome').text(data['o8PureIncome']);
							
							$('#totalFamilyIncome').text(data['o6TotalFamilyIncome']);
							$('#pureIncome').text(data['o8PureIncome']);
							
							$('#').val(data['']);
						}
						$('.id').val(data['id']);
					}
					else{
						if(confirm("数据库中没有该月信息，是否刷新该页面？")){
							//window.location.href = "${ctx}/record/countryBasic/toHref?id="+countryBasicId;
							$('#o11Rice').val("");
							$('#o11Fruits').val("");
							$('#o11Vegetables').val("");
							$('#o11Other').val("");
							$('#o12Wood').val("");
							$('#o12Other').val("");
							$('#o13Aquatic').val("");
							$('#o13Characteristic').val("");
							$('#o13Graziery').val("");
							$('#o14Other').val("");
							$('#workerInTown').val("");
							$('#o2WorkerInTown').val("");
							$('#workerInCountyTownship').val("");
							$('#o2WorkerInCountyTownship').val("");
							$('#workerInCounty').val("");
							$('#o2WorkerInCounty').val("");
							$('#workerOutCounty').val("");
							$('#o2WorkerOutCounty').val("");
							$('#workerInOtherArea').val("");
							$('#o2WorkerInOtherArea').val("");
							$('#o31LandTransferIncome').val("");
							$('#o32Income').val("");
							$('#o33OtherIncome').val("");
							$('#o41PovertySubsidy').val("");
							$('#o42AducationSubsidy').val("");
							$('#o43CivilSubsidy').val("");
							$('#o44MedicalSubsidy').val("");
							$('#o45AgriSubsidy').val("");
							$('#o46ForestrySubsidy').val("");
							$('#o47ResettlementSubsidy').val("");
							$('#o48DisabilitySubsidy').val("");
							$('#o49OtherSubsidy').val("");
							$('#o5Type').val("");
							$('#o5OtherIncome').val("");
							$('#o6TotalFamilyIncome').text("");
							$('#o71Planting').val("");
							$('#o72Forestry').val("");
							$('#o73Breed').val("");
							$('#o74Other').val("");
							$('#o8PureIncome').text("");

							$('#totalFamilyIncome').text("");
							$('#pureIncome').text("");
							
							$('#').val("");
							
						}
						
					}
				}
			})
		})
	})
	
	$('.selYear').blur(function(){
//		console.log("test!")
	})
	new Vue({
		el:'#app',
		data:{
			zz_ls:'1.05152',// 一、经营性收入 种植
			zz_sg:'2',// 水果
			zz_sc:'3',// 蔬菜
			zz_qt:'4',// 其他
			ly_mc:'5',// 木材
			ly_qt:'6',// 其他
			yz_sc:'7',// 水产
			yz_ts:'8',// 特色
			yz_xm:'9',// 畜牧
			qt_qt:'10',// 其他
			gz_xz:'11',// 二、工资性收入 乡镇内
			gz_xz_peo:'',// 乡镇内人数
			gz_xw:'12',// 乡外县内
			gz_xw_peo:'',// 乡外县内人数
			gz_qn:'13',// 区内县外
			gz_qn_peo:'',// 区内县外人数
			gz_qw:'14',// 区外
			gz_qw_peo:'',// 区外人数
			gz_qt:'15',// 其他
			gz_qt_peo:'',// 其他人数
			cc_td:'16',// 三、财产性收入 土地
			cc_hl:'17',// 红利
			cc_qt:'18',// 其他
			sc_zz:'19',// 五、生产经营费用支出 种植
			sc_ly:'20',// 林业
			sc_yz:'21',// 养殖
			sc_qt:'22'// 其他

		},
		computed:{
			total:function(){// 四、家庭总收入
				return (pf(this.zz_ls)+pf(this.zz_sg)+pf(this.zz_sc)+pf(this.zz_qt)+pf(this.ly_mc)+pf(this.ly_qt)+pf(this.yz_sc)+
				pf(this.yz_ts)+pf(this.yz_xm)+pf(this.qt_qt)+pf(this.gz_xz)+pf(this.gz_xw)+pf(this.gz_qn)+pf(this.gz_qw)+
				pf(this.gz_qt)+pf(this.cc_hl)+pf(this.cc_qt)).toFixed(2);
			},
			profit:function () {// 五、家庭纯收入
				return (this.total-pf(this.sc_zz)-pf(this.sc_ly)-pf(this.sc_yz)-pf(this.sc_qt)).toFixed(2);
			}
		}
	})
</script>
</body>
</html>
