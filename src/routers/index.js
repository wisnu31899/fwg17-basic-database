const router = require('express').Router()

router.use('/auth', require('./auth.router'))

router.use('/users', require('./users.router'))

router.use('/products', require('./products.router'))

router.use('/productSize', require('./productSize.router'))

router.use('/productVariant', require('./productVariant.router'))

router.use('/tags', require('./tags.router'))

router.use('/productTags', require('./productTags.router'))

router.use('/productRatings', require('./productRatings.router'))

router.use('/categories', require('./categories.router'))

router.use('/productCategories', require('./productCategories.router'))

router.use('/promo', require('./promo.router'))

router.use('/orders', require('./orders.router'))

router.use('/orderDetails', require('./orderDetails.router'))

router.use('/message', require('./message.router'))

module.exports = router