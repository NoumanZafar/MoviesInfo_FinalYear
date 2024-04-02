import React, { useState, useEffect, Fragment } from 'react';
import axios from 'axios';

const ToolKit = () => {
    const baseApi = "http://localhost:8080";
    const [title, setTitle] = useState('');
    const [releaseDate, setReleaseDate] = useState('');
    const [genre, setGenre] = useState('');
    const [posterURL, setPosterURL] = useState('');
    const [description, setDescription] = useState('');
    const [titleData, setTitleData] = useState([]);
    const [selectedMovieId, setSelectedMovieId] = useState('');
    const [clipURL, setClipURL] = useState('');


    const movieDataCall = async () => {
        let url = `${baseApi}/movies/title`;
        try {
            const response = await axios.get(url, {
                headers: {
                    'Access-Control-Allow-Origin': '*'
                }
            });
            setTitleData(response.data);
        } catch (error) {
            console.error('Error fetching Title data:', error);
        }
    };

    const addMovie = async (e) => {
        e.preventDefault();
        try {
            const response = await axios.post(baseApi + '/movies/addMovie', { title, releaseDate, genre, posterURL, description });
            if (response.status === 200) {
                alert('Movie Added.');
                document.getElementById('addMovieForm').reset();
                movieDataCall();
            } else {
                alert('Adding Movie Data failed.');
                console.error('Adding Movie Data failed.');
            }
        } catch (error) {
            console.error('Error:', error);
        }
    };

    const addClip = async (e) => {
        e.preventDefault();
        try {
            const response = await axios.post(baseApi + '/clips/addClips', { selectedMovieId, clipURL });
            if (response.status === 200) {
                alert('Clip Added.');
                document.getElementById('addClipForm').reset();
            } else {
                alert('Adding Clip failed.');
                console.error('Adding Clip failed.');
            }
        } catch (error) {
            console.error('Error:', error);
        }
    };

    useEffect(() => {
        movieDataCall();
    }, []);


    return (
        <Fragment>
            <div>
                <div>
                    <h1>Add Movie</h1>
                    <form onSubmit={addMovie} id='addMovieForm'>
                        <label>Title:</label>
                        <input type="text" onChange={(e) => setTitle(e.target.value)} required />
                        <br />
                        <label>Release Date:</label>
                        <input type="date" onChange={(e) => setReleaseDate(e.target.value)} required />
                        <br />
                        <label>Genre:</label>
                        <input type="text" onChange={(e) => setGenre(e.target.value)} required />
                        <br />
                        <label>Poster URL:</label>
                        <input type="text" onChange={(e) => setPosterURL(e.target.value)} required />
                        <br />
                        <label>Movie Description:</label>
                        <textarea type="text" onChange={(e) => setDescription(e.target.value)} required />
                        <br />
                        <button type="submit">Add Movie</button>
                    </form>
                </div>
                <div>
                    <h1>Add Clips</h1>
                    <form onSubmit={addClip} id='addClipForm'>
                        <label>Movie:</label>
                        <select onChange={(e) => setSelectedMovieId(e.target.value)}>
                            <option value="">Select a movie</option>
                            {Array.isArray(titleData) && titleData.length > 0 && titleData.map((movie) => (
                                <option key={movie.title} value={movie.id}>{movie.title}</option>
                            ))}
                        </select>
                        <br />
                        <label>Clip URL:</label>
                        <input type="text" onChange={(e) => setClipURL(e.target.value)} required />
                        <br />
                        <button type="submit">Add Clip</button>
                    </form>
                </div>
            </div>
        </Fragment>
    )
}

export default ToolKit
