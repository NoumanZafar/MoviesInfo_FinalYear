package ie.tus.athlone.MoviesInfo;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.company.movies_database.MoviesDatabaseApplication;
import com.company.movies_database.movies_database.movies_database.rating.Rating;
import com.company.movies_database.movies_database.movies_database.rating.RatingImpl;
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
	
	@PostMapping("/rating/insert")
	public ResponseEntity<String> registration(@RequestBody Map<String, String> requestBody) {
		int userId = Integer.parseInt(requestBody.get("userId"));
		int movieId = Integer.parseInt(requestBody.get("movieId"));
		BigDecimal rat = new BigDecimal(requestBody.get("rating"));
		
		boolean recordExist = getRatingRecord(userId, movieId);
		if(recordExist) {
			//update the record
			boolean isUpdated = updateRating(userId, movieId, rat);;
			if(isUpdated)
				return ResponseEntity.ok("Updated...");
			else 
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
			
		}else {
			//insert the record
			boolean isInserted = insertRating(userId, movieId, rat);
			if(isInserted) 
				return ResponseEntity.ok("Inserted...");
			else
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
		}
	}

	/**
	 * INSERT INTO RATING (USER_ID, MOVIE_ID, RATING)
		VALUES
		(1, 101, 4.5);
	 */
	private boolean insertRating(int userId, int movieId, BigDecimal rat) {
		try {
			rating.persist(new RatingImpl()
					.setUserId(userId)
					.setMovieId(movieId)
					.setRating(rat));
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	private boolean getRatingRecord(int userId, int movieId) {
		List<Rating> r =rating.stream()
				.filter(Rating.USER_ID.equal(userId))
				.filter(Rating.MOVIE_ID.equal(movieId))
				.collect(Collectors.toList());
		if (r.isEmpty())
			return false;
		else
			return true;
	}
	
	private boolean updateRating(int userId, int movieId, BigDecimal rat) {
		AtomicBoolean updated = new AtomicBoolean(false);
		rating.stream()
				.filter(Rating.USER_ID.equal(userId))
				.filter(Rating.MOVIE_ID.equal(movieId))
				.map(r -> {
					r.setRating(rat);
					return r;
				})
				.forEach(r -> {
					rating.update(r);
					updated.set(true);
				});
		return updated.get();
	}
}
