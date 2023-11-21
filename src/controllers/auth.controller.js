exports.login = (req, res)=>{
    const {username, password} = req.body
    if(username === 'wisnu123' && password === 'wisnu123'){
        return res.json({
            success: true,
            message: 'login success'
        })
    }else{
        return res.json({
            success: false,
            message: 'wrong username or password'
        })
    }
}