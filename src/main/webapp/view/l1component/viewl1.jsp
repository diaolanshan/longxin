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
	var deleteId;
	var url ;
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
    				var attachment = "<div style='display: inline; width: 15%;float:left; text-align:center' title=" + item.fileName + ">" + "<a href = " + downloadlink + ">" + "<img src='../../images/attachment.png' style='width:60px;border:1px dashed'/>" + "</a>" + "<br/>" + item.fileName + "</div>";
    				$("#attachments").append(attachment);
    				
    			}
    			)
    		},
    		error: function(res){
    			alert("Unexpected error! Try again.");
    		}
    	})
	});
    function showDailog(id, type){
    	deleteId = id;
    	if(type=="parameter"){
    		url = '../delete/parameter/'+deleteId;	
    	}
    	else{
    		url = '../delete/component/'+deleteId;	
    	}
    	$('#myModal').modal('show');
    }
    function deleteThis(){
    	$.post(url);
    	location.reload();
    }

    function update(){
    	$("#updateForm").fadeIn("fast");
    }
    
    function showUpdateParameter(parameterId){
    	$("#updateParameterinfo"+parameterId).fadeIn("fast");
    }
    function addL2Component(){
    	$("#addComponentForm").fadeIn("fast");
    }
</script>

<form:form method="POST" modelAttribute="component" role="form"
	class="form-horizontal" id="editProductForm">
	<fieldset>
		<legend>
			${component.name}细节 &nbsp;&nbsp;&nbsp;<a href="../diagram/${component.id}">
				<span title="物理结构图" class="glyphicon glyphicon-indent-left"></span></a> 
			&nbsp;&nbsp;<a href="../functiondiagram/${component.id}">
			<span title="功能结构图" class="glyphicon glyphicon-indent-right"></span></a>
		</legend>
		<div class="form-group">
			<label for="functionName" class="col-sm-3 control-label">功能名称：</label>
			<div class="control-label">${component.functionName}</div>
		</div>
		<div class="form-group">
			<input type="text" id="idvalue" style="display:none" value="${component.id}">
			<label for="id" class="col-sm-3 control-label">组件描述：</label>
			<div class="control-label">${component.description}</div>
		</div>
		<c:forEach items="${parameters}" var="parameter">
			<div class="form-group">
				<label for="id" class="col-sm-3 control-label">${parameter.parameterName}：</label>
				<div class="control-label" style="width:100%">
					<c:choose>
						<c:when test="${parameter.isDraft }">
							<div style="width:150px;float:left;display:inline;background-color:#f2dede">${parameter.parameterValue}&nbsp;&nbsp;${parameter.unitName}</div>
						</c:when>
						<c:otherwise>
							<div style="width:150px;float:left;display:inline">${parameter.parameterValue}&nbsp;&nbsp;${parameter.unitName}</div>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${parameter.options == \"\"}">
							<div style="width: 300px; hefloat: left; display: inline;font-size:11px;color:gray">取值范围(${parameter.minValue},${parameter.maxValue})</div>
						</c:when>
						<c:otherwise>
							<div style="width: 200px; hefloat: left; display: inline;font-size:11px;color:gray">可选值(${parameter.options})</div>
						</c:otherwise>
					</c:choose>
					&nbsp;&nbsp;<a href="#" data-toggle="popover"><label for="fileupload${parameter.id}" class="glyphicon glyphicon-upload" aria-hidden="true" title="上传文件"></label>
					<input id="fileupload${parameter.id}" type="file" name="files[]" style="display:none" data-url="../../filecontroller/upload/L1COMPONENTPARAMETER/${parameter.id}"></input></a>
					&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="showParameterAttachments(${parameter.id}, ${parameter.category})" data-toggle="popover" title="下载文件"><span class="glyphicon glyphicon-download" aria-hidden="true"></span></a>
					&nbsp;&nbsp;
					&nbsp;&nbsp;
					<a href="javascript:void(0);" onclick="showUpdateParameter(${parameter.id})" data-toggle="popover" title="编辑"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
					<a href="javascript:void(0);" onclick="showDailog(${parameter.id},'parameter')" data-toggle="popover" title="删除"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a>
				</div>
			</div>
		</c:forEach>
		
		<sec:authorize access="hasRole('ROLE_TECHNICALSUPPORT')">
			<div class="form-group">
				<div class="col-sm-offset-7 col-sm-5" style="align: right">
					<input type="button" onclick="update()" class="btn btn-primary start-example" value="编辑本模块" />&nbsp;&nbsp;
					<input type="button" id="add_new" class="btn btn-primary" value="增加属性"></input>
					<input type="button" onclick="addL2Component()" class="btn btn-primary start-example" value="添加子模块" />&nbsp;&nbsp;
				</div>
			</div>
		</sec:authorize>
		
		<div id="attachments" style="display:block;width:100%"></div>
		
		<div style="display: inline; width: 39%;float:left">
			<label for="fileupload" title="上传文件"><img alt="" src="<%=path%>/images/upload.png"> </label>
			<input id="fileupload" type="file" name="files[]" style="display:none"
				data-url="../../filecontroller/upload/L1COMPONENT/${component.id}"
				multiple>
		</div>
	</fieldset>
	<br>
	<table data-toggle="table" data-cache="false" data-height="350" data-pagination="true" id="searchTable1">
		<thead>
	        <tr class="success">
				<th data-field="name"  data-sortable="true">模块名称</th>
				<th data-field="function"  data-sortable="true">功能描述</th>
				<th data-field="description"  data-sortable="true">模块描述</th>
	            <th data-sortable="false">操作</th>
	        </tr>
   	 	</thead>
   	 	<tbody>
   	 		<c:forEach items="${l2components}" var="l2component">  
            <tr>  
                <td>${l2component.name}</td>  
                <td>${l2component.functionName}</td> 
                <td>${l2component.description}</td>  
                <td>
                <a href="../../l2component/view/${l2component.id}"  data-toggle="popover" title="查看"><span class="glyphicon glyphicon-th" aria-hidden="true"></span></a>
                &nbsp;&nbsp;
                <a href="javascript:void(0);" onclick="showDailog(${l2component.id},'component')" data-toggle="popover" title="编辑"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a>
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

<!-- 修改parameter细节form -->
<c:forEach items="${parameters}" var="parameter">
<div class="entry-form" id="updateParameterinfo${parameter.id}" >
	<form id="updateParameterForm${parameter.id}" >
		<table width="100%" border="0" cellpadding="4" cellspacing="0">
			<tr>
				<td colspan="2" align="right"><a href="#" class="closeForm">关闭</a></td>
			</tr>
			<tr>
				<td><input type="text" name="id" style="display:none" value="${parameter.id}"></td>
			</tr>
			<tr>
				<td>参数名称：</td>
				<td><input type="text" name="parameterName" value="${parameter.parameterName}"></td>
			</tr>
			<tr>
				<td>默认值：</td>
				<td>
					<c:choose>
						<c:when test="${parameter.l1Component.template}">
							<input type="text" name="parameterValue" value="${parameter.parameterValue}">
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${parameter.isDraft}">
									<input type="text" name="draftValue" value="${parameter.getDraftValue()}" style="background-color:#f2dede">
								</c:when>
								<c:otherwise>
									<input type="text" name="draftValue" value="${parameter.getDraftValue()}">
								</c:otherwise>
							</c:choose>
							<input type="text" name="parameterValue" value="${parameter.parameterValue}" style="display:none">
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>最小值：</td>
				<td>
					<c:choose>
						<c:when test="${parameter.l1Component.template}">
							<input type="text" name="minValue" value="${parameter.minValue}">
						</c:when>
						<c:otherwise>
							<input type="text" name="minValue" value="${parameter.minValue}" style="display:none">
							<input type="text" name="minValue" value="${parameter.minValue}" disabled="disabled">
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>最大值：</td>
				<td>
					<c:choose>
						<c:when test="${parameter.l1Component.template}">
							<input type="text" name="maxValue" value="${parameter.maxValue}">
						</c:when>
						<c:otherwise>
							<input type="text" name="maxValue" value="${parameter.maxValue}" style="display:none">
							<input type="text" name="maxValue" value="${parameter.maxValue}" disabled="disabled">
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>单位：</td>
				<td>
					<c:choose>
						<c:when test="${parameter.l1Component.template}">
							<input type="text" name="unitName" value="${parameter.unitName}">
						</c:when>
						<c:otherwise>
							<input type="text" name="unitName" value="${parameter.unitName}" style="display:none">
							<input type="text" name="unitName" value="${parameter.unitName}" disabled="disabled">
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td>可选项：</td>
				<td>
					<c:choose>
						<c:when test="${parameter.l1Component.template}">
							<input type="text" name="options" value="${parameter.options}">
						</c:when>
						<c:otherwise>
							<input type="text" name="options" value="${parameter.options}" style="display:none">
							<input type="text" name="options" value="${parameter.options}" disabled="disabled">
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td align="right"></td>
				<td><input type="button" value="保存" onclick="updateParameter(${parameter.id})" class="btn btn-primary">&nbsp;
					<c:if test="${parameter.isDraft}">
						<input type="button" value="批准" onclick="approveParameter(${parameter.id})" class="btn btn-primary">&nbsp;
						<input type="button" value="拒绝" onclick="declineParameter(${parameter.id})" class="btn btn-primary">&nbsp;
					</c:if>
					<input type="button" value="取消" class="btn btn-primary closeForm"></td>
			</tr>
		</table>
	</form>
</div>
</c:forEach>
<div class="entry-form" id="parameterAttachments">
	<form method="POST" action="../update/${component.id}">
		<table width="100%" border="0" cellpadding="4" cellspacing="0">
			<tr>
				<td colspan="2" align="right"><a href="#" class="closeForm">关闭</a></td>
			</tr>
			<tr>
				<td><div id="parameterAttachmentsDiv"></div></td>
			</tr>
		</table>
	</form>
</div>
<!-- update 当前name and description -->
<div class="entry-form" id="updateForm">
	<form method="POST" action="../update/${component.id}">
		<table width="100%" border="0" cellpadding="4" cellspacing="0">
			<tr>
			<td colspan="2" align="right"><a href="#" class="closeForm">关闭</a></td>
			</tr>
			<tr>
				<td>模块名称：</td>
				<td><input type="text" name="name" value="${component.name}"></td>
			</tr>
			<tr>
				<td>功能名称：</td>
				<td><input type="text" name="functionName" value="${component.functionName}"></td>
			</tr>
			<tr>
				<td>描述：</td>
				<td><input type="text" name="description" value="${component.description}"></td>
			</tr>
			<tr>
				<td align="right"></td>
				<td><input type="submit" value="保存" class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="取消" class="btn btn-primary closeForm"></td>
			</tr>
		</table>
	</form>
</div>
<!-- 添加parameter细节form -->
<div class="entry-form" id="parameterinfoForm">
	<form name="parameterinfo" id="parameterinfo">
		<table width="100%" border="0" cellpadding="4" cellspacing="0">
			<tr>
				<td colspan="2" align="right"><a href="#" class="closeForm" id="close">关闭</a></td>
			</tr>
			<tr>
				<td><input type="text" id="componentId" style="display:none" value="${component.id}"></td>
			</tr>
			<tr>
				<td>参数名称：</td>
				<td><input type="text" name="parameterName" ></td>
			</tr>
			<tr>
				<td>默认值：</td>
				<td><input type="text" name="parameterValue"></td>
			</tr>
			<tr>
				<td>最小值：</td>
				<td><input type="text" name="minValue"></td>
			</tr>
			<tr>
				<td>最大值：</td>
				<td><input type="text" name="maxValue"></td>
			</tr>
			<tr>
				<td>单位：</td>
				<td><input type="text" name="unitName"></td>
			</tr>
			<tr>
				<td>可选项：</td>
				<td><input type="text" name="options"></td>
			</tr>
			<tr>
				<td align="right"></td>
				<td><input type="button" value="保存" id="saveparameter" class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;<input
					type="button" value="取消" id="cancel"  class="btn btn-primary closeForm"></td>
			</tr>
		</table>
	</form>
</div>

<!-- 添加下一级component的form -->
<div class="entry-form" id="addComponentForm">
	<form name="addComponent" method="POST" action="./${component.id}/add/component">
		<table width="100%" border="0" cellpadding="4" cellspacing="0">
			<tr>
			<td colspan="2" align="right"><a href="#" class="closeForm">关闭</a></td>
			</tr>
			<tr>
				<td>模块名称：</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>描述：</td>
				<td><input type="text" name="description"></td>
			</tr>
			<tr>
				<td align="right"></td>
				<td><input type="submit" value="保存" class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="取消" class="btn btn-primary closeForm"></td>
			</tr>
		</table>
	</form>
</div>