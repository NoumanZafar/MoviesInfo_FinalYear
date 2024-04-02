import React, { Fragment, useContext, useEffect, useState } from 'react';
import { useLocation } from 'react-router-dom';
import ReactPlayer from 'react-player';
import axios from 'axios';
import { Container } from './Navbar';
import { useNavigate } from 'react-router-dom';
import '../Styles/Details.css';

const Details = () => {
  //getting the movie id from url
  const location = useLocation();
  const params = new URLSearchParams(location.search);
  let initialMovieId = params.get('movieId');
  //STARTED HERE
  const { toggle } = useContext(Container);
  const [movieId, setMovieId] = useState(initialMovieId);
  const [moviesData, setMoviesData] = useState([]);
  const [clipData, setClipData] = useState([]);
  const [relatedPeopleData, setRelatedPeopleData] = useState([]);
  const [averageRatingData, setAverageRatingData] = useState([]);
  const [relatedMoviesData, setRelatedMoviesData] = useState([]);
  const [reviewsData, setReviewsData] = useState([]);
  const [authorizedUserData, setAuthorizedUserData] = useState([]);
  const navigate = useNavigate();
  const baseApi = "http://localhost:8080";
  let email = '';


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
      console.error('Error fetching People data:', error);
    }
  }

  const averageRating = async () => {
    let url = `${baseApi}/reviews/${movieId}`;
    try {
      const response = await axios.get(url, {
        headers: {
          'Access-Control-Allow-Origin': '*'
        }
      });
      setAverageRatingData(response.data);
    } catch (error) {
      console.error('Error fetching Rating data:', error);
    }
  }

  const relatedMovies = async () => {
    let url = `${baseApi}/movies/related/${movieId}`;
    try {
      const response = await axios.get(url, {
        headers: {
          'Access-Control-Allow-Origin': '*'
        }
      });
      setRelatedMoviesData(response.data);
    } catch (error) {
      console.error('Error fetching Related movies data:', error);
    }
  };

  const allReviews = async () => {
    let url = `${baseApi}/reviews/movie/${movieId}`;
    try {
      const response = await axios.get(url, {
        headers: {
          'Access-Control-Allow-Origin': '*'
        }
      });
      setReviewsData(response.data);
    } catch (error) {
      console.error('Error fetching Reviews data:', error);
    }
  };

  const authorizedUser = async () => {
    let url = `${baseApi}/${email}`;
    try {
      const response = await axios.get(url, {
        headers: {
          'Access-Control-Allow-Origin': '*'
        }
      });
      setAuthorizedUserData(response.data);
    } catch (error) {
      console.error('Error fetching Authorized data:', error);
    }
  };

  const getRating = async () => {
    let userId = authorizedUserData.length > 0 ? authorizedUserData[0].userId : '';
    let url = `${baseApi}/${userId}/${movieId}`;
    if (userId) {
      try {
        const response = await axios.get(url, {
          headers: {
            'Access-Control-Allow-Origin': '*'
          }
        });
        let rating = response.data[0].rating;
        const star = document.getElementById('star' + rating)
        star.checked = true;
        document.getElementById("rat").innerHTML = "My Rating: " + rating;
      } catch (error) { }
    }
  };

  const onClickPicture = (id) => {
    setMovieId(id);
    navigate(`/Details?movieId=${id}`);
    window.scrollTo(0, 0);
  };


  //multiple comments by same user
  const postComment = async () => {
    let userId = authorizedUserData.length > 0 ? authorizedUserData[0].userId : '';
    let comment = document.getElementById("commentField").value;
    if (comment) {
      try {
        const response = await axios.post(`${baseApi}/reviews/comment`, { userId, movieId, comment });
        if (response.status === 200) {
          document.getElementById("commentField").value = "";
          alert("Comment Posted.")
          allReviews();
        } else {
          console.error('Comment can\'t be posted');
        }
      } catch (error) {
        console.error('Error:', error);
      }
    } else {
      document.getElementById("commentField").nextElementSibling.innerHTML = "Field Can't be empty";
    }
  };

  const clearSpan = () => {
    document.getElementById("commentField").nextElementSibling.innerHTML = "";
  };

  const handleRatingChange = async (e) => {
    //rating will be used to store it in the sql server
    let rating = e.target.value;
    let userId = authorizedUserData.length > 0 ? authorizedUserData[0].userId : '';
    if (userId) {
      try {
        const response = await axios.post(`${baseApi}/rating/insert`, { userId, movieId, rating });
        if (response.status === 200) {
          alert("You rated a Movie.")
          averageRating();
          getRating();
        } else {
          console.error('Rating can\'t be posted');
        }
      } catch (error) {
        console.error('Error:', error);
      }
    }
  };

  useEffect(() => {
    email = JSON.parse(localStorage.getItem('email'));
    movieCall();
    clipCall();
    relatedPeopleCall();
    averageRating();
    relatedMovies();
    allReviews();
    authorizedUser();
  }, [movieId]);

  useEffect(() => {
    email = JSON.parse(localStorage.getItem('email'));
    getRating();
  }, [authorizedUserData, movieId])
  //console.log(ratingData);

  const onClickActorImage = (personId) => {
    navigate(`/?person=${personId}`);
  }

  // light/dark theme 
  // className={toggle ? 'mainBgColor' : 'secondaryBgColor'}
  return (
    <Fragment>
      <div >

        <div >
          {Array.isArray(moviesData) && moviesData.length > 0 && moviesData.map((movie) => (
            <Fragment key={movie.movieId}>
              <div>
                <div>
                  <div>
                    <img src={movie.posterUrl} alt="" />
                  </div>
                  <div>
                    <h2>{movie.title}</h2>
                    <p><strong>Genre:</strong> {movie.genre}</p>
                    <p><strong>Release Date:</strong> {movie.releaseDate}</p>
                    <p><strong>Description:</strong> {movie.mdescription}</p>
                    <div >
                      {Array.isArray(averageRatingData) && averageRatingData.length > 0 && averageRatingData.map((average) => (
                        <Fragment key={average.AvgRating}>
                          <div>
                            <p><strong>Average Rating:</strong> {average.AvgRating}</p>
                          </div>
                        </Fragment>
                      ))}
                    </div>

                    <div className='stars'>
                      <input type="radio" name="rating" id="star5" value="5" onChange={(e) => handleRatingChange(e)} />
                      <label htmlFor="star5"></label>
                      <input type="radio" name="rating" id="star4.5" value="4.5" onChange={(e) => handleRatingChange(e)} />
                      <label htmlFor="star4.5" className='half'></label>
                      <input type="radio" name="rating" id="star4" value="4" onChange={(e) => handleRatingChange(e)} />
                      <label htmlFor="star4"></label>
                      <input type="radio" name="rating" id="star3.5" value="3.5" onChange={(e) => handleRatingChange(e)} />
                      <label htmlFor="star3.5" className='half'></label>
                      <input type="radio" name="rating" id="star3" value="3" onChange={(e) => handleRatingChange(e)} />
                      <label htmlFor="star3"></label>
                      <input type="radio" name="rating" id="star2.5" value="2.5" onChange={(e) => handleRatingChange(e)} />
                      <label htmlFor="star2.5" className='half'></label>
                      <input type="radio" name="rating" id="star2" value="2" onChange={(e) => handleRatingChange(e)} />
                      <label htmlFor="star2"></label>
                      <input type="radio" name="rating" id="star1.5" value="1.5" onChange={(e) => handleRatingChange(e)} />
                      <label htmlFor="star1.5" className='half'></label>
                      <input type="radio" name="rating" id="star1" value="1" onChange={(e) => handleRatingChange(e)} />
                      <label htmlFor="star1"></label>
                      <input type="radio" name="rating" id="star0.5" value="0.5" onChange={(e) => handleRatingChange(e)} />
                      <label htmlFor="star0.5" className='half'></label>
                    </div>

                    <p id='rat'>My Rating: 0</p>
                  </div>
                </div>
              </div>
            </Fragment>
          ))}
        </div>


        <div >
          {Array.isArray(relatedPeopleData) && relatedPeopleData.length > 0 && relatedPeopleData.map((relatedPeople) => (
            <Fragment key={relatedPeople.personId}>
              <div>
                <img src={relatedPeople.imageUrl} alt="" onClick={() => onClickActorImage(relatedPeople.personId)} />
                <p>{relatedPeople.name}</p>
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
          {Array.isArray(relatedMoviesData) && relatedMoviesData.length > 0 && relatedMoviesData.map((related) => (
            <Fragment key={related.movieId}>
              {related.movieId != movieId && (
                <div>
                  <img src={related.posterUrl} alt="" onClick={() => onClickPicture(related.movieId)} />
                  <p>{related.title}</p>
                </div>
              )}
            </Fragment>
          ))}
        </div>

        <div >
          <h3>Reviews</h3>
          {Array.isArray(reviewsData) && reviewsData.length > 0 && reviewsData.map((review) => (
            <Fragment key={review.reviewId}>
              <div>
                <p>{review.user}</p>
                <p>{review.comment}</p>
              </div>
            </Fragment>
          ))}
          <input type="text" id='commentField' placeholder="Write your comment....." onInput={clearSpan} /><span></span>
          <button onClick={postComment}>Post</button>
        </div>

      </div>
    </Fragment>
  );
}

export default Details;