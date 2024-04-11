import React, { useState, useEffect, Fragment } from 'react';
import axios from 'axios';
import Navbar from '../Components/Navbar';
import '../Styles/Login.css';

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
                document.getElementById('regForm').reset();
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
                    <div className="LoginRegistration">
                        <div className="login">
                            <h1>Login</h1>
                            <form onSubmit={handleUserAuthentication} className="login-form">
                                <label>Email:</label>
                                <input placeholder='Email....' type="email" onChange={(e) => setEmail(e.target.value)} required />
                                <br />
                                <label>Password:</label>
                                <input placeholder='Password....' type="password" onChange={(e) => setPassword(e.target.value)} required />
                                <br />
                                <button type="submit">Login</button>
                                {error && <p className="error">{error}</p>}
                            </form>
                        </div>
                        <div className="registration">
                            <h1>Registration</h1>
                            <form onSubmit={handleUserRegistration} id='regForm' className="registration-form">
                                <label>Username:</label>
                                <input placeholder='Username....' type="text" onChange={(e) => setUsername(e.target.value)} required />
                                <br />
                                <label>Email:</label>
                                <input placeholder='Email....' type="email" onChange={(e) => setEmail(e.target.value)} required />
                                <br />
                                <label>Password:</label>
                                <input placeholder='Password....' type="password" onChange={(e) => setPassword(e.target.value)} required />
                                <br />
                                <button type="submit">Register</button>
                                {error && <p className="error">{error}</p>}
                            </form>
                        </div>
                    </div>

                </Fragment>
            )}
        </Fragment>
    );
};

export default Login;
