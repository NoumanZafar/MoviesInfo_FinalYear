import React from 'react';
import { useLocation } from 'react-router-dom';

const TvShows = () => {
  const location = useLocation();
  const params = new URLSearchParams(location.search);
  const movieId = params.get('movieId');

  return (
    <div>
      <h2>TV Shows</h2>
      <p>Movie ID: {movieId}</p>
    </div>
  );
}

export default TvShows;