<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link href="<%=path%>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/css/signin.css" rel="stylesheet">
<script src="<%=path%>/js/jquery-1.11.2.min.js"></script>
<script src="<%=path%>/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#loginicon").mouseover(function() {
			var src = $(this).attr("src").match(/[^\.]+/) + "over.png";
			$(this).attr("src", src);
		}).mouseout(function() {
			var src = $(this).attr("src").replace("over.png", ".png");
			$(this).attr("src", src);
		});
		
		$(document).keypress(function(e) {
		    if ((e.keyCode || e.which) == 13) {
		    	document.getElementById("login-form").submit();
		    }
		});
		
		$("#loginSubmit").click(function(){
			document.getElementById("login-form").submit();
		})
	})
</script>
</head>
<body class="loginBody">
		<div class="container" style="width: 930px;background-image: linear-gradient(to right, rgba(0, 0, 0, 0.5) 0px, rgba(0, 0, 0, 0) 100%);height:95px;text-align:middle;line-height:95px;">
			<div style="display:inline;width:640px">
				<font style="font-size: 30px;color:rgb(255,255,255)">龙鑫工程知识数据库登陆界面</font>
			</div>
			<div style="display:inline;float:right;width:240px">
				<img alt="" src="<%=path%>/images/mlc.png" style="width:300px">
			</div>
		</div>
		<div class="container" style="padding-top: 80px;padding-left: 120px">
			<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
				<font color="red">用户名或密码错误，请重试！${SPRING_SECURITY_LAST_EXCEPTION.message}
				</font>
			</c:if>
		</div>
		<div class="container"
			style="background-image: url(<%=path%>/images/login-bg.png); width: 930px; margin-top: 10px; height: 300px">
			<form class="form-signin" action="<%=path%>/j_spring_security_check"
				method="post" id="login-form">
				<div
					style="background-image: url(<%=path%>/images/form-bg.png); width: 460px; height: 270px; margin-left: -50px">
					<div style="margin-left: 70px; padding-top: 35px">
						<table>
							<tr>
								<td><img alt="" src="<%=path%>/images/username.png"
									style="width: 25px">&nbsp;&nbsp;&nbsp;</td>
								<td><input type="text" id="inputUserName" name="j_username"
									class="form-control"
									value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}"
									placeholder="输入用户名" required autofocus /></td>
							</tr>
							<tr style="height: 10px"></tr>
							<tr>
								<td><img alt="" src="<%=path%>/images/password.png"
									style="
									width: 25px">&nbsp;&nbsp;&nbsp;</td>
								<td><input type="password" id="inputPassword"
									name="j_password" value="" class="form-control"
									placeholder="输入密码" required /></td>
							</tr>
							<tr style="height: 10px"></tr>
							<tr>
								<td></td>
								<td><a href="#" id="loginSubmit"><img
										id="loginicon" alt="" style="width: 150px"
										src="<%=path%>/images/login.png"></a>
										</td>
							</tr>
						</table>
					</div>
				</div>
			</form>
		</div>
		<footer class="footer">
			<div class="container">
				<span class="text-muted">This information is confidential and
					was prepared by MLC solely for client;It is not to be relied on any
					3rd party without MLC's prior written consent.</span>
			</div>
		</footer>
</body>
</html>
