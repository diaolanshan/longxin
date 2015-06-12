<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%  
String path = request.getContextPath();  
%>
<form:form method="POST" modelAttribute="rounder" role="form" id="selectForm" action="./create">
	<fieldset>
		<legend>创建新产品</legend>
		<table data-toggle="table" data-cache="false" data-height="350" data-pagination="true" id="createnewproducttable" data-show-header="false">
			<tbody>
				<tr>
					<td rowspan="2" data-halign="center"></td>
					<c:forEach var="feature" items="${features}">
						<td colspan="${feature.modules.size()}">${feature.featureName}</td>
					</c:forEach>
				</tr>
				<tr>
					<c:forEach var="feature" items="${features}">
						<c:forEach var="module" items="${feature.modules}">
							<td style="border-left-style:solid;border-left-color:#ddd">${module.moduleName}</td>
						</c:forEach>
					</c:forEach>
				</tr>
				<c:forEach var="bean" items="${rounder.bean}" varStatus="status1">
					<tr>
						<td style="height:30px">${bean.rowName}</td>
						<c:forEach var="matrix" items="${bean.matrixs}" varStatus="status2">
							<td><form:checkbox path="bean[${status1.index}].matrixs[${status2.index}].isChecked"/></td>
						</c:forEach>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br/>
		<div class="form-group">
			<div class="col-sm-offset-4 col-sm-2">
				<button type="button" class="btn btn-primary"
					onclick="location='./search'">取消</button>
				<button type="submit" class="btn btn-primary">保存</button>
			</div>
		</div>
	</fieldset>
</form:form>
