var pool = require('../db/csl_db');

var func = {
    getUser: function(getResult) {
        pool.getConnection(function(cnnerr, connection) {
            if (cnnerr) {
                console.log(cnnerr)
                return getResult([])
            }
            connection.query("CALL sp_get_user()", function(error, result) {
                connection.release();
                if (error) {
                    console.log(error);
                    return getResult([]);
                }
                return getResult(result[0]);
            });
        });
    },
    insertUser: function(data, getResult) {
        pool.getConnection(function(cnnerr, connection) {
            if (cnnerr) {
                return getResult(-1)
            }
            connection.query("CALL sp_insert_user(?,?,?)", [
                data['uNo'],
                data['uName'],
                data['ccyCode']
            ], function(error, result) {
                connection.release();
                if (error) {
                    console.log(error);
                    return getResult(-1);
                }
                return getResult(result[0][0]['result']);
            });
        });
    },
    updateUser: function(data, getResult) {
        pool.getConnection(function(cnnerr, connection) {
            if (cnnerr) {
                return getResult(-1)
            }
            connection.query("CALL sp_update_user(?,?,?)", [
                data['uNo'],
                data['uName'],
                data['ccyCode']
            ], function(error, result) {
                connection.release();
                if (error) {
                    console.log(error);
                    return getResult(-1);
                }
                return getResult(result[0][0]['result']);
            });
        });
    },
    deleteUser: function(data, getResult) {
        pool.getConnection(function(cnnerr, connection) {
            if (cnnerr) {
                return getResult(-1)
            }
            connection.query("CALL sp_delete_user(?)", [
                data['uNo']
            ], function(error, result) {
                connection.release();
                if (error) {
                    console.log(error);
                    return getResult(-1);
                }
                return getResult(result[0][0]['result']);
            });
        });
    }
}

module.exports = func;