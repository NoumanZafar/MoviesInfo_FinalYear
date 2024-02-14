import React, {useState} from 'react'
import './NavBar.css'
import logo_light from '../../assets/logo-black.png'
import logo_dark from '../../assets/logo-white.png'
import search_icon_light from '../../assets/search-w.png'
import search_icon_dark from '../../assets/search-b.png'
import toggle_light from '../../assets/night.png'
import toggle_dark from '../../assets/day.png'
import { NavLink } from 'react-router-dom'


const NavBar = ({theme,setTheme}) => {
    const [menuOpen,setMenuOpen]=useState(false);

    const toggle_mode=()=>{
        theme == 'light' ? setTheme('dark') : setTheme('light');
    }

  return (
    <nav className='navbar'>
      <img src={theme == 'light' ? logo_light : logo_dark} alt="" className='logo'/>
      
      <div className='menu' onClick={()=>{
        setMenuOpen(!menuOpen)
      }}>
        <span></span>
        <span></span>
        <span></span>
        <span></span>
      </div>
      <ul className={menuOpen ? "open" : ""}>
        <li>
            <NavLink to="/home">Home</NavLink>
        </li>
        <li>
            <NavLink to="/products">Products</NavLink>
        </li>
        <li>
            <NavLink to="/features">features</NavLink>
        </li>
        <li>
            <NavLink to="/about">About</NavLink>
        </li>
      </ul>

      <div className='search-box'>
        <input type="text" placeholder='Search'/>
        <img src={theme == 'light' ? search_icon_light : search_icon_dark} alt="" />
      </div>

      <img onClick={()=>{toggle_mode()}} src={theme == 'light' ? toggle_light : toggle_dark} alt="" className='toggle-icon' />

    </nav>
  )
}

export default NavBar
