package com.kubar.itransition.service;

import com.kubar.itransition.model.User;

import java.util.List;

public interface UserService {

    User registerNewUser(User user);

    User findById(String socialNumber);

    List<User>findAll();

    void setRoleAdminToUser(User user);

    void setBanToUser(User user);
}
