const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const Game = require("./models/Game");
const getSentence = require("./api/getSentence");

const app = express();
dotenv.config();
const port = process.env.PORT || 5000;

var server = http.createServer(app);
var io = require("socket.io")(server);

app.use(express.json());

mongoose
  .connect(process.env.MONGO_URL)
  .then(() => {
    console.log("Connected");
  })
  .catch((err) => {
    console.log(err.message);
  });

io.on("connection", (socket) => {

  socket.on("create-game", async ({ nickname }) => {
    try {
      let game = new Game();
      const sentence = await getSentence();
      game.words = sentence;
      let player = {
        socketID: socket.id,
        nickname,
        isPartyLeader: true,
      };
      game.players.push(player);
      game = await game.save();

      const gameId = game._id.toString();
      socket.join(gameId);

      io.to(gameId).emit('updateGame' , game);
    } catch (err) {
      console.log(err);
    }
  });
});

server.listen(port, "0.0.0.0", () => {
  console.log(`Server started and running on port ${port}`);
});
