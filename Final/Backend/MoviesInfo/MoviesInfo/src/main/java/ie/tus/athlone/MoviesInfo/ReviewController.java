package ie.tus.athlone.MoviesInfo;

import java.util.List;
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
	public double getAverageRating(@PathVariable int id) {
		return reviews.stream()
				.filter(Reviews.MOVIE_ID.equal(id))
				.mapToDouble(Reviews.RATING.asDouble())
				.average().getAsDouble();
	}
	
	//-- ALL THE REVIEWS FOR A MOVIE AND WHO POSTED THE REVIEW
//	SELECT R.REVIEW_ID,R.COMMENT,U.USERNAME FROM REVIEWS R
//	INNER JOIN
//	    USERS U ON R.USER_ID = U.USER_ID
//	WHERE 
//	    R.MOVIE_ID = 101;
	
	@GetMapping("/movie/{id}")
	public List<List<Object>> getPeopleReviews(@PathVariable int id) {
//	        return reviews.stream()
//	            .filter(Reviews.MOVIE_ID.equal(id))
//	            .map(review -> new Object[] {
//	                review.getReviewId(),
//	                review.getComment(),
//	                users.stream()
//	                    .filter(Users.USER_ID.equal(review.getUserId().getAsInt()))
//	                    .findAny()
//	                    .map(Users::getUsername)
//	                    .orElse(null) // Handle if user is not found
//	            })
//	            .collect(Collectors.toList());
//		
//		
//        return reviews.stream()
//	            .filter(Reviews.MOVIE_ID.equal(id))
//	            .map(revi -> users.stream().filter(us-> us.getUserId()==revi.getUserId().getAsInt()).collect(Collectors.toList())
//            		)
//	            .collect(Collectors.toList());
		
		
		return reviews.stream()
	            .filter(Reviews.MOVIE_ID.equal(id))
	            .map(review -> {
	            	int userId = review.getUserId().getAsInt();
	                String username = users.stream()
	                        .filter(user -> user.getUserId() == userId)
	                        .map(Users::getUsername)
	                        .findFirst()
	                        .orElse(null); // Handle if user is not found
	                return List.of(review.getReviewId(), review.getComment(), username);
	            })
	            .collect(Collectors.toList());

	    }
	
}
