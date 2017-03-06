package com.kubar.itransition.service.Impl;

import com.kubar.itransition.dao.CategoryDao;
import com.kubar.itransition.model.Category;
import com.kubar.itransition.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CategoryServiceImpl implements CategoryService{

    @Autowired
    private CategoryDao categoryDao;

    @Override
    public Category findByName(String name) {
        return categoryDao.findByName(name);
    }

    @Override
    public void save(Category category) {
        categoryDao.saveAndFlush(category);
    }

    @Override
    public void delete(Category category) {
        categoryDao.delete(category);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.findAll();
    }
}
