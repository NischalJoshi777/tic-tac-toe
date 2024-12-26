import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/model/player.dart';

class RoomDetailsProvider extends ChangeNotifier {
  final List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;

  int get filledBoxes => _filledBoxes;

  Map<String, dynamic> _roomData = {};
  Player _player1 = Player(
    nickname: '',
    socketID: '',
    points: 0,
    playerType: 'X',
  );

  Player _player2 = Player(
    nickname: '',
    socketID: '',
    points: 0,
    playerType: 'O',
  );

  Player get player1 => _player1;

  Player get player2 => _player2;

  Map<String, dynamic> get roomData => _roomData;
  List<String> get displayElements => _displayElements;

  void updateRooData(Map<String, dynamic> roomData) {
    _roomData = roomData;
    notifyListeners();
  }

  void updatePlayer1Details(Map<String, dynamic> player1) {
    _player1 = Player.fromMap(player1);
    notifyListeners();
  }

  void updatePlayer2Details(Map<String, dynamic> player2) {
    _player2 = Player.fromMap(player2);
    notifyListeners();
  }

  void updateDisplayElement(int index, String choice) {
    _displayElements[index] = choice;
    _filledBoxes += 1;
    notifyListeners();
  }

  void setFilledBoxValue(int value) {
    _filledBoxes = value;
    notifyListeners();
  }
}
