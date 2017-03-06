package com.kubar.itransition.service;

import com.kubar.itransition.model.Tag;


public interface TagService {

    Tag findByName(String name);

    void save(Tag tag);

    void delete(Tag tag);
}
