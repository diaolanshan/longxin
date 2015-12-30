<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%
    String path = request.getContextPath();
%>
<script src="<%=path%>/js/jquery.shuttle.js"></script>
<link href="<%=path%>/css/jquery.shuttle.css" rel="stylesheet">
<script type="text/javascript">
	$(function() {
		$("#shuttleSelUser").shuttle();
		$("#shuttleSelProduct").shuttle();
	})

	function showMatrix() {
		var selectedUsers = "users=";
		$("[name='selectedUsersDst'] option").each(function() {
			selectedUsers = selectedUsers + $(this).val() + ",";
		});

		if (selectedUsers === 'users=') {
			$("#alertTableBody").empty();
			$("#alertTableBody").append("请选择用户");
			$("#alertTable").modal('show');
			return;
		}

		var selectedProducts = "products=";
		$("[name='selectedProductsDst'] option").each(function() {
			selectedProducts = selectedProducts + $(this).val() + ",";
		});
		
		if (selectedProducts === 'products=') {
			$("#alertTableBody").empty();
			$("#alertTableBody").append("请选择产品");
			$("#alertTable").modal('show');
			return;
		}
		var data = selectedUsers + "&" + selectedProducts;
		document.selectForm.method = "POST";
		document.selectForm.action = "./select?" + data;
		document.selectForm.submit();
	}
</script>
<body>
	<form:form method="POST" name="selectForm"
		modelAttribute="permssionBean" role="form" id="selectForm">
		<div>
			<fieldset>
				<legend>请选择用户</legend>
				<div class="main,form-group">
					<form:select path="selectedUsers" id="shuttleSelUser"
						items="${users}" itemValue="id" itemLabel="username"
						class="form-control" style="width: 200px;height:150px">
					</form:select>
				</div>
			</fieldset>
		
			<fieldset>
				<legend>请选择产品</legend>
				<div class="main,form-group">
					<form:select path="selectedProducts" id="shuttleSelProduct"
						items="${products}" itemValue="id" itemLabel="name"
						class="form-control" style="width: 200px;height:150px">
					</form:select>
				</div>
			</fieldset>
		
			<div class="form-group">
				<div class="col-sm-offset-4">
					<button type="button" class="btn btn-primary"
						onclick="javascript:showMatrix()">下一步</button>
				</div>
			</div>
		</div>
	</form:form>
	
	<div class="modal fade" id="alertTable" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">警告</h4>
				</div>
				<div class="modal-body" style="display: block" >
					<img alt="" src="<%=path%>/images/alert.jpg" style="width:30px"></img>
					<div style="display:inline;font-size:16px;padding-left:5px" id="alertTableBody"></div>
				</div>
				<div class="modal-footer">
					<input type="button" value="取消" class="btn btn-primary closeForm"
						data-dismiss="modal">
				</div>
			</div>
		</div>
	</div>
</body>