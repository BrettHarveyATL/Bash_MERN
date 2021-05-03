const TestController = require('../controllers/test.controller');

module.exports = app => {
    app.get('/api/tests', TestController.findAllTests);
    app.get('/api/tests/:id', TestController.findOneSingleTest);
    app.put('/api/tests/:id', TestController.updateExistingTest);
    app.post('/api/tests/new', TestController.createNewTest);
    app.delete('/api/tests/:id', TestController.deleteAnExistingTest);
}
