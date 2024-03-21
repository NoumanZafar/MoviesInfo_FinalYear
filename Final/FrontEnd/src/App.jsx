import React, { Fragment } from 'react';
import Login from './Components/Login';
import Navbar from './Components/Navbar';

const storedIsAuthorized = JSON.parse(sessionStorage.getItem('isAuthorized'));
console.log("stored: ", storedIsAuthorized)

const App = () => {

  return (
    <Fragment>
      {storedIsAuthorized ? (
        <div>
          <Navbar />
        </div>
      ) : (
        <div>
          <Login />
        </div>
      )}

    </Fragment>

  );
};

export default App;
