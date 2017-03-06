<%--
  Created by IntelliJ IDEA.
  User: Cuba
  Date: 03.03.2017
  Time: 17:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search</title>
</head>
<body>

<h1>Search for Books</h1>
<form action="/doSearch" method="get">
    Search: <input type="text" name="searchText" /><br/>
    <input type="submit"/>
</form>

</body>
</html>
