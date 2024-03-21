import React, { useState, useEffect, Fragment } from 'react';
import axios from 'axios';
import Navbar from '../Components/Navbar';

const Login = () => {
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
      if (response.status === 200) {
        setIsAuthorized(true);
        setError('');
      } else {
        console.error('Authentication failed');
      }
    } catch (error) {
      setIsAuthorized(false);
      setError('Invalid email or password');
      console.error('Error:', error);
    }
  };

  const handleUserRegistration = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post(baseApi + '/registration', { username, email, password });
      if (response.status === 200) {
        alert("Registration successful");
        setError('');
      } else {
        console.error('Registration failed');
      }
    } catch (error) {
      setError('Something went wrong');
      console.error('Error:', error);
    }
  };

  useEffect(() => {
    console.log('Authentication status:', isAuthorized);
    sessionStorage.setItem('isAuthorized', JSON.stringify(isAuthorized));
  }, [isAuthorized]);

  return (
    <Fragment>
      {isAuthorized ? (
        <div className='App'>
          <Navbar />
        </div>
      ) : (
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
      )}
    </Fragment>
  );
};

export default Login;