<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
        <c:forEach items="${users}" var="user">
            <tr>
                <id>${user.id}</id>
                <td>${user.name}</td>
                <td>${user.signInProvider}</td>
                <td>
                    <a href="<c:url value="/profile/${user.id}"/> "></a>
                </td>
            </tr>
        </c:forEach>
</body>
</html>
