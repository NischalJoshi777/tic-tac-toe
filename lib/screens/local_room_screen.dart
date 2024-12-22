import 'package:flutter/material.dart';
import 'package:multiplayertictactoe/helper/local_game_helper.dart';
import 'package:multiplayertictactoe/widgets/app_header_text.dart';

class LocalRoomScreen extends StatefulWidget {
  const LocalRoomScreen({super.key});

  @override
  State<LocalRoomScreen> createState() => _LocalRoomScreenState();
}

class _LocalRoomScreenState extends State<LocalRoomScreen>
    with SingleTickerProviderStateMixin {
  bool isOTurn = true;
  late List<String> _values;
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _rotate;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _scale = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _rotate = Tween(begin: 0.0, end: 2.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _values = LocalGameHelper.values;
    _controller.forward();
  }

  void _setValue(int index) {
    LocalGameHelper.setValue(index, isOTurn ? "O" : "X");
    setState(() {
      isOTurn = !isOTurn;
    });
    LocalGameHelper.validateWinner(context);
    if (LocalGameHelper.winner.isNotEmpty) {
      _showDialogBox();
    }
  }

  void _showDialogBox() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const AppHeaderText(
          text: 'Game Over!',
        ),
        content: Text(
          LocalGameHelper.winner == "none"
              ? 'Its a draw!'
              : "Winner is ${LocalGameHelper.winner}",
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                LocalGameHelper.resetGame();
                _values = LocalGameHelper.values;
                isOTurn = true;
              });
              Navigator.pop(context);
            },
            child: const Text(
              'Retry',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              LocalGameHelper.resetGame();
              Navigator.of(context)
                  .popUntil((route) => route.settings.name == '/');
            },
            child: const Text(
              'End',
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40.0),
              const AppHeaderText(text: 'LET\'S PLAY'),
              _gameTurnText(),
              const SizedBox(height: 40.0),
              _buildBoard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gameTurnText() {
    return Text(
      "${isOTurn ? "O" : "X"} 's turn",
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: isOTurn ? Colors.red : Colors.blue,
        shadows: const [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 20.0,
            blurRadius: 40.0,
          ),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return Expanded(
      flex: 2,
      child: RotationTransition(
        turns: _rotate,
        child: ScaleTransition(
          scale: _scale,
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
                    _setValue(index);
                  }
                },
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  color: Colors.white24,
                  child: Center(
                    child: AppHeaderText(
                      text: _values[index],
                      shadow: [
                        BoxShadow(
                          color: _values[index] == "O"
                              ? Colors.red
                              : _values[index] == "X"
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
      ),
    );
  }
}
