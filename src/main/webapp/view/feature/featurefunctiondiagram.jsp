<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<body onload="prettyPrint();">
	<ul id="org" style="display: none">
		<li id="${feature.id}"><a href="../../feature/view/${feature.id}">${feature.functionName}</a>
			<ul>
				<c:forEach items="${feature.modules}" var="module">
					<li><a href="./../../module/view/${module.id}">${module.functionName}</a>
						<ul>
							<c:forEach items="${module.l1Components}" var="l1">
								<li><a href="./../../l1component/view/${l1.id}"
									target="_blank">${l1.functionName}</a>
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
        });
    </script>
</body>