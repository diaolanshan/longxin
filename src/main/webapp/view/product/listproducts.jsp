<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%  
String path = request.getContextPath();  
%>
<style>
a {
    color: #2bc0be;
}
</style>
<script>
	var productToBeDelete;
    $(function () {
		$('#searchTable1').bootstrapTable({
		}).on('dbl-click-row.bs.table', function (e, row, $element) {
			location.href="./list/"+row.id;
        });
		
	    $('#deleteProductButton').click(function()
    	    {
  				$.ajax({
  			   	      url:'<%=path%>/product/'+productToBeDelete,
  			   	      method: "DELETE",
  			   	     }).done(function(){
  			   	   		 $('#product'+productToBeDelete).fadeOut(function(){
			   	          $(this).remove(); 
			   	        });
  			   	    })
  				
  			    	$('#myModal').modal('hide');
    	    });
	});
    function showDailog(productId){
    	productToBeDelete = productId;
    	$('#myModal').modal('show');
    }
    
    function createProduct()
    {
    	document.searchProductForm.method = "POST";
		document.searchProductForm.action = "./create";
		document.searchProductForm.submit();
    }
</script>

<form:form method="POST" modelAttribute="productSearchBean" role="form"
	class="form-horizontal" id="searchProductForm">
	
	<table id="table-javascript"></table>
	<fieldset>
		<legend>产品管理</legend>
		<div class="form-group">
			<form:input type="text" class="form-control" style="display:inline;margin-left:10px" id="keyword"  path="keyword" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="submit" class="btn btn-primary start-example" value="查询" />&nbsp; &nbsp;&nbsp;
			  <sec:authorize access="hasRole('ROLE_SUPERTECHNICALSUPPORT')">
			  	<a href="./create"><input type="button" class="btn btn-primary start-example" value="创建新产品" /></a>
			  </sec:authorize>
		</div>
	</fieldset>
	<br/>
	<c:if test="${not searched}">
	<div style="margin-left:-5px">
		<table data-toggle="table" data-cache="false" data-height="425" data-pagination="true" id="searchTable1" >
			<thead>
		        <tr class="success">
					<th data-field="id"  data-sortable="true" data-halign="center">ID</th>
					<th data-field="name"  data-sortable="true" data-halign="center">产品名称</th>
					<th data-field="createdat"  data-sortable="true" data-halign="center">创建日期</th>
					<th data-field="owner"  data-sortable="true" data-halign="center">创建人</th>
		            <th data-sortable="false" data-halign="center">操作区域</th>
		        </tr>
	   	 	</thead>
	   	 	<tbody>
	   	 		<c:forEach items="${products}" var="product">  
	            <tr id="product${product.id}">  
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
	</c:if>

	<c:if test="${searched}">
		<div style="margin-left: -5px">
			<c:forEach items="${products}" var="product">
				<div style="font-size:19px">
					<c:choose>
						<c:when test="${product.searched}">
							 <a href="../product/list/${product.id}">${product.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${product.description}</a>
						</c:when>
						<c:otherwise>
							${product.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${product.description}
						</c:otherwise>
					</c:choose>
					<c:forEach items="${product.tempFeatures}" var="feature">
						<div style="padding-left:30px;font-size:18px">
							<img alt="" src="<%=path%>/images/arrow.png" style="width:23px">
							<c:choose>
								<c:when test="${feature.searched}">
									 <a href="../feature/view/${feature.id}">${feature.featureName} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${feature.description}</a>
								</c:when>
								<c:otherwise>
									${feature.featureName} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${feature.description}
								</c:otherwise>
							</c:choose>
							<c:forEach items="${feature.tempModules}" var="module">
								<div style="padding-left:30px;font-size:17px">
									<img alt="" src="<%=path%>/images/arrow.png" style="width:23px">
									<c:choose>
										<c:when test="${module.searched}">
											 <a href="../module/view/${module.id}">${module.moduleName} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${module.description}</a>
										</c:when>
										<c:otherwise>
											${module.moduleName} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${module.description}
										</c:otherwise>
									</c:choose>
									<c:forEach items="${module.tempL1Components}" var="l1">
										<div style="padding-left:30px;font-size:16px">
											<img alt="" src="<%=path%>/images/arrow.png" style="width:22px">
											<c:choose>
												<c:when test="${l1.searched}">
													 <a href="../l1component/view/${l1.id}">${l1.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${l1.description}</a>
												</c:when>
												<c:otherwise>
													${l1.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${l1.description}
												</c:otherwise>
											</c:choose>
											<c:forEach items="${l1.tempL1Parameters}" var="parameter">
												<img alt="" src="<%=path%>/images/arrow.png" style="width:21px">
												<div style="padding-left:30px;font-size:15px">
													 <a href="../l1component/view/${l1.id}">${parameter.parameterName}
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														${parameter.parameterValue}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<c:choose>
															<c:when test="${parameter.options == ''}">
																<div style="width: 300px; hefloat: left; display: inline; font-size: 11px; color: gray">取值范围(${parameter.minValue},${parameter.maxValue})</div>
															</c:when>
															<c:otherwise>
																<div style="width: 200px; hefloat: left; display: inline; font-size: 11px; color: gray">可选值(${parameter.options})</div>
															</c:otherwise>
														</c:choose> 
														<c:choose>
															<c:when test="${parameter.scopeStatus}">
																<img alt="取值范围已被论证"
																	src="<%=path%>/images/greenlight.png"
																	style="width: 14px;" title="取值范围已被论证">
															</c:when>
															<c:otherwise>
																<img alt="取值范围未被论证"
																	src="<%=path%>/images/redlight.png"
																	style="width: 14px;" title="取值范围还未被论证">
															</c:otherwise>
														</c:choose>
													</a>
												</div>
											</c:forEach>
											<c:forEach items="${l1.tempL2Components}" var="l2">
												<div style="padding-left:30px">
													<img alt="" src="<%=path%>/images/arrow.png" style="width:19px">
													<c:choose>
														<c:when test="${l2.searched}">
															 <a href="../l2component/view/${l2.id}">${l2.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${l2.description}</a>
														</c:when>
														<c:otherwise>
															${l2.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${l2.description}
														</c:otherwise>
													</c:choose>
													<c:forEach items="${l2.tempL2Parameters}" var="parameter">
														<img alt="" src="<%=path%>/images/arrow.png" style="width:18px">
														<div style="padding-left:30px;font-size:14px">
															 <a href="../l2component/view/${l2.id}">${parameter.parameterName}
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																	${parameter.parameterValue}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																	<c:choose>
																		<c:when test="${parameter.options == ''}">
																			<div style="width: 300px; hefloat: left; display: inline; font-size: 11px; color: gray">取值范围(${parameter.minValue},${parameter.maxValue})</div>
																		</c:when>
																		<c:otherwise>
																			<div style="width: 200px; hefloat: left; display: inline; font-size: 11px; color: gray">可选值(${parameter.options})</div>
																		</c:otherwise>
																	</c:choose> 
																	<c:choose>
																		<c:when test="${parameter.scopeStatus}">
																			<img alt="取值范围已被论证"
																				src="<%=path%>/images/greenlight.png"
																				style="width: 14px;" title="取值范围已被论证">
																		</c:when>
																		<c:otherwise>
																			<img alt="取值范围未被论证"
																				src="<%=path%>/images/redlight.png"
																				style="width: 14px;" title="取值范围还未被论证">
																		</c:otherwise>
																	</c:choose>
															</a>
														</div>
													</c:forEach>
													<c:forEach items="${l2.tempL3Components}" var="l3">
														<div style="padding-left:30px">
															<img alt="" src="<%=path%>/images/arrow.png" style="width:18px">
															<c:choose>
																<c:when test="${l3.searched}">
																	 <a href="../l3component/view/${l3.id}">${l3.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${l3.description}</a>
																</c:when>
																<c:otherwise>
																	${l3.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${l3.description}
																</c:otherwise>
															</c:choose>
															<c:forEach items="${l3.tempL3Parameters}" var="parameter">
																<div style="padding-left:30px;font-size:13px">
																   <img alt="" src="<%=path%>/images/arrow.png" style="width:17px">
																   <a href="../l3component/view/${l3.id}">${parameter.parameterName}
																		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																		${parameter.parameterValue}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																		<c:choose>
																			<c:when test="${parameter.options == ''}">
																				<div style="width: 300px; hefloat: left; display: inline; font-size: 11px; color: gray">取值范围(${parameter.minValue},${parameter.maxValue})</div>
																			</c:when>
																			<c:otherwise>
																				<div style="width: 200px; hefloat: left; display: inline; font-size: 11px; color: gray">可选值(${parameter.options})</div>
																			</c:otherwise>
																		</c:choose> 
																		<c:choose>
																			<c:when test="${parameter.scopeStatus}">
																				<img alt="取值范围已被论证"
																					src="<%=path%>/images/greenlight.png"
																					style="width: 14px;" title="取值范围已被论证">
																			</c:when>
																			<c:otherwise>
																				<img alt="取值范围未被论证"
																					src="<%=path%>/images/redlight.png"
																					style="width: 14px;" title="取值范围还未被论证">
																			</c:otherwise>
																		</c:choose>
																	</a>
																</div>
															</c:forEach>
														</div>
													</c:forEach>
												</div>
											</c:forEach>
										</div>
									</c:forEach>
								</div>
							</c:forEach>
						</div>
					</c:forEach>
				</div>
				<hr/>
			</c:forEach>
		</div>
	</c:if>
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
        <button type="button" class="btn btn-primary" id="deleteProductButton">确定</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>