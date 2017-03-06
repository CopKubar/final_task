package com.kubar.itransition.dao;


import com.kubar.itransition.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryDao extends JpaRepository<Category, String>{

    Category findByName(String name);
}
