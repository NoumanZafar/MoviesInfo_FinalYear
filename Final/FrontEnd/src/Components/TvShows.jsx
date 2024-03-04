import React, { Fragment, useContext, useEffect, useState } from 'react';
import { useLocation } from 'react-router-dom';
import ReactPlayer from 'react-player';
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
  const [relatedPeopleData, setRelatedPeopleData] = useState([]);
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
      const response = await axios.get(url, {
        headers: {
          'Access-Control-Allow-Origin': '*'
        }
      });
      setClipData(response.data);
    } catch (error) {
      console.error('Error fetching Clips data:', error);
    }
  };

  const relatedPeopleCall = async () => {
    let url = `${baseApi}/people/${movieId}`;
    try {
      const response = await axios.get(url, {
        headers: {
          'Access-Control-Allow-Origin': '*'
        }
      });
      setRelatedPeopleData(response.data);
    } catch (error) {
      console.error('Error fetching Clips data:', error);
    }
  }






  useEffect(() => {
    movieCall();
    clipCall();
    relatedPeopleCall();
  }, []);
  //console.log(relatedPeopleData)

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
                <ReactPlayer url={clip.clipUrl} controls />
              </div>
            </Fragment>
          ))}
        </div>

        <div >
          {Array.isArray(relatedPeopleData) && relatedPeopleData.length > 0 && relatedPeopleData.map((relatedPeople) => (
            <Fragment key={relatedPeople.personId}>
              <div>
                <img src={relatedPeople.imageUrl} alt="" />
                <p>{relatedPeople.name}</p>
              </div>
            </Fragment>
          ))}
        </div>

      </div>
    </Fragment>
  );
}

export default TvShows;