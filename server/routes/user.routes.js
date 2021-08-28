const UserController = require('../controllers/user.controller');

module.exports = app => {
    app.get('/api/users', UserController.findAllUsers);
    app.get('/api/users/:username', UserController.findOneSingleUser);
    app.put('/api/users/:id', UserController.updateExistingUser);
    app.post('/api/users/new', UserController.createNewUser);
    app.delete('/api/users/delete/:id', UserController.deleteAnExistingUser);
}
