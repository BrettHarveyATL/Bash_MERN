import axios from 'axios';
import React, {useState, useEffect} from 'react';

const AllUsers = (props) => {
    const [users, setUsers] = useState([]);

    useEffect(() => {
        axios.get("http://localhost:8000/api/users")
            .then(res=>{
                setUsers(res.data.users);
                props.setLoaded(true);
            })
            .catch(err=>console.log(err))
            
    }, [props.loaded])
    
    const onClickHandler = (_id) => {
        axios.delete('http://localhost:8000/api/users/delete/'+_id)
        .then(res=>{
            console.log(res)
            props.setLoaded(false)
        })
        .catch(err=>console.log(err))
    }

    return (
        <div>
            <header>
                <h2>All Users</h2>
            </header>
            <div className="mainbody">
                {users.map((user, key)=>{
                    return <div className="oneuser">
                        <h3>{key + 1}: {user.username}</h3>
                        <h5>{user.firstName} {user.lastName}</h5>
                        <button onClick={()=>onClickHandler(user._id)}>Delete</button>
                    </div>
                })}
            </div>
        </div>
    )
}

export default AllUsers;
