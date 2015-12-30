<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
.form-control {
    width: 70%;
}
</style>
<%  
String path = request.getContextPath();  
%>
<script>
    $(function () {
		$('#searchTable1').bootstrapTable({
			
		}).on('dbl-click-row.bs.table', function (e, row, $element) {
			//location.href="../../l2component/view/"+row.id;
        });
		//file upload
		$("div input").fileupload({
			
		    dataType: 'json',
		    done: function (e, data) {
		    	window.location.reload();
		    },
		    progressall: function (e, data) {
		      var progress = parseInt(data.loaded / data.total * 100, 10);
		      $('#progress .bar').css(
		          'width',
		          progress + '%'
		      );
			}
		});
		
    	$.ajax({
    		type: "GET", 
    		url: "../../filecontroller/get/L1COMPONENT/" + $("#idvalue").val(), 
    		dataType: "json",
    		contentType: "application/json; charset=utf-8",
    		success: function(data){
    			$.each(data, function(idx,item)
    			{
    				var downloadlink = "../../filecontroller/download/" + item.id;
    				var attachment = "<div style='display: inline; width: 10%;float:left; text-align:center' title=" + item.fileName + ">" + "<a href = " + downloadlink + ">" + "<img src='../../images/attachment.png' style='width:40px;border:2px dashed;border-color:#2bc0be'/>" + "</a>" + "<br/>" + item.fileName + "</div>";
    				$("#attachments").append(attachment);
    			}
    			)
    		},
    		error: function(res){
    			alert("Unexpected error! Try again.");
    		}
    	})
	});
    
    function update(){
    	$("#updateForm").modal('show');
    }
    
    function showUpdateParameter(parameterId){
    	$("#updateParameterinfo"+parameterId).modal('show');
    }
    function addL2Component(){
    	$("#addComponentForm").modal('show');
    }
</script>

<form:form method="POST" modelAttribute="component" role="form"
	class="form-horizontal" id="editProductForm">
	<fieldset>
		<legend>
			<a href="<%=path%>/module/view/${component.module.id}" title="返回"><img alt="" src="<%=path%>/images/back.png" style="width:35px"></a>
			${component.name}细节 &nbsp;&nbsp;&nbsp;<a href="../diagram/${component.id}">
				<span title="物理结构图" class="glyphicon glyphicon-indent-left"></span></a> 
			&nbsp;&nbsp;<a href="../functiondiagram/${component.id}">
			<span title="功能结构图" class="glyphicon glyphicon-indent-right"></span></a>
		</legend>
		<div class="form-group">
			<label for="functionName" class="col-sm-3 control-label">功能名称：</label>
			<div class="col-sm-8 control-label">${component.functionName}</div>
		</div>
		<div class="form-group">
			<input type="text" id="idvalue" style="display:none" value="${component.id}">
			<label for="id" class="col-sm-3 control-label">组件描述：</label>
			<div class="col-sm-8 control-label">${component.description}</div>
		</div>
		<c:forEach items="${parameters}" var="parameter">
			<div class="form-group">
				<label for="id" class="col-sm-3 control-label">${parameter.parameterName}：</label>
				<div class="col-sm-5 control-label">
					<c:choose>
						<c:when test="${parameter.isDraft }">
							<div style="width:150px;float:left;display:inline;background-color:#f2dede">${parameter.parameterValue}&nbsp;&nbsp;${parameter.unitName}</div>
						</c:when>
						<c:otherwise>
							<div style="width:150px;float:left;display:inline">${parameter.parameterValue}&nbsp;&nbsp;${parameter.unitName}</div>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${parameter.options == ''}">
							<div style="width: 300px; hefloat: left; display: inline;font-size:11px;color:gray">取值范围(${parameter.minValue},${parameter.maxValue})</div>
						</c:when>
						<c:otherwise>
							<div style="width: 200px; hefloat: left; display: inline;font-size:11px;color:gray">可选值(${parameter.options})</div>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${parameter.scopeStatus}">
							<img alt="取值范围已被论证" src="<%=path%>/images/greenlight.png" style="width:14px;" title="取值范围已被论证">
						</c:when>
						<c:otherwise>
							<img alt="取值范围未被论证" src="<%=path%>/images/redlight.png"  style="width:14px;"  title="取值范围还未被论证">
						</c:otherwise>
					</c:choose>
				</div>
				<div class="col-sm-4 control-label">
					<sec:authorize access="hasRole('ROLE_TECHNICALSUPPORT')">
						<c:if test="${isAllowed=='true'}">
							<a href="#" data-toggle="popover"><label for="fileupload${parameter.id}" class="glyphicon glyphicon-upload" aria-hidden="true" title="上传文件"></label>
							<input id="fileupload${parameter.id}" type="file" name="files[]" style="display:none" data-url="../../filecontroller/upload/L1COMPONENTPARAMETER/${parameter.id}"></input></a>
						</c:if>
					</sec:authorize>
					<a href="javascript:void(0);" onclick="showParameterAttachments(${parameter.id}, '${parameter.category}')" data-toggle="popover" title="下载文件"><span class="glyphicon glyphicon-download" aria-hidden="true"></span></a>
					<sec:authorize access="hasRole('ROLE_TECHNICALSUPPORT')">
						<c:if test="${isAllowed=='true'}">
							<a href="javascript:void(0);" onclick="showHistory('L1COMPONENTPARAMETER',${parameter.id})" data-toggle="popover" title="历史记录"><span class=" glyphicon glyphicon-random" aria-hidden="true"></span></a>
							<a href="javascript:void(0);" onclick="showUpdateParameter(${parameter.id})" data-toggle="popover" title="编辑"><img alt="" style="width:20px;margin-left:4px" src="<%=path%>/images/edit.png"></a>
							<a href="javascript:void(0);" onclick="deleteX(this, ${parameter.id}, 'parameter')" data-toggle="popover" title="删除"><img alt="" style="width:20px;margin-left:4px" src="<%=path%>/images/delete.png"></a>
						</c:if>
					</sec:authorize>
				</div>
			</div>
		</c:forEach>

		<div class="form-group">
			<div class="col-sm-offset-6 col-sm-7" style="align: right">
				<sec:authorize access="hasRole('ROLE_TECHNICALSUPPORT')">
					<c:if test="${isAllowed=='true'}">
						<a href="#" data-toggle="popover">
						<label for="fileupload" title="上传文件"><img alt=""
							style="margin-top: -3px;width:24px;height:18px" src="<%=path%>/images/upload.png">
						</label>
						<input id="fileupload" type="file" name="files[]"
							style="display: none"
							data-url="../../filecontroller/upload/L1COMPONENT/${component.id}"></a>
						<input type="button" onclick="update()"
							class="btn btn-primary start-example" value="编辑本模块" />&nbsp;&nbsp;
						<input type="button" id="add_new" class="btn btn-primary"
							value="增加属性"></input>
						<input type="button" onclick="addL2Component()"
							class="btn btn-primary start-example" value="添加子模块" />&nbsp;&nbsp;
					</c:if>
				</sec:authorize>
				<!--<sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')">
					<c:if test="${isAllowed=='true'}">
						<a href="#" data-toggle="popover"><label for="fileupload" title="上传文件"><img alt=""
							style="margin-top: -3px;width:24px;height:18px" src="<%=path%>/images/upload.png">
						</label>
						<input id="fileupload" type="file" name="files[]"
							style="display: none"
							data-url="../../filecontroller/upload/L1COMPONENT/${component.id}"></a>&nbsp;
						<input type="button" onclick="update()"
							class="btn btn-primary start-example" value="编辑本模块" />&nbsp;&nbsp;
						<input type="button" id="add_new" class="btn btn-primary"
							value="增加属性"></input>
						<input type="button" onclick="addL2Component()"
							class="btn btn-primary start-example" value="添加子模块" />&nbsp;&nbsp;
					</c:if>
				</sec:authorize>-->
			</div>
		</div>

		<div id="attachments" style="display:block;width:100%"></div>

	</fieldset>
	<br>
	<table data-toggle="table" data-cache="false" data-height="350" data-pagination="true" id="searchTable1">
		<thead>
	        <tr class="success">
				<th data-field="name"  data-sortable="true" data-halign="center">模块名称</th>
				<th data-field="function"  data-sortable="true" data-halign="center">功能描述</th>
				<th data-field="description"  data-sortable="true" data-halign="center">模块描述</th>
	            <th data-sortable="false" data-halign="center">操作区域</th>
	        </tr>
   	 	</thead>
   	 	<tbody>
   	 		<c:forEach items="${l2components}" var="l2component">  
            <tr>  
                <td>${l2component.name}</td>  
                <td>${l2component.functionName}</td> 
                <td>${l2component.description}</td>  
                <td>
                <a href="../../l2component/view/${l2component.id}"  data-toggle="popover" title="查看"><img alt="" src="<%=path%>/images/view.png"></a>
                &nbsp;&nbsp;
                 <sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')"><a href="javascript:void(0);" onclick="javascript:deleteX(this, ${l2component.id}, 'subComponent')" data-toggle="popover" title="删除"><img alt="" src="<%=path%>/images/delete.png"></a></sec:authorize>
   	 			&nbsp;&nbsp;
            </tr>  
       		</c:forEach>
   	 	</tbody>
	</table>
</form:form>

<!-- 确认框  -->
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

<!-- 确认框  -->
<div class="modal fade" id="historyForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">历史记录</h4>
      </div>
      <div class="modal-body" style="display:block" id="changehistorymodal">
      		<table id="historyTable" border="0" align="left" >
      			
      		</table>
      </div>
    </div>
  </div>
</div>

<!-- update detail -->
<div class="modal fade" id="updateForm" tabindex="-1" role="dialog">
	<form method="POST" action="../update/${component.id}">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">编辑${component.name}信息</h4>
				</div>
				<div class="modal-body">
					<table width="100%" border="0" cellpadding="4" cellspacing="0">
						<tr>
							<td>模块名称：</td>
							<td><div class="form-group"><input type="text" name="name" value="${component.name}" class="form-control"></div></td>
						</tr>
						<tr>
							<td>功能名称：</td>
							<td><div class="form-group"><input type="text" name="functionName" class="form-control"
								value="${component.functionName}"></div></td>
						</tr>
						<tr>
							<td>描述：</td>
							<td><div class="form-group"><textarea rows="3" name="description" class="form-control"
								value="${component.description}"></textarea></div></td>
						</tr>
						<tr>
							<td align="right"></td>
							<td></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<input type="submit" value="保存" class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="取消" class="btn btn-primary closeForm" data-dismiss="modal">
				</div>
			</div>
		</div>
	</form>
</div>

<!-- 修改parameter细节form -->
<c:forEach items="${parameters}" var="parameter" >
<div class="modal fade" tabindex="-1" role="dialog" id="updateParameterinfo${parameter.id}">
	<form id="updateParameterForm${parameter.id}">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">编辑${component.name}信息</h4>
				</div>
				<div class="modal-body">
						<table width="100%" border="0" cellpadding="4" cellspacing="0">
							<tr>
								<td><div class="form-group"><input type="text" name="id" style="display: none"
									value="${parameter.id}"></div></td>
							</tr>
							<tr>
								<td>参数名称：</td>
								<td><div class="form-group"><input type="text" name="parameterName" class="form-control"
									value="${parameter.parameterName}"></div></td>
							</tr>
							<tr>
								<td>默认值：</td>
								<td><c:choose>
										<c:when test="${parameter.l1Component.template}">
											<div class="form-group">
												<input type="text" name="parameterValue" class="form-control"
												value="${parameter.parameterValue}">
													<input type="text" class="form-control" name="tempParameterValue"
									value="${parameter.tempParameterValue}" style="display:none"></div>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${parameter.isDraft}">
													<div class="form-group"><input type="text" name="draftValue" class="form-control"
														value="${parameter.getDraftValue()}"
														style="background-color: #f2dede"></div>
												</c:when>
												<c:otherwise>
													<div class="form-group"><input type="text" name="draftValue" class="form-control"
														value="${parameter.getDraftValue()}"></div>
												</c:otherwise>
											</c:choose> 
											<div class="form-group"><input type="text" name="parameterValue" class="form-control"
												value="${parameter.parameterValue}" style="display: none"></div>
										</c:otherwise>
									</c:choose></td>
							</tr>
							<tr>
								<td>最小值：</td>
								<td><c:choose>
										<c:when test="${parameter.l1Component.template}">
											<div class="form-group"><input type="text" name="minValue" class="form-control"
												value="${parameter.minValue}"></div>
										</c:when>
										<c:otherwise>
											<div class="form-group"><input type="text" name="minValue" class="form-control"
												value="${parameter.minValue}" style="display: none"></div>
											<div class="form-group"><input type="text" name="minValue" class="form-control"
												value="${parameter.minValue}" disabled="disabled"></div>
										</c:otherwise>
									</c:choose></td>
							</tr>
							<tr>
								<td>最大值：</td>
								<td><c:choose>
										<c:when test="${parameter.l1Component.template}">
											<div class="form-group"><input type="text" name="maxValue" class="form-control"
												value="${parameter.maxValue}"></div>
										</c:when>
										<c:otherwise>
											<div class="form-group"><input type="text" name="maxValue" class="form-control"
												value="${parameter.maxValue}" style="display: none"></div>
											<div class="form-group"><input type="text" name="maxValue" class="form-control"
												value="${parameter.maxValue}" disabled="disabled"></div>
										</c:otherwise>
									</c:choose></td>
							</tr>
							<tr>
								<td>单位：</td>
								<td><c:choose>
										<c:when test="${parameter.l1Component.template}">
											<div class="form-group"><input type="text" name="unitName" class="form-control"
												value="${parameter.unitName}"></div>
										</c:when>
										<c:otherwise>
											<div class="form-group"><input type="text" name="unitName" class="form-control"
												value="${parameter.unitName}" style="display: none"></div>
											<div class="form-group"><input type="text" name="unitName" class="form-control"
												value="${parameter.unitName}" disabled="disabled"></div>
										</c:otherwise>
									</c:choose></td>
							</tr>
							<tr>
								<td>可选项：</td>
								<td><c:choose>
										<c:when test="${parameter.l1Component.template}">
											<div class="form-group"><input type="text" name="options" class="form-control"
												value="${parameter.options}"></div>
										</c:when>
										<c:otherwise>
											<div class="form-group"><input type="text" name="options" class="form-control"
												value="${parameter.options}" style="display: none"></div>
											<div class="form-group"><input type="text" name="options" class="form-control"
												value="${parameter.options}" disabled="disabled"></div>
										</c:otherwise>
									</c:choose></td>
							</tr>
							<sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')">
							<tr>
								<td>取值范围已论证？</td>
								<td>
									<c:choose>
										<c:when  test="${parameter.scopeStatus }">
											<div class="form-group"><input type="checkbox" name="scopeStatus" class="form-control" checked value="true"></div>
										</c:when >
										<c:otherwise>
											<div class="form-group"><input type="checkbox" name="scopeStatus" class="form-control" value="true"></div>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							</sec:authorize>
							<tr>
								<td>更改原因：</td>
								<td>
									<div class="form-group">
									<textarea rows="2" cols="1" class="form-control" name="changeReason" id="changeReason"></textarea>
									</div>
								</td>
							</tr>
						</table>
					</div>
					<div class="modal-footer">
						<input type="button" value="保存"
							onclick="updateParameter(${parameter.id})"
							class="btn btn-primary">&nbsp;
						<sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')">
							<c:if test="${isAllowed=='true'}">
								<c:if test="${parameter.isDraft}">
									<input type="button" value="批准"
										onclick="approveParameter(${parameter.id})"
										class="btn btn-primary">&nbsp;
												<input type="button" value="拒绝"
										onclick="declineParameter(${parameter.id})"
										class="btn btn-primary">&nbsp;
								</c:if>
							</c:if>
						</sec:authorize>
						<input type="button" value="取消" class="btn btn-primary closeForm"
							data-dismiss="modal">
					</div>
				</div>
		</div>
	</form>
</div>
</c:forEach>

<!-- download parameter-->
<div class="modal fade" id="parameterAttachments" tabindex="-1" role="dialog">
	<form method="POST" action="../update/${component.id}">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">${component.name}的附件</h4>
				</div>
				<div class="modal-body">
					<table>
						<tr>
							<td><div id="parameterAttachmentsDiv" style="display:block"></div></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<input type="button" value="取消" class="btn btn-primary closeForm" data-dismiss="modal">
				</div>
			</div>
		</div>
	</form>
</div>

<!-- 添加parameter细节form -->
<div class="modal fade" id="parameterinfoForm" tabindex="-1"
	role="dialog">
	<form name="parameterinfo" id="parameterinfo">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">增加子模块</h4>
				</div>
				<div class="modal-body">
					<table width="100%" border="0" cellpadding="4" cellspacing="0">
						<tr>
							<td><input type="text" id="componentId"
								style="display: none" value="${component.id}"></td>
						</tr>
						<tr>
							<td>参数名称：</td>
							<td><div class="form-group"><input type="text" name="parameterName" class="form-control"></div></td>
						</tr>
						<tr>
							<td>默认值：</td>
							<td><div class="form-group"><input type="text" name="parameterValue" class="form-control"></div></td>
						</tr>
						<tr>
							<td>最小值：</td>
							<td><div class="form-group"><input type="text" name="minValue" class="form-control"></div></td>
						</tr>
						<tr>
							<td>最大值：</td>
							<td><div class="form-group"><input type="text" name="maxValue" class="form-control"></div></td>
						</tr>
						<tr>
							<td>单位：</td>
							<td><div class="form-group"><input type="text" name="unitName" class="form-control"></div></td>
						</tr>
						<tr>
							<td>可选项：</td>
							<td><div class="form-group"><input type="text" name="options" class="form-control"></div></td>
						</tr>
						<tr>
							<td>取值范围已论证？</td>
							<td><div class="form-group"><input type="checkbox" name="scopeStatus" class="form-control" value="true"></div></td>
						</tr>
						<tr>
							<td>添加原因：</td>
							<td><div class="form-group"><textarea rows="2" cols="1" class="form-control" name="changeReason" id="changeReason"></textarea></div></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<input type="button" value="保存" id="saveparameter"
						class="btn btn-primary"> 
					<input type="button" value="取消"
						class="btn btn-primary closeForm" data-dismiss="modal">
				</div>
			</div>
		</div>
	</form>
</div>

<!-- 添加下一级component的form -->
<div class="modal fade" id="addComponentForm" tabindex="-1"
	role="dialog">
	<form name="addComponent" method="POST"
		action="./${component.id}/add/component">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">增加子模块</h4>
				</div>
				<div class="modal-body">
					<table width="100%" border="0" cellpadding="4" cellspacing="0">
						<tr>
							<td>模块名称：</td>
							<td><div class="form-group"><input type="text" name="name" class="form-control"></div></td>
						</tr>
						<tr>
							<td>描述：</td>
							<td><div class="form-group"><textarea rows="3" name="description" class="form-control"></textarea></div></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<input type="submit" value="保存" class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="取消" class="btn btn-primary closeForm"
						data-dismiss="modal">
				</div>
			</div>
		</div>
	</form>
</div>