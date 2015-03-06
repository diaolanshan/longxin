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
	
	//file upload
	/*$('#fileupload').fileupload({
        dataType: 'json',
        
        done: function (e, data) {
        	$("tr:has(td)").remove();
            $.each(data.result, function (index, file) {
            	
            	
                $("#uploaded-files").append(
                		$('<tr/>')
                		.append($('<td/>').text(file.fileName))
                		.append($('<td/>').text(file.fileSize))
                		.append($('<td/>').text(file.fileType))
                		.append($('<td/>').html("<a href='http://localhost:8080/longxin/filecontroller/get/"+index+"'>Click</a>"))
                		)//end $("#uploaded-files").append()
            }); 
        },
        
        progressall: function (e, data) {
          var progress = parseInt(data.loaded / data.total * 100, 10);
          $('#progress .bar').css(
              'width',
              progress + '%'
          );
   		},
   		
    dropZone: $('#dropzone')
    });*/
});
