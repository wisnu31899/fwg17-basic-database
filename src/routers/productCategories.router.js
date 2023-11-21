const productcategoriesRouter = require('express').Router()

const productcategoriesController = require('../controllers/productCategories.controller')

productcategoriesRouter.get('/', productcategoriesController.getAllProductCategories)

productcategoriesRouter.get('/:id', productcategoriesController.getDetailProductCategories)

productcategoriesRouter.post('/', productcategoriesController.createProductCategories)

productcategoriesRouter.patch('/:id', productcategoriesController.updateProductCategories)

productcategoriesRouter.delete('/:id', productcategoriesController.deleteProductCategories)

module.exports = productcategoriesRouter