const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const VillianSchema = new mongoose.Schema({
    //new data
name :{ 
    type: String,
    require: [true, 'Name is required'], 
     
    },

});

const Villian = mongoose.model("Villian", VillianSchema);

module.exports = Villian;
