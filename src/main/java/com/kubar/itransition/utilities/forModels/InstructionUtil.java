package com.kubar.itransition.utilities.forModels;

import com.kubar.itransition.model.Instruction;
import com.kubar.itransition.model.Step;
import com.kubar.itransition.service.InstructionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.*;

@Component
public class InstructionUtil {

    @Autowired
    private InstructionService instructionService;

    public List<Instruction> get12MostPopularInstruction(List<Instruction>instructions){
        Comparator<Instruction> compLikes = new Comparator<Instruction>() {
            @Override
            public int compare(Instruction o1, Instruction o2) {
                return o1.getLikes().size()-o2.getLikes().size();
            }
        };
        List<Instruction>mostPopularInstructions=new ArrayList<>();
        instructions.sort(compLikes);
        for (int i=0; i<12; i++){
            mostPopularInstructions.add(instructions.get(i));
        }
        return mostPopularInstructions;
    }

    public List<Instruction> get12MostNewestInstruction(List<Instruction>instructions){
        List<Instruction>mostNewestInstructions=new ArrayList<>();
        for (int i=instructions.size()-1; i>=instructions.size()-12; i--){
            mostNewestInstructions.add(instructions.get(i));
        }
        return mostNewestInstructions;
    }

    public List<Instruction> getInstructionSearch(List<Step> steps){
        List<Instruction> instructions=new ArrayList<>();
        for (Step step: steps){
            if (instructions.size()==0){
                instructions.add(step.getInstruction());
            }
            for (Instruction instruction: instructions){
                if (!Objects.equals(instruction.getId(), step.getInstruction().getId())){
                    instructions.add(step.getInstruction());
                }
            }
        }
        return instructions;
    }
}
