const express = require("express")
const http = require("http")
const mongoose = require('mongoose')
const dotenv = require('dotenv')

const app = express();
dotenv.config();
const port = process.env.PORT || 3000;
var server = http.createServer(app)

app.use(express.json())

mongoose.connect(process.env.MONGO_URL).then(() => {
    console.log("Conected")
}
).catch((err) => {
    console.log(err.message)
})

server.listen(port , "0.0.0.0" , () => {
    console.log(`Server started and running on port ${port}`)
})