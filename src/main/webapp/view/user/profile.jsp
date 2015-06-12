<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%  
String path = request.getContextPath();  
%>
<form:form method="GET" modelAttribute="user" role="form"
	class="form-horizontal" id="editUserForm">
	<div class="boxed-group">
		<h3>用户信息</h3>
		<div
			class="boxed-group-inner clearfix js-uploadable-container js-upload-avatar-image is-default"
			data-upload-policy-url="/upload/policies/avatars">
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
				<label for="role" class="col-sm-3 control-label">创建时间：</label>
				<div class="control-label">${user.createdat}</div>
			</div>
			<div class="form-group">
				<label for="department.id" class="col-sm-3 control-label">部门：</label>
				<div class="control-label">${user.department.getDepartmentname()}</div>
			</div>
			<div class="form-group">
				<label for="role" class="col-sm-3 control-label">登陆次数：</label>
				<div class="control-label">${user.loginCount}</div>
			</div>
			<br/>
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-10">
					<button type="button" onclick="location='<%=path%>/user/profile/${user.id}'" style="margin-left:-14px"
						class="btn btn-primary start-example" >编辑个人信息</button>
				</div>
			</div>
		</div>
	</div>
</form:form>