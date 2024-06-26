package ie.tus.athlone.MoviesInfo;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;

import com.company.movies_database.MoviesDatabaseApplication;
import com.company.movies_database.MoviesDatabaseApplicationBuilder;

@Configuration
public class DatabaseConnection {
	@Bean
	public MoviesDatabaseApplication setup() {
		return new MoviesDatabaseApplicationBuilder()
				.withIpAddress("127.0.0.1") // change every time when server IP changes
				.withPort(3306)
				.withUsername("root")
				.withPassword("root")
//				.withUsername("nouman")
//				.withPassword("Nouman3255!")
				.build();
	}
	
	@Bean
	public Jackson2ObjectMapperBuilder jacksonBuilder() {
		return new Jackson2ObjectMapperBuilder()
				.indentOutput(true);
	}
}
