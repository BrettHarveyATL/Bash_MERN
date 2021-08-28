import React, { useState } from 'react';
import axios from 'axios';

const Login = (props) => {
    const [form, setForm] = useState({
        "username": "",
        "password": ""
    })

    const [errors, setErrors] = useState({});

    const onChangeHandler = (e) => {
        setForm({
            ...form,
            [e.target.name]: e.target.value
        })
    }

    const onSubmitHandler = (e) => {
        e.preventDefault();
        axios.get('http://localhost:8000/api/users/'+form.username)
            .then(res=>{
                //@Brett password check
                if (form.password === res.data.user.password){
                    console.log("Passwords match")
                    props.setActiveUser(res.data.user)
                    setErrors({pw_match: ""})
                }
                else {
                    console.log("Passwords don't match")
                    setErrors({pw_match: "Invalid Username or Password"})
                }
            })
            .catch(err=> console.log(err))
    }

    return(
        <div>
            <h2>Login</h2>
            <div>
                <form onSubmit={onSubmitHandler}>
                    <label htmlFor="username">Username: </label>
                    <input name="username" type="text" onChange={onChangeHandler}/><br></br>

                    <label htmlFor="password">Password: </label>
                    <input name="password" type="password" onChange={onChangeHandler}/><br></br>
                    {errors.pw_match && <span>{errors.pw_match}</span>}<br></br>

                    <button type="submit">Login</button>
                </form>
            </div>
        </div>
    )
}

export default Login;
