package ie.tus.athlone.MoviesInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.company.movies_database.MoviesDatabaseApplication;
import com.company.movies_database.movies_database.movies_database.movie_people.MoviePeople;
import com.company.movies_database.movies_database.movies_database.movie_people.MoviePeopleManager;
import com.company.movies_database.movies_database.movies_database.movies.Movies;
import com.company.movies_database.movies_database.movies_database.movies.MoviesImpl;
import com.company.movies_database.movies_database.movies_database.movies.MoviesManager;


@RestController
@RequestMapping("/movies")
@CrossOrigin("*") // any port#
public class MoviesController {
	// table name
	private final MoviesManager movies;
	private final MoviePeopleManager moviePeople;

	// Constructor
	public MoviesController(MoviesDatabaseApplication app) {
		// initialize the table from database app
		movies = app.getOrThrow(MoviesManager.class);
		moviePeople = app.getOrThrow(MoviePeopleManager.class);
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
	public List<Movies> getRelatedMovies(@PathVariable int id) {
        String genre = movies.stream()
                .filter(movie -> movie.getMovieId() == id)
                .map(Movies.GENRE)
                .findAny()
                .orElse("none");

        return movies.stream()
        		.filter(Movies.GENRE.equal(genre))
        		.collect(Collectors.toList());
	}
	
	//-- CLICK ON ACTOR PHOTO AND DISPLAY ALL MOVIES RELATED TO HIM/HER
	//SELECT * FROM MOVIES WHERE MOVIE_ID IN (
	//SELECT MOVIE_ID FROM MOVIE_PEOPLE WHERE PERSON_ID = '5001');
	@GetMapping("/person/{id}")
	public List<Movies> getRelatedMoviesToActors(@PathVariable int id) {
		return moviePeople.stream()
				.filter(MoviePeople.PERSON_ID.equal(id))
				.flatMap(mp -> movies.stream()
						.filter(Movies.MOVIE_ID.equal(mp.getMovieId())))
				.collect(Collectors.toList());
	}
	
	@PostMapping("/addMovie")
	public ResponseEntity<String> registration(@RequestBody Map<String, String> requestBody) {
		String title = requestBody.get("title");
		String releaseDate = requestBody.get("releaseDate");
		String genre = requestBody.get("genre");
		String posterURL = requestBody.get("posterURL");
		String description = requestBody.get("description");
		boolean isMovieAdded = addMovie(title, releaseDate, genre, posterURL, description);
		if (isMovieAdded) 
			return ResponseEntity.ok("Movie Added Successfully.");
		else 
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
	}

	// INSERT INTO MOVIES VALUES...
	private boolean addMovie(String title, String releaseDate, String genre, String posterURL, String description) {
		try {
			movies.persist(new MoviesImpl()
					.setTitle(title)
					.setReleaseDate(releaseDate)
					.setGenre(genre)
					.setPosterUrl(posterURL)
					.setMDescription(description));
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	
	// SELECT TITLE FROM MOVIES;
	@GetMapping("/title")
	public  List<Map<String, Object>> getAllMoviesTitle() {
		return movies.stream()
	            .map(movie -> {
	                Map<String, Object> movieMap = new HashMap<>();
	                movieMap.put("id", movie.getMovieId());
	                movieMap.put("title", movie.getTitle());
	                return movieMap;
	            })
	            .collect(Collectors.toList());
	}
}
