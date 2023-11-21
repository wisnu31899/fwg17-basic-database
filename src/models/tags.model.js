const db = require('../lib/db.lib')

exports.findAll = async ()=> {
    const sql = `SELECT * FROM "tags"`
    const values = []
    const{rows} = await db.query(sql, values)
    return rows
}

exports.findOne = async (id)=> {
    const sql = 'SELECT * FROM "tags" WHERE id = $1'
    const values = [id]
    const{rows} = await db.query(sql, values)
    return rows
}

exports.create = async (data)=> {
    const sql = `INSERT INTO "tags"
    ("name")
    VALUES
    ($1)
    RETURNING *`
    const values = [data.name]
    const{rows} = await db.query(sql, values)
    return rows[0]
}

exports.update = async (data, id)=> {
    const sql = `UPDATE "tags" 
    SET "name" = $1
    WHERE "id" = $2
    RETURNING *`
    const values = [data.name,id]
    const{rows} = await db.query(sql, values)
    return rows[0]
}

exports.delete = async (id)=> {
    const sql = `DELETE FROM "tags"
    WHERE "id" = $1
    RETURNING *`
    const values = [id]
    const{rows} = await db.query(sql, values)
    return rows
}