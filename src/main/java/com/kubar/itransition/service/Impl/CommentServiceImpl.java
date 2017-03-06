package com.kubar.itransition.service.Impl;

import com.kubar.itransition.dao.CommentDao;
import com.kubar.itransition.model.Comment;
import com.kubar.itransition.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CommentServiceImpl implements CommentService{

    @Autowired
    private CommentDao commentDao;

    @Override
    public Comment findById(Long id) {
        return commentDao.findById(id);
    }

    @Override
    public Comment save(Comment comment) {
        return commentDao.saveAndFlush(comment);
    }

    @Override
    public void delete(Comment comment) {
        commentDao.delete(comment);
    }
}
