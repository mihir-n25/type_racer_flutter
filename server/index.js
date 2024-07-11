const express = require("express");
const http = require("http");
const mongoose = require('mongoose');
const dotenv = require('dotenv');

const app = express();
dotenv.config();
const port = process.env.PORT || 5000;

var server = http.createServer(app);
var io = require('socket.io')(server);

app.use(express.json());

mongoose.connect(process.env.MONGO_URL).then(() => {
    console.log("Connected");
}).catch((err) => {
    console.log(err.message);
});

io.on('connection', (socket) => {
    console.log(socket.id);

    socket.on('test', (data) => {
        console.log(data);
    });
});

server.listen(port, "0.0.0.0", () => {
    console.log(`Server started and running on port ${port}`);
});
