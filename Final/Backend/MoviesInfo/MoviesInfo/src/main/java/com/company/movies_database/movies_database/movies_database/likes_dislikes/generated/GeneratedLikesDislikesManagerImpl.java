package com.company.movies_database.movies_database.movies_database.likes_dislikes.generated;

import com.company.movies_database.movies_database.movies_database.likes_dislikes.LikesDislikes;
import com.company.movies_database.movies_database.movies_database.likes_dislikes.LikesDislikesImpl;
import com.company.movies_database.movies_database.movies_database.likes_dislikes.LikesDislikesManager;
import com.speedment.common.annotation.GeneratedCode;
import com.speedment.runtime.config.identifier.TableIdentifier;
import com.speedment.runtime.core.manager.AbstractManager;
import com.speedment.runtime.field.Field;

import java.util.stream.Stream;

/**
 * The generated base implementation for the manager of every {@link
 * com.company.movies_database.movies_database.movies_database.likes_dislikes.LikesDislikes}
 * entity.
 * <p>
 * This file has been automatically generated by Speedment. Any changes made to
 * it will be overwritten.
 * 
 * @author Speedment
 */
@GeneratedCode("Speedment")
public abstract class GeneratedLikesDislikesManagerImpl 
extends AbstractManager<LikesDislikes> 
implements GeneratedLikesDislikesManager {
    
    private final TableIdentifier<LikesDislikes> tableIdentifier;
    
    protected GeneratedLikesDislikesManagerImpl() {
        this.tableIdentifier = TableIdentifier.of("MOVIES_DATABASE", "MOVIES_DATABASE", "LIKES_DISLIKES");
    }
    
    @Override
    public LikesDislikes create() {
        return new LikesDislikesImpl();
    }
    
    @Override
    public TableIdentifier<LikesDislikes> getTableIdentifier() {
        return tableIdentifier;
    }
    
    @Override
    public Stream<Field<LikesDislikes>> fields() {
        return LikesDislikesManager.FIELDS.stream();
    }
    
    @Override
    public Stream<Field<LikesDislikes>> primaryKeyFields() {
        return Stream.of(
            LikesDislikes.LIKE_ID
        );
    }
}