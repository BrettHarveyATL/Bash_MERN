const Villian = require('../models/villian.model');
 
module.exports.findAllVillians = (req, res) => {
    Villian.find()
        .then(allVillians => res.json({ villians: allVillians }))
        .catch(err => res.json({ message: 'Something went wrong finding all Villians', error: err }));
}
 
module.exports.findOneSingleVillian = (req, res) => {
    Villian.findOne({ _id: req.params.id })
        .then(oneSingleVillian => res.json({ villian: oneSingleVillian }))
        .catch(err => res.json({ message: 'Something went wrong finding one villian', error: err }));
}
 
module.exports.createNewVillian = (req, res) => {
    Villian.create(req.body)
        .then(newlyCreatedVillian => res.json({ villian: newlyCreatedVillian }))
        .catch(err => res.json({ message: 'Something went wrong creating new villian', error: err }));
}
 
module.exports.updateExistingVillian = (req, res) => {
    Villian.findOneAndUpdate(
        { _id: req.params.id },
        req.body,
        { new: true, runValidators: true }
    )
        .then(updatedVillian => res.json({ villian: updatedVillian }))
        .catch(err => res.json({ message: 'Something went wrong updating existing villian', error: err }));
}
 
module.exports.deleteAnExistingVillian = (req, res) => {
    Villian.deleteOne({ _id: req.params.id })
        .then(result => res.json({ result: result }))
        .catch(err => res.json({ message: 'Something went wrong adopting a villian', error: err }));
}
