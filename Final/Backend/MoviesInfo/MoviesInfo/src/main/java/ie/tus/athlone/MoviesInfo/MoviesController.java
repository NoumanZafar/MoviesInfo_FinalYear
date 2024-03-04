package ie.tus.athlone.MoviesInfo;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.company.movies_database.MoviesDatabaseApplication;
import com.company.movies_database.movies_database.movies_database.movies.Movies;
import com.company.movies_database.movies_database.movies_database.movies.MoviesManager;


@RestController
@RequestMapping("/movies")
@CrossOrigin("*") // any port#
public class MoviesController {
	// table name
	private final MoviesManager movies;

	// Constructor
	public MoviesController(MoviesDatabaseApplication app) {
		// initialize the table from database app
		movies = app.getOrThrow(MoviesManager.class);
	}

	//SELECT * FROM MOVIES;
	@GetMapping("")
	public List<Movies> getAllMovies() {
		return movies.stream()
				.collect(Collectors.toList());
	}

	//SELECT * FROM MOVIES WHERE NAME = '';
	@GetMapping("{name}")
	public List<Movies> getMovieByID(@PathVariable String name) {
		return movies.stream()
				.filter(
						movie -> movie.
						getTitle().
						toUpperCase().
						contains(
								name.
								toUpperCase()))
				.collect(Collectors.toList());
	}
	
	//SELECT * FROM MOVIES WHERE MOVIE_ID = '';
	@GetMapping("/id/{id}")
	public List<Movies> getMovieByID(@PathVariable int id) {
		return movies
				.stream()
				.filter(movie -> movie.getMovieId() == id)
				.collect(Collectors.toList());
	}
	
	//-- LIST OF RELATED MOVIES
	//SELECT MOVIE_ID FROM MOVIES WHERE GENRE = (SELECT GENRE FROM MOVIES WHERE MOVIE_ID = 101);
	@GetMapping("/related/{id}")
	public List<Movies> getRelatedMovies(@PathVariable int id){
        String genre = movies.stream()
                .filter(movie -> movie.getMovieId() == id)
                .map(Movies.GENRE)
                .findAny()
                .orElse("none");

        return movies.stream()
        		.filter(Movies.GENRE.equal(genre))
        		.collect(Collectors.toList());
	}
}
