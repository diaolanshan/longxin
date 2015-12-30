<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%  
String path = request.getContextPath();  
%>

<form:form method="POST" modelAttribute="feature" role="form"
	class="form-horizontal" id="viewProductForm">
	<fieldset>
		<legend>以下是等待审批的项目
		 </legend>
		 <div>
		 	${content}
		 </div>
	</fieldset>
</form:form>