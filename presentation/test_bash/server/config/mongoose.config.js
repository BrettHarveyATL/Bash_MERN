const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/user_db', {
    useNewUrlParser: true,
    useUnifiedTopology: true
})
    .then(()=> console.log("DB connection established"))
    .catch(err=> console.log("Error in connecting db", err))
