<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><spring:message code="main.title"/></title>
    <link rel="stylesheet" href="<spring:theme code='styleSheet'/>" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="<c:url value="/static/css/style.css"/>" type="text/css" rel="stylesheet">
    <link href="<c:url value="/static/css/jqcloud.min.css"/>" type="text/css" rel="stylesheet">
</head>
<body>
<!-- NAVBAR -->
<jsp:include page="navbar.jsp"/>
<!-- NAVBAR -->

<div class="container-fluid">
    <br>

    <br>
    <div class="container-fluid">
        <div class="jumbotron">
            <h1>Most Popular</h1>
            <div id="demo">

            </div>
            <!-- <p>this text 4 fun</p>  -->
        </div>

        <div class="row row-flex ">
            <c:forEach var="instruction" items="${popularInstructions}">
                <div class=" col-xs-12 col-sm-6 col-md-3 col-lg-3">
                    <div class="thumbnail">
                        <a href="/showinstruction/${instruction.id}">
                            <div class="caption col-xs-12 col-sm-12 col-md-12 col-lg-12" >
                                <img src="${instruction.imageUrl}" class="img-responsive" alt="instruction image">
                            </div>
                            <div class="row">
                                <div class="caption col-xs-11 col-sm-11 col-md-11 col-lg-11" >
                                    <h3>${instruction.title}</h3>
                                </div>
                            </div>
                        </a>
                        <div class="row">
                            <div class="caption col-xs-offset-1 col-sm-offset-1 col-md-offset-1 col-lg-offset-1 col-xs-11 col-sm-11 col-md-11 col-lg-11" >

                                <div class="row">
                                    <div class="caption col-xs-12 col-sm-12 col-md-12 col-lg-12" >
                                        <div class="row">
                                            <div class="caption col-xs-6 col-sm-6 col-md-6 col-lg-6" >
                                                <i class="fa fa-user-o" aria-hidden="true"></i>
                                                <a href="/profile/${instruction.user.id}"><span>${instruction.user.name}</span></a>
                                            </div>
                                            <div class="caption col-xs-6 col-sm-6 col-md-6 col-lg-6" >
                                                <i class="fa fa-pencil" aria-hidden="true"></i>
                                                <a href="/category/${instruction.category.name}" >
                                                    <span>${instruction.category.name}</span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>
        <div class="jumbotron">
            <h1>The New One</h1>
            <!-- <p>this text 4 fun</p>  -->
        </div>
        <div class="row row-flex ">
            <c:forEach var="instruction" items="${newInstructions}">
                <div class=" col-xs-12 col-sm-6 col-md-3 col-lg-3">
                    <div class="thumbnail">
                        <a href="/showinstruction/${instruction.id}">
                            <div class="caption col-xs-12 col-sm-12 col-md-12 col-lg-12" >
                                <img src="${instruction.imageUrl}" class="img-responsive" alt="instruction image">
                            </div>
                            <div class="row">
                                <div class="caption col-xs-11 col-sm-11 col-md-11 col-lg-11" >
                                    <h3>${instruction.title}</h3>
                                </div>
                            </div>
                        </a>
                        <div class="row">
                            <div class="caption col-xs-offset-1 col-sm-offset-1 col-md-offset-1 col-lg-offset-1 col-xs-11 col-sm-11 col-md-11 col-lg-11" >

                                <div class="row">
                                    <div class="caption col-xs-12 col-sm-12 col-md-12 col-lg-12" >
                                        <div class="row">
                                            <div class="caption col-xs-6 col-sm-6 col-md-6 col-lg-6" >
                                                <i class="fa fa-user-o" aria-hidden="true"></i>
                                                <a href="/profile/${instruction.user.id}"><span>${instruction.user.name}</span></a>
                                            </div>
                                            <div class="caption col-xs-6 col-sm-6 col-md-6 col-lg-6" >
                                                <i class="fa fa-pencil" aria-hidden="true"></i>
                                                <a href="/category/${instruction.category.name}" >
                                                    <span>${instruction.category.name}</span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="caption col-xs-12 col-sm-12 col-md-12 col-lg-12" >--%>
                                        <%--<a href="#" class="btn btn-default" role="button"><i class="fa fa-thumbs-up" aria-hidden="true"></i></a>--%>
                                            <%--&lt;%&ndash;<span class="rate" style="font-size: 1.5em;">instruction.likeCounter</span>&ndash;%&gt;--%>
                                        <%--<span class="rate" style="font-size: 1.5em;">????????</span>--%>
                                            <%--&lt;%&ndash;??????????????????????????????????????&ndash;%&gt;--%>
                                        <%--<a href="#" class="btn btn-default" role="button"><i class="fa fa-thumbs-down" aria-hidden="true"></i></a>--%>
                                    <%--</div>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>

    </div>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- <script src="http://code.jquery.com/jquery-1.7.1.min.js"></script> -->
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

<script src="<c:url value="/static/js/vendor/jqcloud.min.js" />"></script>
<script src="<c:url value="/static/js/vendor/infinitecarousel/jquery.infinitecarousel3.js" />"></script>
<script src="<c:url value="/static/js/vendor/infinitecarousel/jquery.easing.1.3.js" />"></script>
<script src="<c:url value="/static/js/vendor/script.js" />"></script>


<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<script>
    $( document ).ready(function() {
        $(function(){

            var words = [
                {text: "Lorem", weight: 13},
                {text: "Ipsum", weight: 10.5},
                {text: "Dolor", weight: 9.4},
                {text: "Sit", weight: 8},
                {text: "Amet", weight: 6.2},
                {text: "Consectetur", weight: 5},
                {text: "Adipiscing", weight: 5},
//                 ...
            ];

            $('#demo').jQCloud(words);

            $('#carousel').infiniteCarousel({
                imagePath: 'js/infinitecarousel/images/',
                transitionSpeed:600,
                displayTime: 6000,
                internalThumbnails: false,
                thumbnailType: 'count',
                customClass: 'myCarousel',
                progressRingColorOpacity: '0,0,0,.9',
                progressRingBackgroundOn: false,
                margin: 10,
                easeLeft: 'easeOutExpo',
                easeRight:'easeOutBounce',
                inView: 3,
                advance: 1,
                autoPilot: true,
                prevNextInternal: false,
                autoHideCaptions: false
            });


        });
    });
</script>
</body>
</html>
