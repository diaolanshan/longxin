$(document).ready(function(){
	$.ajax({
		type: "GET", 
		url: "/longxin/product/menu", 
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function(data){
			$.each(data, function(idx,item)
			{
				var newMenu = "<ul id=" + item.id + "><a href='/longxin/product/list/" + item.id + "'>" + item.name + "<span class='sr-only'></span></a></ul>";
				$("#productmanagement").append(newMenu);
			}
			)
		},
		error: function(res){
			alert("Unexpected error! Try again.");
		}
	})
	
	var targetMenu = $("#meanItem").text();
	$("#"+targetMenu).addClass("active");

	$("#add_new").click(function(){
		$("#parameterinfoForm").fadeIn("fast");	
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
				alert("Unexpected error! Try again.");
			}
		});
	}
	
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
				alert(res);
				alert("Unexpected error! Try again.");
			}
		});
  }
  
  function approveParameter(parameterId){
		$.ajax({
			type: "GET", 
			url: "./approve/parameter/" + parameterId, 
			dataType: "json",
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
  
  function declineParameter(parameterId){
  	$.ajax({
			type: "GET", 
			url: "./decline/parameter/" + parameterId, 
			dataType: "json",
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
  	$("#parameterAttachments").fadeIn("fast");
  	
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
