const Superhero = require('../models/superhero.model');
 
module.exports.findAllSuperheros = (req, res) => {
    Superhero.find()
        .then(allSuperheros => res.json({ superheros: allSuperheros }))
        .catch(err => res.json({ message: 'Something went wrong finding all Superheros', error: err }));
}
 
module.exports.findOneSingleSuperhero = (req, res) => {
    Superhero.findOne({ _id: req.params.id })
        .then(oneSingleSuperhero => res.json({ superhero: oneSingleSuperhero }))
        .catch(err => res.json({ message: 'Something went wrong finding one superhero', error: err }));
}
 
module.exports.createNewSuperhero = (req, res) => {
    Superhero.create(req.body)
        .then(newlyCreatedSuperhero => res.json({ superhero: newlyCreatedSuperhero }))
        .catch(err => res.json({ message: 'Something went wrong creating new superhero', error: err }));
}
 
module.exports.updateExistingSuperhero = (req, res) => {
    Superhero.findOneAndUpdate(
        { _id: req.params.id },
        req.body,
        { new: true, runValidators: true }
    )
        .then(updatedSuperhero => res.json({ superhero: updatedSuperhero }))
        .catch(err => res.json({ message: 'Something went wrong updating existing superhero', error: err }));
}
 
module.exports.deleteAnExistingSuperhero = (req, res) => {
    Superhero.deleteOne({ _id: req.params.id })
        .then(result => res.json({ result: result }))
        .catch(err => res.json({ message: 'Something went wrong adopting a superhero', error: err }));
}
