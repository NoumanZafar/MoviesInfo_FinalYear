package com.company.movies_database.movies_database.movies_database.people.generated;

import com.company.movies_database.movies_database.movies_database.people.People;
import com.speedment.common.annotation.GeneratedCode;
import com.speedment.runtime.config.identifier.TableIdentifier;
import com.speedment.runtime.core.manager.Manager;
import com.speedment.runtime.field.Field;

import java.util.List;

import static java.util.Arrays.asList;
import static java.util.Collections.unmodifiableList;

/**
 * The generated base interface for the manager of every {@link
 * com.company.movies_database.movies_database.movies_database.people.People}
 * entity.
 * <p>
 * This file has been automatically generated by Speedment. Any changes made to
 * it will be overwritten.
 * 
 * @author Speedment
 */
@GeneratedCode("Speedment")
public interface GeneratedPeopleManager extends Manager<People> {
    
    TableIdentifier<People> IDENTIFIER = TableIdentifier.of("MOVIES_DATABASE", "MOVIES_DATABASE", "PEOPLE");
    List<Field<People>> FIELDS = unmodifiableList(asList(
        People.PERSON_ID,
        People.NAME,
        People.OCCUPATION,
        People.IMAGE_URL
    ));
    
    @Override
    default Class<People> getEntityClass() {
        return People.class;
    }
}