package com.kubar.itransition.dao;

import com.kubar.itransition.model.Step;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StepDao extends JpaRepository<Step, Long>{

    Step findById(Long id);

    Step findByPosition(int position);

}
