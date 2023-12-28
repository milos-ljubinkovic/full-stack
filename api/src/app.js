'use strict'
const express = require('express')
const app = express()
app.use('/', function (req, res, next) { res.status(200).json({ healthy: true }); })

app.use(function (err, req, res, next) {
    console.error(err);
    res.status(500).json({ message: "Internal error", key: "error" })
});

module.exports = app;