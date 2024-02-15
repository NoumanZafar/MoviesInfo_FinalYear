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

	@GetMapping("")
	public List<Movies> getAllMovies() {
		return movies.stream().collect(Collectors.toList());
	}

	@GetMapping("{name}")
	public List<Movies> getMovieByID(@PathVariable String name) {
		return movies.stream().filter(movie -> movie.getTitle().toUpperCase().contains(name.toUpperCase())).collect(Collectors.toList());
	}

}
