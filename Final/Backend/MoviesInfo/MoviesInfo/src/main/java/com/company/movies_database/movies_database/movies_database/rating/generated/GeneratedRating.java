package com.company.movies_database.movies_database.movies_database.rating.generated;

import com.company.movies_database.movies_database.movies_database.movies.Movies;
import com.company.movies_database.movies_database.movies_database.rating.Rating;
import com.company.movies_database.movies_database.movies_database.users.Users;
import com.speedment.common.annotation.GeneratedCode;
import com.speedment.runtime.config.identifier.ColumnIdentifier;
import com.speedment.runtime.config.identifier.TableIdentifier;
import com.speedment.runtime.core.manager.Manager;
import com.speedment.runtime.core.util.OptionalUtil;
import com.speedment.runtime.field.ComparableField;
import com.speedment.runtime.field.IntForeignKeyField;
import com.speedment.runtime.typemapper.TypeMapper;

import java.math.BigDecimal;
import java.util.Optional;

/**
 * The generated base for the {@link
 * com.company.movies_database.movies_database.movies_database.rating.Rating}-interface
 * representing entities of the {@code RATING}-table in the database.
 * <p>
 * This file has been automatically generated by Speedment. Any changes made to
 * it will be overwritten.
 * 
 * @author Speedment
 */
@GeneratedCode("Speedment")
public interface GeneratedRating {
    
    /**
     * This Field corresponds to the {@link Rating} field that can be obtained
     * using the {@link Rating#getUserId()} method.
     */
    IntForeignKeyField<Rating, Integer, Users> USER_ID = IntForeignKeyField.create(
        Identifier.USER_ID,
        Rating::getUserId,
        Rating::setUserId,
        Users.USER_ID,
        TypeMapper.primitive(),
        false
    );
    /**
     * This Field corresponds to the {@link Rating} field that can be obtained
     * using the {@link Rating#getMovieId()} method.
     */
    IntForeignKeyField<Rating, Integer, Movies> MOVIE_ID = IntForeignKeyField.create(
        Identifier.MOVIE_ID,
        Rating::getMovieId,
        Rating::setMovieId,
        Movies.MOVIE_ID,
        TypeMapper.primitive(),
        false
    );
    /**
     * This Field corresponds to the {@link Rating} field that can be obtained
     * using the {@link Rating#getRating()} method.
     */
    ComparableField<Rating, BigDecimal, BigDecimal> RATING = ComparableField.create(
        Identifier.RATING,
        o -> OptionalUtil.unwrap(o.getRating()),
        Rating::setRating,
        TypeMapper.identity(),
        false
    );
    
    /**
     * Returns the userId of this Rating. The userId field corresponds to the
     * database column MOVIES_DATABASE.MOVIES_DATABASE.RATING.USER_ID.
     * 
     * @return the userId of this Rating
     */
    int getUserId();
    
    /**
     * Returns the movieId of this Rating. The movieId field corresponds to the
     * database column MOVIES_DATABASE.MOVIES_DATABASE.RATING.MOVIE_ID.
     * 
     * @return the movieId of this Rating
     */
    int getMovieId();
    
    /**
     * Returns the rating of this Rating. The rating field corresponds to the
     * database column MOVIES_DATABASE.MOVIES_DATABASE.RATING.RATING.
     * 
     * @return the rating of this Rating
     */
    Optional<BigDecimal> getRating();
    
    /**
     * Sets the userId of this Rating. The userId field corresponds to the
     * database column MOVIES_DATABASE.MOVIES_DATABASE.RATING.USER_ID.
     * 
     * @param userId to set of this Rating
     * @return       this Rating instance
     */
    Rating setUserId(int userId);
    
    /**
     * Sets the movieId of this Rating. The movieId field corresponds to the
     * database column MOVIES_DATABASE.MOVIES_DATABASE.RATING.MOVIE_ID.
     * 
     * @param movieId to set of this Rating
     * @return        this Rating instance
     */
    Rating setMovieId(int movieId);
    
    /**
     * Sets the rating of this Rating. The rating field corresponds to the
     * database column MOVIES_DATABASE.MOVIES_DATABASE.RATING.RATING.
     * 
     * @param rating to set of this Rating
     * @return       this Rating instance
     */
    Rating setRating(BigDecimal rating);
    
    /**
     * Queries the specified manager for the referenced Users. If no such Users
     * exists, an {@code NullPointerException} will be thrown.
     * 
     * @param foreignManager the manager to query for the entity
     * @return               the foreign entity referenced
     */
    Users findUserId(Manager<Users> foreignManager);
    
    /**
     * Queries the specified manager for the referenced Movies. If no such
     * Movies exists, an {@code NullPointerException} will be thrown.
     * 
     * @param foreignManager the manager to query for the entity
     * @return               the foreign entity referenced
     */
    Movies findMovieId(Manager<Movies> foreignManager);
    
    enum Identifier implements ColumnIdentifier<Rating> {
        
        USER_ID  ("USER_ID"),
        MOVIE_ID ("MOVIE_ID"),
        RATING   ("RATING");
        
        private final String columnId;
        private final TableIdentifier<Rating> tableIdentifier;
        
        Identifier(String columnId) {
            this.columnId        = columnId;
            this.tableIdentifier = TableIdentifier.of(    getDbmsId(), 
                getSchemaId(), 
                getTableId());
        }
        
        @Override
        public String getDbmsId() {
            return "MOVIES_DATABASE";
        }
        
        @Override
        public String getSchemaId() {
            return "MOVIES_DATABASE";
        }
        
        @Override
        public String getTableId() {
            return "RATING";
        }
        
        @Override
        public String getColumnId() {
            return this.columnId;
        }
        
        @Override
        public TableIdentifier<Rating> asTableIdentifier() {
            return this.tableIdentifier;
        }
    }
}