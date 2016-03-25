<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
%>
<script type="text/javascript">
	$().ready(function() {
		$("#editUserForm").validate({
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
					minlength : "用户名至少包含两个字符"
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
</script>

<form:form method="POST" modelAttribute="user" role="form"
	class="form-horizontal" id="editUserForm">
	<div class="boxed-group">
		<h3>修改用户信息</h3>
		<div
			class="boxed-group-inner clearfix js-uploadable-container js-upload-avatar-image is-default"
			data-upload-policy-url="/upload/policies/avatars">
			<br/>
			<!-- 
	<div class="form-group">
		<label for="id" class="col-sm-2 control-label">用户ID：</label>
		<div class="col-sm-10">
			<form:input type="text" class="form-control" id="id" path="id" />
		</div>
	</div> -->
			<div class="form-group">
				<label for="username" class="col-sm-2 control-label">用户名：</label>
				<div class="col-sm-10">
					<form:input type="text" class="form-control" id="username"
						placeholder="输入用户名" path="username" disabled="true" />
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
					<form:input type="password" class="form-control" id="passwordTemp" path="passwordTemp" style="display:none"/>
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
					<form:select path="role" class="form-control" id="role" disabled="${user.role=='ROLE_ADMIN'}">
						<c:forEach var="item" items="${roles}">
							<form:option value="${item}">${item.description}</form:option>
						</c:forEach>
					</form:select>
				</div>
			</div>
			<div class="form-group">
				<label for="department.id" class="col-sm-2 control-label">部门：</label>
				<div class="col-sm-10">
					<form:select path="department.id" class="form-control"
						id="department.id">
						<c:forEach var="item" items="${departments}">
							<form:option value="${item.id}">${item.departmentname}</form:option>
						</c:forEach>
					</form:select>
				</div>
			</div>
			<div class="form-group">
				<label for="username" class="col-sm-2 control-label">创建时间：</label>
				<div class="col-sm-10">
					<form:input type="text" class="form-control" id="username"
						path="createdat" disabled="true" />
				</div>
			</div>
			<div class="form-group">
				<label for="username" class="col-sm-2 control-label">用户积分：</label>
				<div class="col-sm-10">
					<c:forEach begin="0" end="${user.grade}" step="1">
						<img src="<%=path%>/images/grade.png" style="width: 16px" />
					</c:forEach>
					&nbsp;&nbsp;&nbsp;共计登陆<font color="green"> ${user.loginCount }</font>&nbsp;次
				</div>
			</div>
			<div class="form-group">
				<label for="username" class="col-sm-2 control-label">最后登陆时间：</label>
				<div class="col-sm-10">
					<form:input type="text" class="form-control" id="username"
						path="lastLogin" disabled="true" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="button" class="btn btn-primary"
						onclick="location='../search'">关闭</button>
					<button type="submit" class="btn btn-primary">保存修改</button>
				</div>
			</div>
		</div>
	</div>
</form:form>