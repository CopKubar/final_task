package com.kubar.itransition.service.Impl;

import com.kubar.itransition.dao.InstructionDao;
import com.kubar.itransition.dao.LikeDao;
import com.kubar.itransition.dao.UserDao;
import com.kubar.itransition.model.Instruction;
import com.kubar.itransition.model.Like;
import com.kubar.itransition.model.User;
import com.kubar.itransition.service.LikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@Transactional
public class LikeServiceImpl implements LikeService{

    @Autowired
    private LikeDao likeDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private InstructionDao instructionDao;

    @Override
    public Like findById(Long id) {
        return likeDao.findById(id);
    }

    @Override
    public void Like(User user, Instruction instruction) {
        boolean changed=false;
        Set<Like>likes=user.getLikes();
        for (Like like: likes){
            if (instruction.getLikes().contains(like)){
                if (like.getState()){
                    likeDao.delete(like);
                    changed=true;
                }else {
                    like.setState(true);
                    likeDao.saveAndFlush(like);
                    changed=true;
                }
            }
        }
        if (!changed){
            persistAllAboutLike(user, true, instruction);
        }
    }

    @Override
    public void Dislike(User user, Instruction instruction) {
        boolean changed=false;
        Set<Like>likes=user.getLikes();
        for (Like like: likes){
            if (instruction.getLikes().contains(like)){
                if (like.getState()){
                    like.setState(false);
                    likeDao.saveAndFlush(like);
                    changed=true;
                }else {
                    likeDao.delete(like);
                    changed=true;
                }
            }
        }
        if (!changed){
            persistAllAboutLike(user, false, instruction);
        }
    }

    @Override
    public Set<Like> findAllLikes(User user) {
        return getAllLikeOrDislike(user.getLikes(), true);
    }

    @Override
    public Set<Like> findAllDislikes(User user) {
        return getAllLikeOrDislike(user.getLikes(), false);
    }


    private void persistAllAboutLike(User user, boolean state, Instruction instruction){
        Like like=likeDao.saveAndFlush(new Like(user, state, instruction));
        Set<Like>userLikes=new HashSet<>();
        userLikes.add(like);
        user.setLikes(userLikes);
        userDao.saveAndFlush(user);
        instruction.setLikes(userLikes);
        instructionDao.saveAndFlush(instruction);
    }

    private Set<Like> getAllLikeOrDislike(Set<Like> likes, boolean value){
        Set<Like>sortedLikes=new HashSet<>();
        if (value){
            for (Like like: likes){
                if (like.getState()){
                    sortedLikes.add(like);
                }
            }
        }else {
            for (Like like: likes){
                if (!like.getState()){
                    sortedLikes.add(like);
                }
            }
        }
        return sortedLikes;
    }

}
