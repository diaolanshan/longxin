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
<link href="<%=path%>/css/bootstrap-table.min.css" rel="stylesheet">
<link href="<%=path%>/css/bootstrap-theme.min.css" rel="stylesheet">
<link href="<%=path%>/css/custom.css" rel="stylesheet">
<link href="<%=path%>/css/jquery.jOrgChart.css" rel="stylesheet">
<link href="<%=path%>/css/prettify.css" rel="stylesheet">
<link href="<%=path%>/css/layout.css" rel="stylesheet">
<script src="<%=path%>/js/jquery-1.11.2.min.js"></script>
<script src="<%=path%>/js/jquery-ui.min.js"></script>
<script src="<%=path%>/js/bootstrap.min.js"></script>
<script src="<%=path%>/js/bootstrap-table.min.js"></script>
<script src="<%=path%>/js/jquery.validate.js"></script>
<script src="<%=path%>/js/jquery.jOrgChart.js"></script>
<script src="<%=path%>/js/jquery.ui.widget.js"></script>
<script src="<%=path%>/js/jquery.fileupload.js"></script>
<script src="<%=path%>/js/jquery.iframe-transport.js"></script>
<script src="<%=path%>/js/jquery.poshytip.js"></script>
<script src="<%=path%>/js/longxin.js"></script>
</head>
<body>
	<div style="display:none" id="meanItem"><tiles:getAsString name="menuItem"></tiles:getAsString></div>
	<div class="navbar-fixed-top" style="width:100%">
		<img alt="" src="<%=path%>/images/lego.png" style="background-color: #2bc0be"> 
		<div style="display:inline;background-image:url(<%=path%>/images/header.png);background-repeat:no-repeat;margin-left:200px;height:95px" class="navbar-fixed-top">
			<div style="font-size:45px;padding-left:30px">杭州龙鑫科技有限公司</div>
			<tiles:insertAttribute name="header" />
		</div>
	</div>

	<div class="container-fluid" style="padding-top:50px">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar" style="padding-top:50px;background-color: #121921;width:200px">
				<tiles:insertAttribute name="menu" />
			</div>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<tiles:insertAttribute name="body" />
			</div>
		</div>
	</div>
</body>
</html>
