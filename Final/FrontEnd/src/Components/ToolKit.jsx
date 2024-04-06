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
    const [personName, setPersonName] = useState('');
    const [ocupation, setOcupation] = useState('');
    const [imageURL, setImageURL] = useState('');
    const [nameData, setNameData] = useState([]);
    const [selectedPersonId, setSelectedPersonId] = useState('');


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

    const peopleDataCall = async () => {
        let url = `${baseApi}/people/name`;
        try {
            const response = await axios.get(url, {
                headers: {
                    'Access-Control-Allow-Origin': '*'
                }
            });
            setNameData(response.data);
        } catch (error) {
            console.error('Error fetching People data:', error);
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
            }
        } catch (error) {
            console.error('Error:', error);
        }
    };

    const addClip = async (e) => {
        e.preventDefault();
        if (!selectedMovieId) {
            alert('Please select a movie.');
            return;
        }
        try {
            const response = await axios.post(baseApi + '/clips/addClips', { selectedMovieId, clipURL });
            if (response.status === 200) {
                alert('Clip Added.');
                document.getElementById('addControlsForm').reset();
            } else {
                alert('Adding Clip failed.');
                console.error('Adding Clip failed.');
            }
        } catch (error) {
            console.error('Error:', error);
        }
    };

    const addPerson = async (e) => {
        e.preventDefault();
        if (!selectedMovieId) {
            alert('Please select a movie.');
            return;
        }

        if (!selectedPersonId) {
            alert('Please select a Person.');
            return;
        }

        try {
            const response = await axios.post(baseApi + '/people/addMoviePeople', { selectedMovieId, selectedPersonId });
            if (response.status === 200) {
                alert('Person Added.');
                document.getElementById('addControlsForm').reset();
            } else {
                alert('Relating Person failed.');
            }
        } catch (error) {
            console.error('Error:', error);
        }
    };

    const addPeople = async (e) => {
        e.preventDefault();
        try {
            const response = await axios.post(baseApi + '/people/addPeople', { personName, ocupation, imageURL });
            if (response.status === 200) {
                alert('Person Added.');
                document.getElementById('addPeopleForm').reset();
                peopleDataCall();
            } else {
                alert('Adding People Data failed.');
            }
        } catch (error) {
            console.error('Error:', error);
        }
    };

    useEffect(() => {
        movieDataCall();
        peopleDataCall();
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
                    <h1>Add People</h1>
                    <form onSubmit={addPeople} id='addPeopleForm'>
                        <label>Name:</label>
                        <input type="text" onChange={(e) => setPersonName(e.target.value)} required />
                        <br />
                        <label>Ocupation:</label>
                        <input type="text" onChange={(e) => setOcupation(e.target.value)} required />
                        <br />
                        <label>Image URL:</label>
                        <input type="text" onChange={(e) => setImageURL(e.target.value)} required />
                        <br />
                        <button type="submit">Add People</button>
                    </form>
                </div>

                <div>
                    <h1>Controls</h1>
                    <form id='addControlsForm'>
                        <div>
                            <label>Movie:</label>
                            <select onChange={(e) => setSelectedMovieId(e.target.value)}>
                                <option value="">Select a movie</option>
                                {Array.isArray(titleData) && titleData.length > 0 && titleData.map((movie) => (
                                    <option key={movie.title} value={movie.id}>{movie.title}</option>
                                ))}
                            </select>
                        </div>

                        <div>
                            <h3>Clips</h3>
                            <label>Clip URL:</label>
                            <input type="text" onChange={(e) => setClipURL(e.target.value)} required />
                            <button type="submit" onClick={addClip}>Add Clip</button>
                        </div>

                        <div>
                            <h3>People</h3>
                            <label>Person:</label>
                            <select onChange={(e) => setSelectedPersonId(e.target.value)}>
                                <option value="">Select a Person</option>
                                {Array.isArray(nameData) && nameData.length > 0 && nameData.map((person) => (
                                    <option key={person.name} value={person.personId}>{person.name}</option>
                                ))}
                            </select>
                            <button type="submit" onClick={addPerson}>Add Person</button>
                        </div>
                    </form>
                </div>
            </div>
        </Fragment>
    )
}

export default ToolKit
