<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/">
                Best Way
            </a>
        </div>
        <form class="navbar-form navbar-left" action="/doSearch" role="search">
            <div class="form-group">
                <input type="text" name="searchText" placeholder="<spring:message code="main.search"/>"/>
            </div>
            <button type="submit" class="btn btn-default"><spring:message code="main.search"/></button>
        </form>

        <ul class="nav navbar-nav navbar-right">
            <li role="presentation" class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                    <spring:message code="main.categories"/> <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <c:forEach items="${categories}" var="category">
                        <li><a href="/searchByCategory/${category.name}"> <spring:message code="${category.name}"/></a></li>
                    </c:forEach>
                </ul>
            </li>

            <li role="presentation" class="dropdown  hidden-xs hidden-sm">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                    <spring:message code="main.lang"/><span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="<c:url value="?lang=ru"/>">
                        <span class="badge"><spring:message code="lang.ru"/></span>
                    </a></li>
                    <li><a href="<c:url value="?lang=en"/>">
                        <span class="badge"><spring:message code="lang.en"/></span>
                    </a></li>
                </ul>
            </li>
            <li role="presentation" class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                    <spring:message code="main.theme"/><span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="<c:url value="/?mytheme=theme1"/>"><spring:message code="theme.light"/></a></li>
                    <li><a href="<c:url value="/?mytheme=theme2"/>"><spring:message code="theme.dark"/></a></li>
                </ul>
            </li>
            <li class="divider"></li>
            <sec:authorize access="hasRole('ROLE_USER')">
                <li role="presentation" class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                        <spring:message code="main.signed"/> <sec:authentication property="principal.name"/><span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/logout"><spring:message code="user.logout"/></a></li>
                        <li><a href="${pageContext.request.contextPath}/profile"><spring:message code="main.profile"/></a></li>
                    </ul>
                </li>
            </sec:authorize>
            <sec:authorize access="isAnonymous()">
                <li>
                    <button id='modal-launcher' class="btn btn-primary btn-lg" data-toggle="modal" data-target="#login-modal">
                        <spring:message code="user.login"/>
                    </button>
                </li>
            </sec:authorize>
        </ul>

    </div>
</div>

<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header login_modal_header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h2 class="modal-title" id="myModalLabel"><spring:message code="user.login.account"/></h2>
            </div>
            <div class="modal-body login-modal">
                <br/>
                <div class="clearfix"></div>
                <div id='social-icons-conatainer'>
                    <%--<div class='modal-body-right'>--%>
                    <div class="modal-social-icons">
                        <a href='${pageContext.request.contextPath}/auth/facebook' class="btn btn-default facebook"> <i class="fa fa-facebook modal-icons"></i></a>
                        <a href='${pageContext.request.contextPath}/auth/twitter' class="btn btn-default twitter"> <i class="fa fa-twitter modal-icons"></i></a>
                        <a href='${pageContext.request.contextPath}/auth/vkontakte' class="btn btn-default vk"> <i class="fa fa-vk modal-icons"></i></a>
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
<%--<div class="navbar navbar-inverse navbar-fixed-top">--%>
    <%--<div class="container-fluid">--%>
        <%--<div class="navbar-header">--%>
            <%--<a class="navbar-brand" href="#">--%>
                <%--<img alt="Brand" src="...">--%>
            <%--</a>--%>
        <%--</div>--%>
        <%--<form class="navbar-form navbar-left" action="/doSearch" role="search">--%>
            <%--<div class="form-group">--%>
                <%--<input type="text" name="searchText" placeholder="<spring:message code="main.search"/>"/>--%>
            <%--</div>--%>
            <%--<button type="submit" class="btn btn-default"><spring:message code="main.search"/></button>--%>
        <%--</form>--%>

        <%--<ul class="nav navbar-nav navbar-right">--%>
            <%--<li role="presentation" class="dropdown">--%>
                <%--<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">--%>
                    <%--<spring:message code="main.categories"/> <span class="caret"></span>--%>
                <%--</a>--%>
                <%--<ul class="dropdown-menu">--%>
                    <%--<li><a href="#"> punct 2.1</a></li>--%>
                    <%--<li><a href="#"> punct 2.2</a></li>--%>
                    <%--<li><a href="#"> punct 2.3</a></li>--%>
                <%--</ul>--%>
            <%--</li>--%>
            <%--<li role="presentation" class="dropdown">--%>
                <%--<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">--%>
                    <%--<spring:message code="main.lang"/><span class="caret"></span>--%>
                <%--</a>--%>
                <%--<ul class="dropdown-menu">--%>
                    <%--<li><a href="<c:url value="?lang=ru"/>">--%>
                        <%--<span class="badge"><spring:message code="lang.ru"/></span>--%>
                    <%--</a></li>--%>
                    <%--<li><a href="<c:url value="?lang=en"/>">--%>
                        <%--<span class="badge"><spring:message code="lang.en"/></span>--%>
                    <%--</a></li>--%>
                <%--</ul>--%>
            <%--</li>--%>
            <%--<li role="presentation" class="dropdown">--%>
                <%--<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">--%>
                    <%--<spring:message code="main.theme"/><span class="caret"></span>--%>
                <%--</a>--%>
                <%--<ul class="dropdown-menu">--%>
                    <%--<li><a href="#"><spring:message code="theme.dark"/></a></li>--%>
                    <%--<li><a href="#"><spring:message code="theme.light"/></a></li>--%>
                <%--</ul>--%>
            <%--</li>--%>
            <%--<li class="divider"></li>--%>
            <%--<sec:authorize access="hasRole('ROLE_USER')">--%>
            <%--<li role="presentation" class="dropdown">--%>
                <%--<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">--%>
                    <%--<spring:message code="main.signed"/> <sec:authentication property="principal.name"/><span class="caret"></span>--%>
                <%--</a>--%>
                <%--<ul class="dropdown-menu">--%>
                    <%--<li><a href="${pageContext.request.contextPath}/logout"><spring:message code="user.logout"/></a></li>--%>
                    <%--<li><a href="${pageContext.request.contextPath}/profile"><spring:message code="main.profile"/></a></li>--%>
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