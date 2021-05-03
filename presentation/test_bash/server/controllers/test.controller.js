const Test = require('../models/test.model');
 
module.exports.findAllTests = (req, res) => {
    Test.find()
        .then(allTests => res.json({ tests: allTests }))
        .catch(err => res.json({ message: 'Something went wrong finding all Tests', error: err }));
}
 
module.exports.findOneSingleTest = (req, res) => {
    Test.findOne({ _id: req.params.id })
        .then(oneSingleTest => res.json({ test: oneSingleTest }))
        .catch(err => res.json({ message: 'Something went wrong finding one test', error: err }));
}
 
module.exports.createNewTest = (req, res) => {
    Test.create(req.body)
        .then(newlyCreatedTest => res.json({ test: newlyCreatedTest }))
        .catch(err => res.json({ message: 'Something went wrong creating new test', error: err }));
}
 
module.exports.updateExistingTest = (req, res) => {
    Test.findOneAndUpdate(
        { _id: req.params.id },
        req.body,
        { new: true, runValidators: true }
    )
        .then(updatedTest => res.json({ test: updatedTest }))
        .catch(err => res.json({ message: 'Something went wrong updating existing test', error: err }));
}
 
module.exports.deleteAnExistingTest = (req, res) => {
    Test.deleteOne({ _id: req.params.id })
        .then(result => res.json({ result: result }))
        .catch(err => res.json({ message: 'Something went wrong adopting a test', error: err }));
}
