import React, { Fragment, useContext, useEffect, useState } from 'react'
import axios from 'axios'
import { Container } from './Navbar'
import '../Styles/Movies.css'

const Movies = () => {
  const { toggle } = useContext(Container)
  const [moviesData, setMoviesData] = useState([])
  const baseApi = "http://localhost:8080"

  //get the movie data from server
  const movieCall = async () => {
    //get rerquest
    const data = await axios.get(baseApi + '/movies')
    //set the movie data to movieData -- useState
    setMoviesData(data.data)
  }

  //kinda main method
  useEffect(() => {
    movieCall()
  }, [])
  console.log(moviesData)

  return (
    <Fragment>
      <div className={toggle ? 'mainBgColor' : 'secondaryBgColor'}>
        <div className='movies-container'>
          {/** map the data here */}
          {moviesData.map((movie) => {
            return (
              <Fragment>
                <div id='container'>
                  <img src={movie.posterUrl} alt="" />
                  <h3 id={movie.title.length > 28 ? 'smaller-Text' : ''} className={toggle ? 'titleColorDark' : ''}>{movie.title}</h3>
                </div>
              </Fragment>
            )
          })}
        </div>
      </div>
    </Fragment>
  )
}

export default Movies
