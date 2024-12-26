import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/helper/mp_game_helper.dart';
import 'package:multiplayertictactoe/widgets/app_header_text.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      backgroundColor: Colors.red,
    ),
  );
}

void showDialogBox(BuildContext context, String content) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.black,
      title: const AppHeaderText(
        text: 'Game Over!',
      ),
      content: Text(
        content,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            MpGameHelper().clearBoard(context);
            Navigator.pop(context);
          },
          child: const Text(
            'Play Again',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
