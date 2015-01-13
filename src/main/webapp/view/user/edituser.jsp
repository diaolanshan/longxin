<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<script type="text/javascript">
$().ready(function(){
	$("#editUserForm").validate({
		rules: {
			username: {
				required: true,
				minlength: 5,
				remote: {
					 url: "http://localhost:8080/longxin/user/check",
					 type: "get",
					 data: {
					 	username: function() 
					 		{
					 			return $("#username").val();
					 		}
					 	}
					 }
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
				minlength: "电话长度不能小于7位"
			}
		},
	});
	});
</script>

<form:form method="POST" modelAttribute="user" role="form"
	class="form-horizontal" id="editUserForm">
	<div class="form-group">
		<label for="id" class="col-sm-2 control-label">用户ID：</label>
		<div class="col-sm-10">
			<form:input type="text" class="form-control" id="id" path="id" />
		</div>
	</div>
	<div class="form-group">
		<label for="username" class="col-sm-2 control-label">用户名：</label>
		<div class="col-sm-10">
			<form:input type="text" class="form-control" id="username"
				placeholder="输入用户名" path="username" />
		</div>
	</div>

	<div class="form-group">
		<label for="telephone" class="col-sm-2 control-label">电话号码：</label>
		<div class="col-sm-10">
			<form:input type="text" class="form-control" id="telephone"
				placeholder="电话号码" path="telephone" />
		</div>
	</div>
	<div class="form-group">
		<label for="role" class="col-sm-2 control-label">用户角色：</label>
		<div class="col-sm-10">
			<form:select path="role" class="form-control" id="role">  
			  <option value="ROLE_VISITOR">普通用户</option>
			  <option value="ROLE_TECHNICALSUPPORT">技术人员</option>
			  <option value="ROLE_SUPERTECHNICALSUPPORT">高级技术人员</option>
			  <option value="ROLE_ADMIN">管理员</option>
	        </form:select>
		</div>
	</div>
	<div class="form-group">
		<label for="department.id" class="col-sm-2 control-label">部门：</label>
		<div class="col-sm-10">
			<form:select path="department.id" class="form-control" id="department">  
			   <c:forEach var="department" items="${departments}">
				  <option value="${department.id}">${department.departmentname}</option>
			  </c:forEach>
	        </form:select>
		</div>
	</div>
	
	
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
		<button type="button" class="btn btn-primary" onclick="location='../search'">关闭</button>
        <button type="submit" class="btn btn-primary">保存修改</button>
		</div>
	</div>
</form:form>