package com.kubar.itransition.security.util;

import com.kubar.itransition.model.SocialMediaService;
import com.kubar.itransition.model.User;
import com.kubar.itransition.dto.UserDetailsDto;
import com.kubar.itransition.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.UserProfile;
import org.springframework.stereotype.Component;

@Component
public class SecurityUtil {

    @Autowired
    UserService userService;

    public void logInUser(User user) {
        System.out.println("loginuser");
        UserDetailsDto userDetails = UserDetailsDto.getBuilder()
                .id(user.getId())
                .name(user.getName())
                .socialProvider(user.getSignInProvider())
                .roles(user.getRoles())
                .build();
        Authentication authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(authentication);
    }

    public User createRegistrationUser(Connection<?> connection) {
        System.out.println("createregistrationuser");
        User user = new User();
        if (connection != null) {
            UserProfile socialMediaProfile = connection.fetchUserProfile();
            user.setId(connection.getKey().toString());
            user.setName(socialMediaProfile.getName());
            user.setSignInProvider(SocialMediaService.valueOf(connection.getKey().getProviderId().toUpperCase()));
        }
        return user;
    }

    public User getUserFromContext(){
        try{
            UserDetailsDto userDetailsDto =(UserDetailsDto) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            return userService.findById(userDetailsDto.getId());
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
