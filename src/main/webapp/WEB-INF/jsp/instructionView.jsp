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
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <link rel="stylesheet" href="<spring:theme code='styleSheet'/>" type="text/css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />
    <link href="<c:url value="/static/css/style.css"/>" type="text/css" rel="stylesheet">
    <link href="<c:url value="/static/css/jqcloud.min.css"/>" type="text/css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script src='/static/js/vendor/jquery.ui.widget.js' type='text/javascript'></script>
    <script src='/static/js/vendor/jquery.iframe-transport.js' type='text/javascript'></script>
    <script src='/static/js/vendor/jquery.fileupload.js' type='text/javascript'></script>
    <script src='/static/js/vendor/jquery.cloudinary.js' type='text/javascript'></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>
    <script src='/static/js/vendor/jquery.form.js' type='text/javascript'></script>
    <script type="text/javascript" src="/static/js/vendor/script.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="/static/js/vendor/like-dislike.min.js"></script>
    <script src="/static/js/vendor/jqcloud.min.js"></script>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<div class="container-fluid">
    <div class="container" style="border-bottom: 1px solid;">
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            <img src="${instruction.imageUrl}" class="img-responsive img-thumbnail" alt="...">
        </div>
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            <div class="row">
                <div class="caption col-xs-12 col-sm-12 col-md-12 col-lg-12" >
                    <h1>${instruction.title}</h1>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                    <p>
                        <i class="fa fa-user-o" aria-hidden="true"></i>
                        <a href="/profile/${user.id}"><span>by ${user.name}</span></a>
                        <i class="fa fa-pencil" aria-hidden="true"></i>
                        <a href="#" ><span></span></a>
                    </p>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                        <h5>${category.name}</h5>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-9 col-lg-10">
                        <%--<h3>${instruction.tags}</h3>--%>
                    </div>
                </div>
                <div class="caption col-xs-12 col-sm-12 col-md-12 col-lg-12" >
                    <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_USER')">
                    <div class="like_bar btn-group mr-2" role="group" aria-label="First group">
                        <button class="btn btn-default like" role="button"><i class="fa fa-thumbs-up" style="font-size: 2em;" aria-hidden="true"></i></button>
                        <button class="btn btn-default dislike" role="button"><i class="fa fa-thumbs-down" style="font-size: 2em;" aria-hidden="true"></i></button>
                        <a href="#myModal" class="btn btn-danger"  data-toggle="modal"><i  style="font-size: 2em;" class="fa fa-youtube" aria-hidden="true"></i></a>
                    </div>
                    </sec:authorize>
                    <div class="rate" id="rate" style="font-size: 1.5em;">${rating}</div>
                    <button id="btn-previous" class="btn  btn-primary step-navigation" value="-1" disabled><-</button>
                    <button id="btn-next" class="btn btn-primary  step-navigation" value="1">-></button>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid" STYLE="padding-top: 2em ">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <h1 id="step_name">${step.name}</h1>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
            <img id="step_img" src="${step.imageUrl}" class="img-responsive img-thumbnail" alt="...">
        </div>
        <div id="step_description">${step.description}</div>
    </div>
    <div id="comments"  class="container-fluid" STYLE="padding-top: 2em ">
        <div>
            <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_USER')">
            <form id="commentForm" action="/addcomment">
                <input type="hidden" name="step_id" id="step_id" value="${step.id}">
                <div class="form-group">
                    <label for="text">Comment:</label>
                    <textarea class="form-control" rows="5" id="text"></textarea>
                </div>
                <div>
                    <button type="submit" name="submit">Submit</button>
                </div>
            </form>
            </sec:authorize>
        </div>
        <div id="cloud"></div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <div class="page-header">
                    <h1> Comments </h1>
                </div>
                <div class="comments-list" id="viewComments">
                    <c:forEach items="${comments}" var="comment">
                        <div class="media">
                            <div class="media-body">
                                <h4 class="media-heading user_name"><a href="/profile/${comment.user.id}">${comment.user.name}</a> </h4>
                                    ${comment.text}
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>



<!-- Modal HTML -->
<div id="myModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">YouTube Video</h4>
            </div>
            <div class="modal-body">
                ${instruction.youtubeUrl}
            </div>
        </div>
    </div>
</div>


<%--<script src="/static/js/vendor/jquery-ui.min.js"></script>--%>
<script type="text/javascript">

    $(document).ready(function(){

        var instruction_id= ${instruction.id}
        var qurrent_step=0
        var number_of_steps=${numberOfSteps}

                $(document).ready(function(){
                    var counter=$("#rate");
                    $('.like_bar').likeDislike({

                        activeClass: 'btn-primary',
                        initialValue: ${usersLikeState},
                        //disableClass: '',

                        //reverseMode: true,
                        activeBtn: localStorage['key']? localStorage['key'] : '',
                        click: function(btnType, likes, dislikes, event) {

                            counter.html(parseInt(counter.html()) + likes- dislikes)
                            //console.log($(this).closest(".caption"))
                            //console.log($(this).siblings(".rate"))
                            //$(this).siblings(".rate").html("qaz")
                            //var dislikedsElem = $(this).find('.dislikes');
                            //likesElem.text(parseInt(likesElem.text()) + likes);
                            //dislikedsElem.text(parseInt(dislikedsElem.text()) + dislikes);
                            var self = this;

                            self.readOnly(true);
                            $.ajax({
                                url: '/like',
                                type: 'GET',
                                data: 'instructionId='+instruction_id + '&ratingValue=' + btnType,
                                success: function (data) {
                                    console.log("success");
                                    $(self).find('.likes').text(data.likes);
                                    $(self).find('.dislikes').text(data.dislikes);
                                    localStorage['key'] = btnType;// unlock the buttons
                                    self.readOnly(false);

                                }
                            });
                        }
                    });




                    /* Get iframe src attribute value i.e. YouTube video url
                     and store it in a variable */
                    var url = $("#cartoonVideo").attr('src');

                    /* Assign empty url value to the iframe src attribute when
                     modal hide, which stop the video playing */
                    $("#myModal").on('hide.bs.modal', function(){
                        $("#cartoonVideo").attr('src', '');
                    });

                    /* Assign the initially stored url back to the iframe src
                     attribute when modal is displayed again */
                    $("#myModal").on('show.bs.modal', function(){
                        $("#cartoonVideo").attr('src', url);
                    });
                });


        var step_name=$("#step_name")
        var step_id=$("#step_id")
        var step_img=$("#step_img")
        var step_description=$("#step_description")

        function button_validation(is_button_next) {
            console.log("validation started");
            if (is_button_next){
                console.log(Number(qurrent_step)+1>=number_of_steps)
                if (Number(qurrent_step)+1>=number_of_steps){
                    console.log("enter disable next button")
                    $("#btn-next").disable(true);
                }
                if(qurrent_step>0){
                    console.log("enter enable previous button")
                    $("#btn-previous").disable(false);
//                manipulate_button("#previous" , true);
                }

            }else {
                if (qurrent_step<=0){
                    $("#btn-previous").disable(true);
                }
                if (Number(qurrent_step)+1<=number_of_steps){
//                manipulate_button("#next" , true)
                    console.log("enable next btn")
                    $("#btn-next").disable(false);
                }
            }
            console.log("validation passed");
            console.log("number_of_steps "+number_of_steps+"; qurrent_step+1 "+(Number(qurrent_step)+1))
        }
        function manipulate_button(button,is_activate_action) {
            console.log("enter manipulation");
//        $(button).disabled.is_activate_action;
            $("#previous").disabled=false;
            $("#previous").removeClass( "disabled" )
//        $(button).disabled=true;
        }
        // Disable function
        jQuery.fn.extend({
            disable: function(state) {
                return this.each(function() {
                    var $this = $(this);
                    if($this.is('input, button, textarea, select'))
                        this.disabled = state;
                    else
                        $this.toggleClass('disabled', state);
                });
            }
        });


        $('.step-navigation').click(function() {
            var bttn=$(this);
            console.log("addStep action: "+bttn.attr("value"));
            console.log(bttn);
            qurrent_step+=Number(bttn.attr("value"));
            button_validation(0<Number(bttn.attr("value")))
            console.log("step: "+ qurrent_step)
            ajaxRequest(get_new_step_data(),"/get_step")
        });
        function get_new_step_data() {
            return {step_number: qurrent_step,
                instruction_id:instruction_id,
                "${_csrf.parameterName}":"${_csrf.token}"
            }

        }

//!!!!!!!!!!!!!!!!!!!
        function decodeEntities(encodedString) {
            var textArea = document.createElement('textarea');
            textArea.innerHTML = encodedString;
            return textArea.value;
        }
//!!!!!!!!!!!!!!!!!!!

        function ajaxRequest(data,url){

            console.log("AJAX Start");
            console.log("AJAX data: ");
            console.log(data);
            $.ajax({
                url : url,
                type: 'POST',
                data: data,
                success: function(step_json){
                    console.log("AJAX Succsess")
                    console.log("step json")
                    console.log(step_json)
                    var step=jQuery.parseJSON( step_json ).step;
                    console.log(step)
                    step_name.html(step.name);
                    step_img.attr("src",step.imageUrl);
                    step_description.html(step.description);
//                    step_description.html(decodeEntities(step.description));
                    console.log(step.id)
                    console.log(step_id)
                    step_id.val(step.id)
                    $("#step_id").val(step.id)
                    console.log("step json")
                    console.log(step)
                }
            });
        }
    });

    $(document).ready(function() {
        $('#commentForm').submit(
            function(event) {
                var comment = $('#text').val();
                var stepId = $('#step_id').val();
                var token = $("meta[name='_csrf']").attr("content");
                var header = $("meta[name='_csrf_header']").attr("content");
                console.log(comment+" "+stepId);
                var headers = {};
                headers[header] = token;
                var data = 'text='
                    + encodeURIComponent(comment)
                    + '&stepId='
                    + encodeURIComponent(stepId);

                $.ajax({
                    url : $("#commentForm").attr("action"),
                    data : data,
                    type : "POST",
                    headers: headers,
                    success : function(data) {
                        viewComments.innerHTML = viewComments.innerHTML + '<div class="media"><div class="media-body">' +
                            '<h4 class=\"media-heading user_name\"'+'<a href=\"/profile/>'+data.userid+'\">'+data.username+'</a>'+'</h4>'+
                            data.comment +'</div></div>';
                        $("#text").val('');
                    },

//                    success : function(data) {
//                        viewComments.innerHTML = viewComments.innerHTML + '<div class="media"><div class="media-body">' +
//                            '<h4 class="media-heading user_name">'+'Тут имя автора ссылкой'+'</h4>'+data.comment +
//                            '<a href=\"/profile/'+data.userid+'\">'+'data.username'+'</a>'+'</div></div>';
//                        $("#text").val('');
//                    },
                    error : function(xhr, status, error) {
                        alert(xhr.responseText);
                    }
                });
                return false;
            });
    });

</script>
</body>
</html>