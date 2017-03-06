package com.kubar.itransition.dto;

import com.kubar.itransition.model.Role;
import com.kubar.itransition.model.SocialMediaService;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.social.security.SocialUser;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;


public class UserDetailsDto extends SocialUser{

    private String id;

    private String name;

    private Set<Role> roles=new HashSet<>();

    private SocialMediaService socialProvider;

    public UserDetailsDto(String username, String password, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);
    }

    public static Builder getBuilder(){
        return new Builder();
    }

    public String getId(){
        return id;
    }

    public String getName(){
        return name;
    }

    public Set<Role> getRoles(){
        return roles;
    }

    public SocialMediaService getSocialProvider(){
        return socialProvider;
    }

    @Override
    public String toString() {
        return "UserDetailsDto{" +
                "id=" + id +
                ", username='" + name + '\'' +
                ", roles=" + roles +
                ", socialProvider=" + socialProvider +
                '}';
    }

    public static class Builder {
        private String id;

        private String name;

        private Set<Role> roles=new HashSet<>();

        private SocialMediaService socialProvider;

        private Set<GrantedAuthority> authorities;

        public Builder() {
            this.authorities = new HashSet<>();
        }


        public Builder id(String id) {
            this.id = id;
            return this;
        }

        public Builder name(String name) {
            this.name = name;
            return this;
        }

        public Builder roles(Set<Role>roles) {
            for (Role role: roles){
                SimpleGrantedAuthority authority = new SimpleGrantedAuthority(role.getType());
                this.authorities.add(authority);
            }
            return this;
        }

        public Builder socialProvider(SocialMediaService socialProvider) {
            this.socialProvider = socialProvider;
            return this;
        }



        public UserDetailsDto build() {
            UserDetailsDto userDetailsDto = new UserDetailsDto(name, "", authorities);

            userDetailsDto.id = id;
            userDetailsDto.name = name;
            userDetailsDto.roles=roles;
            userDetailsDto.socialProvider = socialProvider;

            return userDetailsDto;
        }
    }
}
