<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Add instruction</title>

    <link rel="stylesheet" href="<spring:theme code='styleSheet'/>" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />
    <link href="<c:url value="/static/css/style.css"/>" type="text/css" rel="stylesheet">
    <link href="<c:url value="/static/css/jqcloud.min.css"/>" type="text/css" rel="stylesheet">
</head>
<body>

<div class="container">

    <div class="row border_bottom">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <h1> ${instruction.title}</h1>
        </div>
        <div class="col-xs-6 col-md-6 col-lg-6 col-md-6 ">

            <div class="row">
                <div class="col-xs-6 col-md-6 col-lg-6 col-md-6 ">
                    <h2> Category</h2>
                </div>
                <div class="col-xs-6 col-md-6 col-lg-6 col-md-6 ">
                    <textarea class="form-control" disabled rows="2" disabled id="category">${instruction.category.name}</textarea>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-6 col-md-6 col-lg-6 col-md-6 ">
                    <h2> Video</h2>
                </div>
                <div class="col-xs-6 col-md-6 col-lg-6 col-md-6 ">
                    ${instruction.youtubeUrl}
                </div>
            </div>

            <div class="row">
                <div class="col-xs-4 col-md-4 col-lg-4 col-md-4 ">
                    <h2>Tags </h2>
                </div>
                <div class="col-xs-8 col-md-8 col-lg-8 col-md-8 ">
                    <textarea class="form-control" disabled rows="5" id="tags">many stupid tags but nobody cares wich of them writen accept kitten</textarea>
                </div>
            </div>

        </div>

        <div class="col-xs-4 col-md-4 col-lg-4 col-md-4  col-sm-offset-2 col-xs-offset-2 col-md-offset-2 col-lg-offset-2">
            <div class="thumbnail">
                <img src="http://res.cloudinary.com/depejwdfb/image/upload/c_pad,h_200/${instruction.imageUrl}.jpg" alt="...">
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row row-flex ">
            <ol class="list-group" id="sortable">

                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                    <li class="ui-state-default list-group-ite">
                        <div class="thumbnail">
                            <img src="https://www.codeproject.com/KB/GDI-plus/ImageProcessing2/img.jpg" alt="...">
                        </div>
                        <div class="caption">
                            <h3>Thumbnail label</h3>
                        </div>
                    </li>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                    <li class="ui-state-default list-group-ite">
                        <div class="thumbnail">
                            <img src="https://www.codeproject.com/KB/GDI-plus/ImageProcessing2/img.jpg" alt="...">
                        </div>
                        <div class="caption">
                            <h3>Thumbnail label</h3>
                        </div>
                    </li>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                    <li class="ui-state-default list-group-ite">
                        <div class="thumbnail">
                            <img src="https://www.codeproject.com/KB/GDI-plus/ImageProcessing2/img.jpg" alt="...">
                        </div>
                        <div class="caption">
                            <h3>Thumbnail label</h3>
                        </div>
                    </li>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                    <li class="ui-state-default list-group-ite">
                        <div class="thumbnail">
                            <img src="https://www.codeproject.com/KB/GDI-plus/ImageProcessing2/img.jpg" alt="...">
                        </div>
                        <div class="caption">
                            <h3>Thumbnail label</h3>
                        </div>
                    </li>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                    <li class="ui-state-default list-group-ite">
                        <div class="thumbnail">
                            <img src="https://www.codeproject.com/KB/GDI-plus/ImageProcessing2/img.jpg" alt="...">
                        </div>
                        <div class="caption">
                            <h3>Thumbnail label</h3>
                        </div>
                    </li>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                    <li class="ui-state-default list-group-ite">
                        <div class="thumbnail">
                            <img src="https://www.codeproject.com/KB/GDI-plus/ImageProcessing2/img.jpg" alt="...">
                        </div>
                        <div class="caption">
                            <h3>Thumbnail label</h3>
                        </div>
                    </li>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                    <li class="ui-state-default list-group-ite">
                        <div class="thumbnail">
                            <img src="https://www.codeproject.com/KB/GDI-plus/ImageProcessing2/img.jpg" alt="...">
                        </div>
                        <div class="caption">
                            <h3>Thumbnail label</h3>
                        </div>
                    </li>
                </div>

            </ol>
        </div>
    </div>
</div>



<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- <script src="http://code.jquery.com/jquery-1.7.1.min.js"></script> -->
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<!-- <script src='js/jquery.min.js' type='text/javascript'></script> -->
<script src='/static/js/vendor/jquery.ui.widget.js' type='text/javascript'></script>
<script src='/static/js/vendor/jquery.iframe-transport.js' type='text/javascript'></script>
<script src='/static/js/vendor/jquery.fileupload.js' type='text/javascript'></script>
<script src='/static/js/vendor/jquery.cloudinary.js' type='text/javascript'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>

<script type="text/javascript" src="/static/js/vendor/script.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
    $( function() {
        $( "#sortable" ).sortable();
        $( "#sortable" ).disableSelection();
    } );
</script>




</body>
</html>


