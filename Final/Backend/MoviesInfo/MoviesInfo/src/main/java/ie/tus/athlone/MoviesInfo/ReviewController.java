package ie.tus.athlone.MoviesInfo;

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
import com.company.movies_database.movies_database.movies_database.rating.Rating;
import com.company.movies_database.movies_database.movies_database.rating.RatingManager;
import com.company.movies_database.movies_database.movies_database.reviews.Reviews;
import com.company.movies_database.movies_database.movies_database.reviews.ReviewsImpl;
import com.company.movies_database.movies_database.movies_database.reviews.ReviewsManager;
import com.company.movies_database.movies_database.movies_database.users.Users;
import com.company.movies_database.movies_database.movies_database.users.UsersManager;

@RestController
@RequestMapping("/reviews")
@CrossOrigin("*") // any port#
public class ReviewController {
	private final ReviewsManager reviews;
	private final UsersManager users;
	private final RatingManager rating;
	
	public ReviewController(MoviesDatabaseApplication app) {
		reviews = app.getOrThrow(ReviewsManager.class);
		users = app.getOrThrow(UsersManager.class);
		rating = app.getOrThrow(RatingManager.class);
	}
	
	//AVERAGE RATING FOR A SELECTED MOVIE
	//SHOULD BE IN RATING CONTROLLER BUT WORKS FINE.
	//SELECT AVG(RATING) FROM RATING WHERE MOVIE_ID = 101;
	@GetMapping("{id}")
	public List<Map<String, Double>> getAverageRating(@PathVariable int id) {
		double ratin = rating.stream()
				.filter(Rating.MOVIE_ID.equal(id))
				.mapToDouble(Rating.RATING.asDouble())
				.average().orElse(0.0);
		return List.of(Map.of("AvgRating", ratin));
	}

	
	/*
	-- ALL THE REVIEWS FOR A MOVIE AND WHO POSTED THE REVIEW
	SELECT R.REVIEW_ID,R.COMMENT,U.USERNAME FROM REVIEWS R
	INNER JOIN
	    USERS U ON R.USER_ID = U.USER_ID
	WHERE 
	    R.MOVIE_ID = 101;
	*/
	@GetMapping("/movie/{id}")
	public List<Map<String, Object>> getReviewsWithUsers(@PathVariable int id) {
		return reviews.stream()
	            .filter(Reviews.MOVIE_ID.equal(id))
	            .map(review -> {
	            	int userId = review.getUserId().getAsInt();
	                String username = users.stream()
	                        .filter(user -> user.getUserId() == userId)
	                        .map(Users::getUsername)
	                        .findFirst()
	                        .orElse(null); // Handle if user is not found
	                return Map.of(
                            "reviewId", review.getReviewId(),
                            "comment", review.getComment(),
                            "user", username
                    );
	            })
	            .collect(Collectors.toList());
	}
	
	
	@PostMapping("/comment")
	public ResponseEntity<String> registration(@RequestBody Map<String, String> requestBody) {
		int userId = Integer.parseInt(requestBody.get("userId"));
		int movieId = Integer.parseInt(requestBody.get("movieId"));
		String comment = requestBody.get("comment");

		boolean isPosted = insertComment(userId, movieId, comment);
		if (isPosted) {
			return ResponseEntity.ok("Posted successful");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
		}
	}

	/**
	 * INSERT INTO REVIEWS (REVIEW_ID, USER_ID, MOVIE_ID, RATING, COMMENT)
		VALUES
		(3001, 1, 101, 4.5, 'Mind-bending plot!');
	 */
	private boolean insertComment(int userId, int movieId, String comment) {
		try {
			reviews.persist(new ReviewsImpl()
					.setUserId(userId)
					.setMovieId(movieId)
					.setComment(comment));
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
}
