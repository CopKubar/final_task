package com.kubar.itransition.service;

import com.kubar.itransition.model.Step;

import java.util.List;


public interface StepService {

    Step findById(Long id);

    Step findByPosition(int position);

    void save(Step step);

    void delete(Step step);

    void indexSteps() throws Exception;

    List<Step> searchLucene(String textSearch) throws Exception;
}
