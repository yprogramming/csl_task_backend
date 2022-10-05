var express = require('express');
var router = express.Router();
var {
    getUser,
    insertUser,
    updateUser,
    deleteUser
} = require('../func/user_func')


router.get('/all', function(req, res, next) {
    getUser((result) => {
        res.status(200).json({
            success: true,
            code: 200,
            data: result
        })
    })
});

router.post('/insert', function(req, res, next) {
    var uNo = req.body.uNo;
    var uName = req.body.uName;
    var ccyCode = req.body.ccyCode;
    insertUser({
        uNo: uNo,
        uName: uName,
        ccyCode: ccyCode
    }, (result) => {
        if (result == 1) {
            res.status(200).json({
                success: true,
                code: 200,
                message: 'Insert succesfully'
            })
        } else {
            res.status(200).json({
                success: true,
                code: 500,
                message: 'Insert failed'
            })
        }
    })
});

router.put('/update', function(req, res, next) {
    var uNo = req.body.uNo;
    var uName = req.body.uName;
    var ccyCode = req.body.ccyCode;
    updateUser({
        uNo: uNo,
        uName: uName,
        ccyCode: ccyCode
    }, (result) => {
        if (result == 1) {
            res.status(200).json({
                success: true,
                code: 200,
                message: 'Update succesfully'
            })
        } else {
            res.status(200).json({
                success: true,
                code: 500,
                message: 'Update failed'
            })
        }
    })
});

router.delete('/delete', function(req, res, next) {
    var uNo = req.body.uNo;
    deleteUser({
        uNo: uNo
    }, (result) => {
        if (result == 1) {
            res.status(200).json({
                success: true,
                code: 200,
                message: 'Delete succesfully'
            })
        } else {
            res.status(200).json({
                success: true,
                code: 500,
                message: 'Delete failed'
            })
        }
    })
});

module.exports = router;