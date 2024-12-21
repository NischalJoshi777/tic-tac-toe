import 'package:flutter/material.dart';

class LocalGameHelper {
  static String winner = "";

  static List<String> values = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  static void resetGame() {
    values = [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    ];
    winner = "";
  }

  static void setValue(int index, String value) {
    if (values[index].isEmpty) {
      values[index] = value;
    }
  }

  static void validateWinner(BuildContext context) {
    // Checking rows
    if (values[0] == values[1] && values[0] == values[2] && values[0] != '') {
      winner = values[0];
    } else if (values[3] == values[4] &&
        values[3] == values[5] &&
        values[3] != '') {
      winner = values[3];
    } else if (values[6] == values[7] &&
        values[6] == values[8] &&
        values[6] != '') {
      winner = values[6];
    }
    // Checking columns
    else if (values[0] == values[3] &&
        values[0] == values[6] &&
        values[0] != '') {
      winner = values[0];
    } else if (values[1] == values[4] &&
        values[1] == values[7] &&
        values[1] != '') {
      winner = values[1];
    } else if (values[2] == values[5] &&
        values[2] == values[8] &&
        values[2] != '') {
      winner = values[2];
    }
    // Checking diagonals
    else if (values[0] == values[4] &&
        values[0] == values[8] &&
        values[0] != '') {
      winner = values[0];
    } else if (values[2] == values[4] &&
        values[2] == values[6] &&
        values[2] != '') {
      winner = values[2];
    }
  }
}
