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

import java.util.List;
import java.util.Objects;
import java.util.Set;

@Service
@Transactional
public class LikeServiceImpl implements LikeService{

    @Autowired
    private LikeDao likeDao;

    @Override
    public Like findById(Long id) {
        return likeDao.findById(id);
    }

    @Override
    public void changeRating(User user, Instruction instruction, int ratingValue) {
        System.out.println("в методе");
        Like like=null;

        List<Like>likes=user.getLikes();
        for (Like like1: likes){
            for (Like like2: instruction.getLikes()){
                if (Objects.equals(like1.getId(), like2.getId())){
                    like=like2;
                }
            }
        }

        if (like!=null){
            if (ratingValue==0){
                likeDao.delete(like);
            }
            else if (ratingValue==1){
                like.setState(1);
                likeDao.saveAndFlush(like);
            }else if (ratingValue==-1){
                like.setState(-1);
                likeDao.saveAndFlush(like);
            }
        }else {
            if (ratingValue==1){
                likeDao.saveAndFlush(new Like(user, 1, instruction));
            }else if (ratingValue==-1){
                likeDao.saveAndFlush(new Like(user, -1, instruction));
            }
        }
        System.out.println("конец метода");
    }

    @Override
    public Integer findAllLikes(List<Like> likes) {
        return getAllLikeOrDislike(likes);
    }

    @Override
    public void delete(Like like) {
        likeDao.delete(like);
    }
    private Integer getAllLikeOrDislike(List<Like> likes){
        int rating=0;
        for (Like like: likes){
            rating+=like.getState();
        }
        return rating;
    }

    @Override
    public int getUsersStateLike(User user, Instruction instruction){
        List<Like>likes=user.getLikes();
        for (Like like: likes){
            for (Like like1: instruction.getLikes()){
                if(Objects.equals(like.getId(), like1.getId())){
                    System.out.println(like.getState());
                    return like.getState();
                }
            }
        }
        System.out.println(0);
        return 0;
    }


}
