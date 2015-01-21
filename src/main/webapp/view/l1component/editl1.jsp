<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
function showDailog(){
	$('#myModal').modal('show');
}
function deleteProduct(){
	$.post('./delete/'+deleteProductId);
	$('#searchProductForm').submit();
	$('#myModal').modal('hide');
}
</script>

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
		<button type="button" class="btn btn-primary" onclick="location='../search'">关闭</button>
        <button type="submit" class="btn btn-primary">保存修改</button>
		</div>
	</div>
</form:form>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">确认框</h4>
      </div>
      <div class="modal-body"> 确认要删除该产品？</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="deleteProduct()">确定</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>