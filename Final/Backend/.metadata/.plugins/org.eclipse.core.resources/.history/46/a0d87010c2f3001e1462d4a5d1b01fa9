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
import com.company.movies_database.movies_database.movies_database.movie_people.MoviePeopleImpl;
import com.company.movies_database.movies_database.movies_database.movie_people.MoviePeopleManager;
import com.company.movies_database.movies_database.movies_database.people.People;
import com.company.movies_database.movies_database.movies_database.people.PeopleImpl;
import com.company.movies_database.movies_database.movies_database.people.PeopleManager;

@RestController
@RequestMapping("/people")
@CrossOrigin("*") // any port#
public class PeopleController {
	private final PeopleManager people;
	private final MoviePeopleManager moviePeople;

	public PeopleController(MoviesDatabaseApplication app) {
		people = app.getOrThrow(PeopleManager.class);
		moviePeople = app.getOrThrow(MoviePeopleManager.class);
	}

	/**
	 * 
	 * -- SEARCH THE ACORTS FOR A PARTUCULAR MOVIE 
	 * SELECT P.* FROM MOVIE_PEOPLE MP
	 * INNER JOIN PEOPLE P ON MP.PERSON_ID = P.PERSON_ID 
	 * WHERE MP.MOVIE_ID = 101;
	 */
	@GetMapping("{id}")
	public List<People> getMoviePeople(@PathVariable int id) {
		List<Integer> prsonIds = moviePeople.stream()
				.filter(MoviePeople.MOVIE_ID.equal(id))
				.mapToInt(MoviePeople.PERSON_ID)
				.boxed()
				.collect(Collectors.toList());
		
		return people.stream()
				.filter(People.PERSON_ID.in(prsonIds))
				.collect(Collectors.toList());
	}
	
	@PostMapping("/addPeople")
	public ResponseEntity<String> addPeopleData(@RequestBody Map<String, String> requestBody) {
		String personName = requestBody.get("personName");
		String ocupation = requestBody.get("ocupation");
		String imageURL = requestBody.get("imageURL");

		boolean isPersonAdded = addPeople(personName, ocupation, imageURL);
		if (isPersonAdded) 
			return ResponseEntity.ok("Person Added Successfully.");
		else 
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
	}

	// INSERT INTO PEOPLE VALUES...
	private boolean addPeople(String personName, String ocupation, String imageURL) {
		try {
			people.persist(new PeopleImpl()
					.setName(personName)
					.setOccupation(ocupation)
					.setImageUrl(imageURL));
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	// SELECT TITLE FROM PEOPLE;
	@GetMapping("/name")
	public  List<Map<String, Object>> getAllPeopleName() {
		return people.stream()
				.map(person -> {
					 Map<String, Object> peopleMap = new HashMap<>();
					 peopleMap.put("personId", person.getPersonId());
					 peopleMap.put("name", person.getName());
					 return peopleMap;
				})
				.collect(Collectors.toList());
	}
	
	@PostMapping("/addMoviePeople")
	public ResponseEntity<String> addMoviePeopleData(@RequestBody Map<String, String> requestBody) {
		int movieId = Integer.parseInt(requestBody.get("selectedMovieId"));
		int personId = Integer.parseInt( requestBody.get("selectedPersonId"));

		boolean isMoviePersonAdded = addMoviePeople(movieId, personId);
		if (isMoviePersonAdded) 
			return ResponseEntity.ok("Movie Person Added Successfully.");
		else 
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
	}

	// INSERT INTO MMOVIE_PEOPLE VALUES...
	private boolean addMoviePeople(int selectedMovieId, int selectedPersonId) {
		try {
			moviePeople.persist(new MoviePeopleImpl()
					.setMovieId(selectedMovieId)
					.setPersonId(selectedPersonId));
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
