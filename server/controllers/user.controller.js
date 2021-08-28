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

