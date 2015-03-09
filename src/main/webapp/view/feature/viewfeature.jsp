<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	var deleteProductId;
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
    		url: "../../filecontroller/get/feature/" + $("#idvalue").val(), 
    		dataType: "json",
    		contentType: "application/json; charset=utf-8",
    		success: function(data){
    			$.each(data, function(idx,item)
    			{
    				var downloadlink = "../../filecontroller/download/feature/" + $("#idvalue").val() + "/" + item.fileName;
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
    function showDailog(productId){
    	//deleteProductId = productId;
    	//$('#myModal').modal('show');
    }
    function deleteProduct(){
    	$.post('./delete/'+deleteProductId);
    	location.href="./search";
    }
    
</script>

<form:form method="POST" modelAttribute="feature" role="form"
	class="form-horizontal" id="viewProductForm">

	<fieldset>
		<legend>${feature.featureName} &nbsp;&nbsp;&nbsp;&nbsp;<a href="../diagram/${feature.id}">
				<span title="物理名称树" class="glyphicon glyphicon-indent-left"></span></a> 
			&nbsp;&nbsp;&nbsp;&nbsp;<a href="../functiondiagram/${feature.id}">
			<span title="功能名称树" class="glyphicon glyphicon-indent-left"></span></a>
		 </legend>
		<div class="form-group">
			<input type="text" id="idvalue" style="display:none" value="${feature.id}">
			<label for="name" class="col-sm-2 control-label">特性名称：</label>
			<div class="col-sm-5 control-label">${feature.featureName}</div>
		</div>
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">功能名称：</label>
			<div class="col-sm-5 control-label">${feature.functionName}</div>
		</div>
		<div class="form-group">
			<label for="description" class="col-sm-2 control-label">描述：</label>
			<div class="col-sm-5 control-label">${feature.description}</div>
		</div>
	</fieldset>
	<br/>
	<div style="display: inline; width: 39%;float:left">
		<input id="fileupload" type="file" name="files[]" 
			data-url="../../filecontroller/upload/feature/${feature.id}"
			multiple>
	</div>
	<br/><br/>
	<div id="attachments" style="display:block;width:100%">
	</div>
	<br>
	<table data-toggle="table" data-cache="false" data-height="350" data-pagination="true" id="searchTable1">
		<thead>
	        <tr class="success">
				<th data-field="name"  data-sortable="true">模块名称</th>
				<th data-field="description"  data-sortable="true">模块描述</th>
	            <th data-sortable="false">操作</th>
	        </tr>
   	 	</thead>
   	 	<tbody>
   	 		<c:forEach items="${modules}" var="module">  
            <tr>  
                <td>${module.moduleName}</td>  
                <td>${module.description}</td>  
                <td>
                <a href="../../module/view/${module.id}"  data-toggle="popover" title="查看"><span class="glyphicon glyphicon-th" aria-hidden="true"></span></a>
                &nbsp;&nbsp;
                <a href="../../module/edit/${module.id}"  data-toggle="popover" title="编辑"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
   	 			&nbsp;&nbsp;
            </tr>  
       		</c:forEach>
   	 	</tbody>
	</table>
</form:form>

<!-- Modal -->
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
					onclick="deleteProduct()">确定</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>