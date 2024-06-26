package com.company.movies_database.movies_database.movies_database.rating.generated;

import com.company.movies_database.movies_database.movies_database.movies.Movies;
import com.company.movies_database.movies_database.movies_database.rating.Rating;
import com.company.movies_database.movies_database.movies_database.users.Users;
import com.speedment.common.annotation.GeneratedCode;
import com.speedment.runtime.core.manager.Manager;
import com.speedment.runtime.core.util.OptionalUtil;

import java.math.BigDecimal;
import java.util.Objects;
import java.util.Optional;
import java.util.StringJoiner;

/**
 * The generated base implementation of the {@link
 * com.company.movies_database.movies_database.movies_database.rating.Rating}-interface.
 * <p>
 * This file has been automatically generated by Speedment. Any changes made to
 * it will be overwritten.
 * 
 * @author Speedment
 */
@GeneratedCode("Speedment")
public abstract class GeneratedRatingImpl implements Rating {
    
    private int userId;
    private int movieId;
    private BigDecimal rating;
    
    protected GeneratedRatingImpl() {}
    
    @Override
    public int getUserId() {
        return userId;
    }
    
    @Override
    public int getMovieId() {
        return movieId;
    }
    
    @Override
    public Optional<BigDecimal> getRating() {
        return Optional.ofNullable(rating);
    }
    
    @Override
    public Rating setUserId(int userId) {
        this.userId = userId;
        return this;
    }
    
    @Override
    public Rating setMovieId(int movieId) {
        this.movieId = movieId;
        return this;
    }
    
    @Override
    public Rating setRating(BigDecimal rating) {
        this.rating = rating;
        return this;
    }
    
    @Override
    public Users findUserId(Manager<Users> foreignManager) {
        return foreignManager.stream().filter(Users.USER_ID.equal(getUserId())).findAny().orElse(null);
    }
    
    @Override
    public Movies findMovieId(Manager<Movies> foreignManager) {
        return foreignManager.stream().filter(Movies.MOVIE_ID.equal(getMovieId())).findAny().orElse(null);
    }
    
    @Override
    public String toString() {
        final StringJoiner sj = new StringJoiner(", ", "{ ", " }");
        sj.add("userId = "  + Objects.toString(getUserId()));
        sj.add("movieId = " + Objects.toString(getMovieId()));
        sj.add("rating = "  + Objects.toString(OptionalUtil.unwrap(getRating())));
        return "RatingImpl " + sj.toString();
    }
    
    @Override
    public boolean equals(Object that) {
        if (this == that) { return true; }
        if (!(that instanceof Rating)) { return false; }
        final Rating thatRating = (Rating)that;
        if (this.getUserId() != thatRating.getUserId()) { return false; }
        if (this.getMovieId() != thatRating.getMovieId()) { return false; }
        if (!Objects.equals(this.getRating(), thatRating.getRating())) { return false; }
        return true;
    }
    
    @Override
    public int hashCode() {
        int hash = 7;
        hash = 31 * hash + Integer.hashCode(getUserId());
        hash = 31 * hash + Integer.hashCode(getMovieId());
        hash = 31 * hash + Objects.hashCode(OptionalUtil.unwrap(getRating()));
        return hash;
    }
}