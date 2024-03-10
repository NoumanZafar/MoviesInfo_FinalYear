import { useState, useEffect } from 'react';
import axios from 'axios';

const Trends = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [isAuthorized, setIsAuthorized] = useState(false);
  const baseApi = "http://localhost:8080";

  useEffect(() => {
    console.log('Authentication status:', isAuthorized);
  }, [isAuthorized]);

  const handleSubmit = async (e) => {
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
      setError('Invalid email or password');
      console.error('Error:', error);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <label>Email:</label>
      <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} required />
      <br />
      <label>Password:</label>
      <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} required />
      <br />
      <button type="submit">Login</button>
      {error && <p>{error}</p>}
    </form>
  );
}

export default Trends;
