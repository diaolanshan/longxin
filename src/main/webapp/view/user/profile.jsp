<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
	$().ready(function() {
		$("#updateForm").validate({
			rules : {
				telephone : {
					required : true,
					minlength : 7
				},
				password : {
					required : true,
					minlength : 5
				},
				passwordAgain : {
					required : true,
					minlength : 5,
					equalTo : "#password"
				}
			},
			messages : {
				username : {
					required : "请输入用户名",
					minlength : "用户名至少包含两个字符",
					remote : "用户名已经存在"
				},
				password : {
					required : "请输入密码",
					minlength : "密码长度不能小于5位"
				},
				telephone : {
					required : "请输入电话号码",
					minlength : "电话长度不能小于7位"
				},
				passwordAgain : {
					required : "请输入确认密码",
					minlength : "密码长度不能小于5位",
					equalTo : "两次输入密码不一致"
				}
			},
		});
	});

    function update(){
    	$("#updateForm").fadeIn("fast");
    }
</script>

<form:form method="POST" modelAttribute="user" role="form"
	class="form-horizontal" id="editUserForm">
	<fieldset>
		<legend>
			个人信息 &nbsp;&nbsp;&nbsp;
		</legend>
	<div class="form-group">
		<label for="username" class="col-sm-3 control-label">用户名：</label>
		<div class="control-label">${user.username}</div>
	</div>
	<div class="form-group">
		<label for="telephone" class="col-sm-3 control-label">电话号码：</label>
		<div class="control-label">${user.telephone}</div>
	</div>
	<div class="form-group">
		<label for="role" class="col-sm-3 control-label">用户角色：</label>
		<div class="control-label">${user.role.getDescription()}</div>
	</div>
	<div class="form-group">
		<label for="department.id" class="col-sm-3 control-label">部门：</label>
		<div class="control-label">${user.department.getDepartmentname()}</div>
	</div>
	
	
	<div class="form-group">
		<div class="col-sm-offset-7 col-sm-5" style="align: right">
			<input type="button" onclick="update()" class="btn btn-primary start-example" value="编辑个人信息" />&nbsp;&nbsp;
		</div>
	</div>
	</fieldset>
</form:form>

<div class="entry-form" id="updateForm">
	<form method="POST" action="./profile">
		<table width="100%" border="0" cellpadding="4" cellspacing="0">
			<tr>
			<td colspan="2" align="right"><a href="#" class="closeForm">关闭</a></td>
			</tr>
			<tr>
				<td>用户名：</td>
				<td><input type="text" name="username" value="${user.username}"></td>
			</tr>
			<tr>
				<td>密码：</td>
				<td><input type="password" name="password" id="password" value="${user.password}"></td>
			</tr>
			<tr>
				<td>重复密码：</td>
				<td><input type="password" name="passwordagain" value="${user.password}"></td>
			</tr>
			<tr>
				<td>电话号码：</td>
				<td><input type="text" name="telephone" value="${user.telephone}"></td>
			</tr>
			<tr>
				<td align="right"></td>
				<td><input type="submit" value="保存" class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="取消" class="btn btn-primary closeForm"></td>
			</tr>
		</table>
	</form>
</div>