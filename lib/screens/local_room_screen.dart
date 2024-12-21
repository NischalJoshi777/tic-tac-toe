import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/helper/local_game_helper.dart';
import 'package:multiplayertictactoe/widgets/app_header_text.dart';

class LocalRoomScreen extends StatefulWidget {
  const LocalRoomScreen({super.key});

  @override
  State<LocalRoomScreen> createState() => _LocalRoomScreenState();
}

class _LocalRoomScreenState extends State<LocalRoomScreen> {
  bool isOTurn = true;
  late List<String> values;

  @override
  void initState() {
    super.initState();
    values = LocalGameHelper.values;
  }

  void setValue(int index) {
    LocalGameHelper.setValue(index, isOTurn ? "O" : "X");
    setState(() {
      isOTurn = !isOTurn;
    });
    LocalGameHelper.validateWinner(context);
    if (LocalGameHelper.winner.isNotEmpty) {
      showDialogBox();
    }
  }

  void showDialogBox() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over!'),
        content: Text("Winner is ${LocalGameHelper.winner}"),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  LocalGameHelper.resetGame();
                  values = LocalGameHelper.values;
                  isOTurn = true;
                });
                Navigator.pop(context);
              },
              child: const Text('Retry')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Navigate back to the main screen
              },
              child: const Text('End Game')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppHeaderText(text: 'LET\'S PLAY'),
              Text(
                "${isOTurn ? "O" : "X"} 's turn",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  color: isOTurn ? Colors.red : Colors.blue,
                ),
              ),
              const SizedBox(height: 40.0),
              Expanded(
                flex: 2,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (LocalGameHelper.values[index].isEmpty) {
                          setValue(index);
                        }
                      },
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        color: Colors.white24,
                        child: Center(
                          child: AppHeaderText(
                            text: values[index],
                            shadow: [
                              BoxShadow(
                                color: values[index] == "O"
                                    ? Colors.red
                                    : values[index] == "X"
                                        ? Colors.blue
                                        : Colors.transparent,
                                blurRadius: 40.0,
                                spreadRadius: 20.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
