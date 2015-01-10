<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %> 
<ul class="nav nav-sidebar">
	<li id="productmanagement"><a href="/longxin/product/add">产品查询 <span class="sr-only"></span></a></li>
	<security:authorize ifAllGranted="ROLE_ADMIN"><li id="usermanagement"><a href="/longxin/user/search">用户管理</a></li></security:authorize>
</ul>