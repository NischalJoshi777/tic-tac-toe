const express = require("express"); //importing the express
const http = require("http");
const mongoose = require("mongoose"); // It allows you to define schema for creating models in mongodb
const app = express();
const port = process.env.PORT || 3000;

var server = http.createServer(app);
var io = require("socket.io")(server);

//converts the data into json format
app.use(express.json());

const db = require('./db.js'); // Import the constant

const DB = db;
const Room = require("./models/room");

io.on('connection', (socket) => 
    {console.log("connection set up")
        socket.on('createRoom', async ({nickname}) => {
            console.log(nickname);
            try {
                // room is created
                let room = new Room();
                let player = {
                  socketID: socket.id,
                  nickname,
                  playerType: "X",
                };
                room.players.push(player);
                room.turn = player;
                room = await room.save(); //data saved in mongodb
                console.log(room);
                const roomId = room._id.toString(); // a unique id created my the mongodb.  
                socket.join(roomId); // socket manipulates data to yourself.
                io.to(roomId).emit("createRoomSuccess", room); //io sends data to everyone. //creating room has been sucessfull.
              } catch (e) {
                console.log(e);
              }
        });

        socket.on('joinRoom', async ({nickname, roomId})=> {
          try{
            if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
             socket.emit("errorOccurred", "Please enter a valid room ID.");
               return;
            }
            let room = await Room.findById(roomId);
         if (room.canJoin) {
          let playerO = {
            nickname,
            socketID: socket.id,
            playerType: "O",
          }
          console.log(playerO.socketID);
          socket.join(roomId);
          room.players.push(playerO);
          room.canJoin = false;
          room = await room.save();
          io.to(roomId).emit("joinRoomSuccess", room);
          io.to(roomId).emit("updatePlayers", room.players);
          io.to(roomId).emit("updateRoom", room);

        } else {
          socket.emit(
            "errorOccurred",
            "The game is in progress, try again later."
          );
        }
          } catch(e){
             console.log(e.toString);
          }
        });


        socket.on('tap', async ({index, roomId})=>{
        try{
            let room = await Room.findById(roomId);
            let choice = room.turn.playerType; 
            if(room.turnIndex == 0){
              room.turn = room.players[1];
              room.turnIndex = 1;
            } else {
              room.turn = room.players[0];
              room.turnIndex = 0;
            }
            room = await room.save();
            //if sucessfull we need to emit tapped event
            io.to(roomId).emit("tapped", {
              index, 
              choice,
              room
            })
           }catch(e){
          }
       });

       socket.on("winner", async ({ winnerSocketId, roomId }) => {
        try {
//          if(socket.id!=winnerSocketId){return ;}
          let room = await Room.findById(roomId);
          let player = room.players.find(
            (p) => p.socketID == winnerSocketId
          );
          player.points += 1;
          room = await room.save();
          if (player.points >= room.maxRounds) {
            io.to(roomId).emit("endGame", player);
          } else {
            io.to(roomId).emit("pointIncrease", player);
          }
        } catch (e) {
          console.log(e);
        }
      });
    }
);

//establishing connection witht the DB.
mongoose.connect(DB).then(() =>{
    console.log("connection established");}
).catch((e)=> {console.log(e);});

//start listening to the server.
server.listen(port, '0.0.0.0',()=>{
    console.log(`Our server is started and is running in port `+ port);
});
