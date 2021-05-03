const ProductsController = require('../controllers/products.controller');

module.exports = app => {
    app.get('/api/productss', ProductsController.findAllProductss);
    app.get('/api/productss/:id', ProductsController.findOneSingleProducts);
    app.put('/api/productss/:id', ProductsController.updateExistingProducts);
    app.post('/api/productss/new', ProductsController.createNewProducts);
    app.delete('/api/productss/:id', ProductsController.deleteAnExistingProducts);
}
