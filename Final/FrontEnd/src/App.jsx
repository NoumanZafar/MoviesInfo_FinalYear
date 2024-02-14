import React, { useEffect, useState } from 'react'
import NavBar from './Components/NavBar/NavBar'
import { Route, Routes } from 'react-router-dom';
import Home from './Components/pages/Home';
import About from './Components/pages/About';
import Features from './Components/pages/Features';
import Products from './Components/pages/Products';


const App = () => {
  const current_theme = localStorage.getItem('current_theme');
  const [theme,setTheme]=useState(current_theme ? current_theme : 'light');
  
  useEffect(()=>{
    localStorage.setItem('current_theme',theme);
  },[theme])

  return (
    <div className={`container ${theme}`}>
      <NavBar theme={theme} setTheme={setTheme}/>
      <Routes>
        <Route path="/home" element={<Home/>}/>
        <Route path="/about" element={<About/>}/>
        <Route path="/features" element={<Features/>}/>
        <Route path="/products" element={<Products/>}/>
      </Routes>
    </div>
  )
}

export default App
