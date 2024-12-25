import 'package:flutter/material.dart';

class RoomDetailsProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};

  Map<String, dynamic> get roomData => _roomData;

  void updateRooData(Map<String, dynamic> roomData) {
    _roomData = roomData;
    notifyListeners();
  }
}
