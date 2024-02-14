package com.company.movies_database.movies_database.movies_database.people.generated;

import com.company.movies_database.movies_database.movies_database.people.People;
import com.speedment.common.annotation.GeneratedCode;
import com.speedment.runtime.core.util.OptionalUtil;

import java.util.Objects;
import java.util.Optional;
import java.util.StringJoiner;

/**
 * The generated base implementation of the {@link
 * com.company.movies_database.movies_database.movies_database.people.People}-interface.
 * <p>
 * This file has been automatically generated by Speedment. Any changes made to
 * it will be overwritten.
 * 
 * @author Speedment
 */
@GeneratedCode("Speedment")
public abstract class GeneratedPeopleImpl implements People {
    
    private int personId;
    private String name;
    private String occupation;
    private String imageUrl;
    
    protected GeneratedPeopleImpl() {}
    
    @Override
    public int getPersonId() {
        return personId;
    }
    
    @Override
    public String getName() {
        return name;
    }
    
    @Override
    public Optional<String> getOccupation() {
        return Optional.ofNullable(occupation);
    }
    
    @Override
    public String getImageUrl() {
        return imageUrl;
    }
    
    @Override
    public People setPersonId(int personId) {
        this.personId = personId;
        return this;
    }
    
    @Override
    public People setName(String name) {
        this.name = name;
        return this;
    }
    
    @Override
    public People setOccupation(String occupation) {
        this.occupation = occupation;
        return this;
    }
    
    @Override
    public People setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
        return this;
    }
    
    @Override
    public String toString() {
        final StringJoiner sj = new StringJoiner(", ", "{ ", " }");
        sj.add("personId = "   + Objects.toString(getPersonId()));
        sj.add("name = "       + Objects.toString(getName()));
        sj.add("occupation = " + Objects.toString(OptionalUtil.unwrap(getOccupation())));
        sj.add("imageUrl = "   + Objects.toString(getImageUrl()));
        return "PeopleImpl " + sj.toString();
    }
    
    @Override
    public boolean equals(Object that) {
        if (this == that) { return true; }
        if (!(that instanceof People)) { return false; }
        final People thatPeople = (People)that;
        if (this.getPersonId() != thatPeople.getPersonId()) { return false; }
        if (!Objects.equals(this.getName(), thatPeople.getName())) { return false; }
        if (!Objects.equals(this.getOccupation(), thatPeople.getOccupation())) { return false; }
        if (!Objects.equals(this.getImageUrl(), thatPeople.getImageUrl())) { return false; }
        return true;
    }
    
    @Override
    public int hashCode() {
        int hash = 7;
        hash = 31 * hash + Integer.hashCode(getPersonId());
        hash = 31 * hash + Objects.hashCode(getName());
        hash = 31 * hash + Objects.hashCode(OptionalUtil.unwrap(getOccupation()));
        hash = 31 * hash + Objects.hashCode(getImageUrl());
        return hash;
    }
}