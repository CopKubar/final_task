package com.kubar.itransition.dao;

import com.kubar.itransition.model.Step;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Cuba on 04.03.2017.
 */
public interface StepDao extends JpaRepository<Step, Long>{

    Step findById(Long id);
}
