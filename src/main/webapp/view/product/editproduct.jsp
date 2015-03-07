<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript">
$(function(){
	//file upload
	$('#fileupload').fileupload({
	    dataType: 'json',
	    
	    done: function (e, data) {
	    	$("tr:has(td)").remove();
	        $.each(data.result, function (index, file) {
	        	
	        	
	            $("#uploaded-files").append(
	            		$('<tr/>')
	            		.append($('<td/>').text(file.fileName))
	            		.append($('<td/>').text(file.fileSize))
	            		.append($('<td/>').text(file.fileType))
	            		.append($('<td/>').html("<a href='../../filecontroller/download/product/" + $('#id').val() + "/" + file.fileName+"'>Click</a>"))
	            		)//end $("#uploaded-files").append()
	        }); 
	    },
	    
	    progressall: function (e, data) {
	      var progress = parseInt(data.loaded / data.total * 100, 10);
	      $('#progress .bar').css(
	          'width',
	          progress + '%'
	      );
			},
			
	dropZone: $('#dropzone')
	});
})
</script>
<form:form method="POST" modelAttribute="product" role="form"
	class="form-horizontal" id="editProductForm">
	<div class="form-group">
		<label for="id" class="col-sm-2 control-label">产品ID：</label>
		<div class="col-sm-10">
			<form:input type="text" class="form-control" id="id" path="id" disabled="true"/>
		</div>
	</div>
	<div class="form-group">
		<label for="name" class="col-sm-2 control-label">产品名称：</label>
		<div class="col-sm-10">
			<form:input type="text" class="form-control" id="name"
				placeholder="输入用户名" path="name" />
		</div>
	</div>
	<div class="form-group">
		<label for="functionname" class="col-sm-2 control-label">功能名称：</label>
		<div class="col-sm-10">
			<form:input type="text" class="form-control" id="functionName"
				placeholder="输入特性名称" path="functionName" />
		</div>
	</div>
	<div class="form-group">
		<label for="description" class="col-sm-2 control-label">描述：</label>
		<div class="col-sm-10">
			<form:input type="text" class="form-control" id="description"
				placeholder="输入特性名称" path="description" />
		</div>
	</div>
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<button type="button" class="btn btn-primary"
				onclick="location='../list/'+${product.id}">关闭</button>
			<button type="submit" class="btn btn-primary">保存修改</button>
		</div>
	</div>

<br/>
<br/>
<body>
	<div style="display: inline; width: 39%;float:left">
		<div id="dropzone" class="fade well">拖拽文件到此处</div>
		<input id="fileupload" type="file" name="files[]" 
			data-url="../../filecontroller/upload/product/${product.id}"
			multiple>
	</div>

	<div style="display: inline; width: 59%;float:left">
		<table id="uploaded-files" class="table">
			<tr>
				<th>File Name</th>
				<th>File Size</th>
				<th>File Type</th>
				<th>Download</th>
			</tr>
		</table>
	</div>
</body> 
</form:form>

