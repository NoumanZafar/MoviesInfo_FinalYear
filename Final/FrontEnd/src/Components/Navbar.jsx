import React, { Fragment, useState } from 'react'
import { NavLink, Route, Routes } from 'react-router-dom';
import { HiSearch } from 'react-icons/hi'
import '../Styles/Navbar.css'
import Movies from './Movies'
import Details from './Details'

export const Container = React.createContext()
const Navbar = () => {
    const [toggle, setToggle] = useState(true);
    const [inputValue, setInputValue] = useState('')

    const onClickLogout = () => {
        console.log("clicked")
        sessionStorage.setItem('isAuthorized', JSON.stringify(false));
        window.location.reload();
    }

    return (
        <Container.Provider value={{ toggle, inputValue }}>
            <Fragment>
                <nav className={toggle ? '' : 'navBarColor'}>
                    <div className='nav-options'>
                        {/**Add routing here with adding this pages can be accessed with button click*/}
                        <NavLink to="">
                            <h1 id={toggle ? '' : 'heading'}>WEBSITENAME</h1>
                        </NavLink>

                        <NavLink style={({ isActive }) => { return { color: isActive ? '#fff' : '#EE9B00' } }}>
                            <span id={toggle ? 'Movies' : 'MoviesLight'} onClick={() => onClickLogout()}>Logout</span>
                        </NavLink>
                    </div>
                    <div className='input-group'>
                        <input type="text" placeholder='Search....' onChange={(e) => setInputValue(e.target.value)} />
                        <HiSearch fontSize={21} color='black' id='search' />
                        <div id='Color-switcher' onClick={() => setToggle(!toggle)}>
                            <div id={toggle ? 'Color-switcher-mover' : 'Color-switcher-moved'}>

                            </div>
                        </div>
                    </div>
                </nav>

                <Routes>
                    {/**Add routing here with adding this pages can be accessed changing the url manually*/}
                    <Route path='' element={<Movies />} />
                    <Route path='/Details' element={<Details />} />
                </Routes>

            </Fragment>
        </Container.Provider>
    )
}

export default Navbar
