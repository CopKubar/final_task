package com.kubar.itransition.service.Impl;


import com.kubar.itransition.model.User;
import com.kubar.itransition.dto.UserDetailsDto;
import com.kubar.itransition.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;



public class CustomUserDetailsService implements UserDetailsService {

    private UserService userService;

    @Autowired
    public CustomUserDetailsService(UserService userService){
        this.userService=userService;
    }

    @Override
    public UserDetails loadUserByUsername(String number) throws UsernameNotFoundException {
        System.out.println("loadUserByUsername");
        User user = userService.findById(number);
        if (user == null){
            throw new UsernameNotFoundException("No user found with username: " + number);
        }
        return getUserDetailsDto(user);
    }

    private UserDetailsDto getUserDetailsDto(User user){
        UserDetailsDto principal = UserDetailsDto.getBuilder()
                .id(user.getId())
                .name(user.getName())
                .socialProvider(user.getSignInProvider())
                .roles(user.getRoles())
                .build();
        return principal;
    }
}
