import React, { Fragment, useContext, useEffect, useState } from 'react';
import { useLocation } from 'react-router-dom';
import axios from 'axios';
import { Container } from './Navbar';
import { useNavigate } from 'react-router-dom'; // Import useNavigate hook
import '../Styles/Movies.css';

const Movies = () => {
  const { toggle, inputValue } = useContext(Container);
  const [moviesData, setMoviesData] = useState([]);
  const baseApi = "http://localhost:8080";
  const navigate = useNavigate(); // Initialize useNavigate
  // get peron id here from details page.
  const location = useLocation();
  const params = new URLSearchParams(location.search);
  let person = params.get('person');


  const movieCall = async () => {
    let url;
    if (inputValue) {
      url = `${baseApi}/movies/${inputValue}`;
    } else {
      url = `${baseApi}/movies`;
    }

    try {
      const response = await axios.get(url);
      setMoviesData(response.data);
    } catch (error) {
      console.error('Error fetching movie data:', error);
    }
  };

  // movies related to specific person
  const movieCallByRelatedPeople = async () => {
    let url = `${baseApi}/movies/person/${person}`;
    if (person) {
      try {
        const response = await axios.get(url, {
          headers: {
            'Access-Control-Allow-Origin': '*'
          }
        });
        setMoviesData(response.data);
      } catch (error) {
        console.error('Error fetching Movies data:', error);
      }
    }
  };

  useEffect(() => {
    movieCall();
  }, [inputValue]);

  useEffect(() => {
    movieCallByRelatedPeople();
  }, [moviesData]);

  const onClickPicture = (movieId) => {
    // Navigate to Details page with the movieId as a url query parameter
    navigate(`/Details?movieId=${movieId}`);
  };

  return (
    <Fragment>
      <div className={toggle ? 'mainBgColor' : 'secondaryBgColor'}>
        <div className='movies-container'>
          {Array.isArray(moviesData) && moviesData.length > 0 && moviesData.map((movie) => (
            <Fragment key={movie.movieId}>
              <div id='container'>
                <img src={movie.posterUrl} alt="" onClick={() => onClickPicture(movie.movieId)} />
                <h3 id={movie.title.length > 28 ? 'smaller-Text' : ''} className={toggle ? 'titleColorDark' : ''}>{movie.title}</h3>
              </div>
            </Fragment>
          ))}
        </div>
      </div>
    </Fragment>
  );
}

export default Movies;