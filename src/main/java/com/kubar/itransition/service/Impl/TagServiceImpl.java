package com.kubar.itransition.service.Impl;

import com.kubar.itransition.dao.TagDao;
import com.kubar.itransition.model.Tag;
import com.kubar.itransition.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class TagServiceImpl implements TagService{

    @Autowired
    private TagDao tagDao;

    @Override
    public Tag findByName(String name) {
        return tagDao.findByName(name);
    }

    @Override
    public void save(Tag tag) {

    }

    @Override
    public void delete(Tag tag) {

    }
}
