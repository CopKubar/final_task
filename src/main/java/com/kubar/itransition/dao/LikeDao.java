package com.kubar.itransition.dao;

import com.kubar.itransition.model.Like;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Cuba on 04.03.2017.
 */
public interface LikeDao extends JpaRepository<Like, Long>{

    Like findById(Long id);
}
