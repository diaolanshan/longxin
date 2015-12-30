<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%  
String path = request.getContextPath();  
%>
<body onload="prettyPrint();">
	<a href="<%=path%>/feature/view/${feature.product.id}" title="返回"><img alt="" src="<%=path%>/images/back.png" style="width:35px"></a>
	<ul id="org" style="display: none">
		<li id="${feature.product.id}"><a
			href="../../product/list/${feature.product.id}">${feature.product.name}</a>
			<ul>
				<li id="${feature.id}"><a
					href="../../feature/view/${feature.id}" id="currentNode">${feature.functionName}</a>
					<ul>
						<c:forEach items="${feature.functionModules}" var="functionmodule">
							<li><a href="./../../module/view/${module.id}">${functionmodule.name}</a>
								<ul>
									<c:forEach items="${functionmodule.l1Components}" var="l1">
										<li><a href="./../../l1component/view/${l1.id}"
											target="_blank">${l1.name}</a>
											<ul>
												<c:forEach items="${l1.l2Components}" var="l2">
													<li><a href="./../../l2component/view/${l2.id}"
														target="_blank">${l2.functionName}</a>
														<ul>
															<c:forEach items="${l2.l3Components}" var="l3">
																<li><a href="./../../l3component/view/${l3.id}"
																	target="_blank">${l3.functionName}</a></li>
															</c:forEach>
														</ul></li>
												</c:forEach>
											</ul></li>
									</c:forEach>
								</ul></li>
						</c:forEach>
					</ul></li>
			</ul></li>
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