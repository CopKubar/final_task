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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />
    <link href="<c:url value="/static/css/style.css"/>" type="text/css" rel="stylesheet">
    <link href="<c:url value="/static/css/jqcloud.min.css"/>" type="text/css" rel="stylesheet">
</head>
<head>
<body>
<jsp:include page="navbar.jsp"/>

<div class="container">

    <input type="text" id="instruction_id" value="${instruction.id}" name="instruction_id" hidden>

    <div class="container" style="border-bottom: 1px solid;">
        <form class="form-horizontal">
            <div class="form-group">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <input class="form-control" value="${instruction.title}" placeholder="title">
                </div>
            </div>
        </form>
        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
            <div class="text-center" >
                <img src="${instruction.imageUrl}" class="img-responsive img-thumbnail" alt="...">
            </div>
        </div>
        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-xs-12 col-sm-12 col-md-2 col-lg-2  control-label">Категория</label>
                    <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10">
                        <input class="form-control" value="${instruction.category.name}" placeholder="Категория">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-12 col-sm-12 col-md-2 col-lg-2 control-label">YouTube URL</label>
                    <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10">
                        <input class="form-control" value="${instruction.youtubeUrl}" placeholder="YouTube URL">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-12 col-sm-12 col-md-3 col-lg-2 control-label">Tags</label>
                    <div class="col-xs-12 col-sm-12 col-md-9 col-lg-10">
                        <input class="form-control" value="${instruction.tags}" placeholder="Tags">
                    </div>
                </div>
            </form>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="row">
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <button class="btn btn-lg">Edit Instruction Info</button>
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <button id="add_step" class="btn btn-lg" data-step-id="" data-step-description=""
                            data-toggle="modal" href='#edit_step'>
                        Add New Step
                    </button>
                </div>
            </div>
        </div>

    </div>

    <div class="container-fluid" STYLE="padding-top: 2em ">
        <div class="row row-flex outer" id="sortable">
            
        </div>

    </div >

    <%----%>
    <%--Modal STEP--%>
    <%----%>

    <div class="modal fade " id="edit_step">
        <div class="modal-dialog">

            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Edit Instruction</h4>
                </div>

                <div class="modal-body">

                    <form id="new_instruction_form" method="post" action="/editStep">

                        <div id="dropzone-area">Drag here to upload</div>


                        <div class="field" hidden>
                            <input type="text" id="modal_id" name="id"  required>
                        </div>

                        <div class="field" hidden>
                            <input type="text" id="modal_instruction_id" name="instruction_id" value="${instruction.id}" required>
                        </div>

                        <div class="field">
                            <label for="modal_title">title:</label>
                            <input type="text" id="modal_title" name="title" required>
                        </div>
                        <div class="field">
                            <label for="modal_description">description:</label>
                            <input type="text" id="modal_description" name="description" required>
                        </div>


                        <div class="field">
                            <label for="modal_img">img:</label>
                            <input type="text" id="modal_img" name="img" required>
                        </div>


                        <input type="hidden" name="${_csrf.parameterName}"
                               value="${_csrf.token}" />
                    </form>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" id="save_btn"  class="btn btn-primary">Save changes</button>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <%----%>
    <%--Modal STEP--%>
    <%----%>

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
<script src='/static/js/vendor/jquery.form.js' type='text/javascript'></script>
<script type="text/javascript" src="/static/js/vendor/script.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/4.0.1/dropzone.js"></script>
<%--<script src="/static/js/vendor/jquery-ui.min.js"></script>--%>

<script>
</script>
<script>

    $(document).ready(function() {

        function ajaxRequest(data,url){
            console.log("AJAX Start")
            $.ajax(url,{
                type: 'POST',
                data: data,
                success: function(){
                    console.log("AJAX Succsess")
                }
            });
        }

        $( "#sortable" ).sortable({
            cancel: ".ui-state-disabled",
            placeholder: "ui-state-highlight",
            stop         : function(event,ui){ console.log("sort stoped")
                console.log(ui.position)
                console.log("sort stoped")
                console.log(ui.item.index())
                console.log(ui.item.data('step-id'))
                var data={
                    stepId: ui.item.data('step-id'),
                    newPosition: ui.item.index(),
                    "${_csrf.parameterName}":"${_csrf.token}"
                }
                ajaxRequest(data,'/regroup');
                /* do whatever here */ },
//            remove       :
        });


        $('inner').each(function(){
            console.log(window.getComputedStyle(this,':before').li);
        });

        var myDropzone = new Dropzone(document.getElementById('dropzone-area'), {
            uploadMultiple: false,
            parallelUploads: 1,
            acceptedFiles: '.jpg,.png,.jpeg,.gif',

            url: 'https://api.cloudinary.com/v1_1/depejwdfb/image/upload',
            init: function() {
                this.on("addedfile", function () {
                    if (this.files[1] != null) {
                        clear_dropzone(this);
                    }
                });
            }
        });

        function hideExtrainfo() {
            console.log("hide");
            $('.dz-size').hide();
            $('.dz-filename').hide();
            $('.dz-success-mark').hide();
            $('.dz-error-mark').hide();
        }

        function clear_dropzone(dropzone) {
            console.log("clear drop zone");
            if (dropzone.files.length>0){dropzone.removeFile(dropzone.files[0]);}
        }

        var prefix = "user_id"+ "_"+"instruction_id"+"_";
        var is_new_step = false;

//    myDropzone.on("addedfile", function () {
////        $(".dz-preview").remove();
////        hideExtrainfo();
//    });

        myDropzone.on('sending', function (file, xhr, formData) {
            console.log("sending")
            var fileName = prefix + file.name;
            //var fileName =file.name;
            //oadImage(fileName, '#img_url');
            formData.append('api_key', 338123839493786);
            formData.append('public_id', fileName);
            //formData.append('public_id', fileName);
            formData.append('upload_preset', 'ljwk2aya');
            hideExtrainfo();
        });

        myDropzone.on("complete", function (file) {
            console.log("complete");
            //var fileName = prefix + file.name;
            var fileName = "http://res.cloudinary.com/depejwdfb/image/upload/c_pad,h_200/" + prefix + file.name + ".jpg";
            console.log(fileName);
            //var fileName =file.name;
            loadImage(fileName, '#modal_img');
        });
//    myDropzone.on("complete", function (file) {
//        console.log("complete");
//        //var fileName = prefix + file.name;
//        var fileName = "http://res.cloudinary.com/depejwdfb/image/upload/c_pad,h_200/" + prefix + file.name + ".jpg";
//        console.log(fileName);
//        //var fileName =file.name;
//        loadImage(fileName, '#modal_img');
//    });
        //var li = document.getElementById('');



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //BIND DATA LIST-FORM
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        var step= {
            in_dom:"",
            title:"",
            img:"",
            id:"",
            description:""
        };


        function bind_form() {
            console.log("bind form");
            modal.id.val(step.id.data('step-id'));
            modal.title.val(step.title.text());
            modal.description.val(step.description.data('step-description'));
            modal.img.val(step.img.attr('src'));
        };

        function get_step_data(event) {
            console.log("get data from step");
            step.in_dom = $(event.relatedTarget); // Button that triggered the modal
            step.description = step.in_dom; // Extract info from data-* attributes
            step.id = step.in_dom;
            step.img=step.in_dom.find($('.step-img'));
            step.title=step.in_dom.find($('.step_name'));
        };

        function set_step_data(){
            console.log("set data back to step");
            step.title.text(modal.title.val());
            step.description.data('step-description', modal.description.val());
            step.img.attr("src",modal.img.val());
        };

        function set_new_step_id(responseText){
            var step_id=JSON.parse(responseText).step_id;
            console.log(step_id);
            if (is_new_step){
                modal.id=step_id;
                console.log("still new step");
            }
            else {
                console.log("not new step");
                var temp=$('.ajax-response-target');
                temp.removeClass('ajax-response-target').data('step-id',step_id );
                //temp.data('step-id',step_id );
            }
        };
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Work with Modal
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        var modal = {
            in_dom:$("#edit_step"),
            id:$("#modal_id"),
            title:$("#modal_title"),
            description:$("#modal_description"),
            img:$("#modal_img")
        };

        modal.in_dom.on('show.bs.modal', function (event) {
//
//        INDEX!!!!!!!!!!!!!
//
            console.log($('#ordered').index())
//
//        INDEX!!!!!!!!!!!!!
//
            clear_dropzone(myDropzone);
            get_step_data(event);
            bind_form();

            // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
            // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.

//        modal.find('.modal-body input').val(recipient)
        });




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Send Ajax Form
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        var options = {
            beforeSubmit:  showRequest,  // pre-submit callback
            success:       showResponse , // post-submit callback
            resetForm: true        // reset the form after successful submit
        };


        function showRequest(formData, jqForm, options) {
            var queryString = $.param(formData);
            console.log('About to submit: \n\n' + queryString);
            return true;
        }

// post-submit callback
        function showResponse(responseText, statusText, xhr, $form)  {
            console.log("show response")
            if (responseText.length>0){
                console.log("Long Enough");
                set_new_step_id(responseText)

            }
//            alert('status: ' + statusText + '\n\nresponseText: \n' + responseText +
//                    '\n\nThe output div should have already been updated with the responseText.');
            modal.in_dom.modal('hide');
        }

        // bind form using 'ajaxForm'


        $('#save_btn').click(function(event) {

            console.log("click_save");
            $('#new_instruction_form').ajaxSubmit(options);
            //form.ajaxSubmit(options);
            console.log("passed ajax");

            if (!is_new_step){
                console.log("new step");
                set_step_data();
            }
            else {
                $("#sortable").append("" +
                        " <div class=\"ui-state-default list-group-ite col-xs-12 col-sm-6 col-md-3 col-lg-3 inner ajax-response-target\" " +
                        " data-step-id=\""+modal.id.val()+"\" data-step-description=\""+ modal.description.val()+"\" data-toggle=\"modal\" href='#edit_step'>"+
                        "<div class=\"thumbnail\">"+
                        "<img class=\"step-img\" src=\""+modal.img.val()+"\" alt=\"...\">" +
                        "</div>"+
                        "<div class= \" caption \"> "+
                        "<h3 class=\"step_name\">"+modal.title.val()+"</h3>"+
                        "</div>"+
                        "</div>" )
                console.log("not new step");
                is_new_step=false;
            }

            //$('#new_instruction_form').submit();
            //modal.in_dom.remove();
        });

        $('#add_step').click(function(event) {
            is_new_step=true;
            console.log("addStep");


        });



        modal.in_dom.on('hide.bs.modal', function () {
            $('#new_instruction_form').resetForm();
//        clear_dropzone(myDropzone);
//        alert('The modal is about to be hidden.');
        });

        function loadImage(path, target) {
            console.log("loadImage")
            image=$(target);
            image.val(path);
            console.log("path")

        }

    });


</script>



</body>
</html>




