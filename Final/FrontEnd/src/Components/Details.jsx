import React, { Fragment, useContext, useEffect, useState, useRef } from 'react';
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
  //slider here
  const relatedPeopleSliderRef = useRef(null);
  const clipsSliderRef = useRef(null);
  const relatedMoviesSliderRef = useRef(null);
  const [isScrollingRequiredRelatedPeople, setIsScrollingRequiredRelatedPeople] = useState(false);
  const [isScrollingRequiredClips, setIsScrollingRequiredClips] = useState(false);
  const [isScrollingRequiredRelatedMovies, setIsScrollingRequiredRelatedMovies] = useState(false);


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
        document.getElementById("rat").innerHTML = "Your Rating: " + rating + "/5";
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

  const onClickActorImage = (personId) => {
    navigate(`/?person=${personId}`);
  }

  const slideLeft = (ref) => {
    ref.current.scrollBy({
      left: -250,
      behavior: 'smooth'
    });
  }

  const slideRight = (ref) => {
    ref.current.scrollBy({
      left: 250,
      behavior: 'smooth'
    });
  }

  const isScrollingRequired = (sliderRef) => {
    return sliderRef.current && sliderRef.current.scrollWidth > sliderRef.current.clientWidth;
  };

  useEffect(() => {
    setIsScrollingRequiredRelatedPeople(isScrollingRequired(relatedPeopleSliderRef));
  }, [relatedPeopleData]);

  useEffect(() => {
    setIsScrollingRequiredClips(isScrollingRequired(clipsSliderRef));
  }, [clipData]);

  useEffect(() => {
    setIsScrollingRequiredRelatedMovies(isScrollingRequired(relatedMoviesSliderRef));
  }, [relatedMoviesData]);

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

  // light/dark theme 
  // className={toggle ? 'mainBgColor' : 'secondaryBgColor'}
  return (
    <Fragment>
      <div>
        <div className='generalDetails'>
          {Array.isArray(moviesData) && moviesData.length > 0 && moviesData.map((movie) => (
            <Fragment key={movie.movieId}>
              <div className='movieContainer'>
                <div className='poster'>
                  <img src={movie.posterUrl} alt="" />
                </div>
                <div className='otherDetails'>
                  <h1 className='title'>{movie.title}</h1>
                  <p className='genre'><strong>Genre:</strong> {movie.genre}</p>
                  <p className='releaseDate'><strong>Release Date:</strong> {movie.releaseDate}</p>
                  <div className='overAllRating'>
                    {Array.isArray(averageRatingData) && averageRatingData.length > 0 && averageRatingData.map((average) => (
                      <Fragment key={average.AvgRating}>
                        <div>
                          <p><strong>Overall Rating:</strong> {(average.AvgRating).toFixed(2)}</p>
                        </div>
                      </Fragment>
                    ))}
                  </div>
                  <p className='description'><strong>Description:</strong> {movie.mdescription}</p>
                  <div className='ratingDetails'>
                    <h1 id='rat'>Your Rating: 0</h1>
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
                  </div>
                </div>
              </div>
            </Fragment>
          ))}
        </div>


        {Array.isArray(relatedPeopleData) && relatedPeopleData.length > 0 && (
          <div>
            <h2 className='relatedPeopleHeading'>Related People</h2>
            <div className="relatedPeopleSlider">
              {isScrollingRequiredRelatedPeople && (
                <button onClick={() => slideLeft(relatedPeopleSliderRef)}>&#60;</button>
              )}
              <div className="relatedPeopleSliderContainer" ref={relatedPeopleSliderRef}>
                {relatedPeopleData.map((relatedPeople) => (
                  <div key={relatedPeople.personId} className="relatedPeopleItem" onClick={() => onClickActorImage(relatedPeople.personId)}>
                    <img src={relatedPeople.imageUrl} alt="" />
                    <p>{relatedPeople.name}</p>
                  </div>
                ))}
              </div>
              {isScrollingRequiredRelatedPeople && (
                <button onClick={() => slideRight(relatedPeopleSliderRef)}>&#62;</button>
              )}
            </div>
          </div>
        )}




        {Array.isArray(clipData) && clipData.length > 0 && (
          <div>
            <h2 className='clipsHeading'>Clips</h2>
            <div className="clipsSlider">
              {isScrollingRequiredClips && (
                <button onClick={() => slideLeft(clipsSliderRef)}>&#60;</button>
              )}
              <div className="clipsSliderContainer" ref={clipsSliderRef}>
                {clipData.map((clip) => (
                  <div key={clip.clipId} className='clipsItem'>
                    <ReactPlayer url={clip.clipUrl} controls />
                  </div>
                ))}
              </div>
              {isScrollingRequiredClips && (
                <button onClick={() => slideRight(clipsSliderRef)}>&#62;</button>
              )}
            </div>
          </div>
        )}

        {Array.isArray(relatedMoviesData) && relatedMoviesData.length > 1 && (
          <div>
            <h2 className='relatedMoviesHeading'>Related Movies</h2>
            <div className="relatedMoviesSlider">
              {isScrollingRequiredRelatedMovies && (
                <button onClick={() => slideLeft(relatedMoviesSliderRef)}>&#60;</button>
              )}
              <div className="relatedMoviesSliderContainer" ref={relatedMoviesSliderRef}>
                {relatedMoviesData.map((related) => (
                  related.movieId != movieId && (
                    <div key={related.movieId} className='relatedMoviesItem'>
                      <img src={related.posterUrl} alt="" onClick={() => onClickPicture(related.movieId)} />
                      <p>{related.title}</p>
                    </div>
                  )
                ))}
              </div>
              {isScrollingRequiredRelatedMovies && (
                <button onClick={() => slideRight(relatedMoviesSliderRef)}>&#62;</button>
              )}
            </div>
          </div>
        )}



        <div >
          <h2>Reviews</h2>
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