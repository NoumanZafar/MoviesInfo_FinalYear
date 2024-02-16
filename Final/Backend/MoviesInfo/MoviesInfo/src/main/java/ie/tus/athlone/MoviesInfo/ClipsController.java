package ie.tus.athlone.MoviesInfo;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.company.movies_database.MoviesDatabaseApplication;
import com.company.movies_database.movies_database.movies_database.clips.Clips;
import com.company.movies_database.movies_database.movies_database.clips.ClipsManager;

@RestController
@RequestMapping("/clips")
@CrossOrigin("*") // any port#
public class ClipsController {
	private final ClipsManager clips;

	public ClipsController(MoviesDatabaseApplication app) {
		clips = app.getOrThrow(ClipsManager.class);
	}

	// SELECT * FROM CLIPS WHERE MOVIE_ID = '';
	@GetMapping("{id}")
	public List<Clips> getMovieClips(@PathVariable int id) {
		return clips
				.stream()
				.filter(clip -> clip.getMovieId().getAsInt() == id)
				.collect(Collectors.toList());
	}
}
