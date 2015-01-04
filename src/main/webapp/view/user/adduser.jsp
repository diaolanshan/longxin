<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<form:form method="POST" modelAttribute="users" role="form" class="form-horizontal">
	<div class="form-group">
		<label for="username" class="col-sm-2 control-label">用户名：</label> 
		<div class="col-sm-10">
			<form:input
				type="text" class="form-control" id="username"
				placeholder="输入用户名" path="username"/>
		</div>
	</div>
	<div class="form-group">
		<label for="password" class="col-sm-2 control-label">密码：</label> 
		<div class="col-sm-10">
			<form:input
				type="password" class="form-control" id="password"
				placeholder="输入密码" path="password"/>
		</div>
	</div>
	<div class="form-group">
		<label for="passwordagain" class="col-sm-2 control-label">重复密码：</label> 
		<div class="col-sm-10">
			<form:input
				type="password" class="form-control" id="passwordagain"
				placeholder="再次输入密码" path="password"/>
		</div>
	</div>
	<div class="form-group">
		<label for="telephone" class="col-sm-2 control-label">电话号码：</label> 
		<div class="col-sm-10">
			<form:input
				type="text" class="form-control" id="telephone"
				placeholder="电话号码" path="password"/>
		</div>
	</div>
	<!-- <div class="form-group">
		<label for="role" class="col-sm-2 control-label">权限：</label> 
		<div class="col-sm-10">
			<form:select path="role">
				<form:options items=""/>
			</form:select>
		</div>
	</div> -->
	<div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <input type="submit" class="btn btn-default" value="添加用户" />
	      <input type="reset" class="btn btn-default" value="重置" />
	    </div>
  	</div>
</form:form>