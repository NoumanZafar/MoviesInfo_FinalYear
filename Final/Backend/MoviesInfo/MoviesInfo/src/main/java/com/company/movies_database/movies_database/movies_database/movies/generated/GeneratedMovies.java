package com.company.movies_database.movies_database.movies_database.movies.generated;

import com.company.movies_database.movies_database.movies_database.movies.Movies;
import com.speedment.common.annotation.GeneratedCode;
import com.speedment.runtime.config.identifier.ColumnIdentifier;
import com.speedment.runtime.config.identifier.TableIdentifier;
import com.speedment.runtime.core.util.OptionalUtil;
import com.speedment.runtime.field.IntField;
import com.speedment.runtime.field.StringField;
import com.speedment.runtime.typemapper.TypeMapper;

import java.util.Optional;

/**
 * The generated base for the {@link
 * com.company.movies_database.movies_database.movies_database.movies.Movies}-interface
 * representing entities of the {@code movies}-table in the database.
 * <p>
 * This file has been automatically generated by Speedment. Any changes made to
 * it will be overwritten.
 * 
 * @author Speedment
 */
@GeneratedCode("Speedment")
public interface GeneratedMovies {
    
    /**
     * This Field corresponds to the {@link Movies} field that can be obtained
     * using the {@link Movies#getMovieId()} method.
     */
    IntField<Movies, Integer> MOVIE_ID = IntField.create(
        Identifier.MOVIE_ID,
        Movies::getMovieId,
        Movies::setMovieId,
        TypeMapper.primitive(),
        true
    );
    /**
     * This Field corresponds to the {@link Movies} field that can be obtained
     * using the {@link Movies#getTitle()} method.
     */
    StringField<Movies, String> TITLE = StringField.create(
        Identifier.TITLE,
        Movies::getTitle,
        Movies::setTitle,
        TypeMapper.identity(),
        false
    );
    /**
     * This Field corresponds to the {@link Movies} field that can be obtained
     * using the {@link Movies#getReleaseDate()} method.
     */
    StringField<Movies, String> RELEASE_DATE = StringField.create(
        Identifier.RELEASE_DATE,
        o -> OptionalUtil.unwrap(o.getReleaseDate()),
        Movies::setReleaseDate,
        TypeMapper.identity(),
        false
    );
    /**
     * This Field corresponds to the {@link Movies} field that can be obtained
     * using the {@link Movies#getGenre()} method.
     */
    StringField<Movies, String> GENRE = StringField.create(
        Identifier.GENRE,
        o -> OptionalUtil.unwrap(o.getGenre()),
        Movies::setGenre,
        TypeMapper.identity(),
        false
    );
    /**
     * This Field corresponds to the {@link Movies} field that can be obtained
     * using the {@link Movies#getPosterUrl()} method.
     */
    StringField<Movies, String> POSTER_URL = StringField.create(
        Identifier.POSTER_URL,
        Movies::getPosterUrl,
        Movies::setPosterUrl,
        TypeMapper.identity(),
        false
    );
    /**
     * This Field corresponds to the {@link Movies} field that can be obtained
     * using the {@link Movies#getMDescription()} method.
     */
    StringField<Movies, String> M_DESCRIPTION = StringField.create(
        Identifier.M_DESCRIPTION,
        Movies::getMDescription,
        Movies::setMDescription,
        TypeMapper.identity(),
        false
    );
    
    /**
     * Returns the movieId of this Movies. The movieId field corresponds to the
     * database column movies_database.movies_database.movies.MOVIE_ID.
     * 
     * @return the movieId of this Movies
     */
    int getMovieId();
    
    /**
     * Returns the title of this Movies. The title field corresponds to the
     * database column movies_database.movies_database.movies.TITLE.
     * 
     * @return the title of this Movies
     */
    String getTitle();
    
    /**
     * Returns the releaseDate of this Movies. The releaseDate field corresponds
     * to the database column
     * movies_database.movies_database.movies.RELEASE_DATE.
     * 
     * @return the releaseDate of this Movies
     */
    Optional<String> getReleaseDate();
    
    /**
     * Returns the genre of this Movies. The genre field corresponds to the
     * database column movies_database.movies_database.movies.GENRE.
     * 
     * @return the genre of this Movies
     */
    Optional<String> getGenre();
    
    /**
     * Returns the posterUrl of this Movies. The posterUrl field corresponds to
     * the database column movies_database.movies_database.movies.POSTER_URL.
     * 
     * @return the posterUrl of this Movies
     */
    String getPosterUrl();
    
    /**
     * Returns the mDescription of this Movies. The mDescription field
     * corresponds to the database column
     * movies_database.movies_database.movies.M_DESCRIPTION.
     * 
     * @return the mDescription of this Movies
     */
    String getMDescription();
    
    /**
     * Sets the movieId of this Movies. The movieId field corresponds to the
     * database column movies_database.movies_database.movies.MOVIE_ID.
     * 
     * @param movieId to set of this Movies
     * @return        this Movies instance
     */
    Movies setMovieId(int movieId);
    
    /**
     * Sets the title of this Movies. The title field corresponds to the
     * database column movies_database.movies_database.movies.TITLE.
     * 
     * @param title to set of this Movies
     * @return      this Movies instance
     */
    Movies setTitle(String title);
    
    /**
     * Sets the releaseDate of this Movies. The releaseDate field corresponds to
     * the database column movies_database.movies_database.movies.RELEASE_DATE.
     * 
     * @param releaseDate to set of this Movies
     * @return            this Movies instance
     */
    Movies setReleaseDate(String releaseDate);
    
    /**
     * Sets the genre of this Movies. The genre field corresponds to the
     * database column movies_database.movies_database.movies.GENRE.
     * 
     * @param genre to set of this Movies
     * @return      this Movies instance
     */
    Movies setGenre(String genre);
    
    /**
     * Sets the posterUrl of this Movies. The posterUrl field corresponds to the
     * database column movies_database.movies_database.movies.POSTER_URL.
     * 
     * @param posterUrl to set of this Movies
     * @return          this Movies instance
     */
    Movies setPosterUrl(String posterUrl);
    
    /**
     * Sets the mDescription of this Movies. The mDescription field corresponds
     * to the database column
     * movies_database.movies_database.movies.M_DESCRIPTION.
     * 
     * @param mDescription to set of this Movies
     * @return             this Movies instance
     */
    Movies setMDescription(String mDescription);
    
    enum Identifier implements ColumnIdentifier<Movies> {
        
        MOVIE_ID      ("MOVIE_ID"),
        TITLE         ("TITLE"),
        RELEASE_DATE  ("RELEASE_DATE"),
        GENRE         ("GENRE"),
        POSTER_URL    ("POSTER_URL"),
        M_DESCRIPTION ("M_DESCRIPTION");
        
        private final String columnId;
        private final TableIdentifier<Movies> tableIdentifier;
        
        Identifier(String columnId) {
            this.columnId        = columnId;
            this.tableIdentifier = TableIdentifier.of(    getDbmsId(), 
                getSchemaId(), 
                getTableId());
        }
        
        @Override
        public String getDbmsId() {
            return "movies_database";
        }
        
        @Override
        public String getSchemaId() {
            return "movies_database";
        }
        
        @Override
        public String getTableId() {
            return "movies";
        }
        
        @Override
        public String getColumnId() {
            return this.columnId;
        }
        
        @Override
        public TableIdentifier<Movies> asTableIdentifier() {
            return this.tableIdentifier;
        }
    }
}