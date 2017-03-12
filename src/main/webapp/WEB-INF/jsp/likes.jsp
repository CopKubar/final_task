<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add instruction</title>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/4.0.1/dropzone.js"></script>
    <script type="text/javascript" src="<c:url value="/static/js/vendor/like-dislike.min.js"/>"></script>
    <link rel="stylesheet" href="<spring:theme code='styleSheet'/>" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />
    <link href="<c:url value="/static/css/style.css"/>" type="text/css" rel="stylesheet">
    <link href="<c:url value="/static/css/jqcloud.min.css"/>" type="text/css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp"/>

<div id="demo">
    <button class="like">Like
        <span class="likes">${likes}</span>
    </button>
    <button class="dislike">Dislike
        <span class="dislikes">${dislikes}</span>
    </button>
</div>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src='/static/js/vendor/jquery.ui.widget.js' type='text/javascript'></script>
<script src='/static/js/vendor/jquery.iframe-transport.js' type='text/javascript'></script>
<script src='/static/js/vendor/jquery.fileupload.js' type='text/javascript'></script>
<script src='/static/js/vendor/jquery.cloudinary.js' type='text/javascript'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>

<script type="text/javascript" src="/static/js/vendor/script.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


</body>
</html>

