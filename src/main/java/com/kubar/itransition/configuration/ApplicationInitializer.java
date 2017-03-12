package com.kubar.itransition.configuration;


import org.springframework.orm.hibernate4.support.OpenSessionInViewFilter;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.DelegatingFilterProxy;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.*;
import java.util.EnumSet;


public class ApplicationInitializer implements WebApplicationInitializer {

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {

        AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
        rootContext.register(ApplicationConfig.class);

        ServletRegistration.Dynamic dispatcher = servletContext.addServlet("dispatcher", new DispatcherServlet(rootContext));
        dispatcher.setLoadOnStartup(1);
        dispatcher.setInitParameter("throwExceptionIfNoHandlerFound", "true");
        dispatcher.addMapping("/");

        EnumSet<DispatcherType> dispatcherTypes = EnumSet.of(DispatcherType.REQUEST, DispatcherType.FORWARD);

        FilterRegistration.Dynamic characterEncoding = servletContext.addFilter("characterEncodingFilter", CharacterEncodingFilter.class);
        characterEncoding.setInitParameter("encoding", "UTF-8");
        characterEncoding.setInitParameter("forceEncoding", "true");
        characterEncoding.addMappingForServletNames(null, true, "dispatcher");

        FilterRegistration.Dynamic security = servletContext.addFilter("springSecurityFilterChain", new DelegatingFilterProxy());
        security.addMappingForUrlPatterns(dispatcherTypes, true, "/*");

        FilterRegistration.Dynamic filterOpenSession = servletContext.addFilter("openEntityManagerInViewFilter", OpenSessionInViewFilter.class);
        filterOpenSession.addMappingForServletNames(null, true, "dispatcher");

        servletContext.addListener(new ContextLoaderListener(rootContext));
    }



}


