<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<body>
	<table class="table table-striped">
		<caption>条纹表格布局</caption>
		<thead>
			<tr>
				<th>名称</th>
				<th>城市</th>
				<th>密码</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<e:forEach items="${requestScope.projectlist}" var="product">  
            <tr>  
                <td>${product.id}</td>  
                <td>${product.name}</td>  
                <td>${product.createat}</td>  
                <td>${stu.address}</td>  
                <td><a href="/product/update/${product.id}">修改</a>||<a href="/product/delete/${product.id}">删除</a></td>  
            </tr>  
        </e:forEach>  
		</tbody>
	</table>
</body>
</html>
