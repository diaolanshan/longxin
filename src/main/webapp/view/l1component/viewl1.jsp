<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
	function showDailog() {
		$('#myModal').modal('show');
	}
	function deleteProduct() {
		$.post('./delete/' + deleteProductId);
		$('#searchProductForm').submit();
		$('#myModal').modal('hide');
	}
</script>

<form:form method="POST" modelAttribute="product" role="form"
	class="form-horizontal" id="editProductForm">
	<fieldset>
		<legend>
			${l1component.name}细节 &nbsp;&nbsp;&nbsp;&nbsp;<a href="../diagram/${product.id}"><span
				class="glyphicon glyphicon-indent-left"></span></a>
		</legend>
		<div class="form-group">
			<label for="id" class="col-sm-3 control-label">产品ID：</label>
			<div class="col-sm-5 control-label">${product.id}</div>

		</div>
		<div class="form-group">
			<label for="name" class="col-sm-3 control-label">产品名称：</label>
			<div class="col-sm-5 control-label">${product.name}</div>
		</div>
		<div class="form-group">
			<label for="name" class="col-sm-3 control-label">创建时间：</label>
			<div class="col-sm-5 control-label">${product.createdat}</div>
		</div>
		<div class="form-group">
			<label for="description" class="col-sm-3 control-label">描述：</label>
			<div class="col-sm-5 control-label">${product.description}</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-7 col-sm-5" style="align: right">
				<button type="button" class="btn btn-primary"
					onclick="location='../edit/${product.id}'">编辑</button>
			</div>
		</div>
	</fieldset>
</form:form>
