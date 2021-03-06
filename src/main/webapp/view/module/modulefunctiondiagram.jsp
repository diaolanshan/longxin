<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%  
String path = request.getContextPath();  
%>
<body onload="prettyPrint();">
	<a href="<%=path%>/module/view/${module.id}" title="返回"><img alt="" src="<%=path%>/images/back.png" style="width:35px"></a>
	<ul id="org" style="display: none">
		<li id="${module.feature.id}"><a
			href="../../feature/view/${feature.product.id}">${module.feature.functionName}</a>
			<ul>
				<li><a href="./../../module/view/${module.id}" id="currentNode">${module.functionName}</a>
					<ul>
						<c:forEach items="${module.l1Components}" var="l1">
							<li><a href="./../../l1component/view/${l1.id}">${l1.functionName}</a>
								<ul>
									<c:forEach items="${l1.l2Components}" var="l2">
										<li><a href="./../../l2component/view/${l2.id}">${l2.functionName}</a>
											<ul>
												<c:forEach items="${l2.l3Components}" var="l3">
													<li><a href="./../../l3component/view/${l3.id}">${l3.functionName}</a></li>
												</c:forEach>
											</ul></li>
									</c:forEach>
								</ul></li>
						</c:forEach>
					</ul></li>
			</ul>
	</ul>

	<div id="chart" class="orgChart"></div>

	<script>
        jQuery(document).ready(function() {
            
            /* Custom jQuery for the example */
            $("#show-list").click(function(e){
                e.preventDefault();
                
                $('#list-html').toggle('fast', function(){
                    if($(this).is(':visible')){
                        $('#show-list').text('Hide underlying list.');
                        $(".topbar").fadeTo('fast',0.9);
                    }else{
                        $('#show-list').text('Show underlying list.');
                        $(".topbar").fadeTo('fast',1);                  
                    }
                });
            });
            
            $('#list-html').text($('#org').html());
            
            $("#org").bind("DOMSubtreeModified", function() {
                $('#list-html').text('');
                
                $('#list-html').text($('#org').html());
                
                prettyPrint();                
            });
            
            $("table table table table tbody tr td div").filter(".node").css("width","30px").css("height", "80px");
            
            $("div #currentNode").each(function(index) {
        		$(this).parent().css("border-style", "dashed");
        	})
        });
    </script>
</body>