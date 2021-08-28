const SuperheroController = require('../controllers/superhero.controller');

module.exports = app => {
    app.get('/api/superheros', SuperheroController.findAllSuperheros);
    app.get('/api/superheros/:id', SuperheroController.findOneSingleSuperhero);
    app.put('/api/superheros/:id', SuperheroController.updateExistingSuperhero);
    app.post('/api/superheros/new', SuperheroController.createNewSuperhero);
    app.delete('/api/superheros/:id', SuperheroController.deleteAnExistingSuperhero);
}
