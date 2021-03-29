#!/bin/bash
mkdir server
mkdir server/config server/controllers server/models server/routes
echo "What do you want <name> to equal? $\n Enter <name>.model.js, <name>.controller.js, ect"
read name

`touch server/config/mongoose.config.js server/controllers/$name.controller.js server/models/$name.model.js server/routes/$name.routes.js ./server.js`
echo upper_name = ${name^}
cat >> server.js << EOL

const express = require("express");
const app = express();
const cors = require('cors');

app.use(cors());
    
require("./server/config/mongoose.config");
    
app.use(express.json(), express.urlencoded({ extended: true }));
    
const AllMy${name^}Routes = require("./server/routes/$name.routes");
AllMy${name^}Routes(app);
    
app.listen(8000, () => console.log("The server is established on port 8000"));

EOL

cat >> server/config/mongoose.config.js << EOL

const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost/${name}_db', {
    useNewUrlParser: true,
    useUnifiedTopology: true
})
    .then(() => console.log('Established a connection to the database'))
    .catch(err => console.log('Data Base connection error', err));

EOL

cat >> server/controllers/${name}.controller.js << EOL

const ${name^} = require('../models/${name}.model');
 
module.exports.findAll${name^}s = (req, res) => {
    ${name^}.find()
        .then(all${name^}s => res.json({ ${name}s: all${name^}s }))
        .catch(err => res.json({ message: 'Something went wrong finding all ${name^}s', error: err }));
}
 
module.exports.findOneSingle${name^} = (req, res) => {
    ${name^}.findOne({ _id: req.params.id })
        .then(oneSingle${name^} => res.json({ ${name}: oneSingle${name^} }))
        .catch(err => res.json({ message: 'Something went wrong finding one ${name}', error: err }));
}
 
module.exports.createNew${name^} = (req, res) => {
    ${name^}.create(req.body)
        .then(newlyCreated${name^} => res.json({ ${name}: newlyCreated${name^} }))
        .catch(err => res.json({ message: 'Something went wrong creating new ${name}', error: err }));
}
 
module.exports.updateExisting${name^} = (req, res) => {
    ${name^}.findOneAndUpdate(
        { _id: req.params.id },
        req.body,
        { new: true, runValidators: true }
    )
        .then(updated${name^} => res.json({ ${name}: updated${name^} }))
        .catch(err => res.json({ message: 'Something went wrong updating existing ${name}', error: err }));
}
 
module.exports.deleteAnExisting${name^} = (req, res) => {
    ${name^}.deleteOne({ _id: req.params.id })
        .then(result => res.json({ result: result }))
        .catch(err => res.json({ message: 'Something went wrong adopting a ${name}', error: err }));
}

EOL

cat >> server/models/${name}.model.js << EOL
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ${name^}Schema = new mongoose.Schema({
    name:{
        type: String,
        required:[true, "Name is required!"],
        minlength: [3, "Need at least 3 characters for ${name}"]
    },
})

const ${name^} = mongoose.model("${name^}", ${name^}Schema);

module.exports = ${name^};
EOL

cat >> server/routes/${name}.routes.js << EOL
const ${name^}Controller = require('../controllers/${name}.controller');

module.exports = app => {
    app.get('/api/${name}s', ${name^}Controller.findAll${name^}s);
    app.get('/api/${name}s/:id', ${name^}Controller.findOneSingle${name^});
    app.put('/api/${name}s/:id', ${name^}Controller.updateExisting${name^});
    app.post('/api/${name}s/new', ${name^}Controller.createNew${name^});
    app.delete('/api/${name}s/:id', ${name^}Controller.deleteAnExisting${name^});
}
EOL

npm init -y
npm install mongoose express cors

npx create-react-app client

cd client

npm install bootstrap axios

npm install --legacy-peer-deps @reach/router