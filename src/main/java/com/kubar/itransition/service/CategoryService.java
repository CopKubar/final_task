package com.kubar.itransition.service;


import com.kubar.itransition.model.Category;

import java.util.List;

public interface CategoryService {

    Category findByName(String name);

    void save(Category category);

    void delete(Category category);

    List<Category> getAll();
}
