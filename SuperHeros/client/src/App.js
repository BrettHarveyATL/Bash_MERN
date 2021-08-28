import './App.css';
import AllUsers from './views/allusers';
import AddUser from './components/userreg';
import LoggedUser from './components/loggedinuser';
import Login from './components/login';
import { useState } from 'react';
import axios from 'axios';
//new import
import AllVillians from './views/AllVillians';
import AllSuperheros from './views/AllSuperheros';

function App() {
    const [loaded, setLoaded] = useState(false);
    const [activeUser, setActiveUser] = useState({});
    //new state
const [villians, setVillians] = useState([]);
const [superheros, setSuperheros] = useState([]);
    const onClickHandler = (e) => {
    setActiveUser({});
    }
    //new handler
    const onVillianDeleteHander = _id =>{
        axios.delete("http://localhost:8000/api/villians/"+_id)
            .then(res=>{
            console.log(res)
            setLoaded(false);
        })
        .catch(err => console.log(err))
    }
    const onSuperheroDeleteHander = _id =>{
        axios.delete("http://localhost:8000/api/superheros/"+_id)
            .then(res=>{
            console.log(res)
            setLoaded(false);
        })
        .catch(err => console.log(err))
    }
    return (
        <div className="App">
            <h1>Hello there</h1>
            <div className="loginregforms">
                <AddUser loaded={loaded} setLoaded={setLoaded} activeUser={activeUser} setActiveUser={setActiveUser}/>
                <Login loaded={loaded} setLoaded={setLoaded} activeUser={activeUser} setActiveUser={setActiveUser}/>
                {/* new route */}
                <AllVillians villians={villians} onDeleteHander={onVillianDeleteHander}/>
                <AllSuperheros superheros={superheros} onDeleteHander={onSuperheroDeleteHander}/>
        </div>
        <AllUsers loaded={loaded} setLoaded={setLoaded}/>
        <LoggedUser activeUser={activeUser}/>
        <button onClick={onClickHandler}>Logout</button>
        </div>
    );
}

export default App;
