#!/bin/bash
echo "<<----------------------->>"
echo "What would you like to name your model?"
echo "<<----------------------->>"
read input
echo "<<----------------------->>"
#makes all input lowercase
model_name=${input,,}
eval "$(./createMern.sh)"
`touch server/controllers/$model_name.controller.js`
`touch server/models/$model_name.model.js`
`touch server/routes/$model_name.routes.js`

cat >> server/controllers/$model_name.controller.js << EOL
const ${model_name^} = require('../models/${model_name}.model');
 
module.exports.findAll${model_name^}s = (req, res) => {
    ${model_name^}.find()
        .then(all${model_name^}s => res.json({ ${model_name}s: all${model_name^}s }))
        .catch(err => res.json({ message: 'Something went wrong finding all ${model_name^}s', error: err }));
}
 
module.exports.findOneSingle${model_name^} = (req, res) => {
    ${model_name^}.findOne({ _id: req.params.id })
        .then(oneSingle${model_name^} => res.json({ ${model_name}: oneSingle${model_name^} }))
        .catch(err => res.json({ message: 'Something went wrong finding one ${model_name}', error: err }));
}
 
module.exports.createNew${model_name^} = (req, res) => {
    ${model_name^}.create(req.body)
        .then(newlyCreated${model_name^} => res.json({ ${model_name}: newlyCreated${model_name^} }))
        .catch(err => res.json({ message: 'Something went wrong creating new ${model_name}', error: err }));
}
 
module.exports.updateExisting${model_name^} = (req, res) => {
    ${model_name^}.findOneAndUpdate(
        { _id: req.params.id },
        req.body,
        { new: true, runValidators: true }
    )
        .then(updated${model_name^} => res.json({ ${model_name}: updated${model_name^} }))
        .catch(err => res.json({ message: 'Something went wrong updating existing ${model_name}', error: err }));
}
 
module.exports.deleteAnExisting${model_name^} = (req, res) => {
    ${model_name^}.deleteOne({ _id: req.params.id })
        .then(result => res.json({ result: result }))
        .catch(err => res.json({ message: 'Something went wrong adopting a ${model_name}', error: err }));
}
EOL

cat >> server/models/${model_name}.model.js << EOL
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ${model_name^}Schema = new mongoose.Schema({
    //new data
});

const ${model_name^} = mongoose.model("${model_name^}", ${model_name^}Schema);

module.exports = ${model_name^};
EOL

cat >> server/routes/${model_name}.routes.js << EOL
const ${model_name^}Controller = require('../controllers/${model_name}.controller');

module.exports = app => {
    app.get('/api/${model_name}s', ${model_name^}Controller.findAll${model_name^}s);
    app.get('/api/${model_name}s/:id', ${model_name^}Controller.findOneSingle${model_name^});
    app.put('/api/${model_name}s/:id', ${model_name^}Controller.updateExisting${model_name^});
    app.post('/api/${model_name}s/new', ${model_name^}Controller.createNew${model_name^});
    app.delete('/api/${model_name}s/:id', ${model_name^}Controller.deleteAnExisting${model_name^});
}
EOL
touch newdata.txt
cat >> newdata.txt << EOL
require("./server/routes/${model_name}.routes")(app);
EOL
sed -i '/new data/ r newdata.txt' ./server.js
rm newdata.txt
while true;
do  
    echo "<<----------------------->>"
    echo "Would you like to add attributes and validations to your model?"
    echo "You need at least one unless you plan on inputing manually later"
    read -p "Enter y for yes or any other key for no: " -n 1 -r
    echo "<<----------------------->>"
    if [[ $REPLY =~ ^[yY]$ ]]
    then
    export model_name
        bash ../createSingleModel.sh
    else
        exit 0
    fi
done 