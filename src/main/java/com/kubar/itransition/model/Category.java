package com.kubar.itransition.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "categories")
public class Category implements Serializable{

    private String name;
    private List<Instruction> instructions=new ArrayList<>();

    public Category(){}

    public Category(String name, List<Instruction> instructions) {
        this.name = name;
        this.instructions = instructions;
    }

    @Id
    @Column(name = "category_id")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "category", fetch = FetchType.LAZY)
    public List<Instruction> getInstructions() {
        return instructions;
    }

    public void setInstructions(List<Instruction> instructions) {
        this.instructions = instructions;
    }

    @Override
    public String toString() {
        return "Category{" +
                "name='" + name + '\'' +
                ", instructions=" + instructions +
                '}';
    }


}
