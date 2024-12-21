import 'package:flutter/material.dart';

class LocalGameHelper {
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
    values = ["", "", "", "", "", "", "", "", ""];
  }

  static String winner = "";

  static void setValue(int index, String value) {
    if (values[index].isEmpty) {
      values[index] = value;
    }
  }

  static void validateWinner(
    BuildContext context,
  ) {
    //row1
    if ((values[0] == values[1]) &&
        (values[0] == values[2]) &&
        values[0] != "") {
      winner = values[0];
    }
    //row2
    if ((values[3] == values[4]) &&
        (values[3] == values[5]) &&
        values[3] != "") {
      winner = values[3];
    }
    //row3
    if ((values[6] == values[7]) &&
        (values[6] == values[8]) &&
        values[6] != "") {
      winner = values[3];
    }
    //checking column
    //colum1
    if ((values[0] == values[3]) &&
        (values[0] == values[6]) &&
        values[0] != "") {
      winner = values[0];
    }
    //column2
    if ((values[1] == values[4]) &&
        (values[1] == values[7]) &&
        values[1] != "") {
      winner = values[1];
    }
    //column
    if ((values[2] == values[5]) &&
        (values[2] == values[8]) &&
        values[2] != "") {
      winner = values[2];
    }

    //row3
    if ((values[6] == values[7]) &&
        (values[6] == values[8]) &&
        values[6] != "") {
      winner = values[3];
    }
    //checking diagonal
    //colum1
    if ((values[0] == values[4]) &&
        (values[0] == values[8]) &&
        values[0] != "") {
      winner = values[0];
    }
    //column2
    if ((values[2] == values[4]) &&
        (values[2] == values[7]) &&
        values[1] != "") {
      winner = values[3];
    }
    //column
    if ((values[2] == values[4]) &&
        (values[2] == values[6]) &&
        values[2] != "") {
      winner = values[3];
    }

    if (winner.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('GAME OVER'),
          content: Text("Winner is $winner"),
          actions: [
            TextButton(
              onPressed: () {
                resetGame();
                Navigator.pop(context);
              },
              child: const Text('Retry'),
            ),
            TextButton(
              onPressed: () {
                resetGame();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Exit'),
            )
          ],
        ),
      );
    }
  }
}
