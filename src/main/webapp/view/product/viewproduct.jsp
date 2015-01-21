<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
		<legend>产品细节 &nbsp;&nbsp;&nbsp;&nbsp;<a href="../diagram/${product.id}"><span class="glyphicon glyphicon-indent-left"></span></a> </legend>
		<table style="width: 100%">
			<tr>
				<td style="width: 25%; vertical-align: top"><img alt=""
					src="../../images/LX-8000.jpg" style="width: 250px"></td>

				<td style="vertical-align: top">
					<div class="form-group">
						<label for="id" class="col-sm-3 control-label">产品ID：</label>
						<div class="col-sm-5 control-label">${product.id}</div>

					</div>
					<div class="form-group">
						<label for="name" class="col-sm-3 control-label">产品名称：</label>
						<div class="col-sm-5 control-label">${product.name}</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-3 control-label">创建时间：</label>
						<div class="col-sm-5 control-label">${product.createdat}</div>
					</div>
					<div class="form-group">
						<label for="description" class="col-sm-3 control-label">描述：</label>
						<div class="col-sm-5 control-label">${product.description}</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-7 col-sm-5" style="align:right">
							<button type="button" class="btn btn-primary" onclick="location='../edit/${product.id}'">编辑</button>
						</div>
					</div>
				</td>
			</tr>
		</table>
		</fieldset>
		<br/>
		<br/>
		<div class="row placeholders">
            <c:forEach items="${features}" var="feature">
	            <div class="col-xs-6 col-sm-3 placeholder">
	              <a href="../../feature/view/${feature.id}"> <img src="../../images/${feature.iconName}.jpg" class="img-responsive" alt="Generic placeholder thumbnail"></a>
	              <h4>${feature.featureName}</h4>
	              <span class="text-muted">${feature.description}</span>
	            </div>
            </c:forEach>
        </div>
</form:form>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">确认框</h4>
			</div>
			<div class="modal-body">确认要删除该产品？</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary"
					onclick="deleteProduct()">确定</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>