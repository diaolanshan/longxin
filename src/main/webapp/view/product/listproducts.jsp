<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%  
String path = request.getContextPath();  
%>
<script>
	var deleteProductId;
    $(function () {
		$('#searchTable1').bootstrapTable({
			
		}).on('dbl-click-row.bs.table', function (e, row, $element) {
			location.href="./list/"+row.id;
        });
	});
    function showDailog(productId){
    	deleteProductId = productId;
    	$('#myModal').modal('show');
    }
    function deleteProduct(){
    	$.post('./delete/'+deleteProductId);
    	$('#searchProductForm').submit();
    	$('#myModal').modal('hide');
    }
    
</script>

<form:form method="POST" modelAttribute="productSearchBean" role="form"
	class="form-horizontal" id="searchProductForm">
	
	<table id="table-javascript"></table>
	<fieldset>
		<legend>产品管理</legend>
		<div class="form-group">
			<form:input type="text" class="form-control" style="display:inline;margin-left:10px" id="keyword"  path="keyword" />&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
			<input type="submit" class="btn btn-primary start-example" value="查询" />
		</div>
	</fieldset>
	<br/>
	<div style="margin-left:-5px">
		<table data-toggle="table" data-cache="false" data-height="350" data-pagination="true" id="searchTable1" >
			<thead>
		        <tr class="success">
					<th data-field="id"  data-sortable="true" data-halign="center">ID</th>
					<th data-field="name"  data-sortable="true" data-halign="center">产品名称</th>
					<th data-field="createdat"  data-sortable="true" data-halign="center">创建日期</th>
					<th data-field="owner"  data-sortable="true" data-halign="center">创建人</th>
		            <th data-sortable="false" data-halign="center">操作</th>
		        </tr>
	   	 	</thead>
	   	 	<tbody>
	   	 		<c:forEach items="${products}" var="product">  
	            <tr>  
	                <td>${product.id}</td>  
	                <td>${product.name}</td>  
	                <td>${product.createdat}</td>
	                <td>${product.owner.username}</td>  
	                <td>
	                <a href="./list/${product.id}"  data-toggle="popover" title="查看"><img alt="" src="<%=path%>/images/view.png"></a>
	                &nbsp;&nbsp;
	                <sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')">
	                <a href="./edit/${product.id}"  data-toggle="popover" title="编辑"><img alt="" src="<%=path%>/images/edit.png"></a>
	   	 			&nbsp;&nbsp;
	   	 			<a href="javascript:void(0);" onclick="showDailog(${product.id})"  data-toggle="popover" title="删除"><img alt="" src="<%=path%>/images/delete.png"></a>
	   	 			</sec:authorize>
	            </tr>  
	       		</c:forEach>
	   	 	</tbody>
		</table>
	</div>
</form:form>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">确认框</h4>
      </div>
      <div class="modal-body"> 确认要删除该产品？</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="deleteProduct()">确定</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>