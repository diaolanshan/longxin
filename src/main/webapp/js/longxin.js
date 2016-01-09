$(document)
		.ready(
				function() {
					$
							.ajax({
								type : "GET",
								url : "/longxin/login/menu",
								dataType : "json",
								contentType : "application/json; charset=utf-8",
								success : function(data) {
									$
											.each(
													data,
													function(idx, item) {
														var newMenu = "<ul style='height: 40px;padding-top:15px;padding-left:60px;background-color: #393939' id="
																+ item.id
																+ "><a href='/longxin/product/list/"
																+ item.id
																+ "' style='font-size:14px;color:white'>"
																+ item.name
																+ "<span class='sr-only'></span></a></ul>";
														$("#productmanagement")
																.append(newMenu);
													})
								},
								error : function(xhr, ajaxOptions, thrownError) {
									alert("未知错误，请重试！");
								}
							})

					$("a,img,span").tooltip({
						show : null,
						position : {
							my : "left+15 center-15",
							at : "right center-15"
						},
						open : function(event, ui) {
							ui.tooltip.animate({
								top : ui.tooltip.position().top + 10
							}, "fast");
						}
					})

					$("#createDate").datepicker();

					$.ajax({
						type : "GET",
						url : "/longxin/login/waiting/count",
						contentType : "application/html; charset=utf-8",
						success : function(data) {
							if (data != 0) {
								$("#approvernotification").show();
							}
						},
						error : function(res) {
							alert("Unexpected error! Try againn.");
						}
					})

					var targetMenu = $("#meanItem").text();
					$("#" + targetMenu).addClass("active");

					$("#add_new").click(function() {
						$("#parameterinfoForm").modal('show');
					});

					$("#addrequirementbutton").click(function() {
						$("#addrequirement").modal('show');
					});

					$("#org").jOrgChart({
						chartElement : '#chart',
						dragAndDrop : true
					});

					$("#saveparameter").click(function() {
						ajax("save");
					});

					$(".closeForm").click(function() {
						$(".entry-form").fadeOut("fast");
					});

					$("#cancel").click(function() {
						$(".entry-form").fadeOut("fast");
					});

					// form 转 Object
					$.fn.serializeObject = function() {
						var o = {};
						var a = this.serializeArray();
						$.each(a, function() {
							if (o[this.name]) {
								if (!o[this.name].push) {
									o[this.name] = [ o[this.name] ];
								}
								o[this.name].push(this.value || '');
							} else {
								o[this.name] = this.value || '';
							}
						});
						return o;
					};

					function ajax(action, id) {
						if (action == "save") {
							if ($("#parameterinfo" + " #changeReason").val() === '') {
								alert("请输入添加原因");
								return;
							}
							data = $("#parameterinfo").serializeObject();
							// console.info(data);
						} else if (action == "delete") {
							data = "action=" + action + "&item_id=" + id;
						}
						componentId = $("#componentId").val();
						// console.info(componentId);
						$.ajax({
							type : "POST",
							url : "./" + componentId + "/add/parameter",
							data : JSON.stringify(data),
							dataType : "json",
							contentType : "application/json; charset=utf-8",
							success : function(response) {
								if (response.success == "1") {
									window.location.reload();
								}
							},
							error : function(res) {
								alert("Unexpected error! Try again.");
							}
						});
					}

					$(function() {
						$("#usericon").mouseover(
								function() {
									var src = $(this).attr("src").match(
											/[^\.]+/)
											+ "over.png";
									$(this).attr("src", src);
								}).mouseout(
								function() {
									var src = $(this).attr("src").replace(
											"over.png", ".png");
									$(this).attr("src", src);
								});
						$("#exiticon").mouseover(
								function() {
									var src = $(this).attr("src").match(
											/[^\.]+/)
											+ "over.png";
									$(this).attr("src", src);
								}).mouseout(
								function() {
									var src = $(this).attr("src").replace(
											"over.png", ".png");
									$(this).attr("src", src);
								});
					});
				});

function saveNewRequirement(productId) {
	var data = JSON.stringify($("#addrequirementform").serializeObject());
	$.ajax({
		type : "POST",
		url : "./save/" + productId,
		data : data,
		dataType : "json",
		contentType : "application/json; charset=utf-8",
		success : function(response) {
			if (response.success == "1") {
				window.location.reload();
			}
		},
		error : function(res) {
			alert("Unexpected error! Try again.");
		}
	});
}

function updateRequirement(requirementId, productId) {
	var data = JSON.stringify($("#updateRequirementForm" + requirementId)
			.serializeObject());
	$.ajax({
		type : "POST",
		url : "./update/" + productId,
		data : data,
		dataType : "json",
		contentType : "application/json; charset=utf-8",
		success : function(response) {
			if (response.success == "1") {
				window.location.reload();
			}
		},
		error : function(res) {
			alert("Unexpected error! Try again.");
		}
	});
}

function updateParameter(parameterId) {
	var formId = "updateParameterForm" + parameterId;
	if ($("#" + formId + " #changeReason").val() === '') {
		alert("请输入更改原因");
		return;
	}
	componentId = $("#componentId").val();
	$.ajax({
		type : "POST",
		url : "./" + componentId + "/update/parameter",
		data : JSON.stringify($("#updateParameterForm" + parameterId)
				.serializeObject()),
		dataType : "json",
		contentType : "application/json; charset=utf-8",
		success : function(response) {
			if (response.success == "1") {
				window.location.reload();
			}
		},
		error : function(res) {
			alert("Unexpected error! Try again.");
		}
	});
}

function approveParameter(parameterId) {
	var formId = "updateParameterForm" + parameterId;
	if ($("#" + formId + " #changeReason").val() === '') {
		alert("请输入批准原因");
		return;
	}
	$.ajax({
		type : "POST",
		url : "./approve/parameter/" + parameterId,
		dataType : "json",
		data : JSON.stringify($("#updateParameterForm" + parameterId)
				.serializeObject()),
		contentType : "application/json; charset=utf-8",
		success : function(response) {
			if (response.success == "1") {
				window.location.reload();
			}
		},
		error : function(res) {
			alert("Unexpected error! Try again.");
		}
	});
}

function declineParameter(parameterId) {
	var formId = "updateParameterForm" + parameterId;
	if ($("#" + formId + " #changeReason").val() === '') {
		alert("请输入拒绝原因");
		return;
	}
	$.ajax({
		type : "POST",
		url : "./decline/parameter/" + parameterId,
		dataType : "json",
		data : JSON.stringify($("#updateParameterForm" + parameterId)
				.serializeObject()),
		contentType : "application/json; charset=utf-8",
		success : function(response) {
			if (response.success == "1") {
				window.location.reload();
			}
		},
		error : function(res) {
			alert(res);
			alert("Unexpected error! Try again.");
		}
	});
}

function showParameterAttachments(parameterId, category) {
	$("#parameterAttachments").modal('show');

	$
			.ajax({
				type : "GET",
				url : "../../filecontroller/get/" + category + "/"
						+ parameterId,
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function(data) {
					$("#parameterAttachmentsDiv").empty();
					$
							.each(
									data,
									function(idx, item) {
										var downloadlink = "../../filecontroller/download/"
												+ item.id;
										var attachment = "<div style='display: inline;float:left;padding-left:10px; width:70px; text-align:center' id='parameterAttachment" + item.id
												+ "'>"
												+ "<a href = "
												+ downloadlink
												+ ">"
												+ "<img src='../../images/attachment.png' style='width:60px;border:1px dashed'/>"
												+ "</a>"
												+ "<br/>"
												+ item.fileName
												+ "<sec:authorize access='hasRole('ROLE_TECHNICALSUPPORT')'><a href='#' onclick='javascript:deleteParameterAttachment(" +item.id + ")'><br/><img src='../../images/delete.png'/></a></sec:authorize>"
												+ "</div>";
										$("#parameterAttachmentsDiv").append(
												attachment);
									})
				},
				error : function(res) {
					alert("Unexpected error! Try again.");
				}
			})
}

var obj;
var url;
var deleteType;

function deleteThis() {
	$.ajax({
		type : "DELETE",
		url : url,
		async : true,
		success : function(response) {
			$('#myModal').modal('hide');
			if (deleteType == 'subComponent') {
				$(obj).closest('tr').remove();
			} else {
				$(obj).closest('.form-group').remove();
			}
		},
		error : function(res) {
			alert(res.responseText);
			alert("Unexpected error! Try again.");
		}
	})
}

function deleteX(obj, deleteId, type) {
	this.obj = obj;
	this.deleteType = type;
	if (type == 'subComponent') {
		url = '../component/' + deleteId;
	} else {
		url = '../parameter/' + deleteId;
	}
	$('#myModal').modal('show');
}

function showHistory(category, parameterId) {
	$("#historyForm").modal('show');
	$
			.ajax({
				type : "GET",
				url : "../history/parameter/" + category + "/" + parameterId,
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				success : function(data) {
					$("#historyTable").empty();
					$("#changehistorymodal").css({
						"height" : data.length * 60 + 40 + "px"
					});
					if (data.length == 0) {
						$("#historyTable").append("这项参数没有更改记录");
						$("#changehistorymodal").css({
							"height" : "100px"
						});
					}
					$
							.each(
									data,
									function(idx, item) {
										if (item.operationType == 'ADD') {
											var body = "<tr><td><img src='../../images/timeline.png'/></td><td style='text-align:left'>"
													+ item.displayUpdateAt
													+ ',  '
													+ item.operator.username
													+ '增加了这个属性, 原因是:'
													+ item.comments
													+ "</td></tr>"
											$("#historyTable").append(body);
										}
										if (item.operationType == 'CHANGE') {
											var body = "<tr><td><img src='../../images/timeline.png'/></td><td style='text-align:left'>"
													+ item.displayUpdateAt
													+ ',  '
													+ item.operator.username
													+ "把值从<font color='green'>"
													+ item.oldValue
													+ "</font>变成<font color='green'>"
													+ item.newValue
													+ "</font>, 原因是："
													+ item.comments
													+ "</td></tr>"
											$("#historyTable").append(body);
										}
										if (item.operationType == 'APPROVE') {
											var body = "<tr><td><img src='../../images/timeline.png'/></td><td style='text-align:left'>"
													+ item.displayUpdateAt
													+ ',  '
													+ item.operator.username
													+ "批准了把值从<font color='green'>"
													+ item.oldValue
													+ "</font>变成<font color='green'>"
													+ item.newValue
													+ "</font>, 原因是："
													+ item.comments
													+ "</td></tr>"
											$("#historyTable").append(body);
										}
										if (item.operationType == 'DECLINE') {
											var body = "<tr><td><img src='../../images/timeline.png'/></td><td style='text-align:left'>"
													+ item.displayUpdateAt
													+ ',  '
													+ item.operator.username
													+ "拒绝了把值从<font color='green'>"
													+ item.oldValue
													+ "</font>变成<font color='green'>"
													+ item.newValue
													+ "</font>, 原因是："
													+ item.comments
													+ "</td></tr>"
											$("#historyTable").append(body);
										}
									})
				},
				error : function(res) {
					alert("Unexpected error! Try again.");
				}
			});
}
