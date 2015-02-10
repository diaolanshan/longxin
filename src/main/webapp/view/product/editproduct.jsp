<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<form:form method="POST" modelAttribute="product" role="form"
	class="form-horizontal" id="editProductForm">
	<div class="form-group">
		<label for="id" class="col-sm-2 control-label">产品ID：</label>
		<div class="col-sm-10">
			<form:input type="text" class="form-control" id="id" path="id" />
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
		<div class="col-sm-offset-2 col-sm-10">
			<button type="button" class="btn btn-primary"
				onclick="location='../search'">关闭</button>
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

