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
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Add instruction</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />
    <link href="<c:url value="/static/css/style.css"/>" type="text/css" rel="stylesheet">
    <link href="<c:url value="/static/css/jqcloud.min.css"/>" type="text/css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp"/>

<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header login_modal_header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h2 class="modal-title" id="myModalLabel">Login to Your Account</h2>
            </div>
            <div class="modal-body login-modal">
                <br/>
                <div class="clearfix"></div>
                <div id='social-icons-conatainer'>
                    <%--<div class='modal-body-right'>--%>
                    <div class="modal-social-icons">
                        <a href='${pageContext.request.contextPath}/auth/facebook' class="btn btn-default facebook"> <i class="fa fa-facebook modal-icons"></i> Sign In with Facebook </a>
                        <a href='${pageContext.request.contextPath}/auth/twitter' class="btn btn-default twitter"> <i class="fa fa-twitter modal-icons"></i> Sign In with Twitter </a>
                        <a href='${pageContext.request.contextPath}/auth/vkontakte' class="btn btn-default vk"> <i class="fa fa-vk modal-icons"></i> Sign In with Vkontakte </a>
                    </div>
                    <%--</div>--%>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="clearfix"></div>
            <div class="modal-footer login_modal_footer">
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row border_bottom">

        <div class="col-xs-6 col-md-6 col-lg-8 col-md-8 position_name">
            <%--${user_name}--%>
            <sec:authorize access="hasRole('ROLE_USER')">
                <sec:authentication property="principal.name"/>
            </sec:authorize>
            <sec:authorize access="isAnonymous()">
                I am Nobody
            </sec:authorize>

        </div>
        <div class="col-xs-6 col-md-6 col-lg-4 col-md-4 user_img">
            <img src="https://s.pinimg.com/images/user/default_280.png" alt="User Photo">

        </div>
    </div>
    <div class="container-fluid">
        <div class="row row-flex ">
            <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3" data-toggle="modal" href='#new_instruction'>
                <div class="thumbnail">
                    <img src="/static/img/add_blue.png" alt="+">
                </div>
                <div class="caption">
                    <h3>Create Instruction</h3>
                </div>
            </div>

            <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
                <div class="thumbnail">
                    <a href="#myModal" data-toggle="modal">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/LGBT_flag_square.svg/1024px-LGBT_flag_square.svg.png" alt="...">
                    </a>
                </div>
                <div class="caption">
                    <h3>Thumbnail label</h3>
                    <p>
                        <a href="#" class="btn btn-default" role="button"><i class="fa fa-sort-asc" style="font-size:24px"></i></a>
                        <span class="rate" style="font-size: 1.5em;">100</span>
                        <a href="#" class="btn btn-default" role="button"><i class="fa fa-sort-down" style="font-size:24px"></i></a>
                    </p>
                </div>
            </div>
        </div>
    </div>



    <div class="modal fade" id="new_instruction">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">

                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Modal title</h4>
                </div>
                <div class="modal-body">

                    <form id="new_instruction_form" method="post" action="/addInstruction" accept-charset="utf-8">

                        <div class="field">
                            <label for="title">title:</label>
                            <input type="text" id="title" name="title" required>
                        </div>

                        <div class="field">
                            <label for="youtubeURL">youtubeUrl:</label>
                            <input type="text" id="youtubeURL" name="youtubeUrl" required>
                        </div>

                        <div class="field">
                            <label for="category">category:</label>
                            <select name="category" id="category" name="category"  required>
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category.name}">${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" id="save_btn" class="btn btn-primary">Save changes</button>
                    </div>

                </div>
            </div>
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

<script >
    $('#save_btn').click(function(event) {
        console.log("click")
        $('#new_instruction_form').submit();
    });
</script>
</body>
</html>
<%--<!DOCTYPE html>--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>--%>
<%--<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--<meta charset="utf-8">--%>
<%--<meta http-equiv="X-UA-Compatible" content="IE=edge">--%>
<%--<meta name="viewport" content="width=device-width, initial-scale=1">--%>
<%--<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->--%>
<%--<title>Add instruction</title>--%>

<%--<!-- Bootstrap -->--%>
<%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"--%>
<%--integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">--%>
<%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">--%>
<%--<link href="<c:url value="/static/css/style.css"/>" type="text/css" rel="stylesheet">--%>
<%--<link href="<c:url value="/static/css/jqcloud.min.css"/>" type="text/css" rel="stylesheet">--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="navbar navbar-inverse navbar-fixed-top">--%>
<%--<div class="container-fluid">--%>
<%--<div class="navbar-header">--%>
<%--<a class="navbar-brand" href="#">--%>
<%--<img alt="Brand" src="...">--%>
<%--</a>--%>
<%--</div>--%>
<%--<form class="navbar-form navbar-left" action="/doSearch" role="search">--%>
<%--<div class="form-group">--%>
<%--<input type="text" name="searchText" placeholder="search"/>--%>
<%--</div>--%>
<%--<button type="submit" class="btn btn-default">Submit</button>--%>
<%--</form>--%>

<%--<ul class="nav navbar-nav navbar-right">--%>
<%--<li role="presentation" class="dropdown">--%>
<%--<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">--%>
<%--Categories <span class="caret"></span>--%>
<%--</a>--%>
<%--<ul class="dropdown-menu">--%>
<%--<li><a href="#"> punct 2.1</a></li>--%>
<%--<li><a href="#"> punct 2.2</a></li>--%>
<%--<li><a href="#"> punct 2.3</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li role="presentation" class="dropdown">--%>
<%--<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">--%>
<%--Lang<span class="caret"></span>--%>
<%--</a>--%>
<%--<ul class="dropdown-menu">--%>
<%--<li><a href="#"> ru</a></li>--%>
<%--<li><a href="#"> eng</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li role="presentation" class="dropdown">--%>
<%--<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">--%>
<%--Theme<span class="caret"></span>--%>
<%--</a>--%>
<%--<ul class="dropdown-menu">--%>
<%--<li><a href="#">dark</a></li>--%>
<%--<li><a href="#">light</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li class="divider"></li>--%>
<%--<sec:authorize access="hasRole('ROLE_USER')">--%>
<%--<li role="presentation" class="dropdown">--%>
<%--<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">--%>
<%--Signed in as <sec:authentication property="principal.name"/><span class="caret"></span>--%>
<%--</a>--%>
<%--<ul class="dropdown-menu">--%>
<%--<li><a href="${pageContext.request.contextPath}/logout">Log Out</a></li>--%>
<%--<li><a href="${pageContext.request.contextPath}/profile">Profile</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--</sec:authorize>--%>
<%--<sec:authorize access="isAnonymous()">--%>
<%--<li><a href="${pageContext.request.contextPath}/auth/vkontakte">VK</a></li>--%>
<%--<li><a href="${pageContext.request.contextPath}/auth/facebook">FB</a></li>--%>
<%--<li><a href="${pageContext.request.contextPath}/auth/twitter">TW</a></li>--%>
<%--</sec:authorize>--%>
<%--</ul>--%>

<%--</div>--%>
<%--</div>--%>
<%--<!-- <div class="container-fluid"> -->--%>
<%--<div class="container">--%>
<%--<!-- Bootstrap trigger to open modal -->--%>
<%--<div id="form-messages"></div>--%>

<%--<a class="btn btn-primary" data-toggle="modal" href='#new_instruction'>Trigger modal</a>--%>

<%--<div class="modal fade" id="new_instruction">--%>
<%--<div class="modal-dialog">--%>
<%--<div class="modal-content">--%>
<%--<div class="modal-header">--%>

<%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--%>
<%--<h4 class="modal-title">Modal title</h4>--%>
<%--</div>--%>
<%--<div class="modal-body">--%>

<%--<form id="ajax-contact" method="post" action="/addInstruction">--%>

<%--<div class="field">--%>
<%--<label for="title">title:</label>--%>
<%--<input type="text" id="title" name="title" required>--%>
<%--</div>--%>

<%--<div class="field">--%>
<%--<label for="youtubeURL">youtubeUrl:</label>--%>
<%--<input type="text" id="youtubeURL" name="youtubeUrl" required>--%>
<%--</div>--%>

<%--<div class="field">--%>
<%--<label for="category">category:</label>--%>
<%--<select name="category" id="category" name="category" required>--%>
<%--<c:forEach items="${categories}" var="num">--%>
<%--<option value="${num}">${num}</option>--%>
<%--</c:forEach>--%>
<%--</select>--%>
<%--</div>--%>
<%--<div class="field">--%>
<%--<button type="submit">Send</button>--%>
<%--</div>--%>

<%--</form>--%>

<%--<div class="modal-footer">--%>
<%--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
<%--<button type="button" class="btn btn-primary">Save changes</button>--%>
<%--</div>--%>

<%--</div>--%>
<%--</div>--%>
<%--</div>--%>


<%--<!-- <form action="" method="POST" role="form">--%>
<%--<legend>Form title</legend>--%>

<%--<div class="form-group">--%>
<%--<h1>new instruction</h1>--%>
<%--<label for="">label</label>--%>
<%--<input type="text" class="form-control" id="" placeholder="Input field">--%>
<%--<label for="">label</label>--%>
<%--<input type="text" class="form-control" id="" placeholder="Input field">--%>
<%--<label for="">label</label>--%>
<%--<input type="text" class="form-control" id="" placeholder="Input field">--%>
<%--</div>--%>



<%--<button type="submit" class="btn btn-primary">Submit</button>--%>
<%--</form> -->--%>

<%--</div>--%>
<%--</div>--%>



<%--<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->--%>
<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>--%>
<%--<!-- <script src="http://code.jquery.com/jquery-1.7.1.min.js"></script> -->--%>
<%--<!-- Include all compiled plugins (below), or include individual files as needed -->--%>
<%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>--%>
<%--<!-- <script src='js/jquery.min.js' type='text/javascript'></script> -->--%>
<%--<script src='/static/js/jquery.ui.widget.js' type='text/javascript'></script>--%>
<%--<script src='/static/js/jquery.iframe-transport.js' type='text/javascript'></script>--%>
<%--<script src='/static/js/jquery.fileupload.js' type='text/javascript'></script>--%>
<%--<script src='/static/js/vendor/jquery.cloudinary.js' type='text/javascript'></script>--%>


<%--<script type="text/javascript" src="/static/js/script.js"></script>--%>
<%--<!----%>
<%--<script> $.cloudinary.config({ cloud_name: 'sample', api_key: '874837483274837'})--%>
<%--</script> -->--%>

<%--&lt;%&ndash;<script >&ndash;%&gt;--%>
<%--&lt;%&ndash;// Get the form.&ndash;%&gt;--%>
<%--&lt;%&ndash;var form = $('#ajax-instruction');&ndash;%&gt;--%>
<%--&lt;%&ndash;console.log(form);&ndash;%&gt;--%>
<%--&lt;%&ndash;// Get the messages div.&ndash;%&gt;--%>
<%--&lt;%&ndash;var formMessages = $('#form-messages');&ndash;%&gt;--%>
<%--&lt;%&ndash;console.log(formMessages);&ndash;%&gt;--%>
<%--&lt;%&ndash;$(form).submit(function(event) {&ndash;%&gt;--%>
<%--&lt;%&ndash;var formData = $(form).serialize();&ndash;%&gt;--%>
<%--&lt;%&ndash;console.log(formData);&ndash;%&gt;--%>
<%--&lt;%&ndash;});&ndash;%&gt;--%>
<%--&lt;%&ndash;</script>&ndash;%&gt;--%>

<%--&lt;%&ndash;// Set up an event listener for the contact form.&ndash;%&gt;--%>
<%--&lt;%&ndash;//    $(form).submit(function(event) {&ndash;%&gt;--%>
<%--&lt;%&ndash;//&ndash;%&gt;--%>
<%--&lt;%&ndash;//&ndash;%&gt;--%>
<%--&lt;%&ndash;//        // Stop the browser from submitting the form.&ndash;%&gt;--%>
<%--&lt;%&ndash;//        event.preventDefault();&ndash;%&gt;--%>
<%--&lt;%&ndash;//&ndash;%&gt;--%>
<%--&lt;%&ndash;//        // Serialize the form data.&ndash;%&gt;--%>
<%--&lt;%&ndash;//        var formData = $(form).serialize();&ndash;%&gt;--%>
<%--&lt;%&ndash;//        console.log(formData);&ndash;%&gt;--%>
<%--&lt;%&ndash;//        $.ajax({&ndash;%&gt;--%>
<%--&lt;%&ndash;//&ndash;%&gt;--%>
<%--&lt;%&ndash;//            type: 'POST',&ndash;%&gt;--%>
<%--&lt;%&ndash;//            url: $(form).attr('action'),&ndash;%&gt;--%>
<%--&lt;%&ndash;//            data: formData,&ndash;%&gt;--%>
<%--&lt;%&ndash;//&ndash;%&gt;--%>
<%--&lt;%&ndash;//            success: function (response) {&ndash;%&gt;--%>
<%--&lt;%&ndash;//                $(formMessages).text(response);&ndash;%&gt;--%>
<%--&lt;%&ndash;//&ndash;%&gt;--%>
<%--&lt;%&ndash;//                // Clear the form.&ndash;%&gt;--%>
<%--&lt;%&ndash;//                $('#instruction_name').val('');&ndash;%&gt;--%>
<%--&lt;%&ndash;//                $('#youtube_URL').val('');&ndash;%&gt;--%>
<%--&lt;%&ndash;//            },&ndash;%&gt;--%>
<%--&lt;%&ndash;//&ndash;%&gt;--%>
<%--&lt;%&ndash;//            error: function (jqXHR, textStatus, errorThrown) {&ndash;%&gt;--%>
<%--&lt;%&ndash;//                console.log(textStatus, errorThrown);&ndash;%&gt;--%>
<%--&lt;%&ndash;//            }&ndash;%&gt;--%>
<%--&lt;%&ndash;//        })&ndash;%&gt;--%>
<%--&lt;%&ndash;//&ndash;%&gt;--%>
<%--&lt;%&ndash;//&ndash;%&gt;--%>
<%--&lt;%&ndash;//    });&ndash;%&gt;--%>
<%--</body>--%>
<%--</html>--%>
