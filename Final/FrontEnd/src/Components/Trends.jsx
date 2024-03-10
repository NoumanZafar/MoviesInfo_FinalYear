import { useState, useEffect, Fragment } from 'react';
import axios from 'axios';

const Trends = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [username, setUsername] = useState('');
  const [error, setError] = useState('');
  const [isAuthorized, setIsAuthorized] = useState(false);
  const baseApi = "http://localhost:8080";

  const handleUserAuthentication = async (e) => {
    e.preventDefault();

    try {
      const response = await axios.post(baseApi + '/auth', { email, password });

      // Check the status code and handle the response accordingly
      if (response.status === 200) {
        // Successful authentication
        setIsAuthorized(true);
        setError('');
        console.log(isAuthorized)
      } else {
        // Handle other status codes if needed
        console.error('Authentication failed');
      }
    } catch (error) {
      // Handle errors from the backend or network errors
      setIsAuthorized(false);
      setError('Invalid email or password');
      console.error('Error:', error);
    }
  };


  const handleUserRegistration = async (e) => {
    e.preventDefault();

    try {
      const response = await axios.post(baseApi + '/registration', { username, email, password });

      // Check the status code and handle the response accordingly
      if (response.status === 200) {
        // Successful Registration
        alert("Registration successfull")
        setError('');
      } else {
        // Handle other status codes if needed
        console.error('Registration failed');
      }
    } catch (error) {
      // Handle errors from the backend or network errors
      setError('Something went wrong');
      console.error('Error:', error);
    }
  };

  useEffect(() => {
    console.log('Authentication status:', isAuthorized);
  }, [isAuthorized]);


  return (
    <Fragment>
      <div>
        <form onSubmit={handleUserAuthentication}>
          <label>Email:</label>
          <input type="email" onChange={(e) => setEmail(e.target.value)} required />
          <br />
          <label>Password:</label>
          <input type="password" onChange={(e) => setPassword(e.target.value)} required />
          <br />
          <button type="submit">Login</button>
          {error && <p>{error}</p>}
        </form>
      </div>
      <div>
        <form onSubmit={handleUserRegistration}>
          <label>Username:</label>
          <input type="text" onChange={(e) => setUsername(e.target.value)} required />
          <br />
          <label>Email:</label>
          <input type="email" onChange={(e) => setEmail(e.target.value)} required />
          <br />
          <label>Password:</label>
          <input type="password" onChange={(e) => setPassword(e.target.value)} required />
          <br />
          <button type="submit">Register</button>
          {error && <p>{error}</p>}
        </form>
      </div>
    </Fragment>
  );
}

export default Trends;
