package com.kubar.itransition.service.Impl;

import com.kubar.itransition.dao.InstructionDao;
import com.kubar.itransition.model.Instruction;
import com.kubar.itransition.service.InstructionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class InstructionServiceImpl implements InstructionService{

    @Autowired
    private InstructionDao instructionDao;

    @Override
    public Instruction save(Instruction instruction) {
        return instructionDao.saveAndFlush(instruction);
    }

    @Override
    public Instruction findById(Long id) {
        return instructionDao.findById(id);
    }

    @Override
    public void delete(Instruction instruction) {

    }
}
