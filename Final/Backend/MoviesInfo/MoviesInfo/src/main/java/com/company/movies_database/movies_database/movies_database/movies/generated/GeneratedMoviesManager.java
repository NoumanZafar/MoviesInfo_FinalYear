package com.company.movies_database.movies_database.movies_database.movies.generated;

import com.company.movies_database.movies_database.movies_database.movies.Movies;
import com.speedment.common.annotation.GeneratedCode;
import com.speedment.runtime.config.identifier.TableIdentifier;
import com.speedment.runtime.core.manager.Manager;
import com.speedment.runtime.field.Field;

import java.util.List;

import static java.util.Arrays.asList;
import static java.util.Collections.unmodifiableList;

/**
 * The generated base interface for the manager of every {@link
 * com.company.movies_database.movies_database.movies_database.movies.Movies}
 * entity.
 * <p>
 * This file has been automatically generated by Speedment. Any changes made to
 * it will be overwritten.
 * 
 * @author Speedment
 */
@GeneratedCode("Speedment")
public interface GeneratedMoviesManager extends Manager<Movies> {
    
    TableIdentifier<Movies> IDENTIFIER = TableIdentifier.of("MOVIES_DATABASE", "MOVIES_DATABASE", "MOVIES");
    List<Field<Movies>> FIELDS = unmodifiableList(asList(
        Movies.MOVIE_ID,
        Movies.TITLE,
        Movies.RELEASE_DATE,
        Movies.GENRE
    ));
    
    @Override
    default Class<Movies> getEntityClass() {
        return Movies.class;
    }
}