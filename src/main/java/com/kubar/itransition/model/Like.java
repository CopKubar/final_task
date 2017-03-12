package com.kubar.itransition.model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "likes")
public class Like implements Serializable{

    private Long id;
    private User user;
    private int state;
    private Instruction instruction;

    public Like(){}

    public Like(User user, int state, Instruction instruction) {
        this.user = user;
        this.state = state;
        this.instruction = instruction;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "like_id")
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Column(name = "state")
    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "instruction_id")
    public Instruction getInstruction() {
        return instruction;
    }

    public void setInstruction(Instruction instruction) {
        this.instruction = instruction;
    }

    @Override
    public String toString() {
        return "Like{" +
                "id=" + id +
                ", user=" + user +
                ", state=" + state +
                ", instruction=" + instruction +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Like like = (Like) o;

        if (state != like.state) return false;
        if (id != null ? !id.equals(like.id) : like.id != null) return false;
        if (user != null ? !user.equals(like.user) : like.user != null) return false;
        return instruction != null ? instruction.equals(like.instruction) : like.instruction == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (user != null ? user.hashCode() : 0);
        result = 31 * result + state;
        result = 31 * result + (instruction != null ? instruction.hashCode() : 0);
        return result;
    }
}
