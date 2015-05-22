<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
%>
<html>
<head>
<meta charset="utf-8">
<title>请登录</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/signin.css" rel="stylesheet">
<script src="<%=path%>/js/jquery-1.11.2.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script type="text/javascript">
	function formSubmit() {
		document.getElementById("login-form").submit()
	}
	$(document).ready(function(){
		 $("#loginicon")
	        .mouseover(function() { 
	            var src = $(this).attr("src").match(/[^\.]+/) + "over.png";
	            $(this).attr("src", src);
	        })
	        .mouseout(function() {
	            var src = $(this).attr("src").replace("over.png", ".png");
	            $(this).attr("src", src);
	        });
	})
</script>
</head>
<body class="loginBody">
	<div class="container">
		${SPRING_SECURITY_LAST_EXCEPTION.message}
		<form class="form-signin" action="<%=path%>/j_spring_security_check"
			method="post" id="login-form">
			<!-- <div><img alt="" src="../images/lego.png" style="display:inline;margin-left:-60px"><div style="display:inline;font-size: 30;margin-left:-60px;vertical-align: bottom;">请登录</div></div>
			<label for="inputUserName" class="sr-only">用户名</label> 
			<input type="text" id="inputUserName" name="j_username" class="form-control" style="background-image: url(../images/loginform-bg.png)" value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}" placeholder="用户名" required autofocus/>
			<label
				for="inputPassword" class="sr-only">密码</label>
			<input type="password" id="inputPassword" name="j_password" value="" class="form-control"
				placeholder="密码" required/>
			<button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>-->
			<div
				style="background-image: url(../images/form-bg.png); width: 460px; height: 280px; margin-top: 150px; margin-left: -100px">
				<div style="margin-left: 90px; padding-top: 70px">
					<table>
						<tr>
							<td><img alt="" src="../images/username.png"
								style="width: 25px">&nbsp;&nbsp;&nbsp;</td>
							<td><input type="text" id="inputUserName" name="j_username"
								class="form-control"
								value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}"
								placeholder="输入用户名" required autofocus /></td>
						</tr>
						<tr style="height: 10px"></tr>
						<tr>
							<td><img alt="" src="../images/password.png"
								style="width: 25px">&nbsp;&nbsp;&nbsp;</td>
							<td><input type="password" id="inputPassword"
								name="j_password" value="" class="form-control"
								placeholder="输入密码" required /></td>
						</tr>
						<tr style="height: 10px"></tr>
						<tr>
							<td></td>
							<td><a href="#" onclick="formSubmit()"><img
									id="loginicon" alt="" style="width: 150px"
									src="<%=path%>/images/login.png"></a></td>
						</tr>
					</table>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
