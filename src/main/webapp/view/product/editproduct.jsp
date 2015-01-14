<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$().ready(function(){
	$("#editProductForm").validate({

	});
});
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