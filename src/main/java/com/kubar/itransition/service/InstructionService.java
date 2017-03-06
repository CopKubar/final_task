package com.kubar.itransition.service;

import com.kubar.itransition.model.Instruction;

public interface InstructionService {

    Instruction save(Instruction instruction);

    Instruction findById(Long id);

    void delete(Instruction instruction);
}
