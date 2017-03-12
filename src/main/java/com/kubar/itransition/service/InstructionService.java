package com.kubar.itransition.service;

import com.kubar.itransition.model.Instruction;

import java.util.List;

public interface InstructionService {

    Instruction save(Instruction instruction);

    Instruction findById(Long id);

    void delete(Instruction instruction);

    List<Instruction> findAll();
}
