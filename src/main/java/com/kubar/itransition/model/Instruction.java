package com.kubar.itransition.model;

import org.hibernate.search.annotations.*;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "instructions")
public class Instruction implements Serializable{

    private Long id;
    private String title;
    private String imageUrl;
    private String youtubeUrl;
    private User user;
    private Category category;
    private Set<Like> likes=new HashSet<>();
    private Set<Step> steps=new HashSet<>();
    private Set<Tag> tags=new HashSet<>();

    public Instruction(){}

    public Instruction(String title, String imageUrl, String youtubeUrl, User user, Category category, Set<Step> steps, Set<Tag> tags) {
        this.title = title;
        this.imageUrl = imageUrl;
        this.youtubeUrl = youtubeUrl;
        this.user = user;
        this.category = category;
        this.steps = steps;
        this.tags = tags;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "instruction_id")
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column(name = "title")
    @Field(index = org.hibernate.search.annotations.Index.YES, analyze = Analyze.YES, store = Store.NO)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column(name = "image_url")
    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Column(name = "youtube_url")
    public String getYoutubeUrl() {
        return youtubeUrl;
    }

    public void setYoutubeUrl(String youtubeUrl) {
        this.youtubeUrl = youtubeUrl;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "instruction", fetch = FetchType.LAZY)
    public Set<Like> getLikes() {
        return likes;
    }

    public void setLikes(Set<Like> likes) {
        this.likes = likes;
    }

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "instruction", fetch = FetchType.LAZY)
    public Set<Step> getSteps() {
        return steps;
    }

    public void setSteps(Set<Step> steps) {
        this.steps = steps;
    }

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "instruction_tag",
            joinColumns = { @JoinColumn(name = "instruction_id")},
            inverseJoinColumns = { @JoinColumn(name = "tag_id")})
    public Set<Tag> getTags() {
        return tags;
    }

    public void setTags(Set<Tag> tags) {
        this.tags = tags;
    }

    @Override
    public String toString() {
        return "Instruction{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", youtubeUrl='" + youtubeUrl + '\'' +
                ", user=" + user +
                ", category=" + category +
                ", likes=" + likes +
                ", steps=" + steps +
                ", tags=" + tags +
                '}';
    }


}
