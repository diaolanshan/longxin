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
    		url: "../../filecontroller/get/MODULE/" + $("#idvalue").val(), 
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
    	$.post('../delete/component/'+deleteId,location.reload());
    	$('#myModal').modal('hide');
    }
    
    function update(){
    	$("#updateForm").modal('show');
    }
    
    function addComponent(){
    	$("#addComponentForm").modal('show');
    }
    
</script>

<form:form method="POST" modelAttribute="module" role="form"
	class="form-horizontal" id="viewProductForm">
	<fieldset>
		<legend>
			<a href="<%=path%>/feature/view/${module.feature.id}" title="返回"><img alt="" src="<%=path%>/images/back.png" style="width:35px"></a>
			${module.moduleName} 
			&nbsp;&nbsp;&nbsp;<a href="../diagram/${module.id}">
				<span title="物理结构图" class="glyphicon glyphicon-indent-left"></span>
			</a> 
			&nbsp;&nbsp;&nbsp;&nbsp;<a href="../functiondiagram/${module.id}">
			<span title="功能结构图" class="glyphicon glyphicon-indent-right"></span></a>
		</legend>
		
		<div class="form-group">
			<input type="text" id="idvalue" style="display:none" value="${module.id}">
			<label for="name" class="col-sm-3 control-label">模块名称：</label>
			<div class="col-sm-8 control-label">${module.moduleName}</div>
		</div>
		<div class="form-group">
			<label for="name" class="col-sm-3 control-label">功能名称：</label>
			<div class="col-sm-8 control-label">${module.functionName}</div>
		</div>
		<div class="form-group">
			<label for="description" class="col-sm-3 control-label">描述：</label>
			<div class="col-sm-8 control-label">${module.description}</div>
		</div>
		<div class="form-group" align="right">
			<div class="col-sm-offset-7 col-sm-5" style="align: right">
				<c:choose>
					<c:when test="${module.template == false}">
						<sec:authorize access="hasRole('ROLE_TECHNICALSUPPORT')">
							<label for="fileupload" title="上传文件"><img alt=""
								style="margin-top: -4px" src="<%=path%>/images/upload.png">
							</label>
							<input id="fileupload" type="file" name="files[]"
								style="display: none"
								data-url="../../filecontroller/upload/MODULE/${module.id}">&nbsp;
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_TECHNICALSUPPORT')">
							<input type="button" onclick="update()"
								class="btn btn-primary start-example" value="编辑本模块" />&nbsp;&nbsp;</sec:authorize>
						<sec:authorize access="hasRole('ROLE_TECHNICALSUPPORT')">
							<input type="button" onclick="addComponent()"
								class="btn btn-primary start-example" value="添加子模块" />&nbsp;&nbsp;</sec:authorize>
					</c:when>
					<c:otherwise>
						<sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')">
							<label for="fileupload" title="上传文件"><img alt=""
								style="margin-top: -4px;width:24px;height:18px" src="<%=path%>/images/upload.png">
							</label>
							<input id="fileupload" type="file" name="files[]"
								style="display: none"
								data-url="../../filecontroller/upload/MODULE/${module.id}">&nbsp;
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')">
							<input type="button" onclick="update()"
								class="btn btn-primary start-example" value="编辑本模块" />&nbsp;&nbsp;</sec:authorize>
						<sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')">
							<input type="button" onclick="addComponent()"
								class="btn btn-primary start-example" value="添加子模块" />&nbsp;&nbsp;</sec:authorize>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		
		<div id="attachments" style="display:block;width:100%">
		</div>
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
   	 		<c:forEach items="${l1components}" var="l1component">  
            <tr>  
                <td>${l1component.name}</td> 
                <td>${l1component.functionName}</td>  
                <td>${l1component.description}</td>  
                <td>
                <a href="../../l1component/view/${l1component.id}"  data-toggle="popover" title="查看"><img alt="" src="<%=path%>/images/view.png"></a>
                &nbsp;&nbsp;
                <sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')"><a href="javascript:void(0);" onclick="showDailog(${l1component.id})"  data-toggle="popover" title="删除"><img alt="" src="<%=path%>/images/delete.png"></a></sec:authorize>
            </tr>  
       		</c:forEach>
   	 	</tbody>
	</table>
</form:form>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">确认框</h4>
			</div>
			<div class="modal-body">确认要删除该产品？</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary"
					onclick="deleteThis()">确定</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="updateForm" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<form method="POST" action="../update/${module.id}">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">确认框</h4>
				</div>
				<div class="modal-body">
					<table width="100%" border="0" cellpadding="4" cellspacing="0">
						<tr>
							<td>模块名称：</td>
							<td><div class="form-group"><input type="text" name="moduleName" class="form-control"
								value="${module.moduleName}"></div></td>
						</tr>
						<tr>
							<td>功能名称：</td>
							<td><div class="form-group"><input type="text" name="functionName" class="form-control"
								value="${module.functionName}"></div></td>
						</tr>
						<tr>
							<td>描述：</td>
							<td><div class="form-group"><textarea rows="3" name="description" class="form-control"
								value="${module.description}"></textarea></div></td>
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

<div class="modal fade" id="addComponentForm" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<form name="addL1Component" id="addL1Component" method="POST"
		modelAttribute="l1Component" action="./${module.id}/add/component">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">确认框</h4>
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
					<input type="submit" value="保存" class="btn btn-primary">
					<button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</form>
</div>