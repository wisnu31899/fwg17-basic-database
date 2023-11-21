let userModel = require('../models/users.model')

exports.getallusers = async (req, res) => {
    const users = await userModel.findAll()
    return res.json({
        success: true,
        message: 'list all users',
        result: users
    })
}

exports.getdetailuser = async (req, res) => {
    const id = parseInt(req.params.id)
    const user = await userModel.findOne(id)
    if (!user[0]) {
        return res.status(404).json({
            success: false,
            message: 'user not found'
        })
    }
    return res.json({
        success: true,
        message: 'detail user',
        result: user[0]
    })
}

exports.createusers = async (req, res) => {
    const data = req.body
    try {
        const user = await userModel.create(data)
        return res.json({
            success: true,
            message: 'create success',
            result: user
        })
    } catch (err) {
        if (err.code === '23502') {
            return res.status(400).json({
                success: false,
                message: `data cannot be empty`
            })
        }
        console.log(err)
        return res.status(500).json({
            success: false,
            message: 'internal server error'
        })
    }
}

exports.updateusers = async (req, res) => {
    const {id} = req.params
    try {
        const user = await userModel.update(req.body, id)
        return res.json({
            success: true,
            message: 'update success',
            results: user
        })
    } catch (err) {
        if(err.code === "42703"){
            return res.status(404).json({
                success: false,
                message: 'user not found'
            })   
        }
    console.log(err)
    return res.status(500).json({
            success: false,
            message: 'internet server error'
        })
    } 
}

exports.deleteusers = async (req, res) => {
    const id = parseInt(req.params.id)
    try {
        const user = await userModel.delete(id)
        return res.json({
            success: true,
            message: 'delete success',
            result: user
        })
    } catch (err) {
        return res.status(404).json({
            success: false,
            message: 'user not found'
        })
    }
}