package com.company.movies_database.movies_database.movies_database.clips.generated;

import com.company.movies_database.movies_database.movies_database.clips.Clips;
import com.speedment.common.annotation.GeneratedCode;
import com.speedment.runtime.config.identifier.TableIdentifier;
import com.speedment.runtime.core.manager.Manager;
import com.speedment.runtime.field.Field;

import java.util.List;

import static java.util.Arrays.asList;
import static java.util.Collections.unmodifiableList;

/**
 * The generated base interface for the manager of every {@link
 * com.company.movies_database.movies_database.movies_database.clips.Clips}
 * entity.
 * <p>
 * This file has been automatically generated by Speedment. Any changes made to
 * it will be overwritten.
 * 
 * @author Speedment
 */
@GeneratedCode("Speedment")
public interface GeneratedClipsManager extends Manager<Clips> {
    
    TableIdentifier<Clips> IDENTIFIER = TableIdentifier.of("Movies_database", "MOVIES_DATABASE", "CLIPS");
    List<Field<Clips>> FIELDS = unmodifiableList(asList(
        Clips.CLIP_ID,
        Clips.MOVIE_ID,
        Clips.CLIP_URL
    ));
    
    @Override
    default Class<Clips> getEntityClass() {
        return Clips.class;
    }
}