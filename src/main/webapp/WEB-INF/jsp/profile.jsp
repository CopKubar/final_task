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
    <link rel="stylesheet" href="<spring:theme code='styleSheet'/>" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />
    <link href="<c:url value="/static/css/style.css"/>" type="text/css" rel="stylesheet">
    <link href="<c:url value="/static/css/jqcloud.min.css"/>" type="text/css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp"/>

<div class="container">
    <div class="row border_bottom">
        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <form action="/banForUser/" method="post">
                <input type="hidden" >
            </form>
        </sec:authorize>

        <div class="col-xs-5 col-md-5 col-lg-7 col-md-7 position_name">
            <sec:authorize access="hasRole('ROLE_USER')">
                <sec:authentication property="principal.name"/>
            </sec:authorize>
            <sec:authorize access="isAnonymous()">
                I am Nobody
            </sec:authorize>
        </div>
        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <c:choose>
                <c:when test="${pageContext.request.userPrincipal.name eq user.name}"/>
                <c:otherwise>
                    <div class="col-xs-1 col-md-1 col-lg-1 col-md-1 position_name">
                        <form action="/ban/user" method="post">
                            <input type="hidden" value="${user.id}" name="userId">
                            <input type="hidden" name="${_csrf.parameterName}"
                                   value="${_csrf.token}" />
                            <input type="submit" value="Забанить">
                        </form>
                    </div>
                </c:otherwise>
            </c:choose>
        </sec:authorize>
        <div class="col-xs-6 col-md-6 col-lg-4 col-md-4 user_img">
            <img src="https://s.pinimg.com/images/user/default_280.png" alt="User Photo">

        </div>
    </div>

    <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_USER')">
    <div class="container-fluid">
        <div class="row row-flex ">
            <c:if test="${foreignAccount eq false}">
            <div class="col-xs-12 col-sm-6 col-md-3 col-lg-3" data-toggle="modal" href='#new_instruction'>
                <div class="thumbnail">
                    <img src="/static/img/add_blue.png" alt="+">
                </div>
                <div class="caption">
                    <h3>Create Instruction</h3>
                </div>
            </div>
            </c:if>
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
    </sec:authorize>

    <div class="modal fade" id="new_instruction">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">

                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Modal title</h4>
                </div>
                <div class="modal-body">


                    <div id="dropzone-area">Drag here to upload</div>

                    <form id="new_instruction_form" method="post" action="/addInstruction">

                        <div class="field" >
                            <label for="img_url">image: </label>
                            <input type="text" id="img_url" name="image" required>
                        </div>

                        <div class="field">
                            <label for="title">title: </label>
                            <input type="text" id="title" name="title" required>
                        </div>

                        <div class="field">
                            <label for="youtubeURL">youtubeUrl: </label>
                            <input type="text" id="youtubeURL" name="youtubeUrl" required>
                        </div>

                        <div class="field">
                            <label for="category">category:</label>
                            <select name="category" id="category" name="category" required>
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category.name}">${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}"
                               value="${_csrf.token}" />
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


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src='/static/js/vendor/jquery.ui.widget.js' type='text/javascript'></script>
<script src='/static/js/vendor/jquery.iframe-transport.js' type='text/javascript'></script>
<script src='/static/js/vendor/jquery.fileupload.js' type='text/javascript'></script>
<script src='/static/js/vendor/jquery.cloudinary.js' type='text/javascript'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>

<script type="text/javascript" src="/static/js/vendor/script.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script >

    $.cloudinary.config({ cloud_name: 'depejwdfb', api_key: '338123839493786'})


    $('#save_btn').click(function(event) {
        console.log("click")
        $('#new_instruction_form').submit();
    });
</script>


<script>
    function loadImage(path, target) {
        console.log("loadImage")
        image=$(target);
        image.val(path);
        console.log("path")

    }
    var myDropzone = new Dropzone(document.getElementById('dropzone-area'), {
        uploadMultiple: false,
        parallelUploads: 1,
        acceptedFiles: '.jpg,.png,.jpeg,.gif',
        url: 'https://api.cloudinary.com/v1_1/depejwdfb/image/upload'
    });
    var prefix = "user_id"+ "_"+"instruction_id"+"_"
    myDropzone.on('sending', function (file, xhr, formData) {
        console.log("sending")
        var fileName = prefix + file.name;
        //var fileName =file.name;
        //oadImage(fileName, '#img_url');
        formData.append('api_key', 338123839493786);
        formData.append('public_id', fileName);
        //formData.append('public_id', fileName);
        formData.append('upload_preset', 'ljwk2aya');
        $('.dz-size').hide();
        $('.dz-filename').hide();
        $('.dz-success-mark').hide();
        $('.dz-error-mark').hide();
    });
    myDropzone.on("complete", function (file) {
        console.log("complete");
        var fileName = prefix + file.name;
        console.log(file.type);
        console.log(fileName);
        //var fileName =file.name;
        loadImage(fileName, '#img_url');
    });


</script>
</body>
</html>
