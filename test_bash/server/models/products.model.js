const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ProductsSchema = new mongoose.Schema({
    //new data
price :{ 
    type: String,
    require: [true, 'How much is the item, 0 for free.'], 
     
    },
type :{ 
    type: String,
    require: [true, 'Type is required'], 
    minlength: 2, 
    },
productname :{ 
    type: String,
    require: [true, 'Name is required'], 
    minlength: 2, 
    },

});

const Products = mongoose.model("Products", ProductsSchema);

module.exports = Products;
