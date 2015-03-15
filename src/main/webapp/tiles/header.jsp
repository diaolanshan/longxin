<%  
String path = request.getContextPath(); 
%>  

<%@ page language="java" pageEncoding="UTF-8"%>
<div class="navbar-header">
	<button type="button" class="navbar-toggle collapsed"
		data-toggle="collapse" data-target="#navbar" aria-expanded="false"
		aria-controls="navbar">
		<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
		<span class="icon-bar"></span> <span class="icon-bar"></span>
	</button>
</div>
<div id="navbar" class="navbar-collapse collapse">
	<ul class="nav navbar-nav navbar-right" style="margin-top:20px;">
		<li><a href="#" id="userinformation"><img style="width:23px" src="<%=path%>/images/grade.png"/></a></li>
		<li><a href="#">个人信息</a></li>
		<li><a href="/longxin/view/login.jsp">退出</a></li>
	</ul>
</div>