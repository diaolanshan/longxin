<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.form-control {
    width: 70%;
}
</style>

<form:form method="POST" modelAttribute="component" role="form"
	class="form-horizontal" id="editProductForm">
	<fieldset>
		<legend>
			${component.name}细节 &nbsp;&nbsp;&nbsp;&nbsp;<a href="../diagram/${component.id}"><span
				class="glyphicon glyphicon-indent-left"></span></a>
		</legend>
		<div class="form-group">
			<label for="id" class="col-sm-3 control-label">组件描述：</label>
			<div class="control-label">${component.description}</div>
		</div>
		<c:forEach items="${parameters}" var="parameter">
			<div class="form-group">
				<label for="id" class="col-sm-3 control-label">${parameter.parameterName}：</label>
				<div class="control-label" style="width:100%">
					<div style="width:150px;float:left;display:inline">${parameter.parameterValue}&nbsp;&nbsp;${parameter.unitName}</div>
					<c:choose>
						<c:when test="${parameter.valueScope!=null}">
							<div style="width: 100px; hefloat: left; display: inline;font-size:11px;color:gray">取值范围(${parameter.minValue},${parameter.maxValue})</div>
						</c:when>
						<c:otherwise>
							<div style="width: 200px; hefloat: left; display: inline;font-size:11px;color:gray">可选值(${parameter.options})</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</c:forEach>
		
		<div class="form-group">
			<div class="col-sm-offset-7 col-sm-5" style="align: right">
				<input type="button" id="add_new" class="btn btn-primary" value="增加属性"></input>
			</div>
		</div>
	</fieldset>
</form:form>
<div class="entry-form">
	<form name="userinfo" id="userinfo">
		<table width="100%" border="0" cellpadding="4" cellspacing="0">
			<tr>
				<td colspan="2" align="right"><a href="#" id="close">Close</a></td>
			</tr>
			<tr>
				<td>参数名称：</td>
				<td><input type="text" name="parameterName"></td>
			</tr>
			<tr>
				<td>默认值：</td>
				<td><input type="text" name="parameterValue"></td>
			</tr>
			<tr>
				<td>最小值：</td>
				<td><input type="text" name="minValue"></td>
			</tr>
			<tr>
				<td>最大值：</td>
				<td><input type="text" name="maxValue"></td>
			</tr>
			<tr>
				<td>单位：</td>
				<td><input type="text" name="unitName"></td>
			</tr>
			<tr>
				<td>可选项：</td>
				<td><input type="text" name="options"></td>
			</tr>
			<tr>
				<td align="right"></td>
				<td><input type="button" value="Save" id="saveparameter" class="btn btn-primary">&nbsp;&nbsp;&nbsp;&nbsp;<input
					type="button" value="cancel" id="cancel" class="btn btn-primary"></td>
			</tr>
		</table>
	</form>
</div>