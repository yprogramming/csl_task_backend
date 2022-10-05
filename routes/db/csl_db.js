const mysql = require('mysql');
const pool = mysql.createPool({
    host: 'localhost', //process.env.HOST,
    user: 'root', //process.env.USER,
    password: '', //process.env.PASS,
    database: 'csl_task_db', //process.env.DB,
    charset: 'utf8',
    multipleStatements: false,
    connectionLimit: 10,
    supportBigNumbers: true
})

module.exports = pool;