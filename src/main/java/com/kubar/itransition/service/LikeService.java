package com.kubar.itransition.service;

import com.kubar.itransition.model.Instruction;
import com.kubar.itransition.model.Like;
import com.kubar.itransition.model.User;

import java.util.List;
import java.util.Set;


public interface LikeService {

    Like findById(Long id);

    void changeRating(User user, Instruction instruction, int ratingValue);

    Integer findAllLikes(List<Like>likes);

    void delete(Like like);

    int getUsersStateLike(User user, Instruction instruction);

}
