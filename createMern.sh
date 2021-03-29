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
AllMy$upperCaseRoutes(app);
    
app.listen(8000, () => console.log("The server is established on port 8000"));

EOL