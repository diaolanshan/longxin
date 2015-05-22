<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%  
String path = request.getContextPath();  
%>
<script>
	var deleteId;
    $(function () {
		$('#searchTable1').bootstrapTable({
			
		}).on('dbl-click-row.bs.table', function (e, row, $element) {
			//location.href="./edit/"+row.id;
        });
		//file upload
		$('#fileupload').fileupload({
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
    		url: "../../filecontroller/get/FEATURE/" + $("#idvalue").val(), 
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
    function showDailog(id){
    	deleteId = id;
    	$('#myModal').modal('show');
    }
    function deleteThis(){
    	$.post('../delete/module/'+deleteId);
    	location.reload();
    }
    
    function update(){
    	$("#updateForm").modal('show');
    }
    
    function addModule(){
    	$("#addComponentForm").modal('show');
    }
    
    function addFunctionModule(){
    	$("#addFunctionModuleForm").modal('show');
    }
</script>

<form:form method="POST" modelAttribute="feature" role="form"
	class="form-horizontal" id="viewProductForm">

	<fieldset>
		<legend>${feature.featureName} &nbsp;&nbsp;&nbsp;<a href="../diagram/${feature.id}">
				<span title="物理结构图" class="glyphicon glyphicon-indent-left"></span></a> 
			&nbsp;&nbsp;<a href="../functiondiagram/${feature.id}">
			<span title="功能结构图" class="glyphicon glyphicon-indent-right"></span></a>
		 </legend>
		<div class="form-group">
			<input type="text" id="idvalue" style="display:none" value="${feature.id}">
			<label for="name" class="col-sm-3 control-label">特性名称：</label>
			<div class="col-sm-8 control-label">${feature.featureName}</div>
		</div>
		<div class="form-group">
			<label for="name" class="col-sm-3 control-label">功能名称：</label>
			<div class="col-sm-8 control-label">${feature.functionName}</div>
		</div>
		<div class="form-group">
			<label for="description" class="col-sm-3 control-label">描述：</label>
			<div class="col-sm-8 control-label">${feature.description}</div>
		</div>
	</fieldset>
	<sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')">
		<div class="form-group">
			<div class="col-sm-offset-6 col-sm-7" style="align: right">
				<sec:authorize access="hasRole('ROLE_TECHNICALSUPPORT')">
						<label for="fileupload" title="上传文件"><img alt="" style="margin-top:-4px;width:24px;height:18px"
							src="<%=path%>/images/upload.png"> </label> <input id="fileupload"
							type="file" name="files[]" style="display: none"
							data-url="../../filecontroller/upload/FEATURE/${feature.id}">&nbsp;
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')"><input type="button" onclick="update()" class="btn btn-primary start-example" value="编辑本模块" />&nbsp;&nbsp;</sec:authorize>
				<sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')"><input type="button" onclick="addModule()" class="btn btn-primary start-example" value="添加子模块" />&nbsp;&nbsp;</sec:authorize>
				<sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')"><input type="button" onclick="addFunctionModule()" class="btn btn-primary start-example" value="添加功能模块" />&nbsp;&nbsp;</sec:authorize>
				<sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')"><a href="../function/matrix/show/${feature.id}"><input type="button" class="btn btn-primary start-example" value="创建关联" /></a> &nbsp;&nbsp;</sec:authorize>
			</div>
		</div>
	</sec:authorize>
	<br/>
	<div id="attachments" style="display:block;width:100%;">
	</div>
	<br/>
	<table style="width:1010px">
		<tr>
			<td style="width:500px">
				<table data-toggle="table" data-cache="false" data-height="350" data-pagination="true" id="searchTable1">
					<thead>
				        <tr class="success">
							<th data-field="name"  data-sortable="true" data-halign="center">模块名称</th>
							<th data-field="description"  data-sortable="true" data-halign="center">模块描述</th>
				            <th data-sortable="false" data-halign="center">操作</th>
				        </tr>
			   	 	</thead>
			   	 	<tbody>
			   	 		<c:forEach items="${modules}" var="module">  
			            <tr>  
			                <td>${module.moduleName}</td>  
			                <td>${module.description}</td>  
			                <td>
			                <a href="../../module/view/${module.id}"  data-toggle="popover" title="查看"><img alt="" src="<%=path%>/images/view.png"></a>
			                &nbsp;&nbsp;
			               <sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')"><a href="javascript:void(0);" onclick="showDailog(${module.id})"  data-toggle="popover" title="删除"><img alt="" src="<%=path%>/images/delete.png"></a>
			   	 			&nbsp;&nbsp;</sec:authorize>
			            </tr>  
			       		</c:forEach>
			   	 	</tbody>
				</table>
			</td>
			<td style="padding-left:20px;width:500px">
				<table data-toggle="table" data-cache="false" data-height="350" data-pagination="true" id="searchTable2">
					<thead>
				        <tr class="success">
							<th data-field="name"  data-sortable="true" data-halign="center">功能名称</th>
							<th data-field="description"  data-sortable="true" data-halign="center">模块描述</th>
				        </tr>
			   	 	</thead>
			   	 	<tbody>
			   	 		<c:forEach items="${functionModules}" var="functionModule">  
			            <tr>  
			                <td>${functionModule.name}</td>  
			                <td>${functionModule.description}</td>  
			            </tr>  
			       		</c:forEach>
			   	 	</tbody>
				</table>
				</td>
			</tr>
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

<!-- update 当前name and description -->
<div class="modal fade" id="updateForm" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<form method="POST" action="../update/${feature.id}">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">更改${feature.featureName}信息</h4>
				</div>
				<div class="modal-body">
					<table width="100%" border="0" cellpadding="4" cellspacing="0">
						<tr>
							<td>特性名称：</td>
							<td><div class="form-group"><input type="text" name="featureName" class="form-control"
								value="${feature.featureName}"></div></td>
						</tr>
						<tr>
							<td>功能名称：</td>
							<td><div class="form-group"><input type="text" name="functionName" class="form-control"
								value="${feature.functionName}"></div></td>
						</tr>
						<tr>
							<td>描述：</td>
							<td><div class="form-group"><input type="text" name="description" class="form-control"
								value="${feature.description}"></div></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<input type="submit" value="保存" class="btn btn-primary">
					<button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- 添加function module form -->
<div class="modal fade" id="addComponentForm" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<form name="addComponent" method="POST"
		action="./${feature.id}/add/module">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">添加下一级</h4>
				</div>
				<div class="modal-body">
					<table width="100%" border="0" cellpadding="4" cellspacing="0">
						<tr>
							<td>模块名称：</td>
							<td><div class="form-group"><input type="text" name="moduleName" class="form-control"></div></td>
						</tr>
						<tr>
							<td>功能名称：</td>
							<td><div class="form-group"><input type="text" name="functionName" class="form-control"></div></td>
						</tr>
						<tr>
							<td>描述：</td>
							<td><div class="form-group"><input type="text" name="description" class="form-control"></div></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<input type="submit" value="保存" class="btn btn-primary">
					<button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- 添加下一级的form -->
<div class="modal fade" id="addFunctionModuleForm" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<form name="addComponent" method="POST"
		action="./${feature.id}/add/functionmodule">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">添加功能模块</h4>
				</div>
				<div class="modal-body">
					<table width="100%" border="0" cellpadding="4" cellspacing="0">
						<tr>
							<td>功能模块名称：</td>
							<td><div class="form-group"><input type="text" name="name" class="form-control"></div></td>
						</tr>
						<tr>
							<td>描述：</td>
							<td><div class="form-group"><input type="text" name="description" class="form-control"></div></td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<input type="submit" value="保存" class="btn btn-primary">
					<button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</form>
</div>