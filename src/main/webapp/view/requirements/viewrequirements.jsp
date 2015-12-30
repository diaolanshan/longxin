<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>
<style type="text/css">
td {
	white-space: nowrap;
}
.modal .form-control {
    width: 95%;
}
.modal-dialog {
    margin: 30px auto;
    width: 850px;
}
table{
  border-collapse:collapse;
}
#requirementstable td, th{
  border:1px solid black;
}
.form-control{
  font-size: 11px;
  height: 24px;
  padding-top:1px;
}
.form-group {
    margin-bottom: 3px;
    padding-top: 3px;
}
</style>
<script type="text/javascript">
var url;
function showDailog(id){
	url = "./delete/"+id;
	$('#myModal').modal('show');
}
function deleteThis(){
	$.post(url, location.reload());
	$('#myModal').modal('hide');
}
function showUpdateRequirement(requirementId){
	$("#updateRequirementInfo"+requirementId).modal('show');
}
$().ready(function() {
	$("#addrequirementform").validate({
		rules : {
			sequence : {
				required : true,
				minlength : 4,
				remote : {
					url : "./check",
					type : "get",
					contentType: "application/x-www-form-urlencoded; charset=utf-8", 
					data : {
						username : function() {
							return $("#sequence").val();
						}
					}
				}
			},
		},
		messages : {
			sequence : {
				required : "请输入编号",
				minlength : "编号至少包含4个字符",
				remote : "该编号已被使用"
			},
		},
	});
});
</script>
<form:form method="POST" modelAttribute="requirements" role="form"
	class="form-horizontal" id="viewProductForm">
	<table data-toggle="table" data-cache="false"
		data-pagination="true" id="requirementstable" style="font-size:11px">
		<thead>
			<tr>
				<th colspan="2" data-halign="center">需求类别</th>
				<th colspan="4" data-halign="center">原始需求输入<br/>(老产品，工艺过程，客户体验，法规及其他)</th>
				<th colspan="4" data-halign="center">客户/应用输入</th>
				<th colspan="4" data-halign="center">竞争对手输入<br/>(对标数据/使用结果)</th>
				<th colspan="4" data-halign="center">分析比较后我方产品需求(综合内部客户竞争对手的输入)</th>
				<th colspan="6" data-halign="center">需求跟踪</th>
				<th colspan="1" data-halign="center">最终结果</th>
				<th data-halign="center">操作</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td data-halign="center">编号</td>
				<td data-halign="center">需求/规格的名称</td>
				<td data-halign="center">相关文档输入时间</td>
				<td data-halign="center">文档中的原始需求编号</td>
				<td data-halign="center">概述需求<br/>(使用方法和工况)</td>
				<td data-halign="center">数值范围<br/>(负载，温度，时间...)</td>
				<td data-halign="center">客户A</td>
				<td data-halign="center">客户B</td>
				<td data-halign="center">客户C</td>
				<td data-halign="center">客户D</td>
				<td data-halign="center">品牌A</td>
				<td data-halign="center">品牌B</td>
				<td data-halign="center">品牌C</td>
				<td data-halign="center">品牌D</td>
				<td data-halign="center">相关部件和子零件</td>
				<td data-halign="center">分析结果</td>
				<td data-halign="center">概述需求(使用方法和工况)</td>
				<td data-halign="center">数值范围<br/>(负载，温度，时间...)</td>
				<td data-halign="center">跟踪文档</td>
				<td data-halign="center">确认结果</td>
				<td data-halign="center">负责人</td>
				<td data-halign="center">原始计划</td>
				<td data-halign="center">更新计划日期</td>
				<td data-halign="center">关闭日期</td>
				<td data-halign="center">最终结果</td>
				<td>&nbsp;</td>
			</tr>
			<c:forEach var="requirement" items="${requirements}">
				<tr>
					<td data-halign="center">${requirement.sequence}</td>
					<td data-halign="center">${requirement.name}</td>
					<td data-halign="center">${requirement.getDisplayCreateDate()}</td>
					<td data-halign="center">${requirement.originNo}</td>
					<td data-halign="center">${requirement.gRequirement}</td>
					<td data-halign="center">${requirement.valueScope}</td>
					<td data-halign="center">${requirement.customerA}</td>
					<td data-halign="center">${requirement.customerB}</td>
					<td data-halign="center">${requirement.customerC}</td>
					<td data-halign="center">${requirement.customerD}</td>
					<td data-halign="center">${requirement.brandA}</td>
					<td data-halign="center">${requirement.brandB}</td>
					<td data-halign="center">${requirement.brandC}</td>
					<td data-halign="center">${requirement.brandD}</td>
					<td data-halign="center">${requirement.aaComponent}</td>
					<td data-halign="center">${requirement.aaResult}</td>
					<td data-halign="center">${requirement.aaRequirement}</td>
					<td data-halign="center">${requirement.aaScope}</td>
					<td data-halign="center">${requirement.trackDocument}</td>
					<td data-halign="center">${requirement.confirmedResult}</td>
					<td data-halign="center">${requirement.responsible}</td>
					<td data-halign="center">${requirement.originPlan}</td>
					<td data-halign="center">${requirement.getDisplayUpdateDate()}</td>
					<td data-halign="center">${requirement.getDisplayCloseDate()}</td>
					<td data-halign="center">${requirement.finalResult}</td>
					<td><sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')">
						<a href="javascript:void(0);" onclick="showDailog(${requirement.id})" data-toggle="popover" title="删除"><img alt="" src="<%=path%>/images/delete.png"></a>
						<a href="javascript:void(0);" onclick="showUpdateRequirement(${requirement.id})" data-toggle="popover" title="编辑"><img alt="" src="<%=path%>/images/edit.png"></a>
					</sec:authorize>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<br/>
	<input type="button" class="btn btn-primary"  id="addrequirementbutton"
									value="增加新需求"></input>
</form:form>

<c:forEach var="requirement" items="${requirements}">
	<div class="modal fade" id="updateRequirementInfo${requirement.id}" tabindex="-1" role="dialog">
		<form name="updateRequirementForm" id="updateRequirementForm${requirement.id}">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">修改需求</h4>
					</div>
					<div class="modal-body">
						<input type="text" name="id" value="${requirement.id}" style="display:none">
						<table width="100%" border="0" cellpadding="4" cellspacing="0">
							<tr style="background-color:#f5f5f5">
								<td><font size="4px">需求类别</font></td>
								<td>编号：</td>
								<td><div class="form-group">
										<input type="text" name="sequence"  class="form-control" value="${requirement.sequence}">
									</div></td>
								<td>需求/规格的名称：</td>
								<td><div class="form-group">
										<input type="text" name="name" class="form-control" value="${requirement.name}">
									</div></td>
							</tr>
							<tr>
								<td rowspan="2"><font size="4px">原始需求输入</font></td>
								<td>相关文档输入时间：</td>
								<td><div class="form-group">
										<input type="text" name="createDate" class="form-control"
											id="createDate" value="${requirement.createDate }">
									</div></td>
								<td>文档中的原始需求编号：</td>
								<td><div class="form-group">
										<input type="text" name="originNo" class="form-control" value="${requirement.originNo}">
									</div></td>
							</tr>
							<tr>
								<td>概述需求：</td>
								<td><div class="form-group">
										<input type="text" name="gRequirement" class="form-control" value="${requirement.gRequirement}">
									</div></td>
								<td>数值范围：</td>
								<td><div class="form-group">
										<input type="text" name="valueScope" class="form-control" value="${requirement.valueScope}">
									</div></td>
							</tr>
							<tr style="background-color: #f5f5f5">
								<td rowspan="2"><font size="4px">客户/应用输入</font></td>
								<td>客户A：</td>
								<td><div class="form-group">
										<input type="text" name="customerA" class="form-control"  value="${requirement.customerA}">
									</div></td>
								<td>客户B：</td>
								<td><div class="form-group">
										<input type="text" name="customerB" class="form-control" value="${requirement.customerB}">
									</div></td>
							</tr>
							<tr style="background-color: #f5f5f5">
								<td>客户C：</td>
								<td><div class="form-group">
										<input type="text" name="customerC" class="form-control" value="${requirement.customerC}">
									</div></td>
								<td>客户D：</td>
								<td><div class="form-group">
										<input type="text" name="customerD" class="form-control" value="${requirement.customerD}">
									</div></td>
							</tr>
							<tr>
								<td rowspan="2"><font size="4px">竞争对手输入</font></td>
								<td>品牌A：</td>
								<td><div class="form-group">
										<input type="text" name="brandA" class="form-control" value="${requirement.brandA}">
									</div></td>
								<td>品牌B：</td>
								<td><div class="form-group">
										<input type="text" name="brandB" class="form-control" value="${requirement.brandB}">
									</div></td>
							</tr>
							<tr>
								<td>品牌C：</td>
								<td><div class="form-group">
										<input type="text" name="brandC" class="form-control" value="${requirement.brandC}">
									</div></td>
								<td>品牌D：</td>
								<td><div class="form-group">
										<input type="text" name="brandD" class="form-control" value="${requirement.brandD}">
									</div></td>
							</tr>
							<tr style="background-color: #f5f5f5">
								<td rowspan="2"><font size="4px">分析比较后<br />我方产品需求
								</font></td>
								<td>相关部件和子零件：</td>
								<td><div class="form-group">
										<input type="text" name="aaComponent" class="form-control" value="${requirement.aaComponent}">
									</div></td>
								<td>分析结果：</td>
								<td><div class="form-group">
										<input type="text" name="aaResult" class="form-control" value="${requirement.aaResult}">
									</div></td>
							</tr>
							<tr style="background-color: #f5f5f5">
								<td>概述需求：</td>
								<td><div class="form-group">
										<input type="text" name="aaRequirement" class="form-control" value="${requirement.aaRequirement}">
									</div></td>
								<td>数值范围：</td>
								<td><div class="form-group">
										<input type="text" name="aaScope" class="form-control" value="${requirement.aaScope}">
									</div></td>
							</tr>
							<tr>
								<td rowspan="3"><font size="4px">需求跟踪</font></td>
								<td>跟踪文档：</td>
								<td><div class="form-group">
										<input type="text" name="trackDocument" class="form-control" value="${requirement.trackDocument}">
									</div></td>
								<td>确认结果：</td>
								<td><div class="form-group">
										<input type="text" name="confirmedResult" class="form-control" value="${requirement.confirmedResult}">
									</div></td>
							</tr>
							<tr>
								<td>负责人：</td>
								<td><div class="form-group">
										<input type="text" name="responsible" class="form-control" value="${requirement.responsible}">
									</div></td>
								<td>原始计划：</td>
								<td><div class="form-group">
										<input type="text" name="originPlan" class="form-control" value="${requirement.originPlan}">
									</div></td>
							</tr>
							<tr>
								<td>更新计划日期：</td>
								<td><div class="form-group">
										<input type="text" name="updateDate" class="form-control" value="${requirement.updateDate}">
									</div></td>
								<td>关闭日期：</td>
								<td><div class="form-group">
										<input type="text" name="closeDate" class="form-control" value="${requirement.closeDate}">
									</div></td>
							</tr>
							<tr>
								<td><font size="4px">最终结果</font></td>
								<td>最终结果：</td>
								<td colspan="3"><div class="form-group">
										<input type="text" name="finalResult" class="form-control" value="${requirement.finalResult}">
									</div></td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<input type="button" value="保存" id="updaterequirement"
							onclick="javascript:updateRequirement(${requirement.id},${requirement.product.id });"
							class="btn btn-primary"> <input type="button" value="取消"
							class="btn btn-primary closeForm" data-dismiss="modal">
					</div>
				</div>
			</div>
		</form>
	</div>
</c:forEach>

<div class="modal fade" id="addrequirement" tabindex="-1"
	role="dialog">
	<form:form id="addrequirementform">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">增加需求</h4>
				</div>
				<div class="modal-body">
					<table width="100%" border="0" cellpadding="4" cellspacing="0">
						<tr style="background-color:rgb(176,176,176)">
							<td><font size="4px">需求类别</font></td>
							<td>编号：</td>
							<td><div class="form-group"><input type="text" id="sequence" name="sequence" class="form-control"></div></td>
							<td>需求/规格的名称：</td>
							<td><div class="form-group"><input type="text" name="name" class="form-control"></div></td>
						</tr>
						<tr>
							<td rowspan="2"><font size="4px">原始需求输入</font></td>
							<td>相关文档输入时间：</td>
							<td><div class="form-group"><input type="text" name="createDate" class="form-control" id="createDate"></div></td>
							<td>文档中的原始需求编号：</td>
							<td><div class="form-group"><input type="text" name="originNo" class="form-control"></div></td>
						</tr>
						<tr>
							<td>概述需求：</td>
							<td><div class="form-group"><input type="text" name="gRequirement" class="form-control"></div></td>
							<td>数值范围：</td>
							<td><div class="form-group"><input type="text" name="valueScope" class="form-control"></div></td>
						</tr>
						<tr style="background-color:rgb(176,176,176)">
							<td rowspan="2"><font size="4px">客户/应用输入</font></td>
							<td>客户A：</td>
							<td><div class="form-group"><input type="text" name="customerA" class="form-control"></div></td>
							<td>客户B：</td>
							<td><div class="form-group"><input type="text" name="customerB" class="form-control"></div></td>
						</tr>
						<tr style="background-color:rgb(176,176,176)">
							<td>客户C：</td>
							<td><div class="form-group"><input type="text" name="customerC" class="form-control"></div></td>
							<td>客户D：</td>
							<td><div class="form-group"><input type="text" name="customerD" class="form-control"></div></td>
						</tr>
						<tr>
							<td rowspan="2"><font size="4px">竞争对手输入</font></td>
							<td>品牌A：</td>
							<td><div class="form-group"><input type="text" name="brandA" class="form-control"></div></td>
							<td>品牌B：</td>
							<td><div class="form-group"><input type="text" name="brandB" class="form-control"></div></td>
						</tr>
						<tr>
							<td>品牌C：</td>
							<td><div class="form-group"><input type="text" name="brandC" class="form-control"></div></td>
							<td>品牌D：</td>
							<td><div class="form-group"><input type="text" name="brandD" class="form-control"></div></td>
						</tr>
						<tr style="background-color:rgb(176,176,176)">
							<td rowspan="2"><font size="4px">分析比较后<br/>我方产品需求</font></td>
							<td>相关部件和子零件：</td>
							<td><div class="form-group"><input type="text" name="aaComponent" class="form-control"></div></td>
							<td>分析结果：</td>
							<td><div class="form-group"><input type="text" name="aaResult" class="form-control"></div></td>
						</tr>
						<tr style="background-color:rgb(176,176,176)">
							<td>概述需求：</td>
							<td><div class="form-group"><input type="text" name="aaRequirement" class="form-control"></div></td>
							<td>数值范围：</td>
							<td><div class="form-group"><input type="text" name="aaScope" class="form-control"></div></td>
						</tr>
						<tr>
							<td rowspan="3"><font size="4px">需求跟踪</font></td>
							<td>跟踪文档：</td>
							<td><div class="form-group"><input type="text" name="trackDocument" class="form-control"></div></td>
							<td>确认结果：</td>
							<td><div class="form-group"><input type="text" name="confirmedResult" class="form-control"></div></td>
						</tr>
						<tr>
							<td>负责人：</td>
							<td><div class="form-group"><input type="text" name="responsible" class="form-control"></div></td>
							<td>原始计划：</td>
							<td><div class="form-group"><input type="text" name="originPlan" class="form-control"></div></td>
						</tr>
						<tr>
							<td>更新计划日期：</td>
							<td><div class="form-group"><input type="text" name="updateDate" class="form-control"></div></td>
							<td>关闭日期：</td>
							<td><div class="form-group"><input type="text" name="closeDate" class="form-control"></div></td>
						</tr>
						<tr>
							<td style="background-color:rgb(176,176,176)"><font size="4px" >最终结果</font></td>
							<td>最终结果：</td>
							<td colspan="3"><div class="form-group"><input type="text" name="finalResult" class="form-control"></div></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<input type="button" value="保存" id="saverequirement" onclick="javascript:saveNewRequirement(${product.id});"
						class="btn btn-primary"> <input type="button" value="取消"
						class="btn btn-primary closeForm" data-dismiss="modal">
				</div>
			</div>
		</div>
	</form:form>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">确认框</h4>
      </div>
      <div class="modal-body"> 确认要删除？</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="deleteThis()">确定</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>