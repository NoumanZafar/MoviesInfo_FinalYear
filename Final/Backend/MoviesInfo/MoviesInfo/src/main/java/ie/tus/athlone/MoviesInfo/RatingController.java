package ie.tus.athlone.MoviesInfo;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.company.movies_database.MoviesDatabaseApplication;
import com.company.movies_database.movies_database.movies_database.rating.Rating;
import com.company.movies_database.movies_database.movies_database.rating.RatingManager;

@RestController
@CrossOrigin("*") // any port#
public class RatingController {
	private final RatingManager rating;

	public RatingController(MoviesDatabaseApplication app) {
		rating = app.getOrThrow(RatingManager.class);
	}
	
	
	//-- GET THE RATING OF A MOVIE GIVEN BY A SPECIFIC USER
	//SELECT * FROM RATING WHERE USER_ID = 1 AND MOVIE_ID = 101;
	@GetMapping("/{userId}/{movieId}")
	public List<Map<String, Double>> getRating(@PathVariable int userId, @PathVariable int movieId){
		double rat = rating.stream()
						.filter(Rating.USER_ID.equal(userId))
						.filter(Rating.MOVIE_ID.equal(movieId))
						.mapToDouble(Rating.RATING.asDouble())
						.findAny()
						.orElse(0.0);
		return List.of(Map.of("rating", rat));
	}
}