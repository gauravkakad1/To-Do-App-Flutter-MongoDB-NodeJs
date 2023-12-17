const mongoose = require('mongoose');

const connection = mongoose.createConnection('mongodb://127.0.0.1:27017/ToDoApp').on('open', () => {
    console.log("MongoDB Database connected");
}).on('error', () => {
    console.log("Unable to connect to MongoDB database");
});

module.exports = connection;
