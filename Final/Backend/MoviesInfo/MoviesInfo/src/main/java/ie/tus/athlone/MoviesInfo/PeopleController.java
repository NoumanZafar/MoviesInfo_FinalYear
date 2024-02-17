package ie.tus.athlone.MoviesInfo;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.company.movies_database.MoviesDatabaseApplication;
import com.company.movies_database.movies_database.movies_database.movie_people.MoviePeople;
import com.company.movies_database.movies_database.movies_database.movie_people.MoviePeopleManager;
import com.company.movies_database.movies_database.movies_database.people.People;
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
	 * -- SEARCH THE ACORTS FOR A PARTUCULAR MOVIE SELECT P.* FROM MOVIE_PEOPLE MP
	 * INNER JOIN PEOPLE P ON MP.PERSON_ID = P.PERSON_ID WHERE MP.MOVIE_ID = 101;
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
	
	
//	List<MoviePeople> moviePeopleList = moviePeople
//	.stream()
//	.filter(mp -> mp.getMovieId() == id)
//	.toList();
//
//List<People> peopleList = new ArrayList<>();
//for (MoviePeople mp : moviePeopleList) {
//People person = people.stream()
//		.filter(p -> p.getPersonId() == mp.getPersonId())
//		.findFirst()
//		.orElse(null);
//if (person != null) {
//	peopleList.add(person);
//}
//}
//return peopleList;




}
