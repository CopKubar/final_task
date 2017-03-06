package com.kubar.itransition.dao;

import com.kubar.itransition.model.Tag;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Cuba on 04.03.2017.
 */
public interface TagDao extends JpaRepository<Tag, Long>{

    Tag findByName(String name);
}
