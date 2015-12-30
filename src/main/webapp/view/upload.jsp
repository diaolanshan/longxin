<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>jQuery File Upload Example</title>

</head>

<body>
<h1>Spring MVC - jQuery File Upload</h1>
<div style="width:500px;padding:20px">

    <input id="fileupload" type="file" name="files[]" data-url="rest/controller/upload" multiple>
    
    <div id="dropzone">Drop files here</div>
    
    <div id="progress">
        <div style="width: 0%;"></div>
    </div>

    <table id="uploaded-files">
        <tr>
            <th>File Name</th>
            <th>File Size</th>
            <th>File Type</th>
            <th>Download</th>
        </tr>
    </table>
    
</div>
</body> 
</html>