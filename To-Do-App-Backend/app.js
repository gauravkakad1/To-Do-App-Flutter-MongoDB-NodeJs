const express = require('express');
const UserRoute = require('./routes/user.route');
const body_parser = require('body-parser');

const app = express();
app.use(body_parser.json());
app.use('/', UserRoute);



module.exports = app;
