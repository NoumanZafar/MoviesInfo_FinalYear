package com.company.movies_database.movies_database.movies_database.movies.generated;

import com.company.movies_database.movies_database.movies_database.movies.Movies;
import com.company.movies_database.movies_database.movies_database.movies.MoviesImpl;
import com.company.movies_database.movies_database.movies_database.movies.MoviesManager;
import com.speedment.common.annotation.GeneratedCode;
import com.speedment.runtime.config.identifier.TableIdentifier;
import com.speedment.runtime.core.manager.AbstractManager;
import com.speedment.runtime.field.Field;

import java.util.stream.Stream;

/**
 * The generated base implementation for the manager of every {@link
 * com.company.movies_database.movies_database.movies_database.movies.Movies}
 * entity.
 * <p>
 * This file has been automatically generated by Speedment. Any changes made to
 * it will be overwritten.
 * 
 * @author Speedment
 */
@GeneratedCode("Speedment")
public abstract class GeneratedMoviesManagerImpl 
extends AbstractManager<Movies> 
implements GeneratedMoviesManager {
    
    private final TableIdentifier<Movies> tableIdentifier;
    
    protected GeneratedMoviesManagerImpl() {
        this.tableIdentifier = TableIdentifier.of("movies_database", "movies_database", "movies");
    }
    
    @Override
    public Movies create() {
        return new MoviesImpl();
    }
    
    @Override
    public TableIdentifier<Movies> getTableIdentifier() {
        return tableIdentifier;
    }
    
    @Override
    public Stream<Field<Movies>> fields() {
        return MoviesManager.FIELDS.stream();
    }
    
    @Override
    public Stream<Field<Movies>> primaryKeyFields() {
        return Stream.of(
            Movies.MOVIE_ID
        );
    }
}