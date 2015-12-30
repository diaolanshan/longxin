<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%  
String path = request.getContextPath();  
%>

<form:form method="POST" modelAttribute="rounder" role="form" id="selectForm" action="../../matrix/${featureId}/updatematrix">
	<fieldset>
		<legend>创建功能结构--物理结构映射</legend>
		<table data-toggle="table" data-cache="false" data-height="350" data-pagination="true" id="searchTable1" data-show-header="false">
		<tbody>
			<tr>
				<td rowspan="2" data-halign="center"></td>
				<c:forEach var="module" items="${modules}">
					<td colspan="${module.l1Components.size()}">${module.moduleName}</td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach var="module" items="${modules}">
					<c:forEach var="l1Component" items="${module.l1Components}">
						<td style="border-left-style:solid;border-left-color:#ddd">${l1Component.name}</td>
					</c:forEach>
				</c:forEach>
			</tr>
			<c:forEach var="bean" items="${rounder.bean}" varStatus="status1">
				<tr>
					<td style="height:30px">${bean.rowName}</td>
					<c:forEach var="matrix" items="${bean.matrixs}" varStatus="status2">
						<td><form:checkbox path="bean[${status1.index}].matrixs[${status2.index}].isChecked" onclick="javascript:disSelectTheOthers(${rounder.bean.size()},this.id)"/></td>
					</c:forEach>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<br/>
	<div class="form-group">
		<div class="col-sm-offset-4 col-sm-2">
			<button type="submit" class="btn btn-primary">保存</button>
			<button type="button" class="btn btn-primary"
				onclick="location='../../../view/${featureId}'">取消</button>
		</div>
	</div>
	</fieldset>
</form:form>
<script type="text/javascript">
function disSelectTheOthers(count,selected)
{
	for (var i=0;i<count;i++)
	{
		var secondPart = selected.substring(selected.indexOf(".", 0)+1);
		var others = "bean"+i + "." + secondPart;
		if(others!=selected)
			{
			$(document.getElementById(others)).removeAttr("checked","");
			}
	}
}
</script>