<%@ page language="java" pageEncoding="UTF-8"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 

<form:form method="POST" modelAttribute="product"> 
   	 产品名称: <form:input path="name"/><br/> 
    <input type="submit" value="添加产品"/> 
</form:form>