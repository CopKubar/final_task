package com.kubar.itransition.dao;

import com.kubar.itransition.model.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

public interface UserDao extends JpaRepository<User, Long> {

    User findById(String id);

    User findByName(String name);
}
