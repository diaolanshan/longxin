$(document).ready(function(){
	$.ajax({
		type: "GET", 
		url: "http://localhost:8080/longxin/product/menu", 
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function(data){
			$.each(data, function(idx,item)
					{
						var newMenu = "<ul style='height: 40px;padding-top:15px;padding-left:60px;background-color: #393939' id=" + item.id + "><a href='/longxin/product/list/" + item.id + "' style='font-size:14px;color:white'>" + item.name + "<span class='sr-only'></span></a></ul>";
						$("#productmanagement").append(newMenu);
					}
				)
		},
		error: function(res){
			alert("Unexpected error! Try again.");
		}
	})   
	
	$.ajax({
		type: "GET", 
		url: "http://localhost:8080/longxin/login/waiting/count",
		contentType: "application/html; charset=utf-8",
		success: function(data){
			if(data!=0)
			{
				$("#approvernotification").show();
			}
		},
		error: function(res){
			alert("Unexpected error! Try again.");
		}
	})     
	
	var targetMenu = $("#meanItem").text();
	$("#"+targetMenu).addClass("active");

	$("#add_new").click(function(){
		$("#parameterinfoForm").modal('show');	
	});
	
	 $("#org").jOrgChart({
         chartElement : '#chart',
         dragAndDrop  : true
     });
	
	$("#saveparameter").click(function(){
		ajax("save");
	});
	
	$(".closeForm").click(function(){
		$(".entry-form").fadeOut("fast");	
	});

	$("#cancel").click(function(){
		$(".entry-form").fadeOut("fast");	
	});

	//form 转 Object
	$.fn.serializeObject = function()    
	{    
	   var o = {};    
	   var a = this.serializeArray();    
	   $.each(a, function() {    
	       if (o[this.name]) {    
	           if (!o[this.name].push) {    
	               o[this.name] = [o[this.name]];    
	           }    
	           o[this.name].push(this.value || '');    
	       } else {    
	           o[this.name] = this.value || '';    
	       }    
	   });    
	   return o;    
	};  

	function ajax(action,id){
		if(action =="save")
		{
			data = $("#parameterinfo").serializeObject();
			//console.info(data);
		}
		else if(action == "delete"){
			data = "action="+action+"&item_id="+id;
		}
		componentId  = $("#componentId").val();
		//console.info(componentId);
		$.ajax({
			type: "POST", 
			url: "./"+componentId+"/add/parameter", 
			data : JSON.stringify(data),
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function(response){
				if(response.success == "1"){
					window.location.reload();
				}
			},
			error: function(res){
				alert("Unexpected error! Try agaiddddn.");
			}
		});
	}
	
	$(function() {
	    $("#usericon")
	        .mouseover(function() { 
	            var src = $(this).attr("src").match(/[^\.]+/) + "over.png";
	            $(this).attr("src", src);
	        })
	        .mouseout(function() {
	            var src = $(this).attr("src").replace("over.png", ".png");
	            $(this).attr("src", src);
	        });
	    $("#exiticon")
	        .mouseover(function() { 
	            var src = $(this).attr("src").match(/[^\.]+/) + "over.png";
	            $(this).attr("src", src);
	        })
	        .mouseout(function() {
	            var src = $(this).attr("src").replace("over.png", ".png");
	            $(this).attr("src", src);
	        });
	});
});


function updateParameter(parameterId){
		componentId  = $("#componentId").val();
		$.ajax({
			type: "POST", 
			url: "./"+componentId+"/update/parameter", 
			data : JSON.stringify($("#updateParameterForm"+parameterId).serializeObject()),
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function(response){
				if(response.success == "1"){
					window.location.reload();
				}
			},
			error: function(res){
				alert("Unexpected error! Try again.");
			}
		});
  }
  
  function approveParameter(parameterId){
		$.ajax({
			type: "POST", 
			url: "./approve/parameter/" + parameterId, 
			dataType: "json",
			data : JSON.stringify($("#updateParameterForm"+parameterId).serializeObject()),
			contentType: "application/json; charset=utf-8",
			success: function(response){
				if(response.success == "1"){
					window.location.reload();
				}
			},
			error: function(res){
				alert("Unexpected error! Try again.");
			}
		});
  }
  
  function declineParameter(parameterId){
  	$.ajax({
			type: "POST", 
			url: "./decline/parameter/" + parameterId, 
			dataType: "json",
			data : JSON.stringify($("#updateParameterForm"+parameterId).serializeObject()),
			contentType: "application/json; charset=utf-8",
			success: function(response){
				if(response.success == "1"){
					window.location.reload();
				}
			},
			error: function(res){
				alert(res);
				alert("Unexpected error! Try again.");
			}
		});
  }
  
  function showParameterAttachments(parameterId, category){
  	$("#parameterAttachments").modal('show');
  	
  	$.ajax({
  		type: "GET", 
  		url: "../../filecontroller/get/" + category + "/" + parameterId, 
  		dataType: "json",
  		contentType: "application/json; charset=utf-8",
  		success: function(data){
  			$("#parameterAttachmentsDiv").empty();
  			$.each(data, function(idx,item)
  			{
  				var downloadlink = "../../filecontroller/download/" + item.id;
  				var attachment = "<div style='display: inline;float:left;padding-left:10px; width:70px; text-align:center' title=" + item.fileName + ">" + "<a href = " + downloadlink + ">" + "<img src='../../images/attachment.png' style='width:60px;border:1px dashed'/>" + "</a>" + "<br/>" + item.fileName + "</div>";
  				$("#parameterAttachmentsDiv").append(attachment);
  			}
  			)
  		},
  		error: function(res){
  			alert("Unexpected error! Try again.");
  		}
  	})
  }
  
  function showHistory(category,parameterId){
  	$("#historyForm").modal('show');
		$.ajax({
			type: "GET", 
			url: "../history/parameter/" + category +"/" + parameterId, 
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function(data){
				$("#historyTable").empty();
				$.each(data, function(idx,item)
		    			{
							if(item.operationType=='ADD')
							{
		    				var body = "<tr><td><img src=''/></td><td style='text-align:left'>" + item.displayUpdateAt + '  ' + item.operator.username + '增加了这个属性' + "</td></tr>"
		    				$("#historyTable").append(body);
							}
							if(item.operationType=='CHANGE')
							{
		    				var body = "<tr><td><img src=''/></td><td style='text-align:left'>" + item.displayUpdateAt + '  ' + item.operator.username + "把值从<font color='green'>" + item.oldValue +"</font>变成<font color='green'>" + item.newValue + "</font>, 原因是：" + item.comments + "</td></tr>"
		    				$("#historyTable").append(body);
							}
							if(item.operationType=='APPROVE')
							{
		    				var body = "<tr><td><img src=''/></td><td style='text-align:left'>" + item.displayUpdateAt + '  ' + item.operator.username + "批准了把值从<font color='green'>" + item.oldValue +"</font>变成<font color='green'>" + item.newValue + "</font>, 原因是：" + item.comments + "</td></tr>"
		    				$("#historyTable").append(body);
							}
							if(item.operationType=='DECLINE')
							{
		    				var body = "<tr><td><img src=''/></td><td style='text-align:left'>" + item.displayUpdateAt + '  ' + item.operator.username + "拒绝了把值从<font color='green'>" + item.oldValue +"</font>变成<font color='green'>" + item.newValue + "</font>, 原因是：" + item.comments + "</td></tr>"
		    				$("#historyTable").append(body);
							}
		    			}
		    		)
			},
			error: function(res){
				alert("Unexpected error! Try again.");
			}
		});
	}
