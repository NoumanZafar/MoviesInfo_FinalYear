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
import com.company.movies_database.movies_database.movies_database.clips.Clips;
import com.company.movies_database.movies_database.movies_database.clips.ClipsImpl;
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
	
	@PostMapping("/addClips")
	public ResponseEntity<String> addClipData(@RequestBody Map<String, String> requestBody) {
		int movieId = Integer.parseInt(requestBody.get("selectedMovieId"));
		String clipURL = requestBody.get("clipURL");
		boolean isClipAdded = addClips(movieId, clipURL);
		if (isClipAdded) 
			return ResponseEntity.ok("Clip Added Successfully.");
		else 
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
	}

	// INSERT INTO CLIPS VALUES...
	private boolean addClips(int movieId, String clipURL) {
		try {
			clips.persist(new ClipsImpl()
					.setMovieId(movieId)
					.setClipUrl(clipURL));
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
