<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<script>
	var deleteUserId;
    $(function () {
		$('#searchTable').bootstrapTable({
			
		}).on('dbl-click-row.bs.table', function (e, row, $element) {
			location.href="./edit/"+row.id;
        });
	});
    function showDailog(userId){
    	deleteUserId = userId;
    	$('#myModal').modal('show');
    }
    function deleteUser(){
    	$.post('./delete/'+deleteUserId);
    	$('#searchUserForm').submit();
    	$('#myModal').modal('hide');
    }
    
</script>

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
	<table data-toggle="table" data-cache="false" data-height="350" data-pagination="true" id="searchTable" data-row-style="rowStyle">
		<thead>
	        <tr class="success">
	            <th data-field="id" style="display:none" data-sortable="true">用户ID</th>
	            <th data-field="username"  data-sortable="true" >用户名</th>
	            <th data-field="createdat"  data-sortable="true">创建日期</th>
	            <th data-field="telephone"  data-sortable="true">电话</th>
	            <th data-field="role"  data-sortable="true">权限</th>
	            <th data-field="loginCount"  data-sortable="true">会员等级</th>
	            <th data-field="department"  data-sortable="true">部门</th>
	            <th data-sortable="false">操作</th>
	        </tr>
   	 	</thead>
   	 	<tbody>
   	 		<c:forEach var="item" items="${users}">
   	 			<tr>
   	 				<td style="display:none">${item.id}</td>
   	 				<td>${item.username}</td>
   	 				<td>${item.createdat}</td>
   	 				<td>${item.telephone}</td>
   	 				<td>${item.role.description}</td>
   	 				<td></td>
   	 				<td>${item.department.getDepartmentname()}</td>
   	 				<td>
   	 					<a href="./edit/${item.id}"  data-toggle="popover" title="编辑"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
   	 					&nbsp;&nbsp;
   	 					<a href="javascript:void(0);" onclick="showDailog(${item.id})"  data-toggle="popover" title="删除"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a>
   	 				</td>
   	 			</tr>
   	 		</c:forEach>
   	 	</tbody>
	</table>
	
</form:form>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">确认框</h4>
      </div>
      <div class="modal-body"> 确认要删除该用户？</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="deleteUser()">确定</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
