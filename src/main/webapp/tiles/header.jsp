<%  
String path = request.getContextPath(); 
%>  
<%@ page language="java" pageEncoding="UTF-8"%>
<div id="navbar" class="navbar-collapse collapse" style="padding-right:30px">
	<ul class="nav navbar-nav navbar-right" style="margin-top:-50px;">
		<li><a href="<%=path%>/feature/listdraft"><img  alt="" style="width:50px;display:none" src="<%=path%>/images/reminder.png" id="approvernotification"></a></li>
		<li><a href="<%=path%>/user/profile"><img id="usericon" alt="" style="width:50px" src="<%=path%>/images/user.png"></a></li>
		<li><a href="/longxin/view/login.jsp"><img id="exiticon" alt="" style="width:50px" src="<%=path%>/images/exit.png"></a></li>
	</ul>
</div>