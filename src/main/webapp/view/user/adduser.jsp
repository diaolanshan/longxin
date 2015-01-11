<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script type="text/javascript">
$().ready(function(){
	$("#addUserForm").validate({
		rules: {
			username: {
				required: true,
				minlength: 5,
				remote: {
					 url: "http://localhost:8080/longxin/user/check",
					 type: "post",
					 data: {
					 	username: function() 
					 		{
					 			return $("#username").val();
					 		}
					 	}
					 }
			},
			password: {
				required: true,
				minlength: 5
			},
			passwordAgain: {
				required: true,
				minlength: 5,
				equalTo: "#password"
			},
			telephone: {
				required: true,
				minlength: 7
			}
		},
		messages: {
			username: {
				required: "请输入用户名",
				minlength: "Your username must consist of at least 2 characters",
				remote: "用户名已经存在"
			},
			password: {
				required: "请输入密码",
				minlength: "密码长度不能小于5位"
			},
			telephone: {
				required: "请输入电话号码",
				minlength: "密码长度不能小于7位"
			},
			passwordAgain: {
				required: "请输入确认密码",
				minlength: "密码长度不能小于5位",
				equalTo: "两次输入密码不一致"
			}
		},
	});
	});
</script>

<form:form method="POST" modelAttribute="users" role="form"
	class="form-horizontal" id="addUserForm">
	<div class="form-group">
		<label for="username" class="col-sm-2 control-label">用户名：</label>
		<div class="col-sm-10">
			<form:input type="text" class="form-control" id="username"
				placeholder="输入用户名" path="username" />
		</div>
	</div>
	<div class="form-group">
		<label for="password" class="col-sm-2 control-label">密码：</label>
		<div class="col-sm-10">
			<form:input type="password" class="form-control" id="password" 
				placeholder="输入密码" path="password" />
		</div>
	</div>
	<div class="form-group">
		<label for="passwordagain" class="col-sm-2 control-label">重复密码：</label>
		<div class="col-sm-10">
			<form:input type="password" class="form-control" id="passwordagain"
				placeholder="再次输入密码" path="passwordAgain" />
		</div>
	</div>
	<div class="form-group">
		<label for="telephone" class="col-sm-2 control-label">电话号码：</label>
		<div class="col-sm-10">
			<form:input type="text" class="form-control" id="telephone"
				placeholder="电话号码" path="password" />
		</div>
	</div>

	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<input type="submit" class="btn btn-default" value="添加用户" /> <input
				type="reset" class="btn btn-default" value="重置" />
		</div>
	</div>
</form:form>