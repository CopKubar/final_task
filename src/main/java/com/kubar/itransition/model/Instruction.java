package com.kubar.itransition.model;

import org.hibernate.search.annotations.*;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
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
    private List<Like> likes=new ArrayList<>();
    private List<Step> steps=new ArrayList<>();
    private Set<Tag> tags=new HashSet<>();

    public Instruction(){}

    public Instruction(String title, String imageUrl, String youtubeUrl, User user, Category category, List<Step> steps, Set<Tag> tags) {
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

    @OneToMany(cascade = CascadeType.REMOVE, mappedBy = "instruction", fetch = FetchType.LAZY)
    public List<Like> getLikes() {
        return likes;
    }

    public void setLikes(List<Like> likes) {
        this.likes = likes;
    }

    @OneToMany(cascade = CascadeType.REMOVE, mappedBy = "instruction", fetch = FetchType.LAZY)
    @OrderBy("position")
    public List<Step> getSteps() {
        return steps;
    }

    public void setSteps(List<Step> steps) {
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Instruction that = (Instruction) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (title != null ? !title.equals(that.title) : that.title != null) return false;
        if (imageUrl != null ? !imageUrl.equals(that.imageUrl) : that.imageUrl != null) return false;
        if (youtubeUrl != null ? !youtubeUrl.equals(that.youtubeUrl) : that.youtubeUrl != null) return false;
        if (user != null ? !user.equals(that.user) : that.user != null) return false;
        return category != null ? category.equals(that.category) : that.category == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (imageUrl != null ? imageUrl.hashCode() : 0);
        result = 31 * result + (youtubeUrl != null ? youtubeUrl.hashCode() : 0);
        result = 31 * result + (user != null ? user.hashCode() : 0);
        result = 31 * result + (category != null ? category.hashCode() : 0);
        return result;
    }
}
