<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/test" method="post">
        <input type="text" id="title" name="title" required>
        <input type="text" id="youtubeURL" name="youtubeUrl" required>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="submit" value="submit">
</form>
</body>
</html>
