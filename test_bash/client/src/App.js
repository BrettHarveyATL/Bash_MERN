import './App.css';
import AllUsers from './views/allusers';
import AddUser from './components/userreg';
import LoggedUser from './components/loggedinuser';
import Login from './components/login';
import { useState } from 'react';
import axios from 'axios';
//new import
import AllProductss from './views/AllProductss';

function App() {
    const [loaded, setLoaded] = useState(false);
    const [activeUser, setActiveUser] = useState({});
    //new state
const [productss, setProductss] = useState([]);
    const onClickHandler = (e) => {
    setActiveUser({});
    }
    //new handler
    const onProductsDeleteHander = _id =>{
        axios.delete("http://localhost:8000/api/productss/"+_id)
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
                <AllProductss productss={productss} onDeleteHander={onProductsDeleteHander}/>
        </div>
        <AllUsers loaded={loaded} setLoaded={setLoaded}/>
        <LoggedUser activeUser={activeUser}/>
        <button onClick={onClickHandler}>Logout</button>
        </div>
    );
}

export default App;
