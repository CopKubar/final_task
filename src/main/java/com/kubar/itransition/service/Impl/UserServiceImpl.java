package com.kubar.itransition.service.Impl;

import com.kubar.itransition.dao.RoleDao;
import com.kubar.itransition.dao.UserDao;
import com.kubar.itransition.model.Role;
import com.kubar.itransition.model.User;
import com.kubar.itransition.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Transactional
public class UserServiceImpl implements UserService{

    @Autowired
    private UserDao userDao;

    @Autowired
    private RoleDao roleDao;

    @Override
    public User registerNewUser(User user) {
        user.setRoles(getRoles(1L));
        userDao.saveAndFlush(user);
        return user;
    }

    @Override
    public User findById(String socialNumber) {
        return userDao.findById(socialNumber);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public void setRoleAdminToUser(User user) {
        user.setRoles(getRoles(2L));
        userDao.saveAndFlush(user);
    }

    @Override
    public void setBanToUser(User user) {
        user.getRoles().clear();
        user.setRoles(getRoles(3L));
        userDao.saveAndFlush(user);
    }

    private Set<Role> getRoles(Long id){
        Set<Role>roles=new HashSet<>();
        roles.add(roleDao.findById(id));
        return roles;
    }
}
