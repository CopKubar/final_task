package com.kubar.itransition.service;

import com.kubar.itransition.model.Instruction;
import com.kubar.itransition.model.Like;
import com.kubar.itransition.model.User;

import java.util.List;
import java.util.Set;


public interface LikeService {

    Like findById(Long id);

    void Like(User user, Instruction instruction);

    void Dislike(User user, Instruction instruction);

    Set<Like> findAllLikes(User user);

    Set<Like>findAllDislikes(User user);
}
