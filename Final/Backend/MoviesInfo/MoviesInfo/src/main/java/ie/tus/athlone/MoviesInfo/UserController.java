package ie.tus.athlone.MoviesInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.company.movies_database.MoviesDatabaseApplication;
import com.company.movies_database.movies_database.movies_database.users.Users;
import com.company.movies_database.movies_database.movies_database.users.UsersImpl;
import com.company.movies_database.movies_database.movies_database.users.UsersManager;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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

		// Return response
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> jsonResponse = new HashMap<>();
		if (isAuthenticated) {
			jsonResponse.put("message", "Authentication successful");
			try {
				String responseJson = mapper.writeValueAsString(jsonResponse);
				return ResponseEntity.ok(responseJson);
			} catch (JsonProcessingException e) {
				e.printStackTrace(); // Handle exception properly
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
			}
		} else {
			jsonResponse.put("message", "Authentication failed");
			try {
				String responseJson = mapper.writeValueAsString(jsonResponse);
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(responseJson);
			} catch (JsonProcessingException e) {
				e.printStackTrace(); // Handle exception properly
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
			}
		}
	}

	// Example method for user authentication
	private boolean authenticateUser(String email, String password) {
		List<Users> u = user.stream()
				.filter(Users.EMAIL.equal(email)
						.and(Users.PASSWORD.equal(password)))
				.collect(Collectors.toList());

		if (u.isEmpty())
			return false;
		else
			return true;
	}

	@PostMapping("/registration")
	public ResponseEntity<String> registration(@RequestBody Map<String, String> requestBody) {
		String email = requestBody.get("email");
		String password = requestBody.get("password");
		String username = requestBody.get("username");
		// Perform authentication or any other necessary processing
		System.out.println(username + " " + email + " " + password);
		boolean isRegistered = registerUser(username, email, password);

		// Return response
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> jsonResponse = new HashMap<>();
		if (isRegistered) {
			jsonResponse.put("message", "Registration successful");
			try {
				String responseJson = mapper.writeValueAsString(jsonResponse);
				return ResponseEntity.ok(responseJson);
			} catch (JsonProcessingException e) {
				e.printStackTrace(); // Handle exception properly
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
			}
		} else {
			jsonResponse.put("message", "Registration failed");
			try {
				String responseJson = mapper.writeValueAsString(jsonResponse);
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(responseJson);
			} catch (JsonProcessingException e) {
				e.printStackTrace(); // Handle exception properly
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred");
			}
		}
	}

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
}