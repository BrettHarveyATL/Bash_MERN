#!/bin/bash
#creates project folder
mkdir test_bash
cd test_bash
#backend intialization
npm init -y
npm install mongoose express cors dotenv jsonwebtoken bcrypt cookie-parser
mkdir server
mkdir server/config server/controllers server/models server/routes
#Prompts user for app identifier to creates models, controllers, routes, Schema, and frontend naming conventions  
# echo "What do you want <name> to equal?"
# echo "Enter <name>.model.js, <name>.controller.js, ect"
# read input
# #makes all input lowercase
# name=${input,,}
echo """Let's begin your back end, right now we are getting 
login reg ready and then you can pick make some models!"""
`touch server/config/mongoose.config.js server/controllers/user.controller.js server/models/user.model.js server/routes/user.routes.js ./server.js`

cat >> server.js << EOL

const express = require('express');
const app = express();
const port = 8000;
const cors = require('cors');
const cookieParser = require('cookie-parser');

require('./server/config/mongoose.config');
require('dotenv').config();

app.use(cookieParser());
app.use(cors({credentials: true, origin: 'http://localhost:3000'}));

app.use(express.json())
app.use(express.urlencoded({extended: true}))

require("./server/routes/user.routes")(app);
//new data

app.listen(8000, () => console.log(`Listening on port: ${port}`) );

EOL

cat >> server/config/mongoose.config.js << EOL
const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/user_db', {
    useNewUrlParser: true,
    useUnifiedTopology: true
})
    .then(()=> console.log("DB connection established"))
    .catch(err=> console.log("Error in connecting db", err))
EOL

cat >> server/controllers/user.controller.js << EOL
const User = require('../models/user.model');
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

//@Brett everything above the ++++++ line is work in progress. Was trying to figure out why several different controllers looked so different.
// class UserController {
//     register(req, res){
//         const user = new User(req.body);
//         user
//         .save()
//         .then(() => {
//             res
//             .cookie("usertoken", jwt.sign({ _id: user._id }, secret), {
//                 httpOnly: true,
//             })
//             .json({ msg: "success!", user: user });
//         })
//         .catch((err) => res.json(err));
//     }
    
//     //From the learn platform
//     // register: (req, res) => {
//     //     User.create(req.body)
//     //     .then(user => {
//     //         res.json({ msg: "success!", user: user });
//     //     })
//     //     .catch(err => res.json(err));
//     // }

//     login(req, res) {
//         User.findOne({ email: req.body.email })
//         .then((user) => {
//             if (user === null) {
//             res.json({ msg: "invalid login attempt" });
//             } else {
//             bcrypt
//                 .compare(req.body.password, user.password)
//                 .then((passwordIsValid) => {
//                 if (passwordIsValid) {
//                     res
//                     .cookie("usertoken", jwt.sign({ _id: user._id }, secret), {
//                         httpOnly: true,
//                     })
//                     .json({ msg: "success!" });
//                 } else {
//                     res.json({ msg: "invalid login attempt" });
//                 }
//                 })
//                 .catch((err) => res.json({ msg: "invalid login attempt", err }));
//             }
//         })
//         .catch((err) => res.json(err));
//     }

//     logout(req, res) {
//         res
//         .cookie("usertoken", jwt.sign({ _id: "" }, secret), {
//             httpOnly: true,
//             maxAge: 0,
//         })
//         .json({ msg: "ok" });
//     }
// }
// module.exports = new UserController();


//++++++++++++++++++Above from Ruben, below is own attempt++++++++++++++++++++++++++

module.exports.findAllUsers = (req, res) => {
    User.find()
        .then(allUsers => res.json({ users: allUsers }))
        .catch(err => res.json({ message: 'Something went wrong', error: err }));
}

module.exports.findOneSingleUser = (req, res) => {
    User.findOne({ username: req.params.username })
        .then(oneSingleUser => res.json({ user: oneSingleUser }))
        .catch(err => res.json({ message: 'Something went wrong', error: err }));
}

module.exports.createNewUser = (req, res) => {
    User.create(req.body)
        .then(newlyCreatedUser => res.json({ user: newlyCreatedUser }))
        .catch(err => res.json({ message: 'Something went wrong', error: err }));
}

//From the learn platform, not sure how this differs from the code block above
// register: (req, res) => {
//     User.create(req.body)
//     .then(user => {
//         res.json({ msg: "success!", user: user });
//     })
//     .catch(err => res.json(err));
// }

module.exports.updateExistingUser = (req, res) => {
    User.findOneAndUpdate(
        { _id: req.params.id },
        req.body,
        { new: true, runValidators: true }
    )
        .then(updatedUser => res.json({ user: updatedUser }))
        .catch(err => res.json({ message: 'Something went wrong', error: err }));
}

module.exports.deleteAnExistingUser = (req, res) => {
    User.deleteOne({ _id: req.params.id })
        .then(result => res.json({ result: result }))
        .catch(err => res.json({ message: 'Something went wrong', error: err }));
}

EOL

cat >> server/models/user.model.js << EOL
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');

const UserSchema = new mongoose.Schema({
    username: {
        type: String,
        required: [true, "Username is required"],
        //Make sure it's unique. @Brett This validator is being a pain.
        unique: true
    },
    firstName: {
        type: String,
    },
    lastName: {
        type: String,
    },
    email: {
        type: String,
        required: [true, "Email is required"],
        validate: {
            validator: val => /^([\w-\.]+@([\w-]+\.)+[\w-]+)?$/.test(val),
            message: "Please enter a valid email"
        }
        //Make sure it's unique
    },
    password: {
        type: String,
        required: [true, "Password is required"],
        minLength: [8, "Password must be at least 8 characters"]
    }
}, {timestamps: true})


//@Brett all of the UserSchema stuff below works fine, but won't work with the current state of the rest of the project at the moment. The code below will hash the password, but the way the login function currently checks to make sure the password matches the user's needs the raw data still.
// UserSchema.virtual('passwordconf')
//     .get( () => this.passwordconf )
//     .set( value => this.passwordconf = value );

// UserSchema.pre('validate', function(next) {
//     if (this.password !== this.passwordconf) {
//         this.invalidate('passwordconf', 'Password must match confirm password');
//     }
//     next();
// });

// UserSchema.pre('save', function(next) {
//     bcrypt.hash(this.password, 10)
//         .then(hash => {
//         this.password = hash;
//         next();
//     });
// });

const User = mongoose.model('User', UserSchema);

module.exports = User;
EOL

cat >> server/routes/user.routes.js << EOL
const UserController = require('../controllers/user.controller');

module.exports = app => {
    app.get('/api/users', UserController.findAllUsers);
    app.get('/api/users/:username', UserController.findOneSingleUser);
    app.put('/api/users/:id', UserController.updateExistingUser);
    app.post('/api/users/new', UserController.createNewUser);
    app.delete('/api/users/delete/:id', UserController.deleteAnExistingUser);
}
EOL
echo "npx create-react-app client is running"
npx create-react-app client
cd client
npm install bootstrap axios
npm install --legacy-peer-deps @reach/router
cd ..
#<---------------------take the manual create client out after testing-------------------->
# mkdir client
# mkdir client/src
mkdir client/src/views
mkdir client/src/components
# touch client/src/App.js
# touch client/src/App.css
touch client/src/views/allusers.js
touch client/src/components/loggedinuser.js
touch client/src/components/login.js
touch client/src/components/userreg.js
truncate -s 0 client/src/App.js
cat >> client/src/App.js << EOL
import './App.css';
import AllUsers from './views/allusers';
import AddUser from './components/userreg';
import LoggedUser from './components/loggedinuser';
import Login from './components/login';
import { useState } from 'react';
//new import

function App() {
    const [loaded, setLoaded] = useState(false);
    const [activeUser, setActiveUser] = useState({});
    //new state
    const onClickHandler = (e) => {
    setActiveUser({});
    }
    //new handler
    return (
        <div className="App">
            <h1>Hello there</h1>
            <div className="loginregforms">
                <AddUser loaded={loaded} setLoaded={setLoaded} activeUser={activeUser} setActiveUser={setActiveUser}/>
                <Login loaded={loaded} setLoaded={setLoaded} activeUser={activeUser} setActiveUser={setActiveUser}/>
                {/* new route */}
        </div>
        <AllUsers loaded={loaded} setLoaded={setLoaded}/>
        <LoggedUser activeUser={activeUser}/>
        <button onClick={onClickHandler}>Logout</button>
        </div>
    );
}

export default App;
EOL

cat >> client/src/views/allusers.js << EOL
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
EOL

cat >> client/src/components/loggedinuser.js << EOL
import React, { useState } from 'react';

const LoggedUser = (props) => {
    return(
        <div>
            <h6>This is where the logged in user's username should be displayed</h6>
            {
                props.activeUser ? <h4>{props.activeUser.username}</h4> : ""
            }
            
        </div>
    )
}

export default LoggedUser;
EOL

cat >> client/src/components/login.js << EOL
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
EOL

cat >> client/src/components/userreg.js << EOL
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
EOL

truncate -s 0 client/src/App.css
cat >> client/src/App.css << EOL
.App {
  text-align: center;
}

.App-logo {
  height: 40vmin;
  pointer-events: none;
}

@media (prefers-reduced-motion: no-preference) {
  .App-logo {
    animation: App-logo-spin infinite 20s linear;
  }
}

.App-header {
  background-color: #282c34;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-size: calc(10px + 2vmin);
  color: white;
}

.App-link {
  color: #61dafb;
}

@keyframes App-logo-spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.oneuser{
  display: inline-block;
  width: 140px;
  border: 1px black solid;
  padding: 10px;
}

.loginregforms{
  display: inline-block;
}
EOL
#<---------------------creating User Login frontend-------------------->
echo "We are mostly set up just a few more things"
echo "We installed axios, bootstrap, and reach router for you!"

while true;
do
    echo "<<----------------------->>"
    echo "Would you like to create a new model?"
    echo "DO NOT MAKE PRURAL"
    read -p "Enter y for yes or any other key for no: " -n 1 -r
    if [[ $REPLY =~ ^[yY]$ ]]
    then
        bash ../createModel.sh
    else
        break
    fi
done
# echo "<<----------------------->>"