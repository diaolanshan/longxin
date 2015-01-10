<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<form:form method="POST" modelAttribute="userSearchBean" role="form"
	class="form-horizontal" id="searchUserForm">
	
	<table id="table-javascript"></table>
	<fieldset>
		<legend>用户管理</legend>
		<div class="form-group">
			<label for="keyword" class="col-sm-2 control-label">关键字：</label>
			<div class="col-sm-10">
				<form:input type="text" class="form-control" id="keyword"  path="keyword" />
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<input type="submit" class="btn btn-primary start-example" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://localhost:8080/longxin/user/add" class="btn btn-primary start-example"><font style="color:#fff">添加用户</font></a>
			</div>
		</div>
	
	</fieldset>
	<br/>
	<table data-toggle="table" data-cache="false" data-height="299" data-pagination="true">
		<thead>
	        <tr>
	            <th data-field="id"  data-sortable="true">用户名</th>
	            <th data-field="username"  data-sortable="true">用户名</th>
	            <th data-field="createdat"  data-sortable="true">创建日期</th>
	            <th data-field="role"  data-sortable="true">权限</th>
	            <th data-field="department"  data-sortable="true">部门</th>
	            <th data-sortable="false">操作</th>
	        </tr>
   	 	</thead>
   	 	<tbody>
   	 		<c:forEach var="item" items="${users}">
   	 			<tr>
   	 				<td>${item.username}</td>
   	 				<td>${item.username}</td>
   	 				<td>${item.createdat}</td>
   	 				<td>${item.role.description}</td>
   	 				<td>${item.getDepartment().getDepartmentname()}</td>
   	 				<td><a href="/user/edit/${item.id}"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a></td>
   	 			</tr>
   	 		</c:forEach>
   	 	</tbody>
	</table>
	
</form:form>