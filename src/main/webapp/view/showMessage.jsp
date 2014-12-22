<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>  
  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  
<html>  
  <head>  
    <base href="<%=basePath%>">  
      
    <title>My JSP 'index.jsp' starting page</title>  
    <meta http-equiv="pragma" content="no-cache">  
    <meta http-equiv="cache-control" content="no-cache">  
    <meta http-equiv="expires" content="0">      
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">  
    <meta http-equiv="description" content="This is my page">   
  </head>  
    
  <body>  
    用户登陆 <br>  
     ${SPRING_SECURITY_LAST_EXCEPTION.message}  
      <form action="j_spring_security_check" method="post">  
                           用户名：<input type="text" name="j_username" value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}" /><br/>  
                           密码：<input type="password" name="j_password" value="" /><br/>  
        <input type="checkbox" name="_spring_security_remember_me" />两周之内不必登陆(这个功能没有做的)<br/>  
        <input type="submit">       
    </form>  
  </body>  
</html> 