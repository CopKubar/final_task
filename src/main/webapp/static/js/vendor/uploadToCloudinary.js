function loadImage(path, target) {
    $('<img src="' + path + '">').load(function () {
        $(this).appendTo(target);
    });
}
var myDropzone = new Dropzone(document.getElementById('dropzone-area'), {
    uploadMultiple: false,
    parallelUploads: 1,
    acceptedFiles: '.jpg,.png,.jpeg,.gif',
    url: 'https://api.cloudinary.com/v1_1/depejwdfb/image/upload'
});
var prefix = "${pageContext.request.userPrincipal.name}" + "_"
myDropzone.on('sending', function (file, xhr, formData) {
    var fileName = prefix + file.name;
    formData.append('api_key', 338123839493786);
    formData.append('public_id', fileName);
    formData.append('upload_preset', 'ljwk2aya');
});
myDropzone.on("complete", function (file) {
    var fileName = prefix + file.name;
    var url = "http://res.cloudinary.com/depejwdfb/image/upload/c_pad,h_200/" + fileName + ".jpg";
    loadImage(url, '#images');
    myDropzone.removeFile(file);
    var uploadData = {'fileName': fileName, 'userName': "${pageContext.request.userPrincipal.name}"};
    /*doAjax(uploadData, "uploadImage");*/
});
