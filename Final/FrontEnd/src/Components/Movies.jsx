import React, { Fragment, useContext, useEffect, useState } from 'react'
import axios from 'axios'
import { Container } from './Navbar'
import '../Styles/Movies.css'

const Movies = () => {
  const { toggle, inputValue } = useContext(Container)
  const [moviesData, setMoviesData] = useState([])
  const baseApi = "http://localhost:8080"

  const movieCall = async () => {
    let url;
    if(inputValue){
      url = `${baseApi}/movies/${inputValue}`;
    } else {
      url = `${baseApi}/movies`;
    }
  
    try {
      const response = await axios.get(url);
      console.log('Response data:', response); // Log the response data
      setMoviesData(response.data);
    } catch (error) {
      console.error('Error fetching movie data:', error);
    }
  };
  

  //kinda main method
  useEffect(() => {
    movieCall()
  }, [inputValue])
  //console.log('movie data '+moviesData.length)

  return (
    <Fragment>
      <div className={toggle ? 'mainBgColor' : 'secondaryBgColor'}>
        <div className='movies-container'>
        {Array.isArray(moviesData) && moviesData.length > 0 && moviesData.map((movie) => (
           <Fragment key={movie.movieId}>
              <div id='container'>
                <img src={movie.posterUrl} alt="" />
                <h3 id={movie.title.length > 28 ? 'smaller-Text' : ''} className={toggle ? 'titleColorDark' : ''}>{movie.title}</h3>
              </div>
            </Fragment>
          ))}
        </div>
      </div>
    </Fragment>
  );
  
}

export default Movies