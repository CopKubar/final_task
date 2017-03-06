package com.kubar.itransition.service;

import com.kubar.itransition.model.User;

public interface UserService {

    User registerNewUser(User user);

    User findById(String socialNumber);

    User findByName(String name);

    void setRoleAdminToUser(User user);

    void setBanToUser(User user);
}
