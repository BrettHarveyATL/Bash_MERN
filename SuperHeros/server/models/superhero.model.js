const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const SuperheroSchema = new mongoose.Schema({
    //new data
power :{ 
    type: String,
    require: [true, 'Power is required, please try again.'], 
    minlength: 2, 
    },
name :{ 
    type: String,
    require: [true], 
    minlength: 2, 
    },

});

const Superhero = mongoose.model("Superhero", SuperheroSchema);

module.exports = Superhero;
