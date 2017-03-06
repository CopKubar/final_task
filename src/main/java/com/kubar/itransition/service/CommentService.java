package com.kubar.itransition.service;

import com.kubar.itransition.model.Comment;

public interface CommentService {

    Comment findById(Long id);

    Comment save(Comment comment);

    void delete(Comment comment);
}
