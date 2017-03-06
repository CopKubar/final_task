package com.kubar.itransition.service;

import com.kubar.itransition.model.Step;


public interface StepService {

    Step findById(Long id);

    void save(Step step);

    void delete(Step step);
}
