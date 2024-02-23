package ie.tus.athlone.MoviesInfo;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.company.movies_database.MoviesDatabaseApplication;
import com.company.movies_database.movies_database.movies_database.reviews.Reviews;
import com.company.movies_database.movies_database.movies_database.reviews.ReviewsManager;
import com.company.movies_database.movies_database.movies_database.users.Users;
import com.company.movies_database.movies_database.movies_database.users.UsersManager;

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
				.average().getAsDouble();
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
}
