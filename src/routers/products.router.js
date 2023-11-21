const productRouter = require('express').Router()

const productController = require('../controllers/products.controller')

productRouter.get('/', productController.getallproducts)

productRouter.get('/:id', productController.getdetailproduct)

productRouter.post('/', productController.createproducts)

productRouter.patch('/:id', productController.updateproducts)

productRouter.delete('/:id', productController.deleteproducts)

module.exports = productRouter