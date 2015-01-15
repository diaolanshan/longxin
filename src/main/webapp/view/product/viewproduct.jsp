<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<script>
	var deleteProductId;
    $(function () {
		$('#searchTable1').bootstrapTable({
			
		}).on('dbl-click-row.bs.table', function (e, row, $element) {
			//location.href="./edit/"+row.id;
        });
	});
    function showDailog(productId){
    	//deleteProductId = productId;
    	//$('#myModal').modal('show');
    }
    function deleteProduct(){
    	$.post('./delete/'+deleteProductId);
    	location.href="./search";
    }
    
</script>

<form:form method="POST" modelAttribute="product" role="form"
	class="form-horizontal" id="viewProductForm">
	
	<fieldset>
		<legend>产品细节</legend>
		
		<div class="form-group">
			<label for="id" class="col-sm-2 control-label">产品ID：</label>
			<div class="col-sm-10">${product.id} <a href="#" class="btn btn-primary start-example" style="margin-left:550px"><font style="color:#fff">复制产品</font></a></div>
			
		</div>
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">产品名称：</label>
			<div class="col-sm-10">${product.name}</div>
		</div>
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">产品名称：</label>
			<div class="col-sm-10">${product.createdat}</div>
		</div>
	<div class="form-group">
			<label for="name" class="col-sm-2 control-label">特性列表 ：</label>
	</div>
	<div>
	<br/>
	<table data-toggle="table" data-cache="false" data-height="299" data-pagination="true" id="searchTable1">
		<thead>
	        <tr>
				<th data-field="id"  data-sortable="true">特性ID</th>
				<th data-field="featureName"  data-sortable="true">特性名称</th>
	            <th data-sortable="false">操作</th>
	        </tr>
   	 	</thead>
   	 	<tbody>
   	 		<c:forEach items="${features}" var="feature">  
            <tr>  
                <td>${feature.id}</td>  
                <td>${feature.featureName}</td>  
                <td>
                <a href="#"  data-toggle="popover" title="查看"><span class="glyphicon glyphicon-th" aria-hidden="true"></span></a>
                &nbsp;&nbsp;
                <a href="#"  data-toggle="popover" title="编辑"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></a>
   	 			&nbsp;&nbsp;
   	 			<a href="javascript:void(0);" onclick="showDailog(${feature.id})"  data-toggle="popover" title="删除"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a>
   	 					  
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