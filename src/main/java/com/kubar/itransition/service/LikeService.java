package com.kubar.itransition.service;

import com.kubar.itransition.model.Instruction;
import com.kubar.itransition.model.Like;
import com.kubar.itransition.model.User;


public interface LikeService {

    Like findById(Long id);

    void Like(User user, Instruction instruction);

    void Dislike(User user, Instruction instruction);
}
