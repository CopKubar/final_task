package com.kubar.itransition.dao;

import com.kubar.itransition.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentDao extends JpaRepository<Comment, Long>{

    Comment findById(Long id);

    //dao comment
}
