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
    setState(() {
      LocalGameHelper.setValue(index, isOTurn ? "O" : "X");
      isOTurn = !isOTurn;
      LocalGameHelper.validateWinner(context);
    });
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
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40.0),
              Expanded(
                flex: 2,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0, // s
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setValue(index);
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
                                    : Colors.blue,
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
