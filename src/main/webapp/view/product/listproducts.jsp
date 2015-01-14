<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<script>
	var deleteProductId;
    $(function () {
		$('#searchTable1').bootstrapTable({
			
		}).on('dbl-click-row.bs.table', function (e, row, $element) {
			location.href="./edit/"+row.id;
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
			<label for="keyword" class="col-sm-2 control-label">关键字：</label>
			<div class="col-sm-10">
				<form:input type="text" class="form-control" id="keyword"  path="keyword" />
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<input type="submit" class="btn btn-primary start-example" value="查询" />&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="http://localhost:8080/longxin/product/add" class="btn btn-primary start-example"><font style="color:#fff">添加产品</font></a>
			</div>
		</div>
	
	</fieldset>
	<br/>
	<table data-toggle="table" data-cache="false" data-height="299" data-pagination="true" id="searchTable1">
		<thead>
	        <tr>
				<th data-field="id"  data-sortable="true">ID</th>
				<th data-field="name"  data-sortable="true">产品名称</th>
				<th data-field="createdat"  data-sortable="true">创建日期</th>
	            <th data-sortable="false">操作</th>
	        </tr>
   	 	</thead>
   	 	<tbody>
   	 		<c:forEach items="${products}" var="product">  
            <tr>  
                <td>${product.id}</td>  
                <td>${product.name}</td>  
                <td>${product.createdat}</td>  
                <td>
                <a href="./edit/${product.id}"  data-toggle="popover" title="编辑"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
   	 			&nbsp;&nbsp;
   	 			<a href="javascript:void(0);" onclick="showDailog(${product.id})"  data-toggle="popover" title="删除"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a>
   	 					  
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
      <div class="modal-body"> 确认要删除该产品？</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="deleteProduct()">确定</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
