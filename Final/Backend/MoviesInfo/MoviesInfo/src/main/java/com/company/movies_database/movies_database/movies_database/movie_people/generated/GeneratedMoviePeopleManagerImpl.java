package com.company.movies_database.movies_database.movies_database.movie_people.generated;

import com.company.movies_database.movies_database.movies_database.movie_people.MoviePeople;
import com.company.movies_database.movies_database.movies_database.movie_people.MoviePeopleImpl;
import com.company.movies_database.movies_database.movies_database.movie_people.MoviePeopleManager;
import com.speedment.common.annotation.GeneratedCode;
import com.speedment.runtime.config.identifier.TableIdentifier;
import com.speedment.runtime.core.manager.AbstractManager;
import com.speedment.runtime.field.Field;

import java.util.stream.Stream;

/**
 * The generated base implementation for the manager of every {@link
 * com.company.movies_database.movies_database.movies_database.movie_people.MoviePeople}
 * entity.
 * <p>
 * This file has been automatically generated by Speedment. Any changes made to
 * it will be overwritten.
 * 
 * @author Speedment
 */
@GeneratedCode("Speedment")
public abstract class GeneratedMoviePeopleManagerImpl 
extends AbstractManager<MoviePeople> 
implements GeneratedMoviePeopleManager {
    
    private final TableIdentifier<MoviePeople> tableIdentifier;
    
    protected GeneratedMoviePeopleManagerImpl() {
        this.tableIdentifier = TableIdentifier.of("movies_database", "movies_database", "movie_people");
    }
    
    @Override
    public MoviePeople create() {
        return new MoviePeopleImpl();
    }
    
    @Override
    public TableIdentifier<MoviePeople> getTableIdentifier() {
        return tableIdentifier;
    }
    
    @Override
    public Stream<Field<MoviePeople>> fields() {
        return MoviePeopleManager.FIELDS.stream();
    }
    
    @Override
    public Stream<Field<MoviePeople>> primaryKeyFields() {
        return Stream.of(
            MoviePeople.MOVIE_ID,
            MoviePeople.PERSON_ID
        );
    }
}