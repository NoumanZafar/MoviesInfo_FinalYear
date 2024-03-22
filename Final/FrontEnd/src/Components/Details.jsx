import React, { Fragment, useContext, useEffect, useState } from 'react';
import { useLocation } from 'react-router-dom';
import ReactPlayer from 'react-player';
import axios from 'axios';
import { Container } from './Navbar';
import { useNavigate } from 'react-router-dom';

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
  const email = JSON.parse(localStorage.getItem('email'));
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
      console.error('Error fetching Reviews data:', error);
    }
  };

  useEffect(() => {
    movieCall();
    clipCall();
    relatedPeopleCall();
    averageRating();
    relatedMovies();
    allReviews();
    authorizedUser();
  }, [movieId]);


  //console.log(authorizedUserData);


  const onClickPicture = (id) => {
    setMovieId(id);
    navigate(`/Details?movieId=${id}`);
    window.scrollTo(0, 0);
  };


  //multiple comments by same user
  const postComment = async (e) => {
    e.preventDefault();
    let userId = authorizedUserData.length > 0 ? authorizedUserData[0].userId : '';
    let comment = document.getElementById("commentField").value;
    if (comment) {
      try {
        const response = await axios.post(`${baseApi}/reviews/comment`, { userId, movieId, comment });
        if (response.status === 200) {
          console.log("Comment Successfully posted")
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
                <img src={relatedPeople.imageUrl} alt="" />
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
              <div>
                <img src={related.posterUrl} alt="" onClick={() => onClickPicture(related.movieId)} />
                <p>{related.title}</p>
              </div>
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