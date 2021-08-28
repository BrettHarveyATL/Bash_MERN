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
