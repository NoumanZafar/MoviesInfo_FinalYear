package ie.tus.athlone.MoviesInfo;

import java.math.BigDecimal;
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
import com.company.movies_database.movies_database.movies_database.reviews.Reviews;
import com.company.movies_database.movies_database.movies_database.reviews.ReviewsImpl;
import com.company.movies_database.movies_database.movies_database.reviews.ReviewsManager;
import com.company.movies_database.movies_database.movies_database.users.Users;
import com.company.movies_database.movies_database.movies_database.users.UsersImpl;
import com.company.movies_database.movies_database.movies_database.users.UsersManager;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping("/reviews")
@CrossOrigin("*") // any port#
public class ReviewController {
	private final ReviewsManager reviews;
	private final UsersManager users;
	
	public ReviewController(MoviesDatabaseApplication app) {
		reviews = app.getOrThrow(ReviewsManager.class);
		users = app.getOrThrow(UsersManager.class);
	}
	
	//AVERAGE RATING FOR A SELECTED MOVIE
	//SELECT AVG(RATING) FROM REVIEWS WHERE MOVIE_ID = 101;
	@GetMapping("{id}")
	public List<Map<String, Double>> getAverageRating(@PathVariable int id) {
		double rating = reviews.stream()
				.filter(Reviews.MOVIE_ID.equal(id))
				.mapToDouble(Reviews.RATING.asDouble())
				.average().orElse(0.0);
		return List.of(Map.of("AvgRating", rating));
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
		BigDecimal rating = new BigDecimal(requestBody.get("rating"));
		String comment = requestBody.get("comment");

		boolean isPosted = insertComment(userId, movieId, rating, comment);

		// Return response
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> jsonResponse = new HashMap<>();
		if (isPosted) {
			jsonResponse.put("message", "Posted successful");
			System.out.println("Success");
			try {
				String responseJson = mapper.writeValueAsString(jsonResponse);
				return ResponseEntity.ok(responseJson);
			} catch (JsonProcessingException e) {
				e.printStackTrace(); // Handle exception properly
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
			}
		} else {
			jsonResponse.put("message", "Comment Failed");
			try {
				String responseJson = mapper.writeValueAsString(jsonResponse);
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(responseJson);
			} catch (JsonProcessingException e) {
				e.printStackTrace(); // Handle exception properly
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
			}
		}
	}

	/**
	 * INSERT INTO REVIEWS (REVIEW_ID, USER_ID, MOVIE_ID, RATING, COMMENT)
		VALUES
		(3001, 1, 101, 4.5, 'Mind-bending plot!');
	 */
	private boolean insertComment(int userId, int movieId, BigDecimal rating, String comment) {
		try {
			reviews.persist(new ReviewsImpl()
					.setUserId(userId)
					.setMovieId(movieId)
					.setRating(rating)
					.setComment(comment));
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
}
