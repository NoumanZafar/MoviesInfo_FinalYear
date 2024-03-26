import React, { useState, useEffect, Fragment } from 'react';
import axios from 'axios';
import Navbar from '../Components/Navbar';
import '../Styles/Login.css';

const Login = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [username, setUsername] = useState('');
    const [error, setError] = useState('');
    const [regError, setRegError] = useState('');
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
                setRegError('');
                document.getElementById('regForm').reset();
            } else {
                console.error('Registration failed');
            }
        } catch (error) {
            setRegError('Something went wrong');
            console.error('Error:', error);
        }
    };

    useEffect(() => {
        localStorage.setItem('isAuthorized', JSON.stringify(isAuthorized));
        localStorage.setItem('email', JSON.stringify(email));
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
                        <div>
                            <h1>Login</h1>
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
                            <h1>Registration</h1>
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
                                {regError && <p>{regError}</p>}
                            </form>
                        </div>
                    </div>
                </Fragment>
            )}
        </Fragment>
    );
};

export default Login;
