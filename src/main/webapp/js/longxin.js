$(document).ready(function(){
	$.ajax({
		type: "GET", 
		url: "http://localhost:8080/longxin/product/menu", 
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function(data){
			$.each(data, function(idx,item)
			{
				var newMenu = "<ul id=" + item.id + "><a href='/longxin/product/diagram/" + item.id + "'>" + item.name + "<span class='sr-only'></span></a></ul>";
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
		$(".entry-form").fadeIn("fast");	
	});
	
	 $("#org").jOrgChart({
         chartElement : '#chart',
         dragAndDrop  : true
     });
	
	$("#saveparameter").click(function(){
		ajax("save");
	});
	
	$("#close").click(function(){
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
					//$(".entry-form").fadeOut("fast");
					//alert(1);
					/*if(action == "save"){
						$(".entry-form").fadeOut("fast",function(){
							$(".table-list").append("<tr><td>"+response.fname+"</td><td>"+response.lname+"</td><td>"+response.email+"</td><td>"+response.phone+"</td><td><a href='#' id='"+response.row_id+"' class='del'>Delete</a></a></td></tr>");	
							if ( ! $.browser.msie ) {
								$(".table-list tr:last").effect("highlight", {
									color: '#4BADF5'
								}, 1000);
							}
						});	
					}else if(action == "delete"){
						var row_id = response.item_id;
						if ( ! $.browser.msie ) {
							$("a[id='"+row_id+"']").closest("tr").effect("highlight", {
								color: '#4BADF5'
							}, 1000);
						}
						$("a[id='"+row_id+"']").closest("tr").fadeOut();
					}*/
				}
			},
			error: function(res){
				alert("Unexpected error! Try again.");
			}
		});
	}
});
