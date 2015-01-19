<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
    jQuery(document).ready(function() {
        $("#org").jOrgChart({
            chartElement : '#chart',
            dragAndDrop  : true
        });
    });
</script>
<body onload="prettyPrint();">
	<ul id="org" style="display: none">
		<li><a href="./../list/${product.id}">${product.name}</a>
			<ul>
				<c:forEach items="${product.features}" var="feature">
					<li id="${feature.id}"><a href="../../feature/view/${feature.id}">${feature.featureName}</a>
						<ul>
							<c:forEach items="${feature.modules}" var="module">
								<li><a href="#" target="_blank">${module.moduleName}</a>
									<ul>
										<c:forEach items="${module.l1Components}" var="l1">
											<li><a href="#" target="_blank">${l1.name}</a>
												<ul>
													<c:forEach items="${l1.l2Components}" var="l2">
														<li>
															<a href="#" target="_blank">${l2.name}</a>
															<ul>
																<c:forEach items="${l2.l3Components}" var="l3">
																	<li>
																		<a href="#" target="_blank">${l3.name}</a>
																	</li>
																</c:forEach>
															</ul>
														</li>
													</c:forEach>
												</ul>
											</li>
										</c:forEach>
									</ul>
								</li>
							</c:forEach>
						</ul>
					</li>
				</c:forEach>
			</ul>
		</li>
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