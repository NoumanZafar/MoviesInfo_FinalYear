import React, { Fragment, useContext, useEffect, useState } from 'react';
import { useLocation } from 'react-router-dom';
import axios from 'axios';
import { Container } from './Navbar';
import '../Styles/TvShows.css';

const TvShows = () => {
  //getting the movie id from url
  const location = useLocation();
  const params = new URLSearchParams(location.search);
  const movieId = params.get('movieId');
  //STARTED HERE
  const { toggle } = useContext(Container);
  const [moviesData, setMoviesData] = useState([]);
  const [clipData, setClipData] = useState([]);
  const baseApi = "http://localhost:8080";

  const movieCall = async () => {
    let url = `${baseApi}/movies/id/${movieId}`;
    //console.log(url)
    try {
      const response = await axios.get(url);
      setMoviesData(response.data);
    } catch (error) {
      console.error('Error fetching movie data:', error);
    }
  };


  const clipCall = async () => {
    let url = `${baseApi}/clips/${movieId}`;
    //console.log(url)
    try {
      const response = await axios.get(url);
      setClipData(response.data);
    } catch (error) {
      console.error('Error fetching movie data:', error);
    }
  };





  useEffect(() => {
    movieCall();
  }, []);
  //console.log(moviesData)


  useEffect(() => {
    clipCall();
  }, []);
  // console.log(clipData)


  return (
    <Fragment>
      <div >
        <div >
          {Array.isArray(moviesData) && moviesData.length > 0 && moviesData.map((movie) => (
            <Fragment key={movie.movieId}>
              <div>
                <div>
                  <div>
                    <img src={movie.posterUrl} alt="" width={500} height={500} />
                  </div>
                  <div>
                    <h2>{movie.title}</h2>
                    <p><strong>Genre:</strong> {movie.genre}</p>
                    <p><strong>Release Date:</strong> {movie.releaseDate}</p>
                    <p><strong>Description:</strong> {movie.mdescription}</p>
                  </div>
                </div>
              </div>
            </Fragment>
          ))}
        </div>

        <div >
          {Array.isArray(clipData) && clipData.length > 0 && clipData.map((clip) => (
            <Fragment key={clip.clipId}>
              <div>
                <p>{clip.clipUrl}</p>
              </div>
            </Fragment>
          ))}
        </div>

      </div>
    </Fragment>
  );
}

export default TvShows;