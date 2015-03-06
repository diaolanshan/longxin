<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>
<script src="<%=path%>/js/jssor.slider.mini.js"></script>
<script>
	var deleteProductId;
    $(function () {
		$('#searchTable1').bootstrapTable({
			
		}).on('dbl-click-row.bs.table', function (e, row, $element) {
			//location.href="./edit/"+row.id;
        });
	});
    $(function () {
    	$.ajax({
    		type: "GET", 
    		url: "../../filecontroller/get/product/" + $("#idvalue").text(), 
    		dataType: "json",
    		contentType: "application/json; charset=utf-8",
    		success: function(data){
    			$.each(data, function(idx,item)
    			{
    				var downloadlink = "../../filecontroller/download/product/" + $("#idvalue").text() + "/" + item.fileName;
    				var attachment = "<div style='display: inline; width: 15%;float:left; text-align:center' title=" + item.fileName + ">" + "<a href = " + downloadlink + ">" + "<img src='../../images/attachment.png' style='width:60px;border:1px dashed'/>" + "</a>" + "<br/>" + item.fileName + "</div>";
    				$("#attachments").append(attachment);
    				
    			}
    			)
    		},
    		error: function(res){
    			alert("Unexpected error! Try again.");
    		}
    	})
	});
    
    function deleteProduct(){
    	$.post('./delete/'+deleteProductId);
    	location.href="./search";
    }
    
    jQuery(document).ready(function ($) {
        var options = {
            $AutoPlay: true,                                    //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
            $AutoPlaySteps: 1,                                  //[Optional] Steps to go for each navigation request (this options applys only when slideshow disabled), the default value is 1
            $AutoPlayInterval: 2000,                            //[Optional] Interval (in milliseconds) to go for next slide since the previous stopped if the slider is auto playing, default value is 3000
            $PauseOnHover: 1,                                   //[Optional] Whether to pause when mouse over if a slider is auto playing, 0 no pause, 1 pause for desktop, 2 pause for touch device, 3 pause for desktop and touch device, 4 freeze for desktop, 8 freeze for touch device, 12 freeze for desktop and touch device, default value is 1

            $ArrowKeyNavigation: true,   			            //[Optional] Allows keyboard (arrow key) navigation or not, default value is false
            $SlideEasing: $JssorEasing$.$EaseOutQuint,          //[Optional] Specifies easing for right to left animation, default value is $JssorEasing$.$EaseOutQuad
            $SlideDuration: 800,                                //[Optional] Specifies default duration (swipe) for slide in milliseconds, default value is 500
            $MinDragOffsetToSlide: 20,                          //[Optional] Minimum drag offset to trigger slide , default value is 20
            //$SlideWidth: 600,                                 //[Optional] Width of every slide in pixels, default value is width of 'slides' container
            //$SlideHeight: 300,                                //[Optional] Height of every slide in pixels, default value is height of 'slides' container
            $SlideSpacing: 0, 					                //[Optional] Space between each slide in pixels, default value is 0
            $DisplayPieces: 1,                                  //[Optional] Number of pieces to display (the slideshow would be disabled if the value is set to greater than 1), the default value is 1
            $ParkingPosition: 0,                                //[Optional] The offset position to park slide (this options applys only when slideshow disabled), default value is 0.
            $UISearchMode: 1,                                   //[Optional] The way (0 parellel, 1 recursive, default value is 1) to search UI components (slides container, loading screen, navigator container, arrow navigator container, thumbnail navigator container etc).
            $PlayOrientation: 1,                                //[Optional] Orientation to play slide (for auto play, navigation), 1 horizental, 2 vertical, 5 horizental reverse, 6 vertical reverse, default value is 1
            $DragOrientation: 1,                                //[Optional] Orientation to drag slide, 0 no drag, 1 horizental, 2 vertical, 3 either, default value is 1 (Note that the $DragOrientation should be the same as $PlayOrientation when $DisplayPieces is greater than 1, or parking position is not 0)

            $ArrowNavigatorOptions: {                           //[Optional] Options to specify and enable arrow navigator or not
                $Class: $JssorArrowNavigator$,                  //[Requried] Class to create arrow navigator instance
                $ChanceToShow: 2,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
                $AutoCenter: 2,                                 //[Optional] Auto center arrows in parent container, 0 No, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
                $Steps: 1,                                      //[Optional] Steps to go for each navigation request, default value is 1
                $Scale: false                                   //Scales bullets navigator or not while slider scale
            },

            $BulletNavigatorOptions: {                                //[Optional] Options to specify and enable navigator or not
                $Class: $JssorBulletNavigator$,                       //[Required] Class to create navigator instance
                $ChanceToShow: 2,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
                $AutoCenter: 1,                                 //[Optional] Auto center navigator in parent container, 0 None, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
                $Steps: 1,                                      //[Optional] Steps to go for each navigation request, default value is 1
                $Lanes: 1,                                      //[Optional] Specify lanes to arrange items, default value is 1
                $SpacingX: 12,                                   //[Optional] Horizontal space between each item in pixel, default value is 0
                $SpacingY: 4,                                   //[Optional] Vertical space between each item in pixel, default value is 0
                $Orientation: 1,                                //[Optional] The orientation of the navigator, 1 horizontal, 2 vertical, default value is 1
                $Scale: false                                   //Scales bullets navigator or not while slider scale
            }
        };

        //Make the element 'slider1_container' visible before initialize jssor slider.
        $("#slider1_container").css("display", "block");
        var jssor_slider1 = new $JssorSlider$("slider1_container", options);

        //responsive code begin
        //you can remove responsive code if you don't want the slider scales while window resizes
        function ScaleSlider() {
            var parentWidth = jssor_slider1.$Elmt.parentNode.clientWidth;
            if (parentWidth) {
                jssor_slider1.$ScaleWidth(parentWidth - 30);
            }
            else
                window.setTimeout(ScaleSlider, 30);
        }
        ScaleSlider();

        $(window).bind("load", ScaleSlider);
        $(window).bind("resize", ScaleSlider);
        $(window).bind("orientationchange", ScaleSlider);
        //responsive code end
    });
    
</script>
<style>
.container
{
 	width:100%
}
</style>
<form:form method="POST" modelAttribute="product" role="form"
	class="form-horizontal" id="viewProductForm">

	<fieldset>
		<legend>
			产品细节 &nbsp;&nbsp;&nbsp;&nbsp;<a href="../diagram/${product.id}"><span
				class="glyphicon glyphicon-indent-left"></span></a>
		</legend>
		<table style="width: 100%">
			<tr>
				<td style="width: 25%; vertical-align: top">
					<div class="container">
						<div id="slider1_container"
							style="display: none; position: relative; margin: 0 auto; width: 400px; height: 250px; overflow: hidden;">

							<!-- Loading Screen -->
							<div u="loading" style="position: absolute; top: 0px; left: 0px;">
								<div
									style="filter: alpha(opacity = 70); opacity: 0.7; position: absolute; display: block; background-color: #000; top: 0px; left: 0px; width: 100%; height: 100%;">
								</div>
								<div
									style="position: absolute; display: block; background: url(../img/loading.gif) no-repeat center center; top: 0px; left: 0px; width: 100%; height: 100%;">
								</div>
							</div>

							<!-- Slides Container -->
							<div u="slides"
								style="cursor: move; position: absolute; left: 0px; top: 0px; width: 380px; height: 250px; overflow: hidden;">
								<div>
									<img u="image" src2="../../images/01.jpg" />
								</div>
								<div>
									<img u="image" src2="../../images/02.jpg" />
								</div>
								<div>
									<img u="image" src2="../../images/03.jpg" />
								</div>
							</div>
							<!-- Bullet Navigator Skin Begin -->
							<!-- bullet navigator container -->
							<div u="navigator" class="jssorb05"
								style="position: absolute; bottom: 16px; right: 6px;">
								<!-- bullet navigator item prototype -->
								<div u="prototype"
									style="POSITION: absolute; WIDTH: 16px; HEIGHT: 16px;"></div>
							</div>
							<!-- Bullet Navigator Skin End -->
							<!-- Arrow Navigator Skin Begin -->
							<!-- Arrow Left -->
							<span u="arrowleft" class="jssora11l"
								style="width: 37px; height: 37px; top: 23px; left: 8px; margin-left: -10px;">
							</span>
							<!-- Arrow Right -->
							<span u="arrowright" class="jssora11r"
								style="width: 37px; height: 37px; top: 23px; right: 8px; margin-right: 10px;">
							</span>
						</div>
						<!-- Jssor Slider End -->
					</div>
				</td>

				<td style="vertical-align: top">
					<div class="form-group">
						<label for="id" class="col-sm-3 control-label">产品ID：</label>
						<div class="col-sm-5 control-label" id="idvalue">${product.id}</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-3 control-label">产品名称：</label>
						<div class="col-sm-5 control-label">${product.name}</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-3 control-label">创建时间：</label>
						<div class="col-sm-5 control-label">${product.createdat}</div>
					</div>
					<div class="form-group">
						<label for="description" class="col-sm-3 control-label">描述：</label>
						<div class="col-sm-5 control-label">${product.description}</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-7 col-sm-5" style="align: right">
							<button type="button" class="btn btn-primary"
								onclick="location='../edit/${product.id}'">编辑</button>
							<c:if test="${product.template}">
								<button type="button" class="btn btn-primary"
									onclick="location='../clone/${product.id}'">复制产品</button>
							</c:if>
						</div>
					</div>
				</td>
			</tr>
		</table>

		<br />
		<div id="attachments" style="display: block; width: 100%"></div>

	</fieldset>
	<br />
	<br />
	<div class="row placeholders">
		<c:forEach items="${features}" var="feature">
			<div class="col-xs-6 col-sm-3 placeholder">
				<a href="../../feature/view/${feature.id}"> <img
					src="../../images/${feature.iconName}.jpg" class="img-responsive"
					alt="Generic placeholder thumbnail"></a>
				<h4>${feature.featureName}</h4>
				<span class="text-muted">${feature.description}</span>
			</div>
		</c:forEach>
	</div>
</form:form>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">确认框</h4>
			</div>
			<div class="modal-body">确认要删除该产品？</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary"
					onclick="deleteProduct()">确定</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>