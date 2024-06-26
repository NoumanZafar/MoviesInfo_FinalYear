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
import org.springframework.web.bind.annotation.RestController;

import com.company.movies_database.MoviesDatabaseApplication;
import com.company.movies_database.movies_database.movies_database.users.Users;
import com.company.movies_database.movies_database.movies_database.users.UsersImpl;
import com.company.movies_database.movies_database.movies_database.users.UsersManager;

@RestController
@CrossOrigin("*") // any port#
public class UserController {
	private final UsersManager user;

	public UserController(MoviesDatabaseApplication app) {
		user = app.getOrThrow(UsersManager.class);
	}

	// -- LOGIN AUTHORIZATION
	// SELECT * FROM USERS WHERE EMAIL = '' AND PASSWORD = '';
	@PostMapping("/auth")
	public ResponseEntity<String> authenticate(@RequestBody Map<String, String> requestBody) {
		String email = requestBody.get("email");
		String password = requestBody.get("password");
		// Perform authentication or any other necessary processing
		boolean isAuthenticated = authenticateUser(email, password); // authentication logic here
		if (isAuthenticated)
			return ResponseEntity.ok("Authentication successful");
		else
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
	}

	// Example method for user authentication
	private boolean authenticateUser(String email, String password) {
			List<Users> u = user.stream()
					.filter(Users.EMAIL.equal(email)
					.and(Users.PASSWORD.equal(password)))
					.collect(Collectors.toList());
			if(u.isEmpty())
				return false;
			else
				return true;
				
	}

	@PostMapping("/registration")
	public ResponseEntity<String> registration(@RequestBody Map<String, String> requestBody) {
		String email = requestBody.get("email");
		String password = requestBody.get("password");
		String username = requestBody.get("username");
		boolean isRegistered = registerUser(username, email, password);
		if (isRegistered) 
			return ResponseEntity.ok("Registration successful");
		else 
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
	}

	// INSERT INTO USERS VALUES (NULL, USERNAME, EMAIL, PASSWORD);
	private boolean registerUser(String username, String email, String password) {
		try {
			user.persist(new UsersImpl()
					.setUsername(username)
					.setEmail(email)
					.setPassword(password));
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// SELECT * FROM USERS WHERE EMAIL = '';
	@GetMapping("/{email}")
	public List<Users> getUserWithEmail(@PathVariable String email) {
		return user.stream()
				.filter(user -> user.getEmail()
						.equalsIgnoreCase(email))
				.collect(Collectors.toList());
	}
}
