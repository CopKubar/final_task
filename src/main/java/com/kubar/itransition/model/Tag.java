package com.kubar.itransition.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "tags")
public class Tag implements Serializable{

    private String name;
    private Set<Instruction> instructions=new HashSet<>();

    public Tag(){}

    public Tag(String name, Set<Instruction> instructions) {
        this.name = name;
        this.instructions = instructions;
    }

    @Id
    @Column(name = "tag_id")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @ManyToMany(mappedBy = "tags", fetch = FetchType.LAZY)
    public Set<Instruction> getInstructions() {
        return instructions;
    }

    public void setInstructions(Set<Instruction> instructions) {
        this.instructions = instructions;
    }

    @Override
    public String toString() {
        return "Tag{" +
                "name='" + name + '\'' +
                ", instructions=" + instructions +
                '}';
    }


}
