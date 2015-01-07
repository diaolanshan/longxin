<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<script>
    $(function () {

            $('#table-javascript').bootstrapTable({
                method: 'get',
                url: 'http://localhost:8080/longxin/user/list/all.json',
                cache: false,
                height: 400,
                striped: true,
                pagination: true,
                pageSize: 50,
                pageList: [10, 25, 50, 100, 200],
                search: true,
                showColumns: true,
                showRefresh: true,
                minimumCountColumns: 2,
                clickToSelect: true,
                columns: [{
                    field: 'state',
                    checkbox: true
                }, {
                    field: 'id',
                    title: 'Item ID',
                    align: 'right',
                    valign: 'bottom',
                    sortable: true
                }, {
                    field: 'name',
                    title: 'Item Name',
                    align: 'center',
                    valign: 'middle',
                    sortable: true,
                    formatter: nameFormatter
                }, {
                    field: 'price',
                    title: 'Item Price',
                    align: 'left',
                    valign: 'top',
                    sortable: true,
                    formatter: priceFormatter,
                    sorter: priceSorter
                }, {
                    field: 'operate',
                    title: 'Item Operate',
                    align: 'center',
                    valign: 'middle',
                    clickToSelect: false,
                    formatter: operateFormatter,
                    events: operateEvents
                }]
            });
        );
    });
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
	
	<table data-toggle="table" data-url="/longxin/user/list/all.json" data-cache="false" data-height="299" data-pagination="true">
		<thead>
	        <tr>
	            <th data-field="id"  data-sortable="true" >Item ID</th>
	            <th data-field="username"  data-sortable="true">Item Name</th>
	            <th data-field="createdat"  data-sortable="true">Item Price</th>
	        </tr>
   	 	</thead>
	</table>
	
</form:form>