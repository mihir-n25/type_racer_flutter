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



io.on("connection", (socket) => {
  socket.on("create-game", async ({ nickname }) => {
    try {
      let game = new Game();
      const sentence = await getSentence();
      game.words = sentence;
      let player = {
        socketId: socket.id,
        nickname,
        isPartyLeader: true,
      };
      game.players.push(player);
      game = await game.save();

      const gameId = game._id.toString();
      socket.join(gameId);

      io.to(gameId).emit("updateGame", game);
    } catch (err) {
      console.log(err);
    }
  });

  //join-game
  socket.on("join-game", async ({ nickname, gameId }) => {
    try {
      if (!gameId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("notCorrectGame", "Please enter a valid game ID");
        return;
      }
      let game = await Game.findById(gameId);
      if (game.isJoin) {
        const id = game._id.toString();
        let player = {
          nickname,
          socketId: socket.id,
        };
        socket.join(id);
        game.players.push(player);
        game = await game.save();
        io.to(gameId).emit("updateGame", game);
      } else{
        socket.emit('notCorrectGame' , 'The game is in process, please try again later!')
      }
    } catch (error) {
      console.log(error);
    }
  });

 

  //timer listener
  socket.on('timer' , async({playerId , gameId}) => {
    let countDown = 5;
    let game = await Game.findById(gameId);
    let player = game.players.id(playerId);

    if(player.isPartyLeader){
      let timerId = setInterval(async() => {
        if(countDown >= 0){
          io.to(gameId).emit("timer" , {
            countDown,
            msg : "Game Starting"
          });
          countDown--
         }
      } , 1000);
    } else{
      game.isJoin = false;
      game = await game.save();
      io.to(gameId).emit("UpdateGame" , game);
      startGameClock();
      clearInterval(timerId);
    }
  })
});

const startGameClock = async (gameId) => {
  let game = await Game.findById(gameId);
  game.startTime = new Date().getTime();
  game = await game.save();
  
  let time = 60;

  let timerId = setInterval((function gameIntervalFunc() {
    if(time >= 0){
      const timeFormat = calculateTime(time);
      io.to(gameId).emit('timer' , {
        countDown : timeFormat,
        msg : 'Time Remaining..'
      })
      console.log(time)
      time--;
    }
  }) (), 
1000)
}

const calculateTime = (time) => {
  let min = Math.floor(time/60);
  let sec = time%60;
  return `${min}:${sec < 10 ? "0" + sec : sec}`;
}

mongoose
  .connect(process.env.MONGO_URL)
  .then(() => {
    console.log("Connected");
  })
  .catch((err) => {
    console.log(err.message);
  });

server.listen(port, "0.0.0.0", () => {
  console.log(`Server started and running on port ${port}`);
});
