package com.kubar.itransition.service.Impl;

import com.kubar.itransition.dao.StepDao;
import com.kubar.itransition.model.Step;
import com.kubar.itransition.service.StepService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StepServiceImpl implements StepService{

    @Autowired
    private StepDao stepDao;

    @Override
    public Step findById(Long id) {
        return stepDao.findById(id);
    }

    @Override
    public void save(Step step) {
        stepDao.saveAndFlush(step);
    }

    @Override
    public void delete(Step step) {
        stepDao.delete(step);
    }
}
