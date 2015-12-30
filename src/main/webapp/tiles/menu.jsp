<%  
String path = request.getContextPath(); 
%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %> 
<ul class="nav nav-sidebar">
	<li id="productmanagement" style="padding-top:70px">
		<a href="/longxin/product/search" style="font-size:16px;color:white"><img alt="" src="<%=path%>/images/iconfont-fenlei.png">&nbsp;&nbsp;产品管理 </a>
	</li>
	<security:authorize ifAllGranted="ROLE_ADMIN">
		<li id="usermanagement">
			<a href="/longxin/user/search" style="font-size:16px;color:white"><img alt="" src="<%=path%>/images/iconfont-yonghu.png">&nbsp;&nbsp;用户管理</a>
		</li>
	</security:authorize>
	
	<security:authorize ifAllGranted="ROLE_ADMIN">
		<li id="permissionmanagement">
			<a href="/longxin/permission/select" style="font-size:16px;color:white"><img alt="" src="<%=path%>/images/permission.png">&nbsp;&nbsp;权限管理</a>
		</li>
	</security:authorize>
</ul>