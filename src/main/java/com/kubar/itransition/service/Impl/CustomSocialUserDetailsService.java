package com.kubar.itransition.service.Impl;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.social.security.SocialUserDetails;
import org.springframework.social.security.SocialUserDetailsService;
import org.springframework.transaction.annotation.Transactional;


public class CustomSocialUserDetailsService implements SocialUserDetailsService{

    private UserDetailsService userDetailsService;

    public CustomSocialUserDetailsService(UserDetailsService userDetailsService) {
        this.userDetailsService=userDetailsService;
    }

    @Override
    public SocialUserDetails loadUserByUserId(String s) throws UsernameNotFoundException {
        System.out.println("SocialUserById");
        return (SocialUserDetails) userDetailsService.loadUserByUsername(s);
    }
}
