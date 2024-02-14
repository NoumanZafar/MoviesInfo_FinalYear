package com.company.movies_database.movies_database.movies_database.movie_images.generated;

import com.company.movies_database.movies_database.movies_database.movie_images.MovieImages;
import com.company.movies_database.movies_database.movies_database.movies.Movies;
import com.speedment.common.annotation.GeneratedCode;
import com.speedment.runtime.core.manager.Manager;
import com.speedment.runtime.core.util.OptionalUtil;

import java.util.Objects;
import java.util.Optional;
import java.util.OptionalInt;
import java.util.StringJoiner;

/**
 * The generated base implementation of the {@link
 * com.company.movies_database.movies_database.movies_database.movie_images.MovieImages}-interface.
 * <p>
 * This file has been automatically generated by Speedment. Any changes made to
 * it will be overwritten.
 * 
 * @author Speedment
 */
@GeneratedCode("Speedment")
public abstract class GeneratedMovieImagesImpl implements MovieImages {
    
    private int imageId;
    private Integer movieId;
    private String imageUrl;
    
    protected GeneratedMovieImagesImpl() {}
    
    @Override
    public int getImageId() {
        return imageId;
    }
    
    @Override
    public OptionalInt getMovieId() {
        return OptionalUtil.ofNullable(movieId);
    }
    
    @Override
    public String getImageUrl() {
        return imageUrl;
    }
    
    @Override
    public MovieImages setImageId(int imageId) {
        this.imageId = imageId;
        return this;
    }
    
    @Override
    public MovieImages setMovieId(Integer movieId) {
        this.movieId = movieId;
        return this;
    }
    
    @Override
    public MovieImages setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
        return this;
    }
    
    @Override
    public Optional<Movies> findMovieId(Manager<Movies> foreignManager) {
        if (getMovieId().isPresent()) {
            return foreignManager.stream().filter(Movies.MOVIE_ID.equal(getMovieId().getAsInt())).findAny();
        } else {
            return Optional.empty();
        }
    }
    
    @Override
    public String toString() {
        final StringJoiner sj = new StringJoiner(", ", "{ ", " }");
        sj.add("imageId = "  + Objects.toString(getImageId()));
        sj.add("movieId = "  + Objects.toString(OptionalUtil.unwrap(getMovieId())));
        sj.add("imageUrl = " + Objects.toString(getImageUrl()));
        return "MovieImagesImpl " + sj.toString();
    }
    
    @Override
    public boolean equals(Object that) {
        if (this == that) { return true; }
        if (!(that instanceof MovieImages)) { return false; }
        final MovieImages thatMovieImages = (MovieImages)that;
        if (this.getImageId() != thatMovieImages.getImageId()) { return false; }
        if (!Objects.equals(this.getMovieId(), thatMovieImages.getMovieId())) { return false; }
        if (!Objects.equals(this.getImageUrl(), thatMovieImages.getImageUrl())) { return false; }
        return true;
    }
    
    @Override
    public int hashCode() {
        int hash = 7;
        hash = 31 * hash + Integer.hashCode(getImageId());
        hash = 31 * hash + Objects.hashCode(OptionalUtil.unwrap(getMovieId()));
        hash = 31 * hash + Objects.hashCode(getImageUrl());
        return hash;
    }
}