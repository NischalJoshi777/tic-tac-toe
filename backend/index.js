const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const Room = require("./models/room");
const app = express();
const port = process.env.PORT || 3000;

var server = http.createServer(app);
var io = require("socket.io")(server);

app.use(express.json());
const DB = "mongodb+srv://nischaljoshi77:test123@cluster0.4asop.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"


io.on("connection", (socket) => {
  console.log("connected!");
  socket.on("createRoom", async ({ nickname }) => {
    console.log(nickname);
    try {
      // room is created
      let room = new Room();
      let player = {
        socketID: socket.id,
        nickname,
        playerType: "X",//player creating room get x
      };

      room.players.push(player);
      room.turn = player;
      room = await room.save(); //stores data in mongo db
      console.log(room);
      //unique id created by mongoDB;
      const roomId = room._id.toString();
      socket.join(roomId);
      io.to(roomId).emit("createRoomSuccess", room);
    } catch (e) {
      console.log(e);
    }
  });
 });

mongoose.connect(DB)
  .then(() => {
    console.log("Connection established!");
  })
  .catch((e) => {
    console.log(e);
  });

  server.listen(port, "0.0.0.0", () => {
    console.log(`Server started  on port ${port}`);
  });
