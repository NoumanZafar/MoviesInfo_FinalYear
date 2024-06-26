package com.company.movies_database.generated;

import com.company.movies_database.MoviesDatabaseApplication;
import com.company.movies_database.MoviesDatabaseApplicationBuilder;
import com.company.movies_database.MoviesDatabaseApplicationImpl;
import com.company.movies_database.MoviesDatabaseInjectorProxy;
import com.company.movies_database.movies_database.movies_database.clips.ClipsManagerImpl;
import com.company.movies_database.movies_database.movies_database.clips.ClipsSqlAdapter;
import com.company.movies_database.movies_database.movies_database.movie_people.MoviePeopleManagerImpl;
import com.company.movies_database.movies_database.movies_database.movie_people.MoviePeopleSqlAdapter;
import com.company.movies_database.movies_database.movies_database.movies.MoviesManagerImpl;
import com.company.movies_database.movies_database.movies_database.movies.MoviesSqlAdapter;
import com.company.movies_database.movies_database.movies_database.people.PeopleManagerImpl;
import com.company.movies_database.movies_database.movies_database.people.PeopleSqlAdapter;
import com.company.movies_database.movies_database.movies_database.rating.RatingManagerImpl;
import com.company.movies_database.movies_database.movies_database.rating.RatingSqlAdapter;
import com.company.movies_database.movies_database.movies_database.reviews.ReviewsManagerImpl;
import com.company.movies_database.movies_database.movies_database.reviews.ReviewsSqlAdapter;
import com.company.movies_database.movies_database.movies_database.users.UsersManagerImpl;
import com.company.movies_database.movies_database.movies_database.users.UsersSqlAdapter;
import com.speedment.common.annotation.GeneratedCode;
import com.speedment.common.injector.Injector;
import com.speedment.runtime.application.AbstractApplicationBuilder;
import com.speedment.runtime.connector.mysql.MySqlBundle;

/**
 * A generated base {@link
 * com.speedment.runtime.application.AbstractApplicationBuilder} class for the
 * {@link com.speedment.runtime.config.Project} named movies_database.
 * <p>
 * This file has been automatically generated by Speedment. Any changes made to
 * it will be overwritten.
 * 
 * @author Speedment
 */
@GeneratedCode("Speedment")
public abstract class GeneratedMoviesDatabaseApplicationBuilder extends AbstractApplicationBuilder<MoviesDatabaseApplication, MoviesDatabaseApplicationBuilder> {
    
    protected GeneratedMoviesDatabaseApplicationBuilder() {
        super(MoviesDatabaseApplicationImpl.class, GeneratedMoviesDatabaseMetadata.class);
        withManager(ClipsManagerImpl.class);
        withManager(MoviePeopleManagerImpl.class);
        withManager(MoviesManagerImpl.class);
        withManager(PeopleManagerImpl.class);
        withManager(RatingManagerImpl.class);
        withManager(ReviewsManagerImpl.class);
        withManager(UsersManagerImpl.class);
        withComponent(ClipsSqlAdapter.class);
        withComponent(MoviePeopleSqlAdapter.class);
        withComponent(MoviesSqlAdapter.class);
        withComponent(PeopleSqlAdapter.class);
        withComponent(RatingSqlAdapter.class);
        withComponent(ReviewsSqlAdapter.class);
        withComponent(UsersSqlAdapter.class);
        withBundle(MySqlBundle.class);
        withInjectorProxy(new MoviesDatabaseInjectorProxy());
    }
    
    @Override
    public MoviesDatabaseApplication build(Injector injector) {
        return injector.getOrThrow(MoviesDatabaseApplication.class);
    }
}