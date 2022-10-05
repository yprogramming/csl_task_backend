var express = require('express');
var router = express.Router();
var {
    getProduct,
    insertProduct,
    updateProduct,
    deleteProduct
} = require('../func/product_func')


router.get('/all', function(req, res, next) {
    getProduct((result) => {
        res.status(200).json({
            success: true,
            code: 200,
            data: result
        })
    })
});

router.post('/insert', function(req, res, next) {
    var pName = req.body.pName;
    var pPrice = req.body.pPrice;
    var ccyCode = req.body.ccyCode;
    var staff = req.body.staff;
    insertProduct({
        pName: pName,
        pPrice: pPrice,
        ccyCode: ccyCode,
        staff: staff
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
                message: 'Insert product failed'
            })
        }
    })
});

router.put('/update', function(req, res, next) {
    var pId = req.body.pId;
    var pName = req.body.pName;
    var pPrice = req.body.pPrice;
    var ccyCode = req.body.ccyCode;
    var staff = req.body.staff;
    updateProduct({
        pId: pId,
        pName: pName,
        pPrice: pPrice,
        ccyCode: ccyCode,
        staff: staff
    }, (result) => {
        if (result == 1) {
            res.status(200).json({
                success: true,
                code: 200,
                message: 'Update succesfully'
            })
        } else if (result == -2) {
            res.status(200).json({
                success: true,
                code: 201,
                message: 'No permission to modify this product'
            })
        } else {
            res.status(200).json({
                success: true,
                code: 500,
                message: 'Update product failed'
            })
        }
    })
});

router.delete('/delete', function(req, res, next) {
    var pId = req.body.pId;
    var staff = req.body.staff;
    deleteProduct({
        pId: pId,
        staff: staff
    }, (result) => {
        if (result == 1) {
            res.status(200).json({
                success: true,
                code: 200,
                message: 'Delete succesfully'
            })
        } else if (result == -2) {
            res.status(200).json({
                success: true,
                code: 201,
                message: 'No permission to delete this product'
            })
        } else {
            res.status(200).json({
                success: true,
                code: 500,
                message: 'Delete product failed'
            })
        }
    })
});

module.exports = router;