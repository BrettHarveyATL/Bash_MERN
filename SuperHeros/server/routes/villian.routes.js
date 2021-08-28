const VillianController = require('../controllers/villian.controller');

module.exports = app => {
    app.get('/api/villians', VillianController.findAllVillians);
    app.get('/api/villians/:id', VillianController.findOneSingleVillian);
    app.put('/api/villians/:id', VillianController.updateExistingVillian);
    app.post('/api/villians/new', VillianController.createNewVillian);
    app.delete('/api/villians/:id', VillianController.deleteAnExistingVillian);
}
