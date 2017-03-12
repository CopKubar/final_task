package com.kubar.itransition.utilities.forModels;

import com.kubar.itransition.model.Comment;
import com.kubar.itransition.model.Step;
import com.kubar.itransition.service.InstructionService;
import com.kubar.itransition.service.StepService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import static org.apache.commons.lang3.StringEscapeUtils.escapeHtml4;

@Component
public class StepUtil {

    @Autowired
    private StepService stepService;

    @Autowired
    private InstructionService instructionService;

    public List<Step> getSortedListWithSteps(List<Step>steps){
        Comparator<Step> compPosition = new Comparator<Step>() {
            @Override
            public int compare(Step o1, Step o2) {
                return o1.getPosition()-o2.getPosition();
            }
        };
        steps.sort(compPosition);
        return steps;
    }


    public void changePositions(Long stepId, int newPosition) {
        Step stepChange = stepService.findById(stepId);
        stepService.delete(stepChange);
        List<Step> steps2 = getSortedListWithSteps(instructionService.findById(stepChange.getInstruction().getId()).getSteps());
        for (int i = stepChange.getPosition(); i < steps2.size(); i++) {
            steps2.get(i).setPosition(steps2.get(i).getPosition() - 1);
            stepService.save(steps2.get(i));
        }
        stepChange.setPosition(newPosition);
        steps2.add(newPosition, stepChange);
        stepService.save(stepChange);
        for (int i = newPosition + 1; i < steps2.size(); i++) {
            steps2.get(i).setPosition(steps2.get(i).getPosition() + 1);
            stepService.save(steps2.get(i));
        }
    }

    public String generatedJson(Step step){

        String returnString= "{\"step\" : { \"id\" : \"" + step.getId() + "\" ,\"name\" : \"" + step.getName() + "\" , \"imageUrl\" : \"" + step.getImageUrl() +
                        "\", \"description\" : \"" + step.getDescription() + "\" , \"comments\" : {" + coments(step.getComments()) +"}}}";
        return returnString;
    }

    private String coments(List<Comment>comments){
        String s="";
        if (comments!=null) {
            Iterator<Comment> iterator = comments.iterator();
            while (iterator.hasNext()) {
                s += iterator.next();
                if (iterator.hasNext()) {
                    s += ",";
                }
            }
        }
        return s;
    }

}
