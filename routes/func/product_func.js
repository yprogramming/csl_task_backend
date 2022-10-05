var pool = require('../db/csl_db');

var func = {
    getProduct: function(getResult) {
        pool.getConnection(function(cnnerr, connection) {
            if (cnnerr) {
                return getResult([])
            }
            connection.query("CALL sp_get_product()", function(error, result) {
                connection.release();
                if (error) {
                    console.log(error);
                    return getResult([]);
                }
                return getResult(result[0]);
            });
        });
    },
    insertProduct: function(data, getResult) {
        pool.getConnection(function(cnnerr, connection) {
            if (cnnerr) {
                return getResult(-1)
            }
            connection.query("CALL sp_insert_product(?,?,?,?)", [
                data['pName'],
                data['pPrice'],
                data['ccyCode'],
                data['staff']
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
    updateProduct: function(data, getResult) {
        pool.getConnection(function(cnnerr, connection) {
            if (cnnerr) {
                return getResult(-1)
            }
            connection.query("CALL sp_update_product(?,?,?,?,?)", [
                data['pId'],
                data['pName'],
                data['pPrice'],
                data['ccyCode'],
                data['staff']
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
    deleteProduct: function(data, getResult) {
        pool.getConnection(function(cnnerr, connection) {
            if (cnnerr) {
                return getResult(-1)
            }
            connection.query("CALL sp_delete_product(?,?)", [
                data['pId'],
                data['staff']
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