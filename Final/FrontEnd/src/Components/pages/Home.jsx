// src/components/Home.js
import React, { useState } from 'react';

const Home = () => {
  const [selectedMovie, setSelectedMovie] = useState(null);

  // Dummy movie data (replace with actual API calls)
  const movies = [
    { id: 1, title: 'Inception', rating: 4.5, review: 'Mind-bending!' },
    { id: 2, title: 'The Dark Knight', rating: 5, review: 'Epic superhero film' },
    // Add more movies...
  ];

  const handleMovieSelect = (movie) => {
    setSelectedMovie(movie);
  };

  return (
    <div>
      <h1>Movie Homepage</h1>
      <div className="movie-slider">
        {movies.map((movie) => (
          <div
            key={movie.id}
            className={`movie-box ${selectedMovie?.id === movie.id ? 'selected' : ''}`}
            onClick={() => handleMovieSelect(movie)}
          >
            {movie.title}
          </div>
        ))}
      </div>
      {selectedMovie && (
        <div className="movie-details">
          <h2>{selectedMovie.title}</h2>
          <p>Rating: {selectedMovie.rating}</p>
          <p>Review: {selectedMovie.review}</p>
          {/* Add more details (trailer, play online, etc.) */}
        </div>
      )}
    </div>
  );
};

export default Home;

