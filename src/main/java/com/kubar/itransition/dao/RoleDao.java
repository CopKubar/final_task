package com.kubar.itransition.dao;

import com.kubar.itransition.model.Role;
import com.kubar.itransition.model.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

public interface RoleDao extends JpaRepository<Role, Long> {

    Role findById(Long id);
}
