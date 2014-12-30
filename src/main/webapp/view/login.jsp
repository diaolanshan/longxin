<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>  
<html>
<head>
<meta charset="utf-8">
<title>请登录</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/signin.css" rel="stylesheet">
<script src="../js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		${SPRING_SECURITY_LAST_EXCEPTION.message} 
		<form class="form-signin" action="<%=path %>/j_spring_security_check" method="post">
			<h2 class="form-signin-heading">请登录</h2>
			<label for="inputEmail" class="sr-only">用户名</label> 
			<input type="text" name="j_username" class="form-control" value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}" placeholder="用户名" required autofocus/>
			<label
				for="inputPassword" class="sr-only">密码</label>
			<input type="password" name="j_password" value="" class="form-control"
				placeholder="Password" required/>
			<button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
		</form>
	</div>
</body>
</html>
