<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><tiles:insertAttribute name="title" ignore="true" /></title>
<link href="<%=path%>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/css/layout.css" rel="stylesheet">
<link href="<%=path%>/css/bootstrap-table.min.css" rel="stylesheet">
<link href="<%=path%>/css/bootstrap-theme.min.css" rel="stylesheet">
<script src="<%=path%>/js/jquery-1.11.2.min.js"></script>
<script src="<%=path%>/js/bootstrap-table.min.js"></script>
<script src="<%=path%>/js/bootstrap.min.js"></script>
<script src="<%=path%>/js/jquery.validate.js"></script>
<script src="<%=path%>/js/longxin.js"></script>
</head>
<body>
	<div style="display:none" id="meanItem"><tiles:getAsString name="menuItem"></tiles:getAsString></div>
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<tiles:insertAttribute name="header" />
		</div>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<tiles:insertAttribute name="menu" />
			</div>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
					<li><a href="#">Home</a></li>
					<li><a href="#">2013</a></li>
					<li class="active">十一月</li>
				</ol>
				<tiles:insertAttribute name="body" />
			</div>
		</div>
	</div>
</body>
</html>
