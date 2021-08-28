import React, { useEffect, useState } from 'react';
import axios from 'axios';

const AddUser = (props) => {

    const [form, setForm] = useState({
        "username": "",
        "firstName": "",
        "lastName": "",
        "email": "",
        "password": "",
        "passwordconf": "",
    })

    const [usernames, setUsernames] = useState([]);
    const [errors, setErrors] = useState({});

    const onChangeHandler = (e) => {
        setForm({
            ...form,
            [e.target.name]: e.target.value
        })
        //@Brett this is the front end validator I was trying to get working with you and Ruben. Should ensure a unique username, but it's always one character behind what's in state for whatever reason.
        // console.log(form.username)
        // for (let i=0; i<usernames.length; i++){
        //     // console.log(usernames[i].username)
        //     if (usernames[i].username == form.username){
        //         console.log("Got a match")
        //     }
        // }
    }

    useEffect(() => {
        axios.get("http://localhost:8000/api/users")
            .then(res=>{
                setUsernames(res.data.users);
                console.log(usernames);
                props.setLoaded(true);
            })
            .catch(err=>console.log(err))
            
    }, [props.loaded])

    const onSubmitHandler = (e) => {
        e.preventDefault();
        axios.post("http://localhost:8000/api/users/new", form)
            .then(res=>{
                if(res.data.user){
                    props.setActiveUser(res.data.user);
                    props.setLoaded(false);
                }
                else {
                    setErrors(res.data.error.errors);
                }
            })
            .catch(err=> console.log(err))
    }

    return(
        <div>
            <h2>Register</h2>
            <div>
                <form onSubmit={onSubmitHandler}>
                    <label htmlFor="username">Username: </label>
                    <input name="username" type="text" onChange={onChangeHandler}/><br></br>
                    <span>{errors.username ? errors.username.message : ""}</span><br></br>

                    <label htmlFor="firstName">First Name: </label>
                    <input name="firstName" type="text" onChange={onChangeHandler}/><br></br>
                    {errors.firstName && <span>{errors.firstName.message}</span>}<br></br>

                    <label htmlFor="lastName">Last Name: </label>
                    <input name="lastName" type="text" onChange={onChangeHandler}/><br></br>
                    {errors.lastName && <span>{errors.lastName.message}</span>}<br></br>

                    <label htmlFor="email">Email: </label>
                    <input name="email" type="text" onChange={onChangeHandler}/><br></br>
                    {errors.email && <span>{errors.email.message}</span>}<br></br>

                    <label htmlFor="password">Password: </label>
                    <input name="password" type="password" onChange={onChangeHandler}/><br></br>
                    {errors.password && <span>{errors.password.message}</span>}<br></br>

                    <label htmlFor="passwordconf">Confirm Password: </label>
                    <input name="passwordconf" type="password" onChange={onChangeHandler}/><br></br>
                    {errors.passwordconf && <span>{errors.passwordconf.message}</span>}<br></br>
                    {
                        form.passwordconf.length >=8 && form.passwordconf != form.password ? <span>Password and Password Confirmation must match</span> : ""
                    }<br></br>

                    <button type="submit">Register Now</button>
                </form>
            </div>
        </div>
    )
}
export default AddUser;
