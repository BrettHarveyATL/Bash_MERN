const Products = require('../models/products.model');
 
module.exports.findAllProductss = (req, res) => {
    Products.find()
        .then(allProductss => res.json({ productss: allProductss }))
        .catch(err => res.json({ message: 'Something went wrong finding all Productss', error: err }));
}
 
module.exports.findOneSingleProducts = (req, res) => {
    Products.findOne({ _id: req.params.id })
        .then(oneSingleProducts => res.json({ products: oneSingleProducts }))
        .catch(err => res.json({ message: 'Something went wrong finding one products', error: err }));
}
 
module.exports.createNewProducts = (req, res) => {
    Products.create(req.body)
        .then(newlyCreatedProducts => res.json({ products: newlyCreatedProducts }))
        .catch(err => res.json({ message: 'Something went wrong creating new products', error: err }));
}
 
module.exports.updateExistingProducts = (req, res) => {
    Products.findOneAndUpdate(
        { _id: req.params.id },
        req.body,
        { new: true, runValidators: true }
    )
        .then(updatedProducts => res.json({ products: updatedProducts }))
        .catch(err => res.json({ message: 'Something went wrong updating existing products', error: err }));
}
 
module.exports.deleteAnExistingProducts = (req, res) => {
    Products.deleteOne({ _id: req.params.id })
        .then(result => res.json({ result: result }))
        .catch(err => res.json({ message: 'Something went wrong adopting a products', error: err }));
}
