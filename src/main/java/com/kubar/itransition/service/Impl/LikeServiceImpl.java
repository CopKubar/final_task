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

import java.util.HashSet;
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
        Set<Like> likes = user.getLikes();
        for (Like like: likes){
            if (instruction.getLikes().contains(like)){
                if (!like.getState()){
                    like.setState(true);
                    likeDao.saveAndFlush(like);
                }else if (like.getState()){
                    likeDao.delete(like);
                }
            }else {
                persistAllAboutLike(user, true, instruction);
            }
        }
    }

    @Override
    public void Dislike(User user, Instruction instruction) {
        Set<Like> likes = user.getLikes();
        for (Like like: likes){
            if (instruction.getLikes().contains(like)){
                if (!like.getState()){
                    likeDao.delete(like);
                }else if (like.getState()){
                    like.setState(false);
                    likeDao.saveAndFlush(like);
                }
            }else {
                persistAllAboutLike(user, false, instruction);
            }
        }
    }

    private void persistAllAboutLike(User user, boolean state, Instruction instruction){
        Set<Like>likeSet=new HashSet<>();
        likeSet.add(likeDao.saveAndFlush(new Like(user,state, instruction)));
        user.setLikes(likeSet);
        instruction.setLikes(likeSet);
        userDao.saveAndFlush(user);
        instructionDao.saveAndFlush(instruction);
    }


}
