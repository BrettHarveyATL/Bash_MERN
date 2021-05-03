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
require("./server/routes/products.routes")(app);

app.listen(8000, () => console.log('Listening on port:'+port));
