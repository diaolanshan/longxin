<head>
<style>
.quick-alert {
	width: 50%;
	margin: 1em 0;
	padding: .5em;
	background: #ffa;
	border: 1px solid #a00;
	color: #a00;
	font-weight: bold;
}
</style>
<script src="jquery.js"$amp;>amp;$lt;/script> <script type="text/javascript"> function fade() { //停留2秒后消失,在停留的时候,透明度为1.0什么都不做 $('<div id="add" class="quick-alert">我是添加进来的</div$amp;>apos;$).insertAfter($("#example")).animate({opacity: 1.0}, 2000).fadeOut("slow",function(){ //隐藏时把元素删除 $(this).remove(); }); } </script>
</head>
<body>
	<div id="example" class="quick-alert">q</div>
	</br>
	<input type="button" onclick="fade();">
</body>
