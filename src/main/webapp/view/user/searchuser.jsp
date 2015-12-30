<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%  
String path = request.getContextPath(); 
%>  
<script>
	var deleteUserId;
 	function showDailog(userId){
    	deleteUserId = userId;
    	$('#myModal').modal('show');
    }    
    $(function () {
		$('#searchTable').bootstrapTable({
			
		}).on('dbl-click-row.bs.table', function (e, row, $element) {
			location.href="./edit/"+row.id;
        });
		
		$('#deleteUser').click(function()
		{
			$.ajax({
		   	      url:'<%=path%>/user/delete/'+deleteUserId,
		   	      method: "DELETE",
		   	     }).done(function(){
		   	        $('#user'+deleteUserId).fadeOut(function(){
		   	          $(this).remove(); 
		   	        });
		   	    })

		    	$('#myModal').modal('hide');
		    });
	}); 	
</script>

<form:form method="POST" modelAttribute="userSearchBean" role="form"
	class="form-horizontal" id="searchUserForm">
	<table id="table-javascript"></table>
	<fieldset>
		<legend>用户管理</legend>
		<div class="form-group">
			<form:input type="text" class="form-control" id="keyword" style="display:inline;margin-left:10px" path="keyword" />&nbsp;&nbsp;
			<input type="submit" class="btn btn-primary start-example" value="查询" />
			&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="<%=path%>/user/add" class="btn btn-primary start-example"><font style="color:#fff">添加用户</font></a>
		</div>
	</fieldset>
	<br/>
	<table data-toggle="table" data-cache="false" data-height="425" data-pagination="true" id="searchTable" data-row-style="rowStyle">
		<thead>
	        <tr class="success">
	            <th data-field="id" data-visible="false" data-sortable="true" data-halign="center">用户ID</th>
	            <th data-field="username"  data-sortable="true" data-halign="center">用户名</th>
	            <th data-field="createdat"  data-sortable="true" data-halign="center">创建日期</th>
	            <th data-field="telephone"  data-sortable="true" data-halign="center">电话</th>
	            <th data-field="role"  data-sortable="true" data-halign="center">权限</th>
	            <th data-field="loginCount"  data-sortable="true" data-halign="center">用户积分</th>
	            <th data-field="department"  data-sortable="true" data-halign="center">部门</th>
	            <th data-sortable="false" data-halign="center">操作区域</th>
	        </tr>
   	 	</thead>
   	 	<tbody>
   	 		<c:forEach var="item" items="${users}">
   	 			<tr id="user${item.id}">
   	 				<td data-visible="false">${item.id}</td>
   	 				<td>${item.username}</td>
   	 				<td>${item.getDisplayCreatedAt()}</td>
   	 				<td>${item.telephone}</td>
   	 				<td>${item.role.description}</td>
   	 				<td >
   	 				<c:forEach begin="0" end="${item.grade}" step="1">
						<img src="<%=path%>/images/grade.png" style="width:17px"/>
	   	 			</c:forEach></td>
   	 				<td>${item.department.getDepartmentname()}</td>
   	 				<td>
   	 					<a href="./edit/${item.id}"  data-toggle="popover" title="编辑"><img alt="" src="<%=path%>/images/edit.png"></a>
   	 					&nbsp;&nbsp;
   	 					<a href="javascript:void(0);" onclick="showDailog(${item.id})"  data-toggle="popover" title="删除" title=""><img alt="" src="<%=path%>/images/delete.png"></a>
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
        <button type="button" class="btn btn-primary" id="deleteUser">确定</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
