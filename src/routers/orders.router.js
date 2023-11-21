const orderRouter = require('express').Router()

const orderController = require('../controllers/orders.controller')

orderRouter.get('/', orderController.getAllOrder)

orderRouter.get('/:id', orderController.getDetailOrder)

orderRouter.post('/', orderController.createOrder)

orderRouter.patch('/:id', orderController.updateOrder)

orderRouter.delete('/:id', orderController.deleteOrder)

module.exports = orderRouter