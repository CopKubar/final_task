package com.kubar.itransition.model;

import org.hibernate.search.annotations.*;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Indexed
@Table(name = "steps")
public class Step implements Serializable {

    private Long id;
    private String name;
    private String imageUrl;
    private Integer position;
    private String description;
    private Instruction instruction;
    private List<Comment> comments = new ArrayList<>();

    public Step() {
    }

    public Step(Long id, String name, String imageUrl, Integer stepPosition, String description, Instruction instruction) {
        this.id = id;
        this.name = name;
        this.imageUrl = imageUrl;
        this.position = stepPosition;
        this.description = description;
        this.instruction = instruction;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "step_id")
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column(name = "name")
    @Field(index = org.hibernate.search.annotations.Index.YES, analyze = Analyze.YES, store = Store.NO)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "image_url")
    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Column(name = "position")
    public Integer getPosition() {
        return position;
    }

    public void setPosition(Integer position) {
        this.position = position;
    }

    @Column(name = "description")
    @Field(index = org.hibernate.search.annotations.Index.YES, analyze = Analyze.YES, store = Store.NO)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "instruction_id")
    @IndexedEmbedded
    public Instruction getInstruction() {
        return instruction;
    }

    public void setInstruction(Instruction instruction) {
        this.instruction = instruction;
    }

    @OneToMany(cascade = CascadeType.REMOVE, mappedBy = "step", fetch = FetchType.LAZY)
    @IndexedEmbedded
    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    @Override
    public String toString() {
        return "Step{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", position=" + position +
                ", description='" + description + '\'' +
                ", instruction=" + instruction +
                ", comments=" + comments +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Step step1 = (Step) o;

        if (id != null ? !id.equals(step1.id) : step1.id != null) return false;
        if (name != null ? !name.equals(step1.name) : step1.name != null) return false;
        if (imageUrl != null ? !imageUrl.equals(step1.imageUrl) : step1.imageUrl != null) return false;
        if (position != null ? !position.equals(step1.position) : step1.position != null) return false;
        if (description != null ? !description.equals(step1.description) : step1.description != null) return false;
        return instruction != null ? instruction.equals(step1.instruction) : step1.instruction == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (imageUrl != null ? imageUrl.hashCode() : 0);
        result = 31 * result + (position != null ? position.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
        result = 31 * result + (instruction != null ? instruction.hashCode() : 0);
        return result;
    }
}
