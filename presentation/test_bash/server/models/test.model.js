const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const TestSchema = new mongoose.Schema({
    //new data
age :{ 
    type: Number,
    require: [true, 'Age is required'], 
     
    },
name :{ 
    type: String,
    require: [true, 'Name is required'], 
    minlength: 2, 
    },

});

const Test = mongoose.model("Test", TestSchema);

module.exports = Test;
